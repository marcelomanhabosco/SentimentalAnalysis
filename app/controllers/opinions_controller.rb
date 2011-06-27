# encoding: UTF-8
require 'hunspell-ffi'
require 'iconv'

class OpinionsController < ApplicationController
  def create
    @entity = Entity.find(params[:entity_id])
    @opinion = @entity.opinions.create(params[:opinion])
    
    redirect_to @entity
  end
  
  def process_opinions
    opinions = Opinion.find(:all, :conditions => ["entity_id LIKE ?", params[:id]])
    
    remove_all(opinions) if opinions
    
    correct_opinions(opinions)
    
    corrected_opinions = Array.new
    cleaned_opinions = Array.new
    
    opinions.each do |opinion|
      corrected_opinion = CorrectedOpinion.where(:opinion_id => opinion.id).first
      corrected_opinions << corrected_opinion unless corrected_opinion.nil?
    end
    
    clean_opinions(corrected_opinions)
    
    opinions.each do |opinion|
      cleaned_opinion = CleanedOpinion.where(:opinion_id => opinion.id).first
      cleaned_opinions << cleaned_opinion unless cleaned_opinion.nil?
    end
    
    cleaned_opinions = opinions
    
    proccess_sentences(cleaned_opinions)
    
    @entity = Entity.find(params[:id])
    redirect_to @entity
  end
  
  protected
  
  def correct_opinions(opinions)
    @dict = Hunspell.new("pt_BR.aff", "pt_BR.dic.txt")
    opinions.each do |opinion|
      @correct_opinion = String.new
      opinion.opinion_text.mb_chars.downcase.to_s.split(" ").each do |op|
        if op != " "
          spelling(op)
        end
      end
      CorrectedOpinion.create(:opinion_id=> opinion.id, :corrected_opinion_text => @correct_opinion)
    end
  end
  
  def clean_opinions(opinions)
    opinions.each do |opinion|
      @cleaned_opinion = String.new
      @copinion = remove_symbols(opinion.corrected_opinion_text.to_s).split(" ")
      @copinion.each do |correct_op|
        if correct_op != " "
          @is_stopword = stop_word(correct_op)
          if @is_stopword == false
            @cleaned_opinion = @cleaned_opinion + correct_op + " "
          end
        end
      end
      CleanedOpinion.create(:opinion_id=> opinion.opinion_id, :cleaned_opinion_text => @cleaned_opinion)
    end
  end
  
  def stop_word(word)
    @stop_word = StopWord.find(:first, :conditions => ['stop_word LIKE ?', word])
    if @stop_word
      return true
    else
      return false
    end
  end
  
  def spelling(op)
    op = op.force_encoding "ASCII-8BIT"
    if @dict.spell(op.gsub(/[\,\.\?\!\:\;\'\"\_\|\<\>]/, " ")) or @dict.spell(op.gsub(/[\,\.\?\!\:\;\'\"\_\|\<\>]/, " ").capitalize)
      @correct_opinion = @correct_opinion + op + " "
    else
      #op_iso = Iconv.conv('ISO-8859-2','ASCII//translit', op)
      is_lang = slang_word(op)
      if is_lang != false
        @correct_opinion = @correct_opinion + is_lang.to_s + " "
      else
        affective_word = AffectiveWord.find(:first, :conditions => ['word LIKE ?', op.singularize]) || nil
        if !affective_word.nil? or op == "mais"
          @correct_opinion = @correct_opinion + op + " "
        else
          suggestions = @dict.suggest(op)
          @correct_opinion  = @correct_opinion + suggestions[0].to_s + " ";
        end
      end
    end
  end
  
  def slang_word(word)
    @slang = InternetSlangWord.find(:first, :conditions => ['slang_word LIKE ?', word])
    if @slang
       return @slang.correct_word
    else
      return false
    end
  end
  
  def proccess_sentences(cleaned_opinions)
    cleaned_opinions.each do |cleaned_op|
      i = 1
      sentence = 1
      in_pos, final_pos = nil, nil
      cleaned_op.opinion_text.downcase.split(/[\,\.\?\!\:\;]/).each do |op|
        string = ""
        in_pos = i
        op.split(" ").each do |word|
          i= i+1
          final_pos = i
          string = string +" "+ word.to_s
        end
        os = OpinionSentence.create(:opinion_id => cleaned_op.id, :text => string, :initial_position => in_pos, :final_position => final_pos, :pos => 0, :neg => 0, :sentence_count => sentence) unless string.size < 5
        if os
          return_phrase_polarity(os)
          analize_sentence(os)
          sintetize_sentence_polarity(os)
          sentence = sentence + 1
        end
  		end
  	  sintetize_opinion_polarity(cleaned_op.id)
    end
  end
  
  def sintetize_sentence_polarity(os)
    positive, negative = 0.0, 0.0
    PolarityOpinionWord.where(:opinion_sentence_id => os.id).each do |pow|
      positive = positive + pow.pos unless pow.pos == nil
      negative = negative + pow.neg unless pow.neg == nil
    end
    os.update_attributes(:pos => positive, :neg => negative)
  end
  
  def analize_sentence(os)
    i = 0
    os.text.split(" ").each do |word|
      i= i+1
      if word.force_encoding("UTF-8") == "não"
        p = PolarityOpinionWord.where(:opinion_sentence_id => os.id).where("position >= ?", i).first
        p.update_attributes(:pos => p.neg, :neg => p.pos, :word => "#{word.force_encoding("ASCII-8BIT")} #{p.word}") if p
      end
      if i == 1 and (word == "mas" or word == "porém" or word == "não")
        p = PolarityOpinionWord.where(:opinion_sentence_id => os.id).where("position >= ?", i).first || nil
        p.update_attributes(:pos => p.neg, :neg => p.pos, :word => "#{word} #{p.word}") unless p == nil
      elsif word == "mas" or word == "porém"
        p = OpinionSentence.where(:opinion_id => os.opinion_id).where("sentence_count = ?", os.sentence_count-1).first || nil
        p.update_attributes(:pos => p.neg, :neg => p.pos) unless p == nil
      end
    end unless os.nil?
  end
  
  def return_phrase_polarity(os)
    i = os.initial_position
    os.text.split(" ").each do |word|
      if word.to_s != "mais" and word.to_s != "porcaria" and word.to_s != "besta" and word.to_s != "gosta"
        affective_word = AffectiveWord.find(:first, :conditions => ['word LIKE ?', word.singularize]) || nil
      else
        affective_word = AffectiveWord.find(:first, :conditions => ['word LIKE ?', word]) || nil
      end
      PolarityOpinionWord.create(:word => affective_word.word, :pos => affective_word.pos, :neg => affective_word.neg, :opinion_sentence_id => os.id, :position =>i) unless affective_word == nil
      i= i+1
    end
  end
  
  def find_synonym_or_antonym(word, opinion_id)
    polarity = nil
    words = WordRelation.where(:word => word).all
    done = false
    words.each do |relation|
      affective_word = AffectiveWord.where(:word => relation.related_word).first || nil
      unless affective_word.nil? or done == true
        polarity = return_polarity(affective_word, relation.relation)
        done = true
      end
    end
    polarity
  end
  
  def remove_symbols(opinion)
    return opinion.to_s.gsub(/[\,\.\?\!\:\;\'\"\_\|\<\>]/, " ")
  end
  
  def remove_all(opinions)
    opinions.each do |op|
      CorrectedOpinion.destroy_all(:opinion_id => op.id)
      CleanedOpinion.destroy_all(:opinion_id => op.id)
      OpinionSentence.destroy_all(:opinion_id => op.id)
    end 
  end
  
  def return_polarity(aword, relation)
    if relation == "sinonimo"
      return aword.polarity
    else
      return change_polarity(aword.polarity)
    end
  end
  
  def sintetize_opinion_polarity(opinion_id)
    polarity, positive, negative = "", 0, 0
    OpinionSentence.where(:opinion_id => opinion_id).each do |os|
      positive = positive + os.pos
      negative = negative + os.neg
    end
    if positive > negative
      polarity = "Positivo"
    elsif positive == negative
      polarity = "Neutro"
    else
      polarity = "Negativo"
    end
    Opinion.find(opinion_id).update_attributes(:polarity => polarity)
  end
  
end

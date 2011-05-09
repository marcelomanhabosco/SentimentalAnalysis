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
    remove_all
    
    opinions = Opinion.find(:all, :conditions => ["entity_id LIKE ?", params[:id]])
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
    
    define_polarity(cleaned_opinions)
    
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
    if @dict.spell(op)
      @correct_opinion = @correct_opinion + op + " "
    else
      #op_iso = Iconv.conv('ISO-8859-2','ASCII//translit', op)
      is_lang = slang_word(op)
      if is_lang != false
        @correct_opinion = @correct_opinion + is_lang.to_s + " "
      else
        suggestions = @dict.suggest(op)
        @correct_opinion  = @correct_opinion + suggestions[0].to_s + " ";
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
  
  def define_polarity(cleaned_opinions)
    cleaned_opinions.each do |cleaned_op|
      cleaned_op.cleaned_opinion_text.split(" ").each do |op|
        affective_word = AffectiveWord.where(:word => op).first || nil
        if affective_word.nil?
          find_synonym_or_antonym(op, cleaned_op.opinion_id)
        else
          PolarityOpinionWord.create(:opinion_id => cleaned_op.opinion_id, :polarity => affective_word.polarity, :word => op) unless affective_word.nil?
        end
  		end
    end
  end
  
  def find_synonym_or_antonym(word, opinion_id)
    words = WordRelation.where(:word => word).all
    done = false
    words.each do |relation|
      affective_word = AffectiveWord.where(:word => relation.related_word).first || nil
      unless affective_word.nil? or done == true
        polarity = return_polarity(affective_word, relation.relation)
        done = true
        PolarityOpinionWord.create(:opinion_id => opinion_id, :polarity => affective_word.polarity, :word => word) unless affective_word.nil?
      end
    end
  end
  
  def remove_symbols(opinion)
    return opinion.to_s.gsub(/[\,\.\?\!\:\;\'\"\_\|\<\>]/, " ")
  end
  
  def remove_all
    CorrectedOpinion.all.each do |c|
      c.destroy
    end
    
    CleanedOpinion.all.each do |c|
      c.destroy
    end
    
    PolarityOpinionWord.all.each do |p|
      p.destroy
    end
  end
  
  def return_polarity(aword, relation)
    if relation == "sinonimo"
      return aword.polarity
    else
      return change_polarity(aword.polarity)
    end
  end
  
  def change_polarity(polarity)
    if polarity == "+"
      return "-"
    else
      return "+"
    end
  end
  
end

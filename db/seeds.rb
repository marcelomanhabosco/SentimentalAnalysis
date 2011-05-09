# encoding: UTF-8

caminho = "#{Rails.root}/db/seed_data/"

# StopWords
File.open(caminho + 'stopwords.txt').each_with_index do |linha, index|
  puts "Importando StopWords #{index} - #{linha}"
  StopWord.create!(:stop_word => linha.chomp)
end

# Dicionário Internetês
File.open(caminho + 'internetslangwords.txt').each_with_index do |linha, index|
  slang_word, correct_word = linha.chomp.split(" | ")
  puts "Importando Internetes #{index} - #{slang_word}"
  InternetSlangWord.create!(:slang_word => slang_word, :correct_word => correct_word)
end

# Classes Gramaticais
WordClass.create!(:id => 1, :name=>"Verbo")
WordClass.create!(:id => 2, :name=>"Adjetivo")
WordClass.create!(:id => 3, :name=>"Advérbio")
WordClass.create!(:id => 4, :name=>"Substantivo")

# Thesaurus em Português
File.open(caminho + 'base_tep2.txt').each_with_index do |linha, index|
  synset_id, word_class_id, words, synset_ant = linha.chomp.split(" ")
  synset_ant = nil if synset_ant == ""
  puts "Importando Synset #{synset_id}"
  synset = Synset.create!(:id => synset_id, :word_class_id => word_class_id, :synset_ant => synset_ant)
  words.split(",").each do |w|
    synset.synset_words.create(:word => w)
  end
end

# WordNetAffectBR
File.open(caminho + 'affective_words.txt').each_with_index do |linha, index|
  word, polarity = linha.chomp.split(" | ")
  puts "Importando Palavra Afetiva - #{word}"
  AffectiveWord.create!(:word => word, :polarity => polarity)
end

# Relações de Antonímia e Sinonímia
File.open(caminho + 'triplos.txt').each_with_index do |linha, index|
  word_class_id, word, relation, related_word = linha.chomp.split(" ")
  puts "Importando Relacão #{index} - #{word} ~ #{relation} ~ #{related_word}"
  WordRelation.create!(:word_class_id => word_class_id, :word => word, :relation => relation, :related_word => related_word)
end

# Entidades e Opiniões
Entity.create!(:id => 1, :name => "A Origem (Inception)")

File.open(caminho + 'opinioes.txt').each_with_index do |linha, index|
  entity_id, human_score, opinion_text = linha.chomp.split(" | ")
  puts "Importando Opiniao #{index}"
  Opinion.create!(:entity_id => entity_id, :human_score => human_score, :opinion_text => opinion_text)
end
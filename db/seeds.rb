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
Entity.create!(:id => 1, :name => "2012")
Entity.create!(:id => 2, :name => "300")
Entity.create!(:id => 3, :name => "A Origem (Inception)")
Entity.create!(:id => 4, :name => "Avatar")
Entity.create!(:id => 5, :name => "Crepusculo")
Entity.create!(:id => 6, :name => "Crepusculo Lua Nova")
Entity.create!(:id => 7, :name => "Guerra ao Terror")
Entity.create!(:id => 8, :name => "Harry Potter")
Entity.create!(:id => 9, :name => "Paranormal")
Entity.create!(:id => 10, :name => "Premonição")

File.open(caminho + '/opinioes/2012-positivas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - 2012 #{index}"
  Opinion.create!(:entity_id => 1, :human_score => "Positivo", :opinion_text => linha)
end
File.open(caminho + '/opinioes/2012-negativas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - 2012 #{index}"
  Opinion.create!(:entity_id => 1, :human_score => "Negativo", :opinion_text => linha)
end

File.open(caminho + '/opinioes/300-positivas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - 300 #{index}"
  Opinion.create!(:entity_id => 2, :human_score => "Positivo", :opinion_text => linha)
end
File.open(caminho + '/opinioes/300-negativas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - 300 #{index}"
  Opinion.create!(:entity_id => 2, :human_score => "Negativo", :opinion_text => linha)
end

File.open(caminho + '/opinioes/A_Origem-positivas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - A Origem #{index}"
  Opinion.create!(:entity_id => 3, :human_score => "Positivo", :opinion_text => linha)
end
File.open(caminho + '/opinioes/A_Origem-negativas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - A Origem #{index}"
  Opinion.create!(:entity_id => 3, :human_score => "Negativo", :opinion_text => linha)
end

File.open(caminho + '/opinioes/Avatar-positivas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Avatar #{index}"
  Opinion.create!(:entity_id => 4, :human_score => "Positivo", :opinion_text => linha)
end
File.open(caminho + '/opinioes/Avatar-negativas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Avatar #{index}"
  Opinion.create!(:entity_id => 4, :human_score => "Negativo", :opinion_text => linha)
end

File.open(caminho + '/opinioes/Crepusculo-positivas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Crepusculo #{index}"
  Opinion.create!(:entity_id => 5, :human_score => "Positivo", :opinion_text => linha)
end
File.open(caminho + '/opinioes/Crepusculo-negativas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Crepusculo #{index}"
  Opinion.create!(:entity_id => 5, :human_score => "Negativo", :opinion_text => linha)
end

File.open(caminho + '/opinioes/Crepusculo_Lua_Nova-positivas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Crepusculo Lua Nova #{index}"
  Opinion.create!(:entity_id => 6, :human_score => "Positivo", :opinion_text => linha)
end
File.open(caminho + '/opinioes/Crepusculo_Lua_Nova-negativas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Crepusculo Lua Nova #{index}"
  Opinion.create!(:entity_id => 6, :human_score => "Negativo", :opinion_text => linha)
end

File.open(caminho + '/opinioes/Guerra-positivas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Guerra ao Terror #{index}"
  Opinion.create!(:entity_id => 7, :human_score => "Positivo", :opinion_text => linha)
end
File.open(caminho + '/opinioes/Guerra-negativas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Guerra ao Terror #{index}"
  Opinion.create!(:entity_id => 7, :human_score => "Negativo", :opinion_text => linha)
end

File.open(caminho + '/opinioes/Harry-positivas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Harry Potter #{index}"
  Opinion.create!(:entity_id => 8, :human_score => "Positivo", :opinion_text => linha)
end
File.open(caminho + '/opinioes/Harry-negativas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Harry Potter #{index}"
  Opinion.create!(:entity_id => 8, :human_score => "Negativo", :opinion_text => linha)
end

File.open(caminho + '/opinioes/Paranormal-positivas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Paranormal #{index}"
  Opinion.create!(:entity_id => 9, :human_score => "Positivo", :opinion_text => linha)
end
File.open(caminho + '/opinioes/Paranormal-negativas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Paranormal #{index}"
  Opinion.create!(:entity_id => 9, :human_score => "Negativo", :opinion_text => linha)
end

File.open(caminho + '/opinioes/Premonicao-positivas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Premonicao #{index}"
  Opinion.create!(:entity_id => 10, :human_score => "Positivo", :opinion_text => linha)
end
File.open(caminho + '/opinioes/Premonicao-negativas.txt').each_with_index do |linha, index|
  puts "Importando Opiniao - Premonicao #{index}"
  Opinion.create!(:entity_id => 10, :human_score => "Negativo", :opinion_text => linha)
end
require_relative 'Translator'

translator = Translator.new

puts "********************************************"
puts "************* Ruby Translator **************"
puts "********************************************"

translator.getText
puts
translator.getTextLanguage
puts
translator.getTranslationLanguage
puts

puts "Texto traduzido:"
translator.printTranslation
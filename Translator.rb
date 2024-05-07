require 'uri'
require 'net/http'
require 'json'

class Translator
  @@text = ""
  @@text_language = ""
  @@translate_language = ""
  @@translation_filename = ""

  def convertOptionToLanguage(option)
    case option
    when "1"
      return "pt-BR"
    when "2"
      return "en-US"
    when "3"
      return "es"
    else
      return "pt-BR"
    end
  end

  def getText
    puts "Digite seu texto: "
    @@text = gets.chomp
  end

  def getTextLanguage
    puts "Qual idioma o texto está escrito? \nOpções: [1] Português [2] Inglês [3] Espanhol"
    @@text_language = convertOptionToLanguage(gets.chomp)
  end

  def getTranslationLanguage
    puts "Para qual idioma você deseja traduzir o texto? \nOpções: [1] Português [2] Inglês [3] Espanhol"
    @@translate_language = convertOptionToLanguage(gets.chomp)
  end

  def writeTranslationFile(translation)
    time = Time.now

    @@translation_filename = "translations/#{time.strftime("%d-%m-%y")}_#{time.hour}:#{time.min}.txt"
    File.open(@@translation_filename, 'a') do |line|
      line.puts(translation)
    end
  end

  def readTranslationFile
    file = File.open(@@translation_filename)

    file.each do |line|
      puts line
    end
  end

  def printTranslation
    encoded_text = URI.encode_www_form_component(@@text)

    url = URI("https://api.mymemory.translated.net/get?q=#{encoded_text}&langpair=#{@@text_language}|#{@@translate_language}")
    response = Net::HTTP.get_response(url)
    responseBody = JSON.parse(response.body)
    
    translation = responseBody['responseData']['translatedText']

    writeTranslationFile(translation)
    readTranslationFile()
  end
end
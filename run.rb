require "tty-prompt"
require "pry"
require 'bigdecimal'
require './funky_fonts.rb'


  def welcome
   system("clear")
   puts "Welcome to Funky Finance!"
   puts "\n"
   define_variables
  end

  def define_variables
   variables= Hash.new
   options=["I","P", "r", "t"]
   while options.length>1 do
     prompt = TTY::Prompt.new
     selection=prompt.select("What will the variable no.#{5-options.length} be?", options)
     string=user_input_variable(selection)
     variables[selection]=string.to_f
     options=options.select{|v| v!=selection}
   end
   missing_variable=options[0]
   calculate_missing_variable(missing_variable,variables)
  end


  def calculate_missing_variable(missing_variable,variables)
    case missing_variable
    when "I"
      missing_variable_value=variables["P"]*variables["r"]*variables["t"]
      showValue(missing_variable, missing_variable_value)
    when "P"
        missing_variable_value=variables["I"]/(variables["r"]*variables["t"])
        showValue(missing_variable, missing_variable_value)
    when "r"
      missing_variable_value=variables["I"]/(variables["P"]*variables["t"])
      showValue(missing_variable, missing_variable_value)
    when "t"
      missing_variable_value=variables["I"]/(variables["P"]*variables["r"])
      showValue(missing_variable, missing_variable_value)
    end
  end

  def showValue(variable,number)
    number=number.round(2)
    number=number.to_s.split("").join(" ")
    number=number
    puts number
    puts "Variable: #{variable}"
    number_in_funky_fonts=[]
    number.each_char do |char|
      number_in_funky_fonts.push(FunkyFonts.all_fonts[char].split("\n"))
    end
      sentence="\n"
    number_in_funky_fonts[0].length.times do |n|
      number_in_funky_fonts.each do |singlechar|
        sentence+=singlechar[n]

      end
      sentence+="\n"
    end
    puts sentence
  end

  def user_input_variable(selection)
    puts "What is the value of the variable #{selection}?"
    print ">> "
    string=gets.chomp
    validate_numbers(string,selection)
  end

   def validate_numbers(input,selection)
     if input.delete("^0-9.").length!=input.length || input.count(".")>1
       puts "Insert Valid Number"
       user_input_variable(selection)
     elsif BigDecimal.new(input)*100%1!=0
       puts "Only accepted numbers up to 2 decimals"
       user_input_variable(selection)
     else
       input
    end
   end

welcome

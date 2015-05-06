require "peekaboo/version"

require "pry"
require 'tempfile'
require 'fileutils'

class Peekaboo

  def initialize(file_path, line_num)
    @file_path = file_path
    @line_num = line_num
  end 


  def copy

    length = File.readlines(@file_path).size
    ##  why wasn't this working with for i in 0..10
    

   #open tempfile    
    #file = Tempfile.new("temp")
    template = File.read(@file_path)
    line = 0
   #open temp file to write to 
    File.open("temp.rb", "a+") do |f|
       f.write("require 'pry'\n")
    #open source file to read from   
       file = File.open(@file_path)
       file.each do |l|
    #write from file up until line where we want to insert pry    
        if line < @line_num 
          f.write(l)
          line+=1
        end
      end 
    #insert pry into tempfile  
    f.write("\nbinding.pry\n")


    line = 0

   #reopen source file to read from  
   File.open(@file_path).each do |l|
   #write to temp file from error until end of source file  
        if line >= @line_num && line <=length     
          f.write(l)
          line+=1
          #puts "line number is #{line} and line is #{l}"
        else 
          line+=1
        end
      end
    end
    load "temp.rb"
  end

end 

##TODO 
#tempfile 
#read file path from fileutils
#read line num from stdout
#refactor
#deal with edge cases 
#how does tempfile know about pry gem? is it because its required in this gem?

    
#Peekaboo.new("/Users/dananajjar/dev/project/peekaboo/code.rb", 4).copy

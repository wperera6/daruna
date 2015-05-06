require 'tempfile'
require 'fileutils'

#require "peekaboo/version"
# gem build peekaboo.gemspec
# gem install .rb
require "pry"

class Peekaboo

  def initialize(file_path, line_num)
    @file_path = file_path
    @line_num = line_num
  end 


  def copy
    
    length = File.readlines(@file_path).size
    ##  why wasn't this working with for i in 0..10
    
    #FileUtils.mkdir_p ("temp")

   #open tempfile 
    t = Tempfile.new("test_temp")  
    template = File.read(@file_path)
    line = 0
   #open temp file to write to 
  
       t.write("require 'pry'\n")
    #open source file to read from   
       file = File.open(@file_path)
       file.each do |l|
    #write from file up until line where we want to insert pry    
        if line < @line_num 
          t.write(l)
          line+=1
        end
      end 
    #insert pry into tempfile  
    t << "\nbinding.pry\n"
    line = 0
   #reopen source file to read from  
   File.open(@file_path).each do |l|
   #write to temp file from error until end of source file  
        if line >= @line_num && line <=length     
          t << l
          line+=1
        else 
          line+=1
        end
      end
    #binding.pry
    t.rewind
    load t
    t.close
  end

end 

##TODO 
#learn how to call it as a gem 
#read file path from fileutils
#read line num from stdout
#refactor
#deal with edge cases 
#how does tempfile know about pry gem? is it because its required in this gem?

    
Peekaboo.new("/Users/dananajjar/dev/project/peekaboo/code.rb", 20).copy



  
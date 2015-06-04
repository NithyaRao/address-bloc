#Greeting first argument is the greeting followed by names
#   puts "Hello"
 #  greet = ARGV.first 
 #  puts greet
   ARGV[1..-1].each do |arg|
     puts "#{ARGV.first} #{arg}"
   end


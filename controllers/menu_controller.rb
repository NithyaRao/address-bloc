require_relative "../models/address_book"
 
 class MenuController
   attr_accessor :address_book
 
   def initialize
     @address_book = AddressBook.new
   end
 
   def main_menu
 # #2
     puts "Main Menu - #{@address_book.entries.count} entries"
     puts "1 - View all entries"
     puts "2 - Create an entry"
     puts "3 - Search for an entry"
     puts "4 - View Entry Number n"
     puts "5 - Import entries from a CSV"
     puts "6 - Detonate: Delete all entries"
     puts "7 - Exit"
     print "Enter your selection: "
 
 # #3
     selection = gets.to_i
     puts "You picked #{selection}"
     case selection
       when 1
          system "clear"
          view_all_entries
          main_menu
       when 2
          system "clear"
          create_entry
          main_menu
       when 3
          system "clear"
          search_entries
          main_menu
       when 4
          system "clear"
          view_entry_number
          main_menu
       when 5
          system "clear"
          read_csv
          main_menu
       when 6
          system "clear"
          delete_all_entries
          delete_all_menu 
       when 7
          puts "Good-bye!"
 # #8
          exit(0)
 # #9
        else
           system "clear"
           puts "Sorry, that is not a valid input"
           main_menu
        end
   end

 def delete_all_menu
   
     puts "Main Menu - #{@address_book.entries.count} entries"
     puts "1 - Create an entry"
     puts "2 - Import entries from a CSV"
     puts "3 - Exit"
     print "Enter your selection: "
 
     selection = gets.to_i
     puts "You picked #{selection}"
     case selection
       when 1
          system "clear"
          create_entry
          main_menu
       when 2
          system "clear"
          read_csv
          main_menu
       when 3
          puts "Good-bye!"
          exit(0)
        else
           system "clear"
           puts "Sorry, that is not a valid input"
           main_menu
        end
   end

 # #10
   def view_all_entries
     system "clear"
    puts "View all AddressBook Entries"  
     @address_book.entries.each do |entry|
         system "clear"
         puts entry.to_s
         entry_submenu(entry)
     end
    system "clear"
    puts "End of entries" 
  end
 
   
   def search_entries
 
     print "Search by name: "
     name = gets.chomp
 
     match = @address_book.binary_search(name)
     system "clear"

     if match
       puts match.to_s
       search_submenu(match)
     else
       puts "No match found for #{name}"
     end
   end
 
   def view_entry_number 
    system "clear"
    print "Enter the entry number to view: "
    selection = gets.to_i
   if selection > 0
      puts @address_book.entries[selection-1].to_s
   else 
     puts "Invalid Entry.Please enter a valid number"
   end
   # system "clear"
   end

   def read_csv

     print "Enter CSV file to import: "
     file_name = gets.chomp
 
     if file_name.empty?
       system "clear"
       puts "No CSV file read"
       main_menu
     end
 
     begin
       entry_count = @address_book.import_from_csv(file_name)
       system "clear"
       puts "#{entry_count} new entries added from #{file_name}"
     rescue
       puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
       read_csv
     end
   end


   def create_entry
 # #11
     system "clear"
     puts "New AddressBook Entry"
 # #12
     print "Name: "
     name = gets.chomp
     print "Phone number: "
     phone = gets.chomp
     print "Email: "
     email = gets.chomp
 
     @address_book.add_entry(name, phone, email)
  #   puts @address_book.entries.index
  #  puts @address_book.entries.to_s
   #  system "clear"
     puts "New entry created"
      system "clear"
   end

   def delete_entry(entry)
     @address_book.entries.delete(entry)
     puts "#{entry.name} has been deleted"
   end

   def delete_all_entries
     system "clear"
     puts "Delete all AddressBook Entries! Are you sure (Y/N) ? : " 
     input = gets.chomp.upcase
     if input == 'Y'  
        total_entries = @address_book.entries.count
        @address_book.entries.each do |entry|
         delete_entry(entry)
        end
        system "clear"
        puts "#{total_entries} entries has been deleted " 
        delete_all_menu
     elsif input == 'N'
       puts "No entries deleted "
       main_menu
     else 
        system "clear"
        puts "Sorry, that is not a valid input"
        delete_all_entries
     end
   end

   def edit_entry(entry)
 
     print "Updated name: "
     name = gets.chomp
     print "Updated phone number: "
     phone_number = gets.chomp
     print "Updated email: "
     email = gets.chomp
 
     entry.name = name if !name.empty?
     entry.phone_number = phone_number if !phone_number.empty?
     entry.email = email if !email.empty?
     system "clear"

     puts "Updated entry:"
     puts entry
   end

  def entry_submenu(entry)
     puts "n - next entry"
     puts "d - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
 
 # #17
     selection = gets.chomp
 
     case selection
 # #18
     when "n"
 # #19
     when "d"
      delete_entry(entry)
     when "e"
      edit_entry(entry)
      entry_submenu(entry)

     when "m"
       system "clear"
       main_menu
     else
       system "clear"
       puts "#{selection} is not a valid input"
       entries_submenu(entry)
     end 
  end

  def search_submenu(entry)
     puts "\nd - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
 
 
     selection = gets.chomp
 
     case selection
 
     when "n"

     when "d"
      delete_entry(entry)
     when "e"
      edit_entry(entry)
      entry_submenu(entry)

     when "m"
       system "clear"
       main_menu
     else
       system "clear"
       puts "#{selection} is not a valid input"
       entries_submenu(entry)
     end 
  end


 end

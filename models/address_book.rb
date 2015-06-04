require_relative "entry.rb"
require "csv"

class AddressBook
 attr_accessor :entries
 def initialize
     @entries = []
   end
 def add_entry(name, phone, email)
 # #7
     index = 0
     @entries.each do |entry|
 # #8    
       if name < entry.name
         break
       end
       index += 1
     end
 # #9
     @entries.insert(index, Entry.new(name, phone, email))
   end
   
   def remove_entry(entry)
   @entries.delete_if {|index| entry == index}
  end

   def import_from_csv(file_name)
     # Implementation goes here
      csv_text = File.read(file_name)
      csv = CSV.parse(csv_text, headers: true)
 # #8
      csv.each do |row|
       row_hash = row.to_hash
       puts row_hash
       add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
      end
 
     return csv.count
   end
end

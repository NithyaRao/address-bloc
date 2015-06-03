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

   def binary_search(name)
     lower = 0
     upper = entries.length - 1

     while lower <= upper
       mid = (lower + upper) / 2
       mid_name = entries[mid].name
       if name == mid_name
         return entries[mid]
       elsif name < mid_name
         upper = mid - 1
       elsif name > mid_name
         lower = mid + 1
       end
     end

     return nil
   end

    def iterative_search(name)
         cur_index = 0
         upper  = entries.length
        while ( cur_index < upper)
          if name == entries[cur_index].name
              return entries[cur_index]
          end    
          cur_index += 1 
        end  

       return nil
    end
end
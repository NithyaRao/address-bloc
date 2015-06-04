require_relative "controllers/menu_controller"

menu = MenuController.new
system "clear"
puts "Welcome to AddressBloc!"
menu.main_menu
#menu.view_entry_number

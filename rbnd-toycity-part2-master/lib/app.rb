require 'json'

def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("report.txt", "w+")
end

def print_report(out)
    open($report_file, "a") { |f| f<<out }
end


def preparation
# Print "Sales Report" in ascii art
print_report("@@@@@@    @@@@@@   @@@       @@@@@@@@   @@@@@@      @@@@@@@   @@@@@@@@  @@@@@@@    @@@@@@   @@@@@@@   @@@@@@@  \n")
print_report("@@@@@@@   @@@@@@@@  @@@       @@@@@@@@  @@@@@@@      @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@   \n")
print_report("!@@       @@!  @@@  @@!       @@!       !@@          @@!  @@@  @@!       @@!  @@@  @@!  @@@  @@!  @@@    @@!     \n")
print_report("!@!       !@!  @!@  !@!       !@!       !@!          !@!  @!@  !@!       !@!  @!@  !@!  @!@  !@!  @!@    !@!     \n")
print_report("!!@@!!    @!@!@!@!  @!!       @!!!:!    !!@@!!       @!@!!@!   @!!!:!    @!@@!@!   @!@  !@!  @!@!!@!     @!!     \n")
print_report(" !!@!!!   !!!@!!!!  !!!       !!!!!:     !!@!!!      !!@!@!    !!!!!:    !!@!!!    !@!  !!!  !!@!@!      !!!     \n")
print_report("     !:!  !!:  !!!  !!:       !!:            !:!     !!: :!!   !!:       !!:       !!:  !!!  !!: :!!     !!:     \n")
print_report("    !:!   :!:  !:!   :!:      :!:           !:!      :!:  !:!  :!:       :!:       :!:  !:!  :!:  !:!    :!:     \n")
print_report(":::: ::   ::   :::   :: ::::   :: ::::  :::: ::      ::   :::   :: ::::   ::       ::::: ::  ::   :::     ::     \n")
print_report(":: : :     :   : :  : :: : :  : :: ::   :: : :        :   : :  : :: ::    :         : :  :    :   : :     :  \n")
print_report("\n")
end



def print_stars
    30.times {print_report(  "*****")}
    print_report("\n")
end



# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
  # Calcalate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount based off the average sales price


def product_ascii
       # Print "Products" in ascii art
       print_report("                     _            _       \n")
       print_report("                    | |          | |      \n")
       print_report(" _ __  _ __ ___   __| |_   _  ___| |_ ___ \n")
       print_report("| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|\n")
       print_report("| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\\n")
       print_report("| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/\n")
       print_report("| |                                       \n")
       print_report("|_|                                        \n")
end

def product_calci(purchaselist, options={})
      # options has arguments
  
      ttal_sales = purchaselist.map{|purchase| purchase['price']}.reduce(:+)
      print_report("Total Sales:")
      print_report("$#{ttal_sales}\n")
  
      avprice=(ttal_sales / options[:ttpurcount1])
      # print "Average Price:"
      print_report("Average Price:")
      print_report("$" + avprice.to_s + "\n")
  
      result= (100 - (avprice / options[:toyactprice1]) * 100) #.round(2)
      print_report("Average Discount:")
      print_report(result.round(2).to_s + "%" +"\n")


end

def products
       
       product_ascii 
      
       $products_hash["items"].each do |toy|
          avprice=0
          # Print the name of the toy
          print_report("\n" + toy["title"]+"\n")
          print_stars
     
          print_report("Retail Price:")
          toyactprice=toy["full-price"].to_f
          print_report("$#{toyactprice}\n")
   
          print_report("Total Purchases:")
          ttpurcount=toy["purchases"].count
          print_report("#{ttpurcount}\n")
          
          # A method to generate calculated info about product
          product_calci(toy['purchases'], {ttpurcount1:ttpurcount , toyactprice1:toyactprice  } ) 
   
          print_stars
          print "\n"
       end
end






# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined

def brand_ascii
# Print "Brands" in ascii art
        print_report( " _                         _     \n")
        print_report( "| |                       | |    \n")
        print_report( "| |__  _ __ __ _ _ __   __| |___ \n")
        print_report( "| '_ \\| '__/ _` | '_ \\ / _` / __|\n")
        print_report( "| |_) | | | (_| | | | | (_| \\__ \\\n")
        print_report( "|_.__/|_|  \\__,_|_| |_|\\__,_|___/\n")
end

def brands
    @brands ||= $products_hash["items"].map { |toy| toy["brand"] }.uniq
    #$products_hash["items"].map { |toy| toy["brand"] }.uniq
end

def products_by(brand)
    $products_hash["items"].select { |toy| toy["brand"] == brand }
end

def brand_reports(brandstock = 100 ,options={})
  print_report("Brand toys in Stock: ")
  print_report("#{brandstock}\n")
      
  print_report("Average Product Price: ")
  avg_price=options[:brand_price]/options[:noofbrands]
  print_report("$" + avg_price.round(2).to_s + "\n") 
         
  print_report("Total Sales: ")
  print_report("$#{options[:totbrandsales].round(2)}\n")
end

def brand_calculator(brand)
  brand_price=0 
  brandstock=0
  totbrandsales=0
  avg_price=0
  products_by(brand).each do |product|
    brand_price += product["full-price"].to_f
    brandstock += product["stock"]
    result1=product["purchases"].inject(0) do |result1, el| result1 + el["price"] end
    totbrandsales=totbrandsales + result1
  end
  noofbrands=products_by(brand).length
  brand_reports(brandstock,brand_price:brand_price, noofbrands:noofbrands, totbrandsales:totbrandsales)
end


def bybrand
  brand_ascii

  #Calling each Brand for printing data
  brands.each do |brand|
    print_report("#{brand}\n")
    print_stars
  
    brand_calculator(brand) 
    print_report("\n")
  end
end


def start
  setup_files
  preparation
  # Print today's date
  time = Time.new
  mytime=time.strftime("%Y-%m-%d %H:%M:%S")
  print_report("#{mytime}\n")
  print_stars
  products
  bybrand
  puts " SALES REPORT GENERATED for #{mytime} "
  puts " PLEASE READ SALESREPORT IN report.txt"
end

start

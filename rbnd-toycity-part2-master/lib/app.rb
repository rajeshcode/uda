require 'json'

def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("report.txt", "w+")
end


def print_report(out)
    open("report.txt", "a") { |f|
    f<<out
   }
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
end






# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
  # Calcalate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount based off the average sales price

def print_stars
    30.times {print_report(  "*****")}
    print_report("\n")
end

def products
       # Print "Products" in ascii art
       print_report("                     _            _       \n")
       print_report("                    | |          | |      \n")
       print_report(" _ __  _ __ ___   __| |_   _  ___| |_ ___ \n")
       print_report("| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|\n")
       print_report("| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\\n")
       print_report("| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/\n")
       print_report("| |                                       \n")
       print_report("|_|                                        \n")
       
       $products_hash["items"].each do |toy|
       tsales=0
       avprice=0
       # Print the name of the toy
       print_report("\n" + toy["title"]+"\n")
       print_stars
  
       print_report("Retail Price:")
       print_report("$#{toy["full-price"]}\n")

       print_report("Total Purchases:")
       print_report("#{toy["purchases"].count}\n")

       print_report("Total Sales:")
       ttal_sales = toy['purchases'].map{|purchase| purchase['price']}.reduce(:+) 
       print_report("$#{ttal_sales}\n")

       print_report("Average Price:")
       avprice=ttal_sales/(toy["purchases"].count)
       print_report("$" + avprice.to_s + "\n")

       print_report("Average Discount:")
       result= (100-(avprice/(toy["full-price"]).to_f)*100) #.round(2)
       #puts "#{result} %"
       print_report(result.round(2).to_s + "%" +"\n")

       print_stars
       print "\n"
    end
end






# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined


def brands
    @brands ||= $products_hash["items"].map { |toy| toy["brand"] }.uniq
    #$products_hash["items"].map { |toy| toy["brand"] }.uniq
end


def products_by(brand)
  $products_hash["items"].select { |toy| toy["brand"] == brand }
end

def bybrand
# Print "Brands" in ascii art
        print_report( " _                         _     \n")
        print_report( "| |                       | |    \n")
        print_report( "| |__  _ __ __ _ _ __   __| |___ \n")
        print_report( "| '_ \\| '__/ _` | '_ \\ / _` / __|\n")
        print_report( "| |_) | | | (_| | | | | (_| \\__ \\\n")
        print_report( "|_.__/|_|  \\__,_|_| |_|\\__,_|___/\n")

        brands.each do |brand|
          print_report("#{brand}\n")
          print_stars
          brand_price=0
          avg_price=0
          brandstock=0
          result1=0
          totbrandsales=0
          products_by(brand).each do |product|
              #puts product["full-price"]
              brand_price = brand_price + product["full-price"].to_f
              brandstock = brandstock + product["stock"].to_f

              result1=product["purchases"].inject(0) do |result1, el|
                      result1 + el["price"]
              end
              totbrandsales=totbrandsales + result1
          end
          print_report("Brand toys in Stock: ")
          print_report("#{brandstock}\n")

          print_report("Average Product Price: ")
          avg_price=brand_price/products_by(brand).length
          print_report("$" + avg_price.round(2).to_s + "\n") 
    
          print_report("Total Sales: ")
          print_report("$#{totbrandsales.round(2)}\n")
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

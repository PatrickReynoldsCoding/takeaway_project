# {{PROBLEM}} Multi-Class Design Recipe
## 1. Describe the Problem

> As a customer
> So that I can check if I want to order something
> I would like to see a list of dishes with prices.

> As a customer
> So that I can order the meal I want
> I would like to be able to select some number of several available dishes.

> As a customer
> So that I can verify that my order is correct
> I would like to see an itemised receipt with a grand total. 


### Use the twilio-ruby gem to implement this next one. You will need to use doubles too.

> As a customer
> So that I am reassured that my order will be delivered on time
> I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.



## 2. Design the Class system


Consider diagramming out the classes and their relationships. Take care to focus on the details you see as important,
not everything. The diagram below uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com

see list + prices
select multiple choices from list

show multiple choices and sum total 






















Also design the interface of each class in more detail.




```ruby

class Transaction

  def initialize(name, phone) #add kernal to initalize
    
    @name = name
    @phone = phone
    @order = []
    @total = 0
  end

  def interactive_menu
    @order = []
    loop do
      # 1. print the menu and ask the user what to do
      puts "1. View Menu"
      puts "2. Add Item"
      puts "3. View Cart"
      puts "4. Checkout" 
      # 2. read the input and save it into a variable
      selection = gets.chomp
      # 3. do what the user has asked
      case selection
      when "1"
        dominos.show_menu
      when "2"
        puts "Type item number:"
        choice = xxxx.gets.chomp   #need to add kernal to initalize to run test"
        @order.push(dominos.pick_dish(choice))
      when "3"
        show_order
      when "4"
        puts "view receipt?"
        puts "1. Yes"
        puts "2. No"
        choice = xxxx.gets.chomp   #need to add kernal to initalize to run test"
        if choice == yes    
          receipt
          checkout
        else
          checkout
        end

      else
        puts "I don't know what you meant, try again"
      end

    end
  end

  def add_dish(choice)
    #adds to order from the menu class
    @order << choice 
  end

  def show_order
    return @order
  end

  def grand_total
    #"the total was #{@total}"
  end

  def receipt
    show_order
    grandtotal
  end 

  def checkout
    #end transaction and text
    new_text = TextAlert.new(@name, @phone, @total)
  end

end



class Menu

  def initialize(menu)
    @menu = menu
  end

  def show_menu
  #print the menu to the console of dishes prices and numbers
  end

  def dish_pick(dishnum)
    #return dish object when number is given
  end

end




class TextAlert

  def initialize(name, phone, total)
    @name = name
    @phone = phone 
    @total = total
  end


  def send
    #uses instance variables to send a text
  end

end

```

## 3. Create Examples as intergration Tests

ADVICE: Start with 1st intigration test and when you cant progress move to unit test. Repeat this process

Create examples of the classes being used together in different situations and combinations that reflect the ways in which the system will be used.


```ruby
# EXAMPLE

# 1. show_order method = list of dishes
new_transaction = Transaction.new("Paddy", 07945612345)
dominos = Menu.new([[number: 1, dish: "Margarita", price: 9],[number: 2, dish: "Pepperoni", price: 10],[number: 3, dish: "Hawaiian", price: 11]])
expect(dominos.show_menu).to eq "1. Margarita £9""\n""2. Pepperoni £10""\n""3. Hawaiian £11"

#2. show_menu 
new_transaction = Transaction.new("Paddy", 07945612345)
dominos = Menu.new([[number: 1, dish: "Margarita", price: 9],[number: 2, dish: "Pepperoni", price: 10],[number: 3, dish: "Hawaiian", price: 11]])
expect(dominos.show_menu).to eq "1. Margarita £9""\n""2. Pepperoni £10""\n""3. Hawaiian £11"

#3. Add dish to order
new_transaction = Transaction.new("Paddy", 07945612345)
dominos = Menu.new([[number: 1, dish: "Margarita", price: 9],[number: 2, dish: "Pepperoni", price: 10],[number: 3, dish: "Hawaiian", price: 11]])
dominos.add_dish(1)
expect(dominos.show_order).to eq [[number: 1, dish: "Margarita", price: 9]]


#4. Add multiple dishes to order
new_transaction = Transaction.new("Paddy", 07945612345)
dominos = Menu.new([[number: 1, dish: "Margarita", price: 9],[number: 2, dish: "Pepperoni", price: 10],[number: 3, dish: "Hawaiian", price: 11]])
dominos.add_dish(1)
dominos.add_dish(2)
expect(dominos.show_order).to eq [[number: 1, dish: "Margarita", price: 9], [number: 2, dish: "Pepperoni", price: 10]]

#5. Raise error if number isn't entered
new_transaction = Transaction.new("Paddy", 07945612345)
dominos = Menu.new([[number: 1, dish: "Margarita", price: 9],[number: 2, dish: "Pepperoni", price: 10],[number: 3, dish: "Hawaiian", price: 11]])
dominos.add_dish("one")
expect { dominos.show_order }.to raise_error "dish not found. Make sure you've entered an integer seen in the menu."

#6. Raise error if correct number isn't entered
new_transaction = Transaction.new("Paddy", 07945612345)
dominos = Menu.new([[number: 1, dish: "Margarita", price: 9],[number: 2, dish: "Pepperoni", price: 10],[number: 3, dish: "Hawaiian", price: 11]])
dominos.add_dish(4)
expect { dominos.show_order }.to raise_error "dish not found. Make sure you've entered an integer seen in the menu."

#7. Add multiple dishes to order
new_transaction = Transaction.new("Paddy", 07945612345)
dominos = Menu.new([[number: 1, dish: "Margarita", price: 9],[number: 2, dish: "Pepperoni", price: 10],[number: 3, dish: "Hawaiian", price: 11]])
dominos.add_dish(1)
dominos.add_dish(2)
expect(dominos.grand_total).to eq "the total was #{@total}"


#8. Add multiple dishes to order
new_transaction = Transaction.new("Paddy", 07945612345)
dominos = Menu.new([[number: 1, dish: "Margarita", price: 9],[number: 2, dish: "Pepperoni", price: 10],[number: 3, dish: "Hawaiian", price: 11]])
dominos.add_dish(1)
dominos.add_dish(2)
expect(dominos.checkout).to eq 


```
## 4. Create Examples as unit Tests

```ruby

# Transaction class
#-------------------


# 1. show_order method = empty array
new_transaction = Transaction.new("Paddy", 07945612345)
expect(new_transaction.show_order).to eq []


#. error if name is not a string

#. error if phone is not an integer

# Menu class
#-------------------

#1. show_menu
dominos = Menu.new([[number: 1, dish: "Margarita", price: 9],[number: 2, dish: "Pepperoni", price: 10],[number: 3, dish: "Hawaiian", price: 11]])
expect(dominos.show_menu).to eq "1. Margarita £9""\n""2. Pepperoni £10""\n""3. Hawaiian £11"




# TextAlert class
#-------------------
  


```


_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
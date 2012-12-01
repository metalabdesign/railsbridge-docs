!SLIDE subsection
# Ruby Programming for Beginners


!SLIDE
## Language/Library/Framework

A **language** is code that can be used to create an application.

* Ruby, Java, C/C++, etc...

A **library** is a collection of resuable code to accomplish a generic activity.

* Gems, XML parser, spell checker, etc...

A **framework** is collection of resuable code to facilitate development of a particular product or solution.

* Ruby on Rails, Zend Framework (PHP), ASP.Net (C#), etc...


<!SLIDE subsection incremental>
## Ruby Philosophy


>I believe people want to express themselves when they program.
>  
>They don't want to fight with the language.
>
>Programming languages must feel natural to programmers.
>
>I tried to make people enjoy programming and concentrate on the fun and creative part of programming when they use Ruby.

 — [Matz](http://linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html) (Yukihiro Matsumoto), Ruby creator


!SLIDE bullets
## The Ruby Language

Ruby is an **interpreted language**:

  * Doesn't require a compiler
  * Run "on the fly" (via an **interpreter**)
  * Easy to make quick changes

Other interpreted languages include: **Python**, **Perl**, and **JavaScript**.


!SLIDE centereverything


!SLIDE subsection

# Let's start coding!


!SLIDE bullets
## Open Your Terminal

* Windows: **git bash** ![](img/git_bash.png)
* Mac: **Terminal.app** ![](img/mac_terminal_sm.png)
* Ubuntu/Linux: **Terminal**, **xterm**, etc...


!SLIDE
## Prompt

* Terminals show a line of text when you login & after a command finishes
* It's called the `prompt`, and customarily ends with a dollar sign

Whenever instructions start with `"$ "`, type the rest of the line into terminal.

Let's give the terminal a `command`, to open Interactive Ruby (IRB)

``` bash-session
$ irb
```


!SLIDE commandline
## irb: Interactive Ruby

IRB has its own prompt, which customarily ends with `>`

``` bash-session
$ irb
>
```

You can use `Control-D` to exit IRB any time.
Or type `exit` on its own line.

``` irb
> exit
$ 
```

Now you're back to the terminal's prompt.

### Windows Users!

Some people have experienced trouble with backspace, delete, and arrow keys working properly in irb - what a pain! If you run into this problem, use this command instead to launch irb.

``` bash-session
$ irb --noreadline
```


!SLIDE
## Variables

* A variable holds information
* We give it a name so we can refer to it

``` irb
> my_variable = 5
=> 5
> another_variable = "hi"
=> "hi"
> my_variable = 10
=> 10
```

Giving a variable a value is called **assignment**. In the above examples, we are assigning `5` to `my_variable` and `"hi"` to `another_variable`.


!SLIDE
## Variables
### Variable Assignment

Variables are assigned using a single equals sign (`=`).

The **right side** of the equals sign is evaluated first, then the value is assigned to the variable named on the **left side** of the equal sign.

``` ruby
apples = 5
bananas = 10 + 5
fruits = 2 + apples + bananas
bananas = fruits - apples
```


!SLIDE !bullets
## Variables
### Variable Naming

Create a variable whose name has:

* all letters (like `folders`)

* all numbers like `2000`

* an underscore (like `first_name`)
  
* a dash (like `last-name`)
  
* a number anywhere (like `y2k`)

* a number at the start (like `101dalmations`)

* a number at the end  (like `starwars2`)

What did you learn?


!SLIDE bullets
## Data types

Variables can hold many types of information, including:

* String (`"Parturient Purus"`, `'Adipiscing Mollis Tellus'`)
* Numbers (`1`, `1.5`)
* Boolean (`true`, `false`)
* Object (Collection, etc...)

!SLIDE bullets
## Data types
### String

A string is text. It must be wrapped in a matched pair of quotation marks.

``` irb
$ irb
> 'Single quotes work'
=> "Single quotes work"
> "Double quotes work"
=> "Double quotes work"
> "Start and end have to match'
">
```
  
What is happening on the last two lines?  How would you solve it?


### Exercises

1. Create variables called `first_name`, `last_name`, and `favorite_color`.
2. Assign the variables to strings.


!SLIDE
## Data Types
### Numbers

Numbers without decimal points are called **integers** and numbers with decimal points are called **floats**.

#### Examples of Integers

``` ruby
0
-105
898989898
2
```

#### Examples of Floats

``` ruby
0.0
-105.56
.33
.00004
```

You can perform operations on both types of numbers with these characters: `+`, `-`, `/`, `*`
	
	
### Exercises	

1. Try dividing an integer by an integer. Try dividing an integer by a float. How are the results different? 
2. Create two integer variables called `num1` and `num2` and assign them your favorite numbers.
3. Next, compute the [sum](http://en.wikipedia.org/wiki/Summation), [difference](http://en.wikipedia.org/wiki/Difference_%28mathematics%29), [quotient](http://en.wikipedia.org/wiki/Quotient), and [product](http://en.wikipedia.org/wiki/Product_%28mathematics%29) of these two numbers and assign these values to variables called `sum`, `difference`, `quotient`, and `product` respectively.


!SLIDE
## Data Types
### Boolean

A boolean is one of only two possible values: `true` or `false`.

``` irb
> 1 + 1 == 2
=> true
> 1 + 1 == 0
=> false
```

(`==` means "is equal to". _More on that later._)


### Exercises

1. Create a variable named `favorite_color` and assign it to your favorite color.
2. Create a variable named `not_favorite_color` and assign it to a different color.
3. Test to see if these variables are equal.


!SLIDE
## Operators

Operators are used to manipulate variables and values.

``` irb
> my_variable = 5
=> 5
> my_variable + 2
=> 7
> my_variable * 3
=> 15

> string_one = "this is a string."
=> "this is a string."
> string_two = " this is also a string."
=> " this is also a string."
> string_one + string_two
=> "this is a string. this is also a string."
```


### Exercises 

1. Create variables for your **first name** and **last name** as well as **favorite colour**
2. Print out a sentence that reads "Hi, my name is (first name) (last name) and my favorite color is (favorite color)."
3. Extra: string interpolation with `#{}` 


!SLIDE
## Conditionals

Do something only if a condition is `true`:

``` irb
> age = 15
=> 15
> if age >= 12
?> puts "teenager!"
?> end
=> "teenager!"
```

... or **else**:

``` irb
> if age >= 12
?> puts "teenager!"
?> else
?> puts "child!"
?> end
```


!SLIDE
## Loops

Repeatedly do something a certain number of times:

``` irb
> 3.times do
?> puts "hello"
?> end
"hello"
"hello"
"hello"
=> 3
```


### Exercises

1. Create a loop that counts from `0` to `10`
2. Hint: use a variable


!SLIDE
## Collection
### Array

An array is a list.

Array is defined between **square brackets** (`[`, `]`). A comma separates each **element**.

``` irb
> fruits = ["kiwi", "strawberry", "plum"]
=> ["kiwi", "strawberry", "plum"]
```


### Exercises	

1. Make your own array and name it `grocery_list`
2. Include at least 5 items from your grocery list in the array


!SLIDE
## Collection
### Array
#### Indexes / Indices

Elements of an array are stored in order. Each can be accessed by its `index`. In programming, most indexes **start at 0**, not 1.

``` irb
> fruits[0]
=> "kiwi"
> fruits[1]
=> "strawberry"
> fruits[2]
=> "plum"
```


### Exercises	

1. Use your `grocery_list` from previous exercises
2. Print out the element at index `0`, `3`, and `5`


!SLIDE
## Collection
### Hash

A Hash is a collection of pairs.

Hash is defined between **curly braces** (`{`, `}`). A comma separates each **entry**. A entry consists of a **key** and a **value** pair, separated by a "arrow" (`=>`).

``` irb
> provinces = { "BC" => "British Columbia", "AB" => "Alberta" }
=> {"BC"=>"British Columbia", "AB"=>"Alberta"}
```

Hash is also known as **dictionary** or **associative array**. The keys within a hash must be unique.


### Exercises

1. Create a Hash for all of Canadian provinces


!SLIDE
## Collection 
### Hash
#### Hash Access

Entries in a hash can be accessed by their key:

``` irb
> provinces["AB"]
=> "Alberta"
```


### Exercises

1. Try assigning a different value to an existing entry
2. Try assigning a value to an non-existing entry


!SLIDE
## Methods

A **method** is a collection of code that accomplishes a specific purpose.

The act of getting the method to perform its job is call **invoking** (or **calling**) it. Some methods **return** a value:

``` ruby
secret = rand()
```

Some methods while not returning anything, perform other functions instead:

``` ruby
puts(secret)
```

A method is a great way of collecting useful sets of code and reusing them later.

In Ruby, you can create a method with `def` and `end`:

``` ruby
def say_something()
  puts("Hello World!")
end
```

To call the methods:

``` ruby
say_something()
```


### Exercises

1. Create a method that prints "Hi, my name is (my name)."


!SLIDE
## Methods
### Method Parameters

The built-in `puts` method accepts a **parameter**. A parameter is information **passed to** the method.

To define a method that accepts a parameter:

``` ruby
def say_text(input)
  puts(input)
end
```

Additional parameters are separated by comma (`,`):

``` ruby
def say_two_things(input1, input2)
  puts(input1)
  puts(input2)
end
```

Inside the method, parameters are just like variables.


### Exercises

1. Create a method that takes a `name` parameter and prints "Hi, my name is (the name parameter)."


!SLIDE
## Methods
### Method Return

A method can optionally **return** something. The built-in `rand` method returns a random number between `0` and `1`. When a method returns, its execution is also terminated. What the method returns is called the **return value** of a method.

To return from a method:

``` ruby
def hello()
  return "Hello World!"
end

def age()
  return 28
end

def weight(age)
  if age < 10
    return 5
  else
    return 10
  end
end
```

The return value can be assigned to a variable, and used just like any other values:

``` ruby
my_text = hello()
my_age = age()
```

In Ruby, as a convenience, the last expression in your method is always returned. For example, these two methods are equivalent:

``` ruby
def adder(a, b)
  value = a + b
  return value
end
```

``` ruby
def adder(a, b)
  value = a + b
  value
end
```


!SLIDE
## Objects

An **object** is a entity that contains **attributes** and **methods**. The attributes of an object describe its properties, and the methods of an object describe the actions the object can perform.

We interact with objects via the **dot notation**. For example:

``` ruby
puts plane.altitude
plane.call_sign = "oceanic 815"
plane.take_off()
```


!SLIDE
## Objects
### Objects in Ruby

Everything in Ruby is an objects.

**Array** ([ruby-doc.org/core-1.9.3/Array.html](http://www.ruby-doc.org/core-1.9.3/Array.html))

``` ruby
[7,1,0,3,4].length
[1,2,3].concat([4,5,6])
[1,2,8,3,6,3,1,9,8].uniq.sort
```

**Hash** ([ruby-doc.org/core-1.9.3/Hash.html](http://www.ruby-doc.org/core-1.9.3/Hash.html))

``` ruby
{ name: "Billy", age: 27 }.empty?
```

**String** ([ruby-doc.org/core-1.9.3/String.html](http://www.ruby-doc.org/core-1.9.3/String.html))

``` ruby
"My Name is ".concat("Billy")
```

**Integer** ([ruby-doc.org/core-1.9.3/Integer.html](http://www.ruby-doc.org/core-1.9.3/Integer.html))

``` ruby
13.even?
```


!SLIDE
## Class

A **class** is the blueprint that we use to create objects. An object created from a class is called a **instance** of that class.

A class is defined between `class` and `end`:

``` ruby
class Plane
  attr_accessor :altitude
  attr_accessor :call_sign
  
  def take_off
    puts "#{self.call_sign} is taking off"
  end
  
  def land
    puts "#{self.call_sign} is landing"
  end
  
  def report
    puts "Current altitude: #{self.altitude}"
  end
end
```

In the above example:

* We create a class called "Plane"
* A "Plane" has two properties: `altitude` and `call_sign`
* A "Plane" can `take_off`, `land`, and `report`

To actually create a "Plane":

``` ruby
plane1 = Plane.new
plane1.altitude = 500
plane1.call_sign = "oceanic 815"
plane1.take_off
```


!SLIDE
## Class
### Inheritance

Inheritance is the means by which one class extends the functionalities/properties of another. The class the new class is based on is called the **parent**, and the new class is called the **child**.

The child has all the attributes and methods of its parent, as well as any additional attributes and methods that the child defines. The parent on the other hand, does not gain any additional attributes and methods from its child.

Inheritance is achieved with the `<` symbol:

``` ruby
class Jet < Plane
  attr_accessor :weapon
  
  def fire
    puts "#{self.call_sign} is firing #{self.weapon}"
  end
end

plane2 = Jet.new
plane2.weapon = "guns"
plane2.altitude = 6000
plane2.call_sign = "Maverick"
plane2.report
```


!SLIDE
# Running Your Code

!SLIDE subsection
## Interpreter

Ruby is an interpreted language. Ruby code isn't run by the computer directly. It first must go through a Ruby interpreter.

The most common interpreter is Matz's Ruby Interpreter ("MRI"). There are many others.

There are various ways to run code through a Ruby interpreter. We were using IRB earlier and now we will use a file.


!SLIDE
## Running Code From a File
### Create the File

> Why use a file? What's different from, say, irb?

Note which folder your terminal is currently in, this is your `working directory` (you can find this out by typing `pwd` into your shell).

In your text editor, create a file named `hello.rb` inside your working directory.

``` ruby
puts "Hello, World!"
```

## Running Code From a File
### Run the Saved Code

We can tell the ruby interpreter to run our code:

``` bash-session
$ ruby hello.rb
Hello World!
```


## Running Code From a File
### Command-Line Arguments (`ARGV`)

The `ARGV` variable is a special array that's available to the script when it's run from the command-line.

Change your code to:

``` ruby
puts "Hello, #{ARGV.first}!"
```

... and run it:

``` bash-session
$ ruby hello.rb Alice
Hello, Alice!
```


### Exercises

1. What happens if you now run your script without a argument?
2. What can you do to make you script work both with and without argument?


!SLIDE
# Let's Create Projects!


!SLIDE
## Project 1:
### [Personal Chef Lab](http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html)
_(start at "4. Objects, Attributes, and Methods")_

Topics:

* Command-line program. Practice in Ruby syntax and OOP concepts, and creating command-line programs.

* Explore strings: concatenation, manipulation, interpolation, coercion.

* Symbols, nil, basic math operators, blocks, method chaining, passing parameters to methods, iteration, branching, conditionals & conditional looping.


!SLIDE
## Project 2:
### [Encryptor Lab](http://tutorials.jumpstartlab.com/projects/encryptor.html)

Topics:

* Command-line program.  Reinforce skills learned in Personal Chef.

* Explore how to manipulate arrays, do more elaborate strings manipulations, refactor code, take advantage of character mapping, and  access the filesystem from within code.


!SLIDE
## Project 3:
### [Event Manager Lab](http://tutorials.jumpstartlab.com/projects/eventmanager.html)

Topics:

* Command-line program. Reusing others code & data, refactoring your own code & cleaning up data, writing custom code to solve requirements.

* Gems, `initialize` method, parameters, file input/output, processing/sanitizing data, looping, conditional branching, using file-based data storage (CSV, XML, JSON), accessing an external API, nils, DRY principle, constants, sort_by, more string manipulations.


!SLIDE
## Project 4:
### Testing & More

A follow-up to EventManager focusing more on Ruby object decomposition and working with Command Line Interfaces and program control flow.

1. [Testing](http://tutorials.jumpstartlab.com/topics/internal_testing/rspec_and_bdd.html) Topics: TDD, BDD, Rspec
_(stop at "Exceptions")_
2. [Event Reporter Lab](http://tutorials.jumpstartlab.com/projects/event_reporter.html) Topics: Object decomposition, working with Command Line Interfaces, and program control flow. Continues project created in Event Manager lab.
3. [Rspec](http://tutorials.jumpstartlab.com/topics/internal_testing/rspec_practices.html )

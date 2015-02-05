ruby_bits
=========

Code School - Learn the core bits every Ruby programmer should know

LEVEL 1 - Expressions
---------------------

#### An overview of best practices for writing expressions in Ruby

There are lots of sugar syntax smelting across ruby let's see some of them:

###### - Unless:

Sometimes you may wan't to settle logic over an negative assumption. On those cases instead of using the negative of a certain expression you can use `unless`.

**Ex.:** bad code:

```ruby
  if ! books.empty?
    puts "Our books:"
    puts books
  end
```

good code:

```ruby
  unless books.empty?
    puts "Our books:"
    puts books
  end
```

*ps.:* If, for any reason, you come to need an else over this, is it better to switch back to `if` and `else` starting with affirmative conditions instead.

###### - NIL is FALSE:

In ruby `NIL` is treated as `FALSE` when it comes to conditions.

**Ex.:** bad code:

```ruby
  if attachment.file_path != nil
    attachment.post
  end
```

good code:

```ruby
  if attachment.file_path
    attachment.post
  end
```

*ps.:* Be careful because sometimes what you think will be evaluated in one way goes to another. `""` treated as `true`; `0` treated as `true`; `[]` treated as `true`;

###### - INLINE:

Some times you'll need to test some conditions, and for make it readable so you can try inline `if`/`unless`.

**Ex.:** bad code:

```ruby
  if password.length < 9
    fail "Password too short";
  end
  unless username
    fail "No user name set";
```

good code:

```ruby
  fail "Password too short" if password.length < 9
  fail "No user name set" unless username
```

###### - SHORT-CIRCUIT - "AND":

The logical *AND* is expressed in Ruby as `&&`, and it work only evaluating a second statement when first is true. Maybe sometimes you'll have two levels of `if` that can be keep together, using the *AND*.

**Ex.:** bad code:

```ruby
  if user
    if user.loged_in?
      #
    end
  end
```

good code:

```ruby
  if user && user.loged_in?
    #
  end
```

###### - SHORT-CIRCUIT - "ASSIGNMENT":

When you're assigning something to a variable is ruby, is important that you keep in mind the evaluation sequence. If you have a double AND, the second statement will be only be evaluated when first was true; when you have a false, it will be evaluate only when it has a false;

```ruby
result = nill || 1 #result is 1
result = 1 || nill #result is 1
result = 1 || 2  #result is 1
```

**Ex.:** bad code:

```ruby
  tweets = timeline.tweets
  tweets = [] unless tweets
```

good code:

```ruby
  tweets = timeline.tweets || []
```

*ps.:* You can use this conditional assignments to set defaults to variables.

**Ex.:** bad code

```ruby
  options[:country] = 'us' if options[:country].nill?
  options[:privacy] = true if options[:privacy].nill?
  options[:geotag] = true if options[:geotag].nill?
```

good code:

```ruby
  options[:country] ||= 'us' #it verifies about bee nil and than assign it.
  options[:privacy] ||= true
  options[:geotag] ||= true
```

LEVEL 2 - Methods and Classes
-----------------------------

#### Passing optional arguments, raising exceptions, using begin/rescue/end, attr_accessor vs. attr_reader

There are lots of sugar syntax smelting across ruby let's see some of them:

##### METHODS:

###### - Optional Arguments:

Sometimes we could have a method with multiple arguments, but only a few of them will be always sent. This kind of method is difficult to read, and also to use, when isn't clear what all those parameters are.

Traditionally the calls for such method will be fulled of nil. In ruby there is 3 main ways to get around that:

####### - Default Arguments:

To set defaults to your method's parameters you should atribute the default value as you right down the method interface and parameters declaration, so every time you call this methods won't be necessary to set them.

**Ex.:** bad code:

```ruby
def tweet(message, lat, long)
  #...
end

tweet("Practicing Ruby!", nil, nil)
```

good code:

```ruby
def tweet(message, lat = nil, long = nil)
  #...
end
```

####### - Named Arguments:

When you start to have more and more arguments, sometimes is difficult to go around them only using defaults. So many times in a set of 4 arguments only the last one is required, and for that you will have to set placeholders for them, even you'he them managed with defaults. One way to solved that is using hash argument, setting whats necessary with its references keys.

**Ex.:** bad code:

```ruby
def tweet(message, lat = nil, long = nil, reply_id = nil)
  #...
end

tweet("Practicing Ruby!", nil, nil, 227946)
```

good code:

```ruby
def tweet(message, options = {})
  status = Status.new
  status.lat = options[:lat]
  status.long = options[:long]
  status.body = message
  status.reply_id = options[:reply_id]
  status.post
end

tweet("Practicing Ruby!",
  :reply_id => 227946
 )
```

####### - Raise Exception:

Sometimes we need to keep it clear that our code is facing and handling an error, and we can do that creating different kinds of objects, ruby as some other languages has an appropriated implementation pattern for that, they're the `Exceptions`. using exceptions is cleared to callers what is expected to be causing errors, handling them as the same.

**Ex.:** bad code:

```ruby
def get_tweets(list)
  if list.authorized?(@user)
    list.tweets
  else
    []
  end
end

tweets = get_tweets(my_list)
if tweets.empty?
  alert "No tweets were found!" +
  "Are you authorized to access this list?"
end
```

good code:

```ruby
def get_tweets(list)
  unless list.authorized?(@user)
    raise AuthorizationException.new
  end

  list.tweets
end

begin
  tweets = get_tweets(my_list)
rescue AuthorizationException
  warn "You are not authorized to access to access this list."
end
```

####### - "SPLAT" Arguments:

There're sometimes that we need to send lots of same type arguments inside a method, in ruby you can use SPLAT arguments for that.

**Ex.:** bad code:

```ruby
def mention(status, name1 = nil, name2 = nil)
  #...
end
```

good code:

```ruby
def mention(status, *name)
  tweet("#{names.join(' ')} #{status}")
end

mention('Your courses rocked!', 'eallam', 'greggpollack')
```

##### CLASSES:

Why do we need classes? Sometimes we do need to represent unique objects, with unique state, and that behave somehow unique over this state. For those cases ruby, as any other object oriented language, has classes.

Imagine that you need to print the following user names, and each name is formed by first and surname. Imagine now that, at some point you got a celebrity that is only known by its artistic name, how to print its name? How to behave differently based in the internal state?

**Ex.:** bad code:

```ruby
user_names = [
  ["Ashton", "Kutcher"],
  ["Wil", "Wheaton"],
  ["Madonna"]
]

user_names.each { |n| puts "#{n[1]}, #{n[0]}"}

Kutcher, Ashton
Wheaton, Wil
, Madonna
```

good code:

```ruby
class Name
  def initialize(first, last = nil)
    @first = first
    @last = last
  end
  def format
    [@last, @first].compact.join(', ')
  end
end

user_names = []
user_names << Name.new('Ashton', 'Kutcher')
user_names << Name.new('Wil', 'Wheaton')
user_names << Name.new('Madonna')
user_names.each { |n| puts n.format }

Kutcher, Ashton
Wheaton, Wil
Madonna
```

LEVEL 3
-------

#### Encapsulation, instance & private methods, inheritance, and refactoring

LEVEL 4
-------

#### Helpers that are built on top of the Ruby Language (arrays, dates, hashes, numbers, and strings

LEVEL 5
-------

#### Namespacing methods, Mixins vs. class inheritance, method hooks, ActiveSupport::Concern

LEVEL 6
-------

#### Iterating and yielding, passing arguments, returning variables, Enumerable, and refactoring

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

####### - Oversharing? Attribute accessor and reader

As we've saw an object could have state and behaviour. Most of state will be modified as long as the object exists, for those rubby provides a `attr_accessor` which meand to create internal gets and setters for each listed attribute.

```ruby
class Tweet
  attr_accessor :status, :created_at
  def initialize(status)
    @status = status
    @created_at = Time.new
  end
end

tweet = Tweet.new("Eating breakfast.")
tweet.created_at = Time.new(2084,1,1)
```

Sometimes you don't need that every state change over time, some objects should be immutable instead, for those cases ruby provides another accessor called `attr_reader`. This one only implements getters for those informed attributes.

```ruby
class Tweet
  attr_accessor :status
  attr_reader :created_at
  def initialize(status)
    @status = status
    @created_at = Time.new
  end
end

tweet = Tweet.new("Eating breakfast.")
tweet.created_at = Time.new(2084,1,1) #undefine method

```

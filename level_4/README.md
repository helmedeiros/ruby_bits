LEVEL 4
-------

#### Activesupport

Active support is a toolkit of support libraries and Ruby core extensions extracted from the Rails framework. Rich support for multibyte strings, internationalization, time zones, and testing. You can check more about it [here](https://rubygems.org/gems/activesupport).

##### Install and Load it

To install and use the `activesupport` gem you'll need to do:

First, to install both `gem` `activesupport` and `i18n` given the coupling between them:

```shell
  gem install activesupport
  gem install i18n
```

After that, inside your ruby file you will need to load it. Is important to see that you may don't need all classes to be load, so when you discover what you need change the loading.

```ruby
  require 'active_support/all'
```

##### Core extensions: ARRAY

Activesupport add tons of helpers for classes such `Array`. Remember that ruby allow us to open and extend any class as needed. Saying that, imagine that we have an array with 7 positions, and from where we need to create different subarrays combinations and split operations. Let's see how to do that using the `activesupport` helpers.

######from(position) ⇒ Object

Returns the tail of the array from position.

```ruby
  array = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
  array.from(0) # => ['a', 'b', 'c', 'd', 'e', 'f', 'g']
  array.from(3) # => ['d', 'e', 'f', 'g']
  array.from(-2) # => ['f', 'g']
```

######to(position) ⇒ Object

Returns the beginning of the array up to position.

```ruby
  array = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
  array.to(0) # => ['a']
  array.to(3) # => ['a', 'b', 'c', 'd']
  array.to(-3) # => ['a', 'b', 'c','d', 'e']
```

######in_groups_of(number, fill_with = nil) ⇒ Object

Splits or iterates over the array in groups of size number, padding any remaining slots with fill_with unless it is false.

```ruby
  array = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
  array.in_groups_of(0) # ERROR
  array.in_groups_of(1) # => ["a"] ["b"] ["c"] ["d"] ["e"] ["f"] ["g"]
  array.in_groups_of(2) # => ["a", "b"] ["c", "d"] ["e", "f"] ["g", nil]
```

######split(value = nil) ⇒ Object

Divides the array into one or more subarrays based on a delimiting value or the result of an optional block.

```ruby
  array = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
  array.split('c') # => [["a", "b"], ["d", "e", "f", "g"]]
```

##### Core extensions: Date and DateTime

Activesupport add tons of helpers for classes such as `Date` and `DateTime`. Remember that ruby allow us to open and extend any class as needed. Saying that, imagine that we have a date, and we want to know what is the next, previous or even the first day of the current week. Let's see how to do that using the `activesupport` helpers.

#######at_beginning_of_day ⇒ Object

Converts Date to a Time (or DateTime if necessary) with the time portion set to the beginning of the day (0:00)

```ruby
  apocalypse = DateTime.new(2012, 12, 21, 14, 27, 45)
  puts apocalypse.at_beginning_of_day # => 2012-12-21T00:00:00+00:00
```

#######at_end_of_month ⇒ Object

Converts Date to a Time (or DateTime if necessary) with the time portion set to the end of the last day of the current month (23:59:59)

```ruby
  apocalypse = DateTime.new(2012, 12, 21, 14, 27, 45)
  puts apocalypse.at_end_of_month # => 2012-12-31T23:59:59+00:00
```

#######at_beginning_of_year ⇒ Object

Converts Date to a Time (or DateTime if necessary) with the time portion set to the end of the first day of the current year (00:00)

```ruby
  apocalypse = DateTime.new(2012, 12, 21, 14, 27, 45)
  puts apocalypse.at_beginning_of_year # => 2012-01-01T00:00:00+00:00
```

#######advance(options) ⇒ Object

Uses Date to provide precise Time calculations for years, months, and days. The options parameter takes a hash with any of these keys: `:years`, `:months`, `:weeks`, `:days`, `:hours`, `:minutes`, `:seconds`.

```ruby
require 'active_support/all'

apocalypse = DateTime.new(2012, 12, 21, 14, 27, 45)
puts apocalypse.advance(years: 1) # => 2013-12-21T14:27:45+00:00
puts apocalypse.advance(months: 2) # => 2013-02-21T14:27:45+00:00
puts apocalypse.advance(weeks: 3) # => 2013-01-11T14:27:45+00:00
puts apocalypse.advance(days: 4) # => 2012-12-25T14:27:45+00:00
puts apocalypse.advance(years: 1, months: 2, weeks: 3, days: 4) # => 2014-03-18T14:27:45+00:00

```

#######.tomorrow ⇒ Object

Returns a new Date representing the date 1 day after today (i.e. tomorrow's date).

```ruby
require 'active_support/all'

apocalypse = DateTime.new(2012, 12, 21, 14, 27, 45)
puts apocalypse.tomorrow # => 2012-12-22T14:27:45+00:00

```

#######.yesterday ⇒ Object

Returns a new Date representing the date 1 day ago (i.e. yesterday's date).

```ruby
require 'active_support/all'

apocalypse = DateTime.new(2012, 12, 21, 14, 27, 45)
puts apocalypse.yesterday # => 2012-12-20T14:27:45+00:00

```

##### Core extensions: Hash

Activesupport add tons of helpers for classes such as `Hash`. Remember that ruby allow us to open and extend any class as needed. Saying that, imagine that we receive a option hash, and we want to set some default values, or have its keys as strings. Let's see how to do that using the `activesupport` helpers.

#######reverse_merge(other_hash) ⇒ Object

Merges the caller into other_hash.

```ruby
  require 'active_support/all'

  def user(options={})
    defaults = {lang: "pt-br", country: "br"}
    options.reverse_merge(defaults)
  end

  puts user({lang: "en", user: "helmedeiros"})

```

#######stringify_keys ⇒ Object

Returns a new hash with all keys converted to strings.

```ruby
  require 'active_support/all'

  hash = { name: 'Rob', age: '28' }
  puts hash.stringify_keys

```

#######except(keys) ⇒ Object

Returns a hash that includes everything but the given keys.

```ruby
  require 'active_support/all'

  def user(options={})
    defaults = {lang: "pt-br", country: "br"}
    options.reverse_merge(defaults)
  end

  my_user = user({lang: "en", user: "helmedeiros"})

  puts "Users configuration: #{my_user.except(:user)}"

```

#######.odd and .even

Turn esay and verbose to identify when a number is even or odd.

```ruby
  require 'active_support/all'

  def background_class(index)
    return 'white' if index.odd?
    return 'grey' if index.even?
  end

  tweets = ["abc", "easy", "123", "simple", "DOREMI"]

  tweets.each_with_index do |tweet, index|
    puts "<div class='#{background_class(index)}'>#{tweet}</div>"
  end

  # => <div class='grey'>abc</div>
  # => <div class='white'>easy</div>
  # => <div class='grey'>123</div>
  # => <div class='white'>simple</div>
  # => <div class='grey'>DOREMI</div>

```

##### Inflector

The Inflector transforms words from singular to plural, class names to table names, modularized class names to ones without, and class names to foreign keys.

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

##### Core extensions: Date

Activesupport add tons of helpers for classes such `Date`. Remember that ruby allow us to open and extend any class as needed. Saying that, imagine that we have a date, and we want to know what is the next, previous or even the first day of the current week. Let's see how to do that using the `activesupport` helpers.

#######at_beginning_of_day ⇒ Object

Converts Date to a Time (or DateTime if necessary) with the time portion set to the beginning of the day (0:00)

```ruby
  apocalypse = DateTime.new(2012, 12, 21, 14, 27, 45)
  puts apocalypse.at_beginning_of_day # => 2012-12-21T00:00:00+00:00
```

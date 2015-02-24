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

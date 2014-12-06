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

The logical *AND* is expressed in Ruby as `&&`, and it work only evaluating a second statement when first is false. Maybe sometimes you'll have two levels of `if` that can be keep together, using the *AND*.

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

LEVEL 2 - Methods and Classes
-----------------------------

#### Passing optional arguments, raising exceptions, using begin/rescue/end, attr_accessor vs. attr_reader

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

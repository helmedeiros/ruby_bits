LEVEL 3
-------

#### Encapsulation, instance & private methods, inheritance, and refactoring

Object Oriented Programming tries to made logic more real world like, guiding programmers to shape their code as objects with state and behaviour. And as the real world we'd sometimes need some abstractions to keep it more visible and understandable, for that OO languages like ruby of [polymorphism](http://en.wikipedia.org/wiki/Polymorphism_(computer_science)) and [inheritance](http://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)) not only for that concepts but also to avoid code repetition([DRY](http://www.reddit.com)).

###### - Encapsulation:

Most of methods work with not local data, to accomplish its goals, but sometimes is to risk to pass Strings and numbers around. For that OO languages uses the encapsulation concept, allowing selective hiding of properties and methods in an object by building an impenetrable wall to protect the code from accidental corruption. Look the following `send_tweet` method, it receives an string and a number, the tweet's status and id of its owner, and inside it is requested to retrive the `user` using that id. This method knows to much about the implementation, maybe the better way was to encapsulate, status and owner and the `retrieve_user` into a `tweet` class.

**Ex.:** bad code:

```ruby
send_tweet('Practicing Ruby-Fu!', 14)

def send_tweet(status, owner_id)
  retrieve_user(owner_id)
end
```

good code:

```ruby
class Tweet
  attr_accessor ...
  def owner
    retrieve_user(owner_id)
  end
end

tweet = Tweet.new
tweet.status = 'Practicing Ruby-Fu!'
tweet.owner_id = current_user.id

send_tweet(tweet)

def send_tweet(message)
  message.owner
end
```

####### - Visibility:

Encapsulation is about selective hiding of properties and methods in an object, ruby allow us to do so setting different visibilities among class components. By default all methods are `public`, and if want to change that you need to use one of the three reserved scope words, public, private and protected. All of them affect all methods existing below the word. See the example below, we don't need bump_karma to be public, it will be used only internally, so we need to keep it pro

**Code.:** See the example below, by ruby default the `bump_karma` method is public, when it should't.

```ruby
class User
  def up_vote(friend)
    bump_karma
    friend.bump_karma
  end

  def bump_karma
    puts "karma up for #{name}"
  end
end

joe = User.new 'joe'
leo = User.net 'leo'

joe.up_vote(leo)

```

**Code.:** See the example below, by ruby default the `bump_karma` method is public, when it should't. We only want to be public the `up_vote`, for that we add a private statement above the `bump_karma`.

```ruby
class User
  def up_vote(friend)
    bump_karma
    friend.bump_karma
  end

  private

  def bump_karma
    puts "karma up for #{name}"
  end
end

joe = User.new 'joe'
leo = User.net 'leo'

joe.up_vote(leo)

```

**Code.:** But when we do that the sytem will break once it have a call from another instance of the same class. To have that it to be `protected` instead, because it needs to call the `bump_karma` of `friend`.

```ruby
class User
  def up_vote(friend)
    bump_karma
    friend.bump_karma
  end

  protected

  def bump_karma
    puts "karma up for #{name}"
  end
end

joe = User.new 'joe'
leo = User.net 'leo'

joe.up_vote(leo)

```

####### - Inheritance:

Sometimes you will face two classes with same behavior/state, for that O.O. will bring the inheritance concept. This will facilitate code reuse also allow independent extensions of the original software via public classes.

**Code.:** See the example below, Images and Videos can have the same state/behavior and their code shows that equality.

```ruby
class Image
  attr_accessor :title, :size, :url
  def to_s
    "#{@title}, {@size}"
  end
end

class Video
  attr_accessor :title, :size, :url
  def to_s
    "#{@title}, {@size}"
  end
end
```

**Code.:** Applying the `inheritance` concept, we could abstract their behaviour into a super class called `Attachment`.

```ruby
class Image < Attachment

end

class Video < Attachment

end

class Attachment
  attr_acessor :title, :size, :url
  def to_s

    "#{@tilte}, #{@size}"
  end
end
```

**Code.:** A method could only make sense for an specific type. For that inheritance alows subclasses to have their fields, for that you only need to declare them into a subclass.

```ruby
class Image < Attachment

end

class Video < Attachment
  attr_accessor :duration
end

class Attachment
  attr_acessor :title, :size, :url
  def to_s

    "#{@tilte}, #{@size}"
  end
end
```

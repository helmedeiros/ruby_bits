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

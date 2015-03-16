LEVEL 5
-------

#### Modules

When we're work with ruby scripts, sometimes, we may finished with a set of methods that made sense together. We could keep them inside the same file, but there are plenty of other ways to set them together as a meaningful unit. Let's see them:

##### Namespace

When we group together methods in a single file, we're defining the lot over the global scope. We're polluting it, also asking for conflicts.

Ruby has, as other programming languages, what we call namespaces. Namespaces give us different levels to identify methods and Variables. That will make possible to distinguish between identifiers with the same exact name.

IMAGE_UTILS.RB

```ruby
  def preview(image)

  end
  def transfer(image, destination)

  end  
```

After that, all you need to do is require the file.

RUN.RB

```ruby
  require 'image_utils'

  image = user.image
  preview(image)
```

A wrapper file could represent a big problem when by default Ruby set all its identifies together in a global scope. First it pollutes the global namespace. Also generating potential conflicts with methods with same name.

One way to solve that is wrapping them over a module, doing that we set all of them over the prefixed module name. See the following example

IMAGE_UTILS.RB

```ruby
  module  ImageUtils
    def preview(image)

    end
    def transfer(image, destination)

    end  
  end
```

RUN.RB

```ruby
  require 'image_utils'

  image = user.image
  ImageUtils.preview(image)
```

##### Mixin

A common pattern in Ruby is to `include` modules inside classes, this will expose the methods as instances methods on the current class.

IMAGE_UTILS.RB

```ruby
  module  ImageUtils
    def preview

    end
    def transfer(destination)

    end  
  end
```

AVATAR.RB

```ruby
  require 'image_utils'

  class Image
    include ImageUtils
  end

```

RUN.RB

```ruby
  require 'avatar'

  image = user.image
  image.preview

```

Note that when we do so, the included class gain access to the including atributes and methods. Saying that, we don't need to send them as parameters anymore.

##### Ancestors

When we include a module in a class, what is happinig is that the module is being injected inside the ancestors class.

AVATAR.RB

```ruby
  require 'image_utils'

  class Image
    include ImageUtils
  end

```

```ruby
  Image.ancestors  # => [Image, ImageUtils, Object, Kernel, BasicObject]
  Image.included_modules # =>   [ImageUtils, Kernel]
```

##### Mixin vs Class Inheritance

Looking at how mixin happens, you should be asking yourself: when will I choose mixin rather than inheritance? Remember that in ruby a class can only have one superclass, and it should always suggest a specialization. See the example below. On it our first move to remove duplication could be inheritance, but we don't have specialization, so we should preter to apply mixin instead.

**Ex.:** bad code - With duplicated code:

```ruby
  class Post
    def share_on_facebook
    end
  end

  class Image
    def share_on_facebook
    end
  end

  class Tweet
    def share_on_facebook
    end
  end
```

**Ex.:** bad code - Removing duplicated code using inheritance:

```ruby
  class Shareable
    def share_on_facebook
    end
  end

  class Post < Shareable
  end

  class Image < Shareable
  end

  class Tweet < Shareable
  end
```

good code - using mixin instead of inheritance:

```ruby
  module Shareable
    def share_on_facebook
    end
  end

  class Post
    include Shareable
  end

  class Image
    include Shareable
  end

  class Tweet
    include Shareable
  end
```

good code - mixin allowing code reuse from more than one source:

```ruby
  module Shareable
    def share_on_facebook
    end
  end

  module Favoritable
    def add_to_delicius
    end
  end
```

##### Mixin - Class Methods

Sometimes we could have a class that only expose methods as class methods, for those cases we'll need to do so not using `include` but `extend` instead.

```ruby
  module Searchable
    def find_all_from(user)
    end
  end

  class Tweet
    extend Searchable
  end

  Tweet.find_all_from('@helmedeiros')
```

##### Mixin - Instance methods from an Object

Sometimes we'll only be expecting a object to behave like some module, not all instaciated objects from a specific class. For that we can also use `mixin`, but instead of `extend` or `include` it from its class, we'll do so after instantiation, directly into the new object.

```ruby
  module ImageUtils
    def preview
    end
  end

  class Image
  end

  image = Image.new
  image.extend(ImageUtils)
  image.preview

  image = Image.new
  image.preview # => NoMethodError: undefined method 'preview for #<Image:0x123b123a12>'
```

##### Hooks - Self.included

Sometimes a module could have some methods that you may want to expose as a class methods, while others could be requested to be as an instance one. To do so you could think to have a module and a inner module, splitting the expected class methods from those who is wanted to keep as instance ones. The class methods will be `extend` while the instances will be `include`. This a bad way to do so. In ruby we have `hooks`, let's see how to use them.

**Ex.:** bad code - Module methods being called by an instance and a class:

```ruby
  module ImageUtils
    def preview
    end
    def transfer(destination)
    end
    module ClassMethods
      def fetch_from_twitter(user)
      end
    end
  end

  class Image
    include ImageUtils
    extend ImageUtils::ClassMethods
  end

  image = user.image
  image.preview

  Image.fetch_from_twitter('helmedeiros')
```

good code - instead you can have a self.included method

```ruby
  module ImageUtils
    def self.included(base)
      base.extend(ClassMethods)
    end
    def preview
    end
    def transfer(destination)
    end
    module ClassMethods
      def fetch_from_twitter(user)
      end
    end
  end

  class Image
    include ImageUtils
  end

  image = user.image
  image.preview

  Image.fetch_from_twitter('helmedeiros')
```

##### ActiveSupport - Concern

As we saw earlier ruby has lots of util gems, among them we do have the `ActiveSupport`. The `ActiveSupport::Concern` give us a simple pattern to follow to deal with modules dependencies, also a better way to include and extend modules from any class.

References: [Claudia Farias - Keep Coding](http://scriptogr.am/krawdyah/post/rails-e-concerns), [Ryan - My issues with Modules](https://gist.github.com/ryanb/4172391), [DHH - Put chubby models ib a diet with concerns](https://signalvnoise.com/posts/3372-put-chubby-models-on-a-diet-with-concerns), [Bryan Helmkamp - 7 patterns to refactor fat activerecord models](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/)

**Ex.:** bad code - Module methods being called by an instance and a class:

```ruby
  module M
    def self.included(base)
      base.extend ClassMethods
      scope :disabled, where(:disabled => true)
    end

    module ClassMethods
    end
  end

  require 'active_support/concern'
```

good code - cleanner code using concerns

```ruby
  module M
    extend ActiveSupport::Concern

    included do
      scope :disabled, where(:disabled => true)
    end

    module ClassMethods
    end
  end
```

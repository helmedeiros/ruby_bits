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

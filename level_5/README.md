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

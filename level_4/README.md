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

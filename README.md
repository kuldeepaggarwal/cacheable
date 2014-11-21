# Cacheable

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cacheable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cacheable

## Usage

1. Include `cacheable` module in the model, and then it will provide you
`cache_has_many` class method for defining `has_many` associations.

```ruby
class User < ActiveRecord::Base
  include Cacheable

  cache_has_many :posts, dependent: :destroy
end

user = User.last
user.posts
# => #<ActiveRecord::Associations::CollectionProxy [#<Post id: 31, title: "new test", user_id: 3, created_at: "2014-11-21 15:59:33", updated_at: "2014-11-21 15:59:49">]>
user.cache_posts # => [#<Post id: 31, title: "new test", user_id: 3, created_at: "2014-11-21 15:59:33", updated_at: "2014-11-21 15:59:49">]
```

+Note:+ `cache_<association>` will always return you an array, so it is not chainable.


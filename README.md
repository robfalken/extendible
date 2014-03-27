# Extendible

Let referenced objects in your ActiveModel::Serializer based API only include ID attribute by default, and extend them using URL parameters.

e.g. `https://api/resource?extend=author.name,author.username` to extend your referenced author with its name and username attributes.

## Installation

Add this line to your application's Gemfile:

    gem 'extendible'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install extendible

## Usage

You need to scope your params to the serializer by adding this to your controller:

    serialization_scope :params

and also include extendible in your serializer class:

    include Extendible     

Then you can define your extendible references simply by adding this your serializer

    extendible :author

You can also make multiple referenced objects extendible        
    
    extendible :author, :category

*full example of app/serializers/post_serializer.rb*

    class PostSerializer < ActiveModel::Serializer
      include Extendible

      attributes :id,
                 :subject,
                 :body


      extendible :author
    end

This will by default only include the id attribute for your author object

    {
      ...
      "author": {
        "id": 1
      }
    }

You can then extend the object by passing `?extend=author` in the URL, which will include all author attributes

    {
      ...
      "author": {
        "id": 1,
        "name": "Robert Falken",
        "username": "robertfalken"
      }
    }

Or, if you would like to only get the username, use dot notation `?extend=author.username`

    {
      ...
      "author": {
        "id": 1,
        "username": "robertfalken"
      }
    }

You also can extend multiple objects or attributes by comma separating them `?extend=author.username,category`    

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

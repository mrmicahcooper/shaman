# Shaman

Make a MD5 Sha from a string.

If the string is a valid JSON string the parse it, sort it, and then create a
MD5.
## Installation

Add this line to your application's Gemfile:

    gem 'shaman'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shaman

## Usage

```ruby
    Shaman.new("some string").sha

    #=> "5ac749fbeec93607fc28d666be85e73a"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/shaman/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

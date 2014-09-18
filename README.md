# Rbsx

Ruby sx Wrapper

## Installation

Add this line to your application's Gemfile:

    gem 'rbsx'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rbsx

You need [sx](https://github.com/spesmilo/sx/) installed.

## Usage

Configure it:

```
Rbsx.configure do |c|
  c.sx_path = "/path/to/sx"
end
```

```
rbsx = Rbsx.new(sx_path: "/path/to_sx") # you can optionally set the path here too
rbsx.bci_fetch_last_height # 32132131
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rbsx/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Copy `spec/config.yml.sample` to `spec/config.yml` and edit as necessary.
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
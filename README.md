# DotOptions - Options object with dot-notation access

Convert any hash to a an object with deep read/write dot-notation access.

[![Gem Version](https://badge.fury.io/rb/dot_options.svg)](https://badge.fury.io/rb/dot_options)
[![Build Status](https://github.com/DannyBen/dot_options/workflows/Test/badge.svg)](https://github.com/DannyBen/dot_options/actions?query=workflow%3ATest)

---

## Install

```
$ gem install dot_options
```

## Usage

```ruby
# Initialize a DotOptions object with a hash:
opts = {
  debug:  true,
  output: { color: true },
  skin:   { background: { color: :black, texture: 'Stripes' } },
}
options = DotOptions.new opts

# Read any option with dot-notation:
p options.skin.background.color  # => :black

# Update any option with dot-notation:
options.skin.background.color = :black

# ... or create an entire branch by providing a hash
options.skin.foreground = { color: :white, font: 'JetBrains Mono' }
p options.skin.foreground.font  # => 'JetBrains Mono'
```

## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].


[issues]: https://github.com/DannyBen/dot_options/issues

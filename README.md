# DotOptions - Options object with dot-notation access

Convert any hash to a an object with deep read/write dot-notation access.

[![Gem Version](https://badge.fury.io/rb/dot_options.svg)](https://badge.fury.io/rb/dot_options)
[![Build Status](https://github.com/DannyBen/dot_options/workflows/Test/badge.svg)](https://github.com/DannyBen/dot_options/actions?query=workflow%3ATest)
[![Maintainability](https://api.codeclimate.com/v1/badges/9506098f88fd04fdefae/maintainability)](https://codeclimate.com/github/DannyBen/dot_options/maintainability)

---

## Install

```
$ gem install dot_options
```

## Usage

```ruby
require 'dot_options'

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

# Print a flat view of all options
puts options
# => debug = true
# => output.color = true
# => skin.background.color = :black
# => skin.background.texture = "Stripes"
# => skin.foreground.color = :white
# => skin.foreground.font = "JetBrains Mono"

# ... or a compact inspection string
p options
# => { debug: true, output: { color: true },
# =>   skin: { background: { color: :black, texture: "Stripes" },
# =>   foreground: { color: :white, font: "JetBrains Mono" } } }
```

### Subclassing

Subclassing `DotOptions` is a useful way to have an object with default options.

```ruby
require 'dot_options'

class Skin < DotOptions
  DEFAULTS = {
    color: :black,
    border: { color: :red, width: 3 },
    background: { color: :lime, texture: 'Stripes' },
  }

  def initialize(options = nil, *)
    opts = DEFAULTS.merge(options || {})
    super(opts, *)
  end
end

# Get an object with the default settings
skin = Skin.new 
p skin.background.color  # => :lime

# Get an object and override some settings
skin = Skin.new color: :blue
p skin.color  # => :blue
```

## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].


[issues]: https://github.com/DannyBen/dot_options/issues

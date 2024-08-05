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
# Usage
require 'dot_options'

# Initialize a DotOptions object with a hash:
opts = {
  debug:  true,
  output: { color: true },
  skin:   { background: { color: :black, texture: 'Stripes' } },
}
options = DotOptions.new opts

# Read any option with dot-notation:
p options.skin.background.color
#=> :black

# Update any option leaf with dot-notation:
options.skin.background.color = :black

# Print a flat view of all options
puts options
#=> debug = true
#=> output.color = true
#=> skin.background.color = :black
#=> skin.background.texture = "Stripes"

# ... or a compact inspection string for any branch
p options.skin
#=> <background: <color: :black, texture: "Stripes">>

# Access is also possible using []
p options.skin[:background].color
p options.skin[:background][:color]
#=> :black
#=> :black
```

### Subclassing

Subclassing `DotOptions` is a useful way to have an object with default options.

```ruby
# Subclassing
require 'dot_options'

class Skin < DotOptions
  def initialize(options = nil)
    super defaults.merge(options || {})
  end

  def defaults
    {
      color: :black,
      border: { color: :red, width: 3 },
      background: { color: :lime, texture: 'Stripes' },
    }
  end
end

# Get an object with the default options
skin = Skin.new 
p skin.background.color
#=> :lime

# Get an object and override some root options using a hash
skin = Skin.new color: :blue
p skin.color
#=> :blue

# Get an object and update some deep options using a block
skin = Skin.new { border.color = :yellow }
puts skin.border
#=> color = :yellow
#=> width = 3

# The initialization block receives the object itself which can be useful
# in some cases
skin = Skin.new do |skin|
  skin.color = :cyan
  skin.border.width = 10
end
p skin.color
p skin.border
#=> :cyan
#=> <color: :red, width: 10>
```

## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].


[issues]: https://github.com/DannyBen/dot_options/issues

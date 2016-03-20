# jekyll-press
Minifier plugin for jekyll. Minifies all html, js, css files. Simple just drop it in solution. No Java required.

This plugin:
 - compress html with the help of [html_press](https://github.com/stereobooster/html_press)
 - compress JavaScript files with the help of [uglifier](https://github.com/lautis/uglifier)
 - compress css files with the help of [css_press](https://github.com/stereobooster/css_press)

## Alternative

Gulp based workflow see: [sondr3/generator-jekyllized](https://github.com/sondr3/generator-jekyllized)

## Installation

### Bundler
Add this line to your application's `Gemfile`:
```ruby
gem 'jekyll-press'
```

And then execute:
```bash
$ bundle
```

### Standalone
Execute:
```bash
$ gem install jekyll-press
```

## Usage

### With Bundler (recomended)
Create the following plugin in your projects _plugins directory.

```ruby
# _plugins/bundler.rb
require "rubygems"
require "bundler/setup"
Bundler.require(:default)
```

This will automatically require all of the gems specified in your Gemfile.

### Standalone
Create the following plugin in your projects _plugins directory.

```ruby
# _plugins/jekyll-press-plugin.rb
require 'jekyll-press'
```

### Settings

```yaml
jekyll-press:
  exclude: 'atom.xml' # Exclude files from processing - file name, glob pattern or array of file names and glob patterns
  js_options: {}      # js minifier options
  css_options: {}     # css minifier options
  html_options: {}    # html minifier options
```

## TODO
 - add test: run against simple jekyll site and check if there is no errors
 - Minify JPEGs with [`jpegtran`](https://github.com/cmer/jpegtran) or `smush.it` ([smusher](https://github.com/grosser/smusher))
 - Minify PNGs with [`optipng`](https://github.com/martinkozak/optipng) or `smush.it` ([smusher](https://github.com/grosser/smusher))
 - Auto CSS sprites (for example [sprite factory](https://github.com/jakesgordon/sprite-factory/))

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# Minifier plugin for jekyll

Based on [plugin](https://gist.github.com/2758691) by [mytharcher](https://github.com/mytharcher)

This plugin:
 - compress html with the help of [html_press](https://github.com/stereobooster/html_press)
 - compress JavaScript files with the help of [uglifier](https://github.com/lautis/uglifier)
 - compress css files with the help of [css_press](https://github.com/stereobooster/css_press)

## Usage
 - put `jekyll_press.rb` in plugins folder
 - add gems to `Gemfile`
 - `bundle`
 - regenerate all content

## TODO
 - Minify JPEGs with `jpegtran` or `smush.it` ([smusher](https://github.com/grosser/smusher))
 - Minify PNGs with `optipng` or `smush.it` ([smusher](https://github.com/grosser/smusher))
 - Auto CSS sprites (for example [sprite factory](https://github.com/jakesgordon/sprite-factory/))
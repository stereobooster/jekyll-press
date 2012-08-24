# jekyll_press 0.0.1
# https://github.com/stereobooster/jekyll_press

require 'html_press'
require 'css_press'
require 'uglifier'

module Jekyll
  module Compressor
    def output_file(dest, content)
      FileUtils.mkdir_p(File.dirname(dest))
      File.open(dest, 'w') do |f|
        f.write(content)
      end
    end

    def output_html(path, content)
      self.output_file(path, HtmlPress.press(content))
    end

    def output_js(path, content)
      self.output_file(path, Uglifier.new.compile(content))
    rescue Uglifier::Error => e
      puts "parse error occurred while processing: #{path}"
      puts "details: #{e.message.strip}"
      puts "copying initial file"
      self.output_file(path, content)
    end

    def output_css(path, content)
      self.output_file(path, CssPress.press(content))
    rescue Racc::ParseError => e
      puts "parse error occurred while processing: #{path}"
      puts "details: #{e.message.strip}"
      puts "copying initial file"
      self.output_file(path, content)
    end
  end

  class Post
    include Compressor

    def write(dest)
      dest_path = self.destination(dest)
      self.output_html(dest_path, self.output)
    end
  end

  class Page
    include Compressor

    def write(dest)
      dest_path = self.destination(dest)
      self.output_html(dest_path, self.output)
    end
  end

  class StaticFile
    include Compressor
  	
    def copy_file(path, dest_path)
      FileUtils.mkdir_p(File.dirname(dest_path))
      FileUtils.cp(path, dest_path)
    end

    def write(dest)
      dest_path = self.destination(dest)

      return false if File.exist?(dest_path) and !self.modified?
      @@mtimes[path] = mtime

      case File.extname(dest_path)
        when '.js'
          if dest_path =~ /.min.js$/
            copy_file(path, dest_path)
          else
            self.output_js(dest_path, File.read(path))
          end
        when '.css'
          if dest_path =~ /.min.css$/
            copy_file(path, dest_path)
          else
            self.output_css(dest_path, File.read(path))
          end
        else
          copy_file(path, dest_path)
      end

      true
    end
  end
end

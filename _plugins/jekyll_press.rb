# jekyll_press 0.0.2
# https://github.com/stereobooster/jekyll_press

module Jekyll
  module Compressor
    
    class << self
      attr_accessor :html, :css, :js
      def load_gem name
        begin
          require name
          true
        rescue LoadError
          warn "Install #{name}: gem install #{name} or place it in Gemfile"
          false
        end
      end
    end

    self.html = self.load_gem 'html_press'
    self.css = self.load_gem 'css_press'
    self.js = self.load_gem 'uglifier'

    def output_file(dest, content)
      FileUtils.mkdir_p(File.dirname(dest))
      File.open(dest, 'w') do |f|
        f.write(content)
      end
    end

    if self.html
      def output_html(path, content)
        self.output_file(path, HtmlPress.press(content))
      end
    end

    if self.js
      def output_js(path, content)
        self.output_file(path, Uglifier.new.compile(content))
      rescue Uglifier::Error => e
        warn "parse error occurred while processing: #{path}"
        warn "details: #{e.message.strip}"
        warn "copying initial file"
        self.output_file(path, content)
      end
    end

    if self.css
      def output_css(path, content)
        self.output_file(path, CssPress.press(content))
      rescue Racc::ParseError => e
        warn "parse error occurred while processing: #{path}"
        warn "details: #{e.message.strip}"
        warn "copying initial file"
        self.output_file(path, content)
      end
    end
  end

  if Compressor.html
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
  end

  if Compressor.css || Compressor.js
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
            if !Compressor.js || dest_path =~ /.min.js$/
              copy_file(path, dest_path)
            else
              self.output_js(dest_path, File.read(path))
            end
          when '.css'
            if !Compressor.css || dest_path =~ /.min.css$/
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
end

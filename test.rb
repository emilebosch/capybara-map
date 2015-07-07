require 'byebug'
require 'capybara'
require 'filewatcher'
require 'capybara/dsl'
require './maps/map'
require './maps/like_button_maps'
require './maps/profile_maps'
require './maps/login_maps'
require './maps/comment_maps'
require './maps/activity_maps'

include Capybara::DSL

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

def reset!
  Capybara.reset_sessions!
end

Capybara.run_server = false
Capybara.current_driver = :chrome
Capybara.app_host = 'http://localhost:3000'

def mods
  page.all("[class*='mod-']").map  { |x| x[:class].match(/(mod-.*?(\s|$))/)[0] }
end

def mods2
  page.all("[class*='mod-']").map  { |x| [x, x[:class].match(/(mod-.*?(\s|$))/)[0]] }
end

def to_widget(css)
  x = css.gsub("mod","").gsub(/-[a-z]/) {|x|x.upcase}.gsub("-","") + "Widget"  
  begin
    Object.const_get(x)
  rescue
  end
end

def missing
  for a in mods.uniq.map {|x| [x, to_widget(x)] }.reject {| x | x[1] != nil }
    puts a[0]
  end
end

def explain
  for a in mods2.map {|x| [x[0], to_widget(x[1])] }.reject {|x|x[1] == nil}
    widget = a[1].new(a[0])
    widget.explain
  end
end

# CLI 

t = Thread.new { 
  while cmd = gets.strip
    exit    if cmd == "quit"
    explain if cmd == "explain"
    missing if cmd == "missing"
  end
}

t.abort_on_exception = true

# File watcher and runner

FileWatcher.new(["tests/*","widgets/*"]).watch do |filename|
  puts "Loading #{filename}"
  begin 
    load filename
    if filename.include? "widget"
      css = "mod-#{File.basename(filename).chomp("widget.rb").gsub("_","-")}"
      a = to_widget(css)
      for w in a.all(page)
        w.explain
      end
    end
  rescue StandardError => e
    puts e
  end
end

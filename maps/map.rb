class Map
  attr_accessor :elm

  class << self
    attr_accessor :config
  end

  def initialize(element)
    self.elm = element
  end

  def self.css_name
    ".mod" + (self.name.chomp "Widget").gsub(/([A-Z])/) { "-#{$1}".downcase }
  end

  def self.first(page)
    self.all(page).first
  end

  def self.all(page)
    page.all(self.css_name).map { |e| self.new(e) }
  end

  def self.element(name, selector)
    self.register name
    define_method name do
      elm.find selector
    end
  end

  def self.text(name, selector)
    self.register name
    define_method name do
      elm.find(selector).text
    end
  end

  def self.widget(name, selector, widget)
    self.register name
    define_method name do
      widget.new(elm.find(selector))
    end
  end

  def self.widgets(name, selector, widget)
    self.register name
    define_method name do
      elm.all(selector).map { |e| widget.new(e) }
    end
  end

  def self.register(obj)
    self.config = [] unless self.config
    config << name
  end

  def explain
    puts self.class.name
    x = {}
    for a in self.class.config
      begin
        x[a] = send(a)
      rescue StandardError => e
        x[a] = e
      end
    end
    pp x
    puts "-----"
  end
end

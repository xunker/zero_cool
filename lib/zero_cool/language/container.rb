class ZeroCool::Language::Container
  attr_reader :opening_text, :closing_text, :container_type

  def self.container_name
    underscore(self.name.split('::').last).downcase.to_sym
  end

  def self.language_class
    raise NotImplementedError
  end

  def self.register!
    language_class.add_container(self)
  end

  def self.generate(opts = {})
    self.new(opts).generate
  end

  def initialize(options={})
    # bring in variables set on the class level
    %i[ @opening_text @closing_text @container_type ].each do |ivar|
      instance_variable_set(ivar, self.class.instance_variable_get(ivar))
    end
  end

  def generate(options = {})
    output = [@opening_text]
    output << @closing_text
    output.map do |s|
      language_class.interpolate(s)
    end.join(language_class.line_ending)
  end
  alias :to_s :generate

  def self.opening_text(text=nil)
    if block_given?
      @opening_text = yield.to_s
    elsif text
      @opening_text = text.to_s
    end
    @opening_text
  end

  def self.closing_text(text=nil)
    if block_given?
      @closing_text = yield.to_s
    elsif text
      @closing_text = text.to_s
    end
    @closing_text
  end

  def self.container_type(type_sym=nil)
    @container_type = type_sym.downcase.to_sym if type_sym
    @container_type
  end
  
  def self.type(type_sym=nil); container_type(type_sym); end

protected

  def language_class
    self.class.language_class
  end

private
  # mostly stolen from ActiveSupport::Inflector
  def self.underscore(camel_cased_word)
    word = camel_cased_word.to_s.gsub('::', '/')
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end

end

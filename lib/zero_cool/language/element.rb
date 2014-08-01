class ZeroCool::Language::Element
  attr_reader :text, :position, :parent_types

  def self.element_name
    underscore(self.name.split('::').last).downcase.to_sym
  end

  def self.language_class
    raise NotImplementedError
  end

  def self.register!
    language_class.add_element(self)
  end

  def self.generate(opts = {})
    self.new(opts).generate
  end

  def initialize(options={})
    # bring in variables set on the class level
    %i[
      @text @position @parent_types @default_weight @parent_weights
    ].each do |ivar|
      instance_variable_set(ivar, self.class.instance_variable_get(ivar))
    end
    @parent_types ||= [] # make sure this is an array
    @indentation = options.delete(:indentation).to_i
  end

  def generate(options = {})
    indentation = (options[:indentation] || @indentation).to_i
    indentation_string*indentation + language_class.interpolate(@text)
  end
  alias :to_s :generate

  def self.root_element?
    @parent_types.nil? || @parent_types.empty?
  end

  def root_element?
    self.class.root_element?
  end

  def self.has_parent_type?(parent_type)
    (@parent_types || []).include?(parent_type)
  end

  # :beginning, :end or :none
  def self.position?(pos)
    pos == :none ? @position.nil? : @position == pos
  end

  def self.beginning_position?
    position?(:beginning)
  end

  def self.no_position?
    position?(:none)
  end

  def self.end_position?
    position?(:end)
  end

  def self.text(t=nil)
    if block_given?
      @text = yield.to_s
    elsif t
      @text = t.to_s
    end
  end

  def self.parent_types(types=[])
    types.each { |t| parent_type(t) }
  end

  def self.parent_type(type)
    @parent_types ||= []
    @parent_types << type unless @parent_types.include?(type)
  end
  
  def self.position(pos)
    @position = pos.to_sym
  end

  def indentation_string
    language_class.indentation_string
  end

  def self.default_weight(weight=0)
    @default_weight = weight.to_i
  end

  def self.weight(weight=0)
    default_weight(weight)
  end


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

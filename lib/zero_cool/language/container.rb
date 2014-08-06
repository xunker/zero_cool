class ZeroCool::Language::Container
  attr_reader :opening_text, :closing_text, :container_type, :parent_types, :indentation, :no_content_indentation

  @@subclasses = []

  def self.inherited(subclass)
    @@subclasses << subclass
  end

  def self.subclasses
    @@subclasses
  end

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
    %i[
      @opening_text @closing_text @container_type
      @parent_types @default_weight @parent_weights
      @no_content_indentation
      @prepend_newlines @append_newlines
      @prepend_padding_newlines @append_padding_newlines
    ].each do |ivar|
      instance_variable_set(ivar, self.class.instance_variable_get(ivar))
    end
    @parent_types ||= [] # make sure this is an array
    @indentation = options.delete(:indentation).to_i
  end

  def generate(options = {})
    indentation = (options[:indentation] || @indentation).to_i

    output = []

    prepend_newlines.times { output << '' }

    output << indentation_string*indentation + @opening_text.to_s
    prepend_padding_newlines.times { output << '' }
    
    # find all containers or elements that can be children of this container

    sub_containers = container_classes.select{|c| c.has_parent_type?(@container_type) }
    elements = element_classes.select{|c| c.has_parent_type?(@container_type) }

    # beginning elements
    if bp = elements.select(&:beginning_position?).sample
      output << bp.generate(indentation: indentation + (@no_content_indentation ? 0 : 1))
    end

    3.times do
      no_position = elements.select(&:no_position?)
      if e_or_c = (sub_containers + no_position).sample
        output << e_or_c.generate(indentation: indentation + (@no_content_indentation ? 0 : 1))
      end
    end

    if ep = elements.select(&:end_position?).sample
      output << ep.generate(indentation: indentation+1)
    end

    append_padding_newlines.times { output << '' }

    output << indentation_string*indentation + @closing_text.to_s

    append_newlines.times { output << '' }

    output.map do |s|
      language_class.interpolate(s)
    end.join(language_class.line_ending)
  end
  alias :to_s :generate

  def self.root_container?
    @parent_types.nil? || @parent_types.empty?
  end

  def root_container?
    self.class.root_container?
  end

  def self.has_parent_type?(parent_type)
    (@parent_types || []).include?(parent_type)
  end

  def self.opening_text(text=nil)
    if block_given?
      @opening_text = yield.to_s
    elsif text
      @opening_text = text.to_s
    end
  end

  def self.closing_text(text=nil)
    if block_given?
      @closing_text = yield.to_s
    elsif text
      @closing_text = text.to_s
    end
  end

  def self.container_type(type_sym)
    @container_type = type_sym.downcase.to_sym
  end

  def self.parent_types(types=[])
    types.each { |t| parent_type(t) }
  end

  def self.parent_type(type)
    @parent_types ||= []
    @parent_types << type unless @parent_types.include?(type)
  end
  
  def self.type(type_sym=nil); container_type(type_sym); end

  def self.no_content_indentation(orly=false)
    @no_content_indentation = !!orly
  end

  def prepend_newlines?
    !@prepend_newlines.nil?
  end

  def prepend_newlines
    prepend_newlines? ? @prepend_newlines.call.to_i : 0
  end

  # accepts integer, two integers (max, max) or range
  def self.prepend_newlines(min=0, max=nil)
    @prepend_newlines = if min && max && max.to_i > min.to_i
      lambda { (min.to_i..max.to_i).to_a.sample }
    elsif min.is_a?(Range)
      lambda { min.to_a.sample }
    else
      lambda { min.to_i }
    end
  end

  def append_newlines?
    !@append_newlines.nil?
  end

  def append_newlines
    append_newlines? ? @append_newlines.call.to_i : 0
  end

  # accepts integer, two integers (max, max) or range
  def self.append_newlines(min=0, max=nil)
    @append_newlines = if min && max && max.to_i > min.to_i
      lambda { (min.to_i..max.to_i).to_a.sample }
    elsif min.is_a?(Range)
      lambda { min.to_a.sample }
    else
      lambda { min.to_i }
    end
  end

  def prepend_padding_newlines?
    !@prepend_padding_newlines.nil?
  end

  def prepend_padding_newlines
    prepend_padding_newlines? ? @prepend_padding_newlines.call : 0
  end

  # accepts integer, two integers (max, max) or range
  def self.prepend_padding_newlines(min=0, max=nil)
    @prepend_padding_newlines = if min && max && max.to_i > min.to_i
      lambda { (min.to_i..max.to_i).to_a.sample }
    elsif min.is_a?(Range)
      lambda { min.to_a.sample }
    else
      lambda { min.to_i }
    end
  end

  def append_padding_newlines?
    !@append_padding_newlines.nil?
  end

  def append_padding_newlines
    append_padding_newlines? ? @append_padding_newlines.call : 0
  end

  # accepts integer, two integers (max, max) or range
  def self.append_padding_newlines(min=0, max=nil)
    @append_padding_newlines = if min && max && max.to_i > min.to_i
      lambda { (min.to_i..max.to_i).to_a.sample }
    elsif min.is_a?(Range)
      lambda { min.to_a.sample }
    else
      lambda { min.to_i }
    end
  end

  def containers
    language_class.containers
  end

  def container_classes
    language_class.container_classes
  end

  def elements
    language_class.elements
  end

  def element_classes
    language_class.element_classes
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

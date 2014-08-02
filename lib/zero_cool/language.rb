class ZeroCool::Language
  LANGUAGE_CLASS_PATTERN = /^ZeroCool::Language::([A-Z][A-Za-z0-9]+)$/
  # Class => :language
  @@languages = {}

  # :language => [ { container_name: <container class> }, ... ]
  @@containers = {}

  # :language => [ { element_name: <element class> }, ... ]
  @@elements = {}

  def self.line_ending
    "\n"
  end

  def self.indentation_string
    "\t"
  end

  def self.interpolation_class
    raise NotImplementedError
  end

  def self.inherited(subclass)
    subclass_name = subclass.to_s
    unless subclass_name =~ LANGUAGE_CLASS_PATTERN
      raise "#{subclass_name} has wrong class to inherit from ZeroCool::Language"
    end
    lang = divine_language_name_from_class(subclass)
    @@languages[subclass] = lang
    @@containers[lang] = {}
    @@elements[lang] = {}
  end

  def self.add_container(container)
    @@containers[language_name][container.container_name] = container
  end

  def self.containers
    @@containers[language_name]
  end

  def self.container_classes
    @@containers[language_name].map(&:last)
  end

  def containers
    self.class.containers
  end

  def self.container(container_name=nil)
    # get the container the want, or a random container
    @@containers[language_name][container_name] || @@containers[language_name][@@containers[language_name].keys.sample]
  end

  # get a random container that has no parent
  def self.root_container
    root_container_keys = @@containers[language_name].select{|k,v| v.root_container? }.map(&:last).sample
  end

  def root_container
    self.class.root_container
  end

  def container(container_name=nil)
    self.class.container(container_name)
  end

  def self.remove_container(container)
    case container.class.name
    when 'Symbol', 'String'
      @@containers[language_name].delete_if { |c| c.name == container.to_sym }
    else
      @@containers[language_name].delete(container)
    end
  end

  def self.add_element(element)
    @@elements[language_name][element.element_name] = element
  end

  def self.elements
    @@elements[language_name]
  end

  def self.element_classes
    @@elements[language_name].map(&:last)
  end

  def elements
    self.class.elements
  end

  def self.element(element_name=nil)
    # get the element the want, or a random element
    @@elements[language_name][element_name] || @@elements[language_name][@@elements[language_name].keys.sample]
  end

  # get a random element that has no parent
  def self.root_element
    root_element_keys = @@elements[language_name].select{|k,v| v.root_element? }.map(&:last).sample
  end

  def root_element
    self.class.root_element
  end

  def element(element_name=nil)
    self.class.element(element_name)
  end

  def self.remove_element(element)
    case element.class.name
    when 'Symbol', 'String'
      @@elements[language_name].delete_if { |c| c.name == element.to_sym }
    else
      @@elements[language_name].delete(container)
    end
  end

  def self.interpolate(string)
    interpolations.parse(string)
  end

private

  def self.interpolations
    @interpolations ||= self.interpolation_class.new
  end

  def language_name
    self.class.language_name
  end

  def self.language_name
    divine_language_name_from_class(self)
  end

  def self.divine_language_name_from_class(language_class)
    if m = language_class.name.match(LANGUAGE_CLASS_PATTERN)
      m[1].downcase.to_sym
    else
      raise "Couldn't divine language name from #{language_class}"
    end
  end

end

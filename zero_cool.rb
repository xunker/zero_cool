#!/usr/bin/env ruby

# generate real looking ruby code based on simple rules

INDENT_CHARACTER = '  '

CONTAINERS = {
  bare_class: {
    opening_text: "class __CLASS_NAME__\n\n",
    closing_text: 'end',
    type: :class
  },
  inhertited_class: {
    opening_text: "class __CLASS_NAME__ < __PARENT_CLASS_NAME__\n\n",
    closing_text: 'end',
    type: :class
  },
  instance_method_with_arguments: {
    opening_text: 'def __METHOD_NAME__ __METHOD_ARGUMENTS__',
    closing_text: 'end',
    parent_types: [ :class ],
    type: :method,
  },
  instance_method_with_no_arguments: {
    opening_text: 'def __METHOD_NAME__',
    closing_text: 'end',
    parent_types: [ :class ],
    type: :method,
  },
  while_loop: {
    opening_text: 'while __VARIABLE_NAME__ __EQUALITY_CHECK__ __RANDOM_NUMBER_0_100__ do',
    closing_text: 'end',
    parent_types: [ :method ],
    type: :loop
  }
}

ELEMENTS = {
  class_instantiation: {
    parent_types: [ :method ],
    text: '__VARIABLE_NAME__ = __CLASS_NAME__.__INSTANTIATION_METHOD__'
  },
  bang_method_call: {
    parent_types: [ :method ],
    text: '__VARIABLE_NAME__!'
  },
  integer_variable_assignment: {
    parent_types: [ :method ],
    text: '__VARIABLE_NAME__ = __RANDOM_NUMBER_0_100__'
  },
  equality_check_runtime_error: {
    parent_types: [ :method ],
    text: 'raise __EXCEPTION_CLASS__, "__ERROR_MESSAGE__" unless __EQUALITY_CHECK__',
    position: :beginning
  },
  explicit_boolean_return: {
    parent_types: [ :method ],
    text: 'return __BOOLEAN__',
    position: :end
  },
  explicit_variable_return: {
    parent_types: [ :method ],
    text: 'return __VARIABLE_NAME__',
    position: :end
  },
  explicit_nil_return: {
    parent_types: [ :method ],
    text: 'return nil',
    position: :end
  },
  include_module: {
    parent_types: [ :class, :method ],
    text: 'include __CLASS_NAME__',
    position: :beginning
  },
  require_file: {
    parent_types: [ :class, :method ],
    text: "require '__BARE_FILE_NAME__'",
    position: :beginning
  }
}

class Interpolation
  METASYNTATIC_VARIABLES = %w[ foo bar baz qux quuz corge grault garply waldo fred plugh xyzzy thud ]

  def parse(string)
    return_string = string.dup
    string.scan(/__([A-Z0-9_]+)__/).flatten.each do |ip|
      method_symbol = ('i_' + ip.downcase).to_sym
      if respond_to?(method_symbol)
        return_string.sub!("__#{ip}__", send(method_symbol))
      end
    end
    return_string
  end

  def i_variable_name
    METASYNTATIC_VARIABLES.sample
  end

  def i_boolean
    %w[ true false ].sample
  end

  def i_random_number_0_100
    rand(100).to_s
  end

  def i_random_number_0_10
    rand(10).to_s
  end

  def i_class_name
    [
      %w[ User Purchase Author Book Page Database Origin Purpose ],
      %w[ Processor Creator Updater Scanner Reader Writer Output Input Stream ],
      %w[ Factory Model Migration Validator Manager Maker ]
    ].map(&:sample).join
  end

  def i_parent_class_name
    "Active#{%w[Model Support Extension].sample}::#{%w[Concern Record Table Request Response].sample}"
  end

  def i_method_name
    words = %w[ bind pull remote origin create save validate calculate ]
    connectors = %w[ with by for in on at to from before after ]

    ary1 = []
    (rand(words.size/1)+1).times do
      word = (words - ary1).sample
      ary1 << word
    end
    ary2 = []
    if ary1.size > 1
      (ary1.size - 1).times do
        ary2 << connectors.sample
      end
    end
    name = ary1.zip(ary2).flatten.compact.join('_')

    punct_chance = rand(10)
    if punct_chance >= 8
      name = name + '!'
    elsif punct_chance >= 7
      name = name + '?'
    end
    name
  end

  def i_method_arguments
    '(' + (rand(2)+1).times.map do
      [
        %w[ options user purchase book page record ].sample,
        [ '', '', '', '={}', '=nil', "=#{rand(10)}", "=#{i_class_name}.#{i_instantiation_method}"].sample
      ].join
    end.join(', ') + ')'
  end

  def i_instantiation_method
    %w[ new build create create! first first! last last! ].sample
  end

  def i_exception_class
    [
      %w[ Serious Unknown Majour Flagrant ],
      %w[ Error Failure Warning Trouser ]
    ].map(&:sample).join + 'Exception'
  end

  def i_error_message
    [
      %w[ property method argument value condition ],
      [ 'is not', 'was not', 'should be', "isn't", 'must be' ],
      %w[ found present boolean string integer symbol hash array valid ]
    ].map(&:sample).join(' ')
  end

  def i_equality_symbol
    ['==', '!=', '>', '>=', '<', '<='].sample
  end

  def i_equality_check
    [
      lambda { "#{i_variable_name} #{i_equality_symbol} #{i_random_number_0_10}" },
      lambda { "#{i_variable_name}.is_a?(#{i_class_name})" },
      lambda { "#{i_variable_name}.present?" },
      lambda { "#{i_variable_name}.blank?" },
      lambda { "#{i_variable_name}.nil?" },
      lambda { "#{i_variable_name}.empty?" },
    ].sample.call
  end

  def i_bare_file_name
    [
      %w[ file directory socket port link stream symbol ],
      %w[ processor reader writer linker embedder ruiner ]
    ].map(&:sample).join('_')
  end
end

interpolation = Interpolation.new

indentation = 0
3.times do |i|
  # find random container that has no parent
  container_key = CONTAINERS.reject{|key, hash| hash[:parents] || hash[:parent_types] }.keys.sample
  container = CONTAINERS[container_key]
  
  puts INDENT_CHARACTER*indentation + interpolation.parse(container[:opening_text])
  indentation += 1

  3.times do |ii|
    # find containers with parent name or type of container
    sub_container_key = CONTAINERS.select{|key, hash| (hash[:parents] || []).include?(container_key) || (hash[:parent_types] ||[]).include?(container[:type]) }.keys.sample
    sub_container = CONTAINERS[sub_container_key]

    puts INDENT_CHARACTER*indentation + interpolation.parse(sub_container[:opening_text])
    indentation += 1

    if (rand(5) >= 4)
      beginning_element_key = ELEMENTS.select do |key, hash|
        (hash[:position] == :beginning) && ((hash[:parents] || []).include?(sub_container_key) || (hash[:parent_types] || []).include?(sub_container[:type]))
      end.keys.sample

      if beginning_element_key
        puts INDENT_CHARACTER*indentation + interpolation.parse(ELEMENTS[beginning_element_key][:text])
      end
    end

    (rand(4)+1).times do |iii|
      # find elements with parent name or type of sub_container
      element_key = ELEMENTS.select do |key, hash|
        (hash[:position].nil? || hash[:position] == :middle) && ((hash[:parents] || []).include?(sub_container_key) || (hash[:parent_types] || []).include?(sub_container[:type]))
      end.keys.sample
      element = ELEMENTS[element_key]

      puts INDENT_CHARACTER*indentation + interpolation.parse(element[:text])
    end

    if (rand(5) >= 4)
      ending_element_key = ELEMENTS.select do |key, hash|
        hash[:position] == :end && ((hash[:parents] || []).include?(sub_container_key) || (hash[:parent_types] || []).include?(sub_container[:type]))
      end.keys.sample

      if ending_element_key
        puts INDENT_CHARACTER*indentation + interpolation.parse(ELEMENTS[ending_element_key][:text])
      end
    end

    indentation -= 1
    puts INDENT_CHARACTER*indentation + sub_container[:closing_text]
    puts ''
  end

  indentation -= 1
  puts INDENT_CHARACTER*indentation + container[:closing_text]
  puts ''
end
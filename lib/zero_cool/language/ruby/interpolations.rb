class ZeroCool::Language::Ruby::Interpolations < ZeroCool::Language::Interpolations
  def i_variable_name
    %w[
      foo bar baz qux quuz corge grault garply waldo fred plugh xyzzy thud
    ].sample
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
      lambda { "#{i_variable_name} #{i_equality_symbol} #{i_variable_name}" }
    ].sample.call
  end

  def i_object_boolean_check
    [
      lambda { "#{i_variable_name}.is_a?(#{i_class_name})" },
      lambda { "#{i_variable_name}.present?" },
      lambda { "#{i_variable_name}.blank?" },
      lambda { "#{i_variable_name}.nil?" },
      lambda { "#{i_variable_name}.empty?" },
      lambda { "#{i_variable_name}.42?" },
    ].sample.call
  end

  def i_bare_file_name
    [
      %w[ file directory socket port link stream symbol ],
      %w[ processor reader writer linker embedder ruiner ]
    ].map(&:sample).join('_')
  end

  def i_complex_assertion
    rand(10) >= 5 ? i_equality_check : i_object_boolean_check
  end
end
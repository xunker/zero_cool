class ZeroCool::Language::Python::Interpolations < ZeroCool::Language::Interpolations
  def i_variable_name
    %w[
      foo bar baz qux quuz corge grault garply waldo fred plugh xyzzy thud
    ].sample
  end

  def i_boolean
    %w[ True False ].sample
  end

  def i_random_number_0_100
    rand(100).to_s
  end

  def i_random_number_0_10
    rand(10).to_s
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
    ary1.zip(ary2).flatten.compact.join('_')
  end

  def i_type
    %w[
        NoneType TypeType BooleanType IntType LongType FloatType ComplexType
        StringType UnicodeType TupleType ListType DictType FunctionType
        LambdaType GeneratorType CodeType ClassType InstanceType MethodType
        UnboundMethodType BuiltinFunctionType BuiltinMethodType ModuleType
        FileType XRangeType SliceType EllipsisType TracebackType FrameType
        BufferType DictProxyType NotImplementedType GetSetDescriptorType
        MemberDescriptorType StringTypes
    ].sample
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

  def i_property_check
    [
      lambda { "length(#{i_variable_name}) #{i_equality_symbol} #{i_random_number_0_10}" },
      lambda { "type(#{i_variable_name}) == #{i_type}" },
      lambda { "#{i_variable_name}" }
    ].sample.call
  end

  def i_complex_assertion
    rand(10) >= 5 ? i_equality_check : i_property_check
  end

  def i_class_name
    [
      %w[ User Purchase Author Book Page Database Origin Purpose ],
      %w[ Processor Creator Updater Scanner Reader Writer Output Input Stream ],
      %w[ Factory Model Migration Validator Manager Maker ]
    ].map(&:sample).join
  end

  def i_empty_data_structure
    [ '{}', '[]', '""', "''"].sample
  end

end
class ZeroCool::Language::Ruby::Element::ClassInstantiation < ZeroCool::Language::Ruby::Element
  text do
    '__VARIABLE_NAME__ = __CLASS_NAME__.__INSTANTIATION_METHOD__'
  end

  parent_types [ :method, :loop ]

end

class ZeroCool::Language::Ruby::Element::BangMethodCall < ZeroCool::Language::Ruby::Element
  text '__VARIABLE_NAME__!'
  parent_types [ :method, :loop ]
end

class ZeroCool::Language::Ruby::Element::IntegerVariableAssignment < ZeroCool::Language::Ruby::Element
  text '__VARIABLE_NAME__ = __RANDOM_NUMBER_0_100__'
  parent_types [ :method, :loop ]
end

class ZeroCool::Language::Ruby::Element::EqualityCheckRuntimeError < ZeroCool::Language::Ruby::Element
  text 'raise __EXCEPTION_CLASS__, "__ERROR_MESSAGE__" unless __COMPLEX_ASSERTION__'
  parent_type :method
  position :beginning
end

class ZeroCool::Language::Ruby::Element::ExplicitBooleanReturn < ZeroCool::Language::Ruby::Element
  text 'return __BOOLEAN__'
  parent_type :method
  position :end
end

class ZeroCool::Language::Ruby::Element::ExplicitVariableReturn < ZeroCool::Language::Ruby::Element
  text 'return __VARIABLE_NAME__'
  parent_type :method
  position :end
end

class ZeroCool::Language::Ruby::Element::ExplicitNilReturn < ZeroCool::Language::Ruby::Element
  text 'return nil'
  parent_type :method
  position :end
end

class ZeroCool::Language::Ruby::Element::IncludeModule < ZeroCool::Language::Ruby::Element
  text 'include __CLASS_NAME__'
  parent_type :class
  position :beginning
end

class ZeroCool::Language::Ruby::Element::RequireFile < ZeroCool::Language::Ruby::Element
  text "require '__BARE_FILE_NAME__'"
  parent_type :class
  position :beginning
end

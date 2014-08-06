class ZeroCool::Language::Python::Element::BareMethodCall < ZeroCool::Language::Python::Element
  text '__METHOD_NAME__()'
  parent_types [ :function, :loop, :if ]
  # prepend_newlines 0..2
  # append_newlines 0..2
end
ZeroCool::Language::Python::Element::BareMethodCall.register!

class ZeroCool::Language::Python::Element::IntegerVariableAssignment < ZeroCool::Language::Python::Element
  text '__VARIABLE_NAME__ = __RANDOM_NUMBER_0_100__'
  parent_types [ :function, :loop, :if ]
end
ZeroCool::Language::Python::Element::IntegerVariableAssignment.register!

class ZeroCool::Language::Python::Element::BreakLoop < ZeroCool::Language::Python::Element
  text 'break'
  parent_type :loop
end
ZeroCool::Language::Python::Element::BreakLoop.register!

class ZeroCool::Language::Python::Element::ExplicitBooleanReturn < ZeroCool::Language::Python::Element
  text 'return __BOOLEAN__'
  parent_types [ :function, :if ]
  position :end
end
ZeroCool::Language::Python::Element::ExplicitBooleanReturn.register!

class ZeroCool::Language::Python::Element::ExplicitVariableReturn < ZeroCool::Language::Python::Element
  text 'return __VARIABLE_NAME__'
  parent_types [ :function, :if ]
  position :end
end
ZeroCool::Language::Python::Element::ExplicitVariableReturn.register!

class ZeroCool::Language::Python::Element::ExplicitBareReturn < ZeroCool::Language::Python::Element
  text 'return'
  parent_types [ :function, :if ]
  position :end
end
ZeroCool::Language::Python::Element::ExplicitBareReturn.register!

class ZeroCool::Language::Python::Element::ClassInitStatement < ZeroCool::Language::Python::Element
  text do
    'self.__VARIABLE_NAME__ = __EMPTY_DATA_STRUCTURE__'
  end
  position :beginning
  parent_types [ :class_init ]
end
ZeroCool::Language::Python::Element::ClassInitStatement.register!

class ZeroCool::Language::Python::Element::OpeningVariableInFile < ZeroCool::Language::Python::Element
  text do
    '__VARIABLE_NAME__ = __EMPTY_DATA_STRUCTURE__'
  end
  position :beginning
  parent_types [ :file ]
end
ZeroCool::Language::Python::Element::OpeningVariableInFile.register!
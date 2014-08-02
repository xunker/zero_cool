class ZeroCool::Language::Python::Element::BareMethodCall < ZeroCool::Language::Python::Element
  text '__METHOD_NAME__()'
  parent_types [ :function, :loop, :if ]
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

# class ZeroCool::Language::Python::Element::IncludeModule < ZeroCool::Language::Python::Element
#   text 'include __CLASS_NAME__'
#   parent_type :class
#   position :beginning
# end
# ZeroCool::Language::Python::Element::IncludeModule.register!

# class ZeroCool::Language::Python::Element::RequireFile < ZeroCool::Language::Python::Element
#   text "require '__BARE_FILE_NAME__'"
#   parent_type :class
#   position :beginning
# end
# ZeroCool::Language::Python::Element::RequireFile.register!

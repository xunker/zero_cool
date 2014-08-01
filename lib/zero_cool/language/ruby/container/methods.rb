class ZeroCool::Language::Ruby::Container::InstanceMethodWithArguments < ZeroCool::Language::Ruby::Container
  opening_text 'def __METHOD_NAME__ __METHOD_ARGUMENTS__'
  closing_text "end\n"
  parent_types [ :class ]
  type :method
end
ZeroCool::Language::Ruby::Container::InstanceMethodWithArguments.register!

class ZeroCool::Language::Ruby::Container::InstanceMethodWithNoArguments < ZeroCool::Language::Ruby::Container 
  opening_text 'def __METHOD_NAME__'
  closing_text "end\n"
  parent_type :class
  type :method
end
ZeroCool::Language::Ruby::Container::InstanceMethodWithNoArguments.register!
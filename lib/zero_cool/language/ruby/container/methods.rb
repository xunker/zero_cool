class ZeroCool::Language::Ruby::Container::InstanceMethodWithArguments < ZeroCool::Language::Ruby::Container
  opening_text 'def __METHOD_NAME__ __METHOD_ARGUMENTS__'
  closing_text 'end'
  parent_types [ :class ]
  type :method
end

class ZeroCool::Language::Ruby::Container::InstanceMethodWithNoArguments < ZeroCool::Language::Ruby::Container 
  opening_text 'def __METHOD_NAME__'
  closing_text 'end'
  parent_type :class
  type :method
end
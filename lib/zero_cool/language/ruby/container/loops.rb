class ZeroCool::Language::Ruby::Container::WhileLoop < ZeroCool::Language::Ruby::Container
  opening_text 'while __EQUALITY_CHECK__ do'
  closing_text 'end'
  parent_types [ :method ]
  container_type :loop
end

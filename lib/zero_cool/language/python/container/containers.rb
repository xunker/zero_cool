class ZeroCool::Language::Python::Container::FlatFile < ZeroCool::Language::Python::Container
  opening_text do
    '#!/usr/bin/env python'
  end

  # closing_text 'end'
  
  type :file
  prepend_newlines 0,3
  no_content_indentation true
end
ZeroCool::Language::Python::Container::FlatFile.register!

class ZeroCool::Language::Python::Container::InfiniteLoop < ZeroCool::Language::Python::Container
  opening_text do
    'while True:'
  end

  type :loop

  prepend_newlines 0,3

  parent_types [ :file ]
end
ZeroCool::Language::Python::Container::InfiniteLoop.register!

class ZeroCool::Language::Python::Container::IfStatement < ZeroCool::Language::Python::Container
  opening_text do
    'if __COMPLEX_ASSERTION__:'
  end
  prepend_newlines 0,3
  type :if
  parent_types [ :file, :loop, :function ]
end
ZeroCool::Language::Python::Container::IfStatement.register!

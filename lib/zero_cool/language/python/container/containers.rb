class ZeroCool::Language::Python::Container::FlatFile < ZeroCool::Language::Python::Container
  opening_text do
    '#!/usr/bin/env python'
  end

  type :file
  prepend_padding_newlines 0,3

  no_content_indentation true
end
ZeroCool::Language::Python::Container::FlatFile.register!

class ZeroCool::Language::Python::Container::InfiniteLoop < ZeroCool::Language::Python::Container
  opening_text do
    'while True:'
  end

  type :loop

  prepend_newlines 0,2

  parent_types [ :file, :class ]
end
ZeroCool::Language::Python::Container::InfiniteLoop.register!

class ZeroCool::Language::Python::Container::IfStatement < ZeroCool::Language::Python::Container
  opening_text do
    'if __COMPLEX_ASSERTION__:'
  end
  type :if
  parent_types [ :file, :loop, :function, :class ]
end
ZeroCool::Language::Python::Container::IfStatement.register!

class ZeroCool::Language::Python::Container::BareClass < ZeroCool::Language::Python::Container
  opening_text do
    'class __CLASS_NAME__:'
  end
  prepend_newlines 0,2
  prepend_padding_newlines 0,2
  append_newlines 0,2
  type :class
  parent_types [ :file ]
end
ZeroCool::Language::Python::Container::BareClass.register!

class ZeroCool::Language::Python::Container::ClassInit < ZeroCool::Language::Python::Container
  opening_text do
    'def  __init__(self):'
  end
  type :class_init
  parent_types [ :class ]
end
ZeroCool::Language::Python::Container::ClassInit.register!

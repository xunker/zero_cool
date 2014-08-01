class ZeroCool::Language::Ruby::Container::BareClass < ZeroCool::Language::Ruby::Container
  opening_text do
    'class __CLASS_NAME__'
  end
    
  closing_text do
    'end'
  end
  
  type :class
end
ZeroCool::Language::Ruby::Container::BareClass.register!

class ZeroCool::Language::Ruby::Container::InheritedClass < ZeroCool::Language::Ruby::Container
  opening_text 'class __CLASS_NAME__ < __PARENT_CLASS_NAME__'
  closing_text 'end'
  type :class
end
ZeroCool::Language::Ruby::Container::InheritedClass.register!

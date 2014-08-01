class ZeroCool::Language::Ruby < ZeroCool::Language

  def self.line_ending
    "\n"
  end

  def self.interpolation_class
    ZeroCool::Language::Ruby::Interpolations
  end
end

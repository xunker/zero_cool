class ZeroCool::Language::Interpolations
  def parse(string)
    return_string = string.dup
    string.scan(/__([A-Z0-9_]+)__/).flatten.each do |ip|
      method_symbol = ('i_' + ip.downcase).to_sym
      if respond_to?(method_symbol)
        return_string.sub!("__#{ip}__", send(method_symbol))
      end
    end
    return_string
  end
end
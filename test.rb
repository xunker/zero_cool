require 'zero_cool'

ruby = ZeroCool::Language::Ruby.new
# python = ZeroCool::Language::Python.new

# puts ruby.containers.map(&:last).map(&:container_name).inspect
# puts python.containers.map(&:last).map(&:container_name).inspect
# puts ruby.elements.map(&:last).map(&:element_name).inspect
# puts python.elements.map(&:last).map(&:element_name).inspect

# puts ruby.containers.map(&:last).map(&:new).map(&:opening_text).inspect
# puts ruby.containers.map(&:last).map(&:new).map(&:parent_types).inspect
# puts ruby.elements.map(&:last).map(&:new).map(&:parent_types).inspect

puts ruby.root_container.generate
# puts python.root_container.generate
require 'zero_cool/version'
require 'zero_cool/language'
require 'zero_cool/language/container'
require 'zero_cool/language/element'
require 'zero_cool/language/interpolations'

require 'zero_cool/language/ruby'
require 'zero_cool/language/ruby/container'
require 'zero_cool/language/ruby/container/classes'
require 'zero_cool/language/ruby/container/methods'
require 'zero_cool/language/ruby/container/loops'
require 'zero_cool/language/ruby/element'
require 'zero_cool/language/ruby/element/elements'
require 'zero_cool/language/ruby/interpolations'

require 'zero_cool/language/python'
require 'zero_cool/language/python/container'
require 'zero_cool/language/python/container/classes'
require 'zero_cool/language/python/element'
require 'zero_cool/language/python/interpolations'

# Dir[File.dirname(__FILE__) + '/zero_cool/language/**/*.rb'].each do |file|
#   puts file
#   require file
# end

# module ZeroCool
  
# end
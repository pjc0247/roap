require 'method_source'

require_relative 'roap/roap'
require_relative 'roap/loader'
require_relative 'roap/utils'
require_relative 'roap/all_extensions'

require_relative 'roap/attrs/runtime'
require_relative 'roap/attrs/static'

Roap::require_all __dir__, 'roap/exts'
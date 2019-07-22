require "slim"

module GraphqlMetrics
  class Engine < ::Rails::Engine
    isolate_namespace GraphqlMetrics
  end
end

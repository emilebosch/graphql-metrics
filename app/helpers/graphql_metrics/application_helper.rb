module GraphqlMetrics
  module ApplicationHelper
    def ok(query)
      b = x = {}
      for f in query.fields
        x = b
        for k, i in f.path.each_with_index
          x[k] = (i == f.path.length - 1 ? f : {})
          x = x[k]
        end
      end
      b
    end
  end
end

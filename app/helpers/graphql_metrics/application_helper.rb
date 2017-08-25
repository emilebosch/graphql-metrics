module GraphqlMetrics
  module ApplicationHelper
    def render_query(obj, qq)
      a = "<ul>"
      for k, v in obj
        a += "<li>#{k}</li>" 
        #"render_query(v,qq)''
      end
      a += "</ul>"
      a
    end
  end
end

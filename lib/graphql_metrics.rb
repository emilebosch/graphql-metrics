require "graphql_metrics/engine"
$MUTEX = Mutex.new

module GraphqlMetrics

  class Field
    attr_accessor :type
    attr_accessor :name
    attr_accessor :start
    attr_accessor :end
    attr_accessor :path
    attr_accessor :annotations

    def initialize(type, name, path)
      self.type = type
      self.name = name
      self.path = path
      self.annotations = []
    end

    def annotate(d)
      self.annotations << d
    end

    def time
      (self.end-self.start) * 1000.0
    end
  end

  class Query

    def initialize(query)
      @query = query
      @start = Time.now
    end

    def time
      @start
    end

    def fields
      @fields ||= []
    end

    def time
      fields.sum(&:time)
    end

    def query
      @query
    end

    def to_query_string
      @query.document.to_query_string
    end
  end

  class Store

    def self.instance
      @@instance ||= Store.new
    end

    def instrument(type, field)
      old_resolve_proc = field.resolve_proc

      new_resolve_proc = ->(obj, args, ctx) {

        f = Field.new(type.name, field.name, ctx.path)
        old_resolve_proc.to_s =~ /@(.*):(\d+)/
        x=$2
        f.annotate "in #{$1.gsub Rails.root.join("app").to_s,""}:#{x}" unless $1.blank?
        
        ctx[:field] = f

        f.start  = Time.now
        resolved = old_resolve_proc.call(obj, args, ctx)
        if resolved.respond_to? :to_sql
          f.annotate resolved.to_sql
        end
        f.end    = Time.now

        ctx[:query].fields << f
        resolved
      }

      field.redefine do
        resolve(new_resolve_proc)
      end

    end

    def queries
      @queries ||= []
    end
  end

  class QueryInstrumentation

    def before_query(query)
      query.context[:query] = Query.new(query)
    end

    def after_query(query)
      $MUTEX.synchronize {
        GraphqlMetrics::Store.instance.queries << query.context[:query]
      }
    end
  end

  class FieldInstrumentation
    def instrument(type, field)
      GraphqlMetrics::Store.instance.instrument(type,field)
    end
  end

end
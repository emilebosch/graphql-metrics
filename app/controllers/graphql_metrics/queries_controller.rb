module GraphqlMetrics
  class QueriesController < ApplicationController
    layout "graphql_metrics/application"  

    def index
    end

    def show
      @query = GraphqlMetrics::Store.instance.queries[params[:id].to_i]
    end
  end
end

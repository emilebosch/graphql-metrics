# Graphql metrics

![alt text](https://raw.githubusercontent.com/emilebosch/graphql-metrics/master/metric.png)


Simple performance dashboard for graphql queries for runtime development. Ouput of the Graphql hackathon. Only use for performance usage in development, dont run this in production.

Add to bundle:

```
gem 'graphql_metrics',source: 'https://github.com/emilebosch/graphql-metrics.git'
```

Add to your graphql schema:

```
Schema = GraphQL::Schema.define do
  query(Types::Query)
  mutation(Types::Mutation)
  
  instrument :field, GraphqlMetrics::FieldInstrumentation.new
  instrument :query, GraphqlMetrics::QueryInstrumentation.new
end
```

Then mount your engine at `/metrics`

```
mount GraphqlMetrics::Engine, at: '/metrics'
```

Tadaa..
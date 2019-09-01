# Graphql Metrics Dashboard

A picture is more worth than a thousand badly written words.

![alt text](https://raw.githubusercontent.com/emilebosch/graphql-metrics/master/metric.png)

Simple performance dashboard for graphql queries for runtime development for rails applications. Only use for performance measurement in development, dont run this in production.

## Installation

Add to bundle:

```ruby
gem 'graphql_metrics',source: 'https://github.com/emilebosch/graphql-metrics.git'
```

Add to your graphql schema:

```ruby
Schema = GraphQL::Schema.define do
  query(Types::Query)
  mutation(Types::Mutation)

  instrument :field, GraphqlMetrics::FieldInstrumentation.new
  instrument :query, GraphqlMetrics::QueryInstrumentation.new
end
```

Then mount your engine at `/metrics`

```ruby
mount GraphqlMetrics::Engine, at: '/metrics'
```

## Note

THis is using an in memory story to record the queries and fields. Therefore you might want to prevent any forking webserver.

Recommend switching to webrick for testing.


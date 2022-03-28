Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*',
             headers: :any,
             methods: [:get, :post, :options, :patch, :put, :delete],
             expose: %w[access-token uid client]
  end
end

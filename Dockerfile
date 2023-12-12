# ...

# Copy master.key for assets:precompile
COPY config/master.key config/

# Build stage for asset precompilation
FROM base as assets_precompile
COPY . .
RUN bundle exec bootsnap precompile app/ lib/
RUN RAILS_MASTER_KEY=$(cat config/master.key) SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Final build stage
FROM base

# Install packages needed for deployment
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-0 libvips && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=assets_precompile /usr/local/bundle /usr/local/bundle
COPY --from=assets_precompile /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
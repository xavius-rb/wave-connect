# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3
FROM ruby:$RUBY_VERSION-alpine as base

# Set working directory
WORKDIR /rails

# Install dependencies for both build and runtime
RUN apk add --no-cache \
    build-base \
    libpq-dev \
    libxml2 \
    tzdata \
    gcompat

# Throw-away build stage to reduce size of final image
FROM base as build

# Install build dependencies and Node.js
RUN apk add --no-cache --virtual .build-deps \
    git \
    bash \
    libpq-dev \
    libxml2-dev && \
    apk add --no-cache nodejs npm && \
    npm install -g yarn

# Copy Gemfile and Gemfile.lock before other files (leverage Docker cache)
COPY Gemfile Gemfile.lock ./

# Install application gems
RUN bundle install --jobs "$(nproc)" && \
    rm -rf /usr/local/bundle/cache && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Remove build dependencies
RUN apk del .build-deps

# Final stage for app image
FROM base as deployment

# Copy built artifacts: gems and application code
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Ensure permissions are correct for non-root user
RUN addgroup -S rails && adduser -S -G rails rails && \
    chown -R rails:rails /rails /usr/local/bundle

USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint.sh"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]

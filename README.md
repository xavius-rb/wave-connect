# Wave Connect
[![CI](https://github.com/xavius-rb/wave-connect/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/xavius-rb/wave-connect/actions/workflows/ci.yml)

A Ruby on Rails application for software engineers who want to manage services.

## Prerequisites

- Ruby 3.4.2
- PostgreSQL
- Docker

## Development Environment

### Using DevContainer (Recommended)

The easiest way to get started is using VS Code's Dev Containers. This approach automatically sets up all prerequisites and provides a consistent development environment.

1. Prerequisites for this method:
   - Visual Studio Code
   - Docker Desktop
   - VS Code Remote - Containers extension

2. Setup steps:
   ```bash
   git clone [repository-url]
   cd wave-connect
   code .
   ```

3. When VS Code prompts to "Reopen in Container", click "Reopen in Container". Or use the command palette (F1) and select "Dev Containers: Reopen in Container"

4. Wait for the container to build. This will automatically:
   - Set up Ruby 3.4.2
   - Setup and run PostgreSQL
   - Install all dependencies
   - Configure the development environment

5. Once inside the container, start the app with:
   ```bash
   bin/dev
   ```

The development environment is now ready to use!

## Getting Started

### Installation

1. Clone the repository
```bash
git clone https://github.com/xavius-rb/wave-connect
cd wave-connect
```

2. Install dependencies
```bash
bin/bundle install
```

3. Setup database
```bash
bin/rails db:prepare
```

### Development

Start the development server:
```bash
bin/dev
```

The application will be available at http://localhost:3000

## Testing

The project uses RSpec for testing. To run the test suite:

```bash
bin/rspec
```

### Code Quality

Run the linter:
```bash
bin/rubocop
```

Run security checks:
```bash
bin/brakeman
```

## Configuration

### Environment Variables

Copy the example environment file and adjust as needed:
```bash
cp .env.example .env
```

### Database Configuration

Database configuration can be found in `config/database.yml`

## Deployment

This project uses Kamal for deployment. Deployment configuration can be found in `config/deploy.yml`.

To deploy:
```bash
bin/kamal deploy
```

## Architecture

### Key Components

- Rails 8.x
- PostgreSQL Database
- RSpec for testing
- Rubocop for code quality
- Brakeman for security analysis
- Kamal for deployment
- Docker support
- PWA support (see `app/views/pwa/`)

### Background Jobs

Background job processing is configured using Active Job.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Write tests for new features
- Follow the Ruby Style Guide enforced by Rubocop
- Run the test suite before submitting pull requests
- Keep the documentation up to date

# Wave Connect

A Ruby on Rails application for software engineers who want to manage services/applications.

## Prerequisites

- Ruby 3.4.2
- PostgreSQL
- Docker (optional)
- Node.js (for JavaScript compilation)

## Getting Started

### Installation

1. Clone the repository
```bash
git clone [repository-url]
cd wave-connect
```

2. Install dependencies
```bash
bundle install
```

3. Setup database
```bash
bin/rails db:create db:migrate db:seed
```

### Development

Start the development server:
```bash
bin/dev
```

The application will be available at http://localhost:3000

### Using Docker

A Dockerfile is provided for containerized development:

1. Build the image:
```bash
docker build -t wave-connect .
```

2. Run the container:
```bash
docker-compose up
```

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

- Rails 7.x
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

## License

[Add your license information here]

## Contact

[Add contact information or maintainer details here]

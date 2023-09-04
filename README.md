# Decidim::Insights

**NOTE: This module is built particularly for the City of Helsinki, it may not
work perfectly outside the Helsinki layout for the time being.**

This module provides regional information about the Helsinki major districts. It
provides the `/areas` route where this information is presented for each major
district in Helsinki.

The development has been funded by the [City of Helsinki](https://www.hel.fi/).

## Usage

Once this module is installed, you can access the regional information by
browsing to the  `/areas` path within the instance.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "decidim-insights", github: "mainio/decidim-module-insights", branch: "main"
```

And then execute:

```bash
bundle
```

## Contributing

See [Decidim](https://github.com/decidim/decidim).

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.

# Decidim::Insights

**NOTE: This module is built particularly for the City of Helsinki, it may not
work perfectly outside the Helsinki layout for the time being.**

This module provides regional information about the Helsinki major districts. It
provides the possibility to create insight "sections" which contain regional
information for defined areas. In fact, it is developed in a manner that allow
using it outside of the Helsinki context but it may require some investigation
and research on how to get it working properly.

The module is already functional but it does not provide any administration
interface yet, which means the data has to be entered or imported manually to
the system.

The development has been funded by the [City of Helsinki](https://www.hel.fi/).

## Usage

Once this module is installed, nothing will automatically appear within Decidim.
The steps to take to make it functional:

- Create a new insight "section" and give it a URL slug, e.g. `/areas`
  * This section will be available at this path at the root of the Decidim
    instance.
- Create areas for the defined section, these will be listed in the URL defined
  for the insight section.
- For each area, create "insights" or "details" as this module calls them. These
  are the data types that will render the insight cards. These can be either
  graphs or informational sections containing text, lists, etc.
- Optionally, you can also add regional "plans" for each area. These plans
  should provide information for the users about the activity on that region.
  This is meant to support making proposals within a Decidim instance, so that
  people would not create unnecessary proposals about anything that is already
  being planned or alternatively that people would support these plans to make
  them progress faster.

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

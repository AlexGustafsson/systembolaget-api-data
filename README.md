systembolaget-api-data  - up to date git source of [Systembolaget's open APIs](https://www.systembolaget.se/api/) available in XML and JSON
======

The repository is automatically updated with changes by a bot running the cross-platform utility [systembolaget-api-fetch](https://github.com/AlexGustafsson/systembolaget-api-fetch).

# Quickstart
<a name="quickstart"></a>

#### Using systembolaget-api-fetch

Start by grabbing cloning the repository or download the repository as a zip file.

```
> tree ./systembolaget-api-fetch
output
├── json
│   ├── assortment.json
│   ├── inventory.json
│   └── stores.json
└── xml
    ├── assortment.xml
    ├── inventory.xml
    └── stores.xml
```

# Table of contents

[Quickstart](#quickstart)<br/>
[Use cases](#usecases)<br/>
[Contributing](#contributing)<br/>
[Disclaimer](#disclaimer)

# Use cases
<a name="usecases"></a>

The utility can be used to automatically grab the latest available data in XML or JSON format. The data can be used to create interesting statistical charts, recommendation apps, search engines and more.

# Contributing
<a name="contributing"></a>

Any help with the project is more than welcome. Check either [systembolaget-api-fetch](https://github.com/AlexGustafsson/systembolaget-api-fetch) for code related to the download and translation utility that manages the data, or [systembolaget-api-bot](https://github.com/AlexGustafsson/systembolaget-api-bot) for the utility that automatically updates this repository.

# Disclaimer
<a name="disclaimer"></a>

_Although the project is very capable, it is not built with production in mind. Therefore there might be complications when trying to use systembolaget-api-data for large-scale projects meant for the public. The utility was created to easily integrate Systembolaget's open APIs on several platforms and as such it might not promote best practices nor be performant._

_The author nor the utility is in any way affiliated with Systembolaget._

systembolaget-api-data  - up to date git source of [Systembolaget's open APIs](https://www.systembolaget.se/api/) available in XML and JSON
======

The repository is automatically updated with changes by a bot running the cross-platform utility [systembolaget-api](https://github.com/AlexGustafsson/systembolaget-api).

# Quickstart
<a name="quickstart"></a>

## Running the bot

The bot, available in `bot.sh`, is a simple shell script utilizing the [systembolaget-api](https://github.com/AlexGustafsson/systembolaget-api) utility.

The script features several commands, but they all add up to the `run` command, usable like so:

```shell
./bot.sh --repository https://github.com/user/repository --ssh-key "$(PWD)/bot_ed25519" run
```

The SSH key can be generated using `ssh-keygen -o -a 100 -t ed25519 -f bot_ed25519` and should be added as a [Deploy Key](https://developer.github.com/v3/guides/managing-deploy-keys/) to the repository. Make sure the key has `push` privileges.

For advanced usage, refer to the source code and the `help` command: `./bot.sh help`.

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

Any help with the project is more than welcome. Although this is largely a mirror of Systembolaget's data, any corrections to it or the bot is welcome.

# Disclaimer
<a name="disclaimer"></a>

_Although the project is very capable, it is not built with production in mind. Therefore there might be complications when trying to use systembolaget-api-data for large-scale projects meant for the public. The utility was created to easily interact with Systembolaget's open APIs on several platforms and as such it might not promote best practices nor be performant._

_The author nor the utility is in any way affiliated with Systembolaget._

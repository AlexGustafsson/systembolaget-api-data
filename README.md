systembolaget-api-data  - up to date git source of [Systembolaget's open APIs](https://www.systembolaget.se/api/) available in XML and JSON
======

> Note: since 2020-11-01 Systembolaget has withdrawn access to their APIs due to parties abusing it (for financial gain or targeting minors). The data is therefore no longer up to date. If the situation changes, this repository will be live again. If you'd like to contribute and help solve the issue, you're more than welcome to join in over at https://github.com/AlexGustafsson/systembolaget-api.

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

The bot can also be run using Docker. First you'll need to build the image:

```
docker build -t axgn/systembolaget-api-bot .
```

You can then invoke it like so:

```shell
docker run -it \
  --mount type=bind,source="$(pwd)"/bot_ed25519,target=/etc/bot/bot_ed25519,readonly \
  --mount type=bind,source="$(pwd)"/bot_ed25519.pub,target=/etc/bot/bot_ed25519.pub,readonly \
  axgn/systembolaget-api-bot "0 7 * * *" run --ssh-key /etc/bot/bot_ed25519 --log debug
```

The command for the container is identical to that of the `bot.sh` script - apart from the first parameter which is the (required) cron syntax - such as `0 7 * * *`. The default command is `"0 7 * * *" run --log debug --ssh-key /etc/bot/bot_ed25519`.

Note that the user `bot` within the container will have to have read access to the mounted key files.

# Table of contents

[Quickstart](#quickstart)<br/>
[Examples](#examples)<br/>
[Use cases](#usecases)<br/>
[Contributing](#contributing)<br/>
[Disclaimer](#disclaimer)

# Examples
<a name="examples"></a>

Example of an assortment item from `json/assortment.json`:

```json
{
  "id": "8936603",
  "itemId": "1000155",
  "itemNumber": "89366",
  "name": "Midas Golden Pilsner",
  "name2": "",
  "price": 26.7,
  "volume": 330,
  "pricePerLiter": 80.91,
  "salesStart": "2015-09-01",
  "discontinued": false,
  "group": "Öl",
  "type": "Ljus lager",
  "style": "Pilsner - tjeckisk stil",
  "packaging": "Flaska",
  "seal": "",
  "origin": "Hallands län",
  "countryOfOrigin": "Sverige",
  "producer": "Imperiebryggeriet",
  "supplier": "Imperiebryggeriet  AB",
  "vintage": "",
  "testedVintage": "",
  "alcoholByVolume": "4.90%",
  "assortment": "BS",
  "assortmentText": "Ordervaror",
  "organic": false,
  "ethical": false,
  "kosher": false,
  "ingredientDescription": ""
}
```

Example of a store item from `xml/stores.xml`:

```xml
<Store>
  <Type>Butik</Type>
  <ID>0106</ID>
  <Name>Garnisonen</Name>
  <Address1>Karlavägen 100 A</Address1>
  <Address2></Address2>
  <Address3>115 26</Address3>
  <Address4>STOCKHOLM</Address4>
  <Address5>Stockholms län</Address5>
  <PhoneNumber>08/662 64 85</PhoneNumber>
  <StoreType></StoreType>
  <Services></Services>
  <Keywords>STOCKHOLM;STHLM;ÖSTERMALM</Keywords>
  <OpeningHours>2020-07-17;10:00;19:00;;;0;_*2020-07-18;10:00;15:00;;;0;_*2020-07-19;00:00;00:00;;;-;_*2020-07-20;10:00;19:00;;;0;_*2020-07-21;10:00;19:00;;;0;_*2020-07-22;10:00;19:00;;;0;_*2020-07-23;10:00;19:00;;;0;_*2020-07-24;10:00;19:00;;;0;_*2020-07-25;10:00;15:00;;;0;_*2020-07-26;00:00;00:00;;;-;_*2020-07-27;10:00;19:00;;;0;_*2020-07-28;10:00;19:00;;;0;_*2020-07-29;10:00;19:00;;;0;_*2020-07-30;10:00;19:00;;;0;_*2020-07-31;10:00;19:00;;;0;_*2020-08-01;10:00;15:00;;;0;</OpeningHours>
  <RT90x>6581720</RT90x>
  <RT90y>1630377</RT90y>
</Store>
```

Example of a inventory item from `json/inventory.json`:

```json
{
  "id": "0102",
  "itemNumbers": [
    302,
    701
  ]
}
```

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

# systembolaget-api-data  - up to date git source of Systembolaget's assortment

The repository is automatically updated with changes by a bot running the
cross-platform utility
[systembolaget-api](https://github.com/AlexGustafsson/systembolaget-api).

## Quickstart

### Running the bot

The bot, available in `bot.sh`, is a simple shell script utilizing the
[systembolaget-api](https://github.com/AlexGustafsson/systembolaget-api)
utility.

The script features several commands, but they all add up to the `run` command,
usable like so:

```shell
./bot.sh --repository https://github.com/user/repository --ssh-key "$PWD/bot_ed25519" run
```

The SSH key can be generated using
`ssh-keygen -o -a 100 -t ed25519 -f bot_ed25519` and should be added as a
[Deploy Key](https://developer.github.com/v3/guides/managing-deploy-keys/) to
the repository. Make sure the key has `push` privileges.

For advanced usage, refer to the source code and the `help` command:

```shell
./bot.sh help
```

The bot can also be run using Docker. First you'll need to build the image:

```shell
docker build -t axgn/systembolaget-api-bot .
```

You can then invoke it like so:

```shell
docker run -it \
  --mount type=bind,source="$PWD/bot_ed25519,target=/etc/bot/bot_ed25519,readonly" \
  --mount type=bind,source="$PWD/bot_ed25519.pub,target=/etc/bot/bot_ed25519.pub,readonly" \
  axgn/systembolaget-api-bot run --ssh-key /etc/bot/bot_ed25519 --log debug
```

The command for the container is identical to that of the `bot.sh` script. The
default command is `run --log debug --ssh-key /etc/bot/bot_ed25519`.

Note that the user `bot` within the container will have to have read access to
the mounted key files.

## Table of contents

[Quickstart](#quickstart)<br/>
[Examples](#examples)<br/>
[Use cases](#use-cases)<br/>
[Contributing](#contributing)

## Examples

Example of an assortment item from `data/assortment.json`:

```json
{
  "alcoholPercentage": 4.5,
  "assortment": "FS",
  "assortmentText": "Fast sortiment",
  "bottleText": "Flaska",
  "category": null,
  "categoryLevel1": "Öl",
  "categoryLevel2": "Ljus lager",
  "categoryLevel3": "Pilsner - tysk stil",
  "categoryLevel4": null,
  "color": "Gul färg.",
  "country": "Sverige",
  "customCategoryTitle": "Öl, Ljus lager, Pilsner - tysk stil",
  "dishPoints": null,
  "ethicalLabel": null,
  "grapes": [],
  "images": [
    {
      "fileType": null,
      "imageUrl": "https://product-cdn.systembolaget.se/productimages/831123/831123",
      "size": null
    }
  ],
  "isClimateSmartPackaging": false,
  "isCompletelyOutOfStock": false,
  "isDiscontinued": false,
  "isEthical": false,
  "isKosher": false,
  "isManufacturingCountry": true,
  "isNews": false,
  "isOrganic": true,
  "isRegionalRestricted": false,
  "isSupplierTemporaryNotAvailable": false,
  "isSustainableChoice": false,
  "isTemporaryOutOfStock": false,
  "isWebLaunch": false,
  "originLevel1": null,
  "originLevel2": null,
  "otherSelections": null,
  "packagingLevel1": "Flaska",
  "price": 15.9,
  "producerName": "Spendrups",
  "productId": "831123",
  "productLaunchDate": "2014-06-02T00:00:00",
  "productNameBold": "Melleruds",
  "productNameThin": "Utmärkta Pilsner",
  "productNumber": "125303",
  "productNumberShort": "1253",
  "recycleFee": 0,
  "restrictedParcelQuantity": 0,
  "seal": [],
  "sugarContent": 0,
  "sugarContentGramPer100ml": 0,
  "supplierName": "Spendrups Bryggeri AB",
  "taste": "Maltig smak med inslag av knäckebröd, honung och citrusskal.",
  "tasteClockBitter": 6,
  "tasteClockBody": 6,
  "tasteClockCasque": 1,
  "tasteClockFruitacid": 0,
  "tasteClockGroupBitter": null,
  "tasteClockGroupSmokiness": null,
  "tasteClockRoughness": 0,
  "tasteClockSmokiness": 0,
  "tasteClockSweetness": 1,
  "tasteClocks": [
    {
      "key": "TasteClockBitter",
      "value": 6
    },
    {
      "key": "TasteClockBody",
      "value": 6
    },
    {
      "key": "TasteClockSweetness",
      "value": 1
    }
  ],
  "tasteSymbols": ["Fläsk", "Fisk", "Buffémat", "Sällskapsdryck"],
  "usage": "Serveras vid 10-12°C som sällskapsdryck, till buffé eller till rätter av fisk eller ljust kött. ",
  "vintage": null,
  "volume": 330,
  "volumeText": "330 ml"
}
```

Example of a store item from `data/stores.json`:

```json
{
  "siteId": "0102",
  "alias": "Fältöversten",
  "address": "Karlaplan 13",
  "postalCode": "115 20",
  "city": "STOCKHOLM",
  "phone": "08/662 22 89",
  "county": "Stockholms län",
  "Position": {
    "latitude": 59.3388103109104,
    "longitude": 18.09087976878224
  },
  "openingHours": [
    {
      "date": "2022-08-21T00:00:00",
      "openFrom": "00:00:00",
      "openTo": "00:00:00",
      "reason": "-"
    },
    {
      "date": "2022-08-22T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "19:00:00",
      "reason": ""
    },
    {
      "date": "2022-08-23T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "19:00:00",
      "reason": ""
    },
    {
      "date": "2022-08-24T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "19:00:00",
      "reason": ""
    },
    {
      "date": "2022-08-25T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "19:00:00",
      "reason": ""
    },
    {
      "date": "2022-08-26T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "19:00:00",
      "reason": ""
    },
    {
      "date": "2022-08-27T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "15:00:00",
      "reason": ""
    },
    {
      "date": "2022-08-28T00:00:00",
      "openFrom": "00:00:00",
      "openTo": "00:00:00",
      "reason": "-"
    },
    {
      "date": "2022-08-29T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "19:00:00",
      "reason": ""
    },
    {
      "date": "2022-08-30T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "19:00:00",
      "reason": ""
    },
    {
      "date": "2022-08-31T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "19:00:00",
      "reason": ""
    },
    {
      "date": "2022-09-01T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "19:00:00",
      "reason": ""
    },
    {
      "date": "2022-09-02T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "19:00:00",
      "reason": ""
    },
    {
      "date": "2022-09-03T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "15:00:00",
      "reason": ""
    },
    {
      "date": "2022-09-04T00:00:00",
      "openFrom": "00:00:00",
      "openTo": "00:00:00",
      "reason": "-"
    },
    {
      "date": "2022-09-05T00:00:00",
      "openFrom": "10:00:00",
      "openTo": "19:00:00",
      "reason": ""
    }
  ]
}
```

## Use cases

The utility can be used to automatically grab the latest available data from
Systembolaget. The data can be used to create interesting statistical charts,
archives and more. Note however that data derived from the platform should not
be used in a way that goes against
[Systembolaget's mission](https://www.omsystembolaget.se/english/systembolaget-explained/).

## Contributing

Any help with the project is more than welcome. Although this is largely a
mirror of Systembolaget's data, any corrections to it or the bot is welcome.

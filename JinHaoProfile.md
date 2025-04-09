# JinHaoProfile Class

## Overview
The `JinHaoProfile` class represents the profile of a hearing aid device, containing various configuration details including product series, software versions, and the programs available for the device.

---

## Properties

| Property              | Type                       | Description                                                                                  |
|-----------------------|----------------------------|----------------------------------------------------------------------------------------------|
| `pSeriesCode`         | `String`                   | The product series code for the hearing aid.                                                 |
| `skuCode`             | `String`                   | The SKU code for the hearing aid.                                                             |
| `patternCode`         | `String`                   | The pattern code for the hearing aid.                                                         |
| `hwVersion`           | `String`                   | The hardware version number of the product.                                                  |
| `swVersion`           | `String`                   | The software version number of the product.                                                  |
| `bhwPattern`          | `String`                   | The Bluetooth hardware model number of the product.                                           |
| `bhwVersion`          | `String`                   | The Bluetooth hardware version number of the product.                                        |
| `bswVersion`          | `String`                   | The Bluetooth software version number of the product.                                        |
| `version`             | `String`                   | The product version number.                                                                   |
| `otaVersion`          | `String`                   | The version used for firmware upgrades verification.                                         |
| `seriesCode`          | `String`                   | A unique identifier for the hearing aid.                                                     |
| `adName`              | `String`                   | The advertisement name shown when scanning Bluetooth devices.                                 |
| `programs`            | `[JinHaoProgram]`          | An array of programs available for the hearing aid. These are derived from the `modeConfig` property. |

---

## Methods

### `init()`
- **Description**: Initializes a new `JinHaoProfile` instance with default values.

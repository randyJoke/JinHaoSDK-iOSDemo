# JinHaoProgram Enum

### Overview
The `JinHaoProgram` enum defines the different hearing aid modes (programs) available for a JinHao accessory. These modes represent different listening environments, such as normal, restaurant, outdoor, and music.

| Program Case     | Raw Value | Description                              |
|------------------|-----------|------------------------------------------|
| `normal`         | 0         | Standard listening mode.                 |
| `restaurant`     | 1         | Program designed for restaurant settings. |
| `outdoor`        | 2         | Program designed for outdoor environments. |
| `music`          | 3         | Program designed for music listening.    |

---

# JinHaoChip Enum

### Overview
The `JinHaoChip` enum represents different types of hearing aid chips used in the JinHao accessory. The chip types are used to differentiate between different hardware configurations.

| Chip Case        | Raw Value  | Description                                |
|------------------|------------|--------------------------------------------|
| `h01`            | 0x01       | Represents the H01 hearing aid chip.      |
| `a4`             | 0x00       | Represents the A4 hearing aid chip.       |
| `a16`            | 0x06       | Represents the A16 hearing aid chip.      |
| `unassigned`     | N/A        | Represents an unassigned chip type.      |

---

# JinHaoBLEChip Enum

### Overview
The `JinHaoBLEChip` enum defines the different Bluetooth chip types used in the JinHao accessory. These chip types correspond to various Bluetooth modules used in communication.

| BLE Chip Case    | Raw Value  | Description                                |
|------------------|------------|--------------------------------------------|
| `u87`            | 0x07       | Represents the U87 Bluetooth chip.        |
| `tiny600`        | 0x08       | Represents the Tiny600 Bluetooth chip.    |
| `unassigned`     | N/A        | Represents an unassigned Bluetooth chip.  |


# JinHaoProfileType Enum

## Overview
The `JinHaoProfileType` enum represents different types of profile data associated with the hearing aid device. Each case corresponds to a specific category of information that can be retrieved from or set on the device.

---

## Cases

| Case                   | Raw Value (UInt8) | Description                                                           |
|------------------------|-------------------|-----------------------------------------------------------------------|
| `productSeries`         | `0x00`            | The product series information of the hearing aid.                    |
| `productPattern`        | `0x01`            | The product pattern type of the hearing aid.                          |
| `productHard`           | `0x02`            | The hardware version of the product.                                  |
| `productSoft`           | `0x03`            | The software version of the product.                                  |
| `productSku`            | `0x04`            | The SKU code of the hearing aid product.                              |
| `productReserved`       | `0x05`            | Reserved field for additional product-specific data.                  |
| `productSeriesCode`     | `0x06`            | The series code for the hearing aid product.                          |
| `bluetoothHardPattern` | `0x10`            | The Bluetooth hardware pattern type.                                  |
| `bluetoothHard`         | `0x11`            | The Bluetooth hardware version of the product.                        |
| `bluetoothSoft`         | `0x12`            | The Bluetooth software version of the product.                        |
| `advertisementName`     | `0x13`            | The advertisement name displayed when scanning Bluetooth devices.      |
| `firmware`              | `0x22`            | The firmware version number of the device.                             |
| `ota`                   | `0x20`            | OTA (Over-The-Air) update version number.                             |
| `unknown`               | `0xFF`            | Represents an unknown or undefined profile type.                      |

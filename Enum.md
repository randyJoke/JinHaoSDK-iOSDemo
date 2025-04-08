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

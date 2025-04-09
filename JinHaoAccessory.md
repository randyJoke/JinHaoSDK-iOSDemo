# JinHaoAccessory Class

The `JinHaoAccessory` class inherits from the `Accessory` class and handles various functionalities for interacting with JinHao Bluetooth accessories, including battery status, program settings, volume control, and DSP configuratio.

## Protocols

### JinHaoAccessoryDelegate
Inherits from `AccessoryDelegate` and provides the following callbacks:

| Callback Method                                                                 | Description                                                                  |
| -------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| `batteryDidChanged(_ accessory: JinHaoAccessory, bat: Int)`                       | Notifies when the battery level changes or call `readBattery()` method.                                     |
| `didNotifyProgram(_ accessory: JinHaoAccessory, previous: Int, current: Int)`     | Notifies When we switch programs through the hearing aid's button
| `didNotifyVolume(_ accessory: JinHaoAccessory, previous: Int, current: Int)`      | Notifies When we adjust volume through the hearing aid's button
| `didUpdateValue(_ accessory: JinHaoAccessory, request: JinHaoRequest)`            | Notifies when a request `request(request: JinHaoRequest, complete: ((JinHaoResult) -> Void)?)` for [JinHaoAccessory](#jinhaoaccessory-class) update occurs.                                        |

## Public Properties

| Property Name        | Type                               | Description                                                                  |
| -------------------- | ---------------------------------- | ---------------------------------------------------------------------------- |
| `address`            | `String`                           | The address of the JinHao accessory, obtained from manufacturer data.        |
| `orientation`        | `AccessoryOrientation`             | The orientation of the accessory (`.left`, `.right`, or `.unassigned`).      |
| `hearChip`           | `JinHaoChip`                       | The hearing chip type used by the accessory.                                 |
| `bleChip`            | `JinHaoBLEChip`                    | The BLE chip type used by the accessory.                                     |
| `bat`                | `Int?`                             | The battery level of the accessory (if available).                          |
| `program`            | `Int?`                             | The current program number.                                                  |
| `volumeDic`          | `[Int: Int]`                       | A dictionary mapping program numbers to their respective volume settings.    |
| `dspDic`             | `[Int: JinHaoDsp]`                 | A dictionary mapping program numbers to their corresponding DSP data.        |
| `global`             | `JinHaoGlobalDsp?`                 | The global DSP configuration that applies to all programs.                  |
| `profile`            | `JinHaoProfile`                    | The accessory’s profile containing hardware and software version information.|
| `brEdr`              | `Bool`                             | Indicates whether Bluetooth BR/EDR (Basic Rate/Enhanced Data Rate) is enabled. |
| `transEnable`        | `Bool`                             | Indicates whether transparency functionality is enabled.                    |
| `transLevel`         | `Int?`                             | The transparency level (if enabled).                                         |
| `hearingSupported`   | `Bool`                             | Indicates whether the hearing test functionality is supported.              |
| `localName`          | `String?`                          | The local name of the peripheral, overridden to set and get from the `Accessory` base class. |
| `numberOfProgram`    | `Int?`                             | The total number of available programs, including global programs.           |
| `scenesOfProgram`    | `[JinHaoProgram]`                  | An array of programs in the accessory's profile.                             |
| `volume`             | `Int?`                             | The current volume level for the active program (if available).              |
| `dsp`                | `JinHaoDsp?`                       | The DSP data for the active program (if available).                          |

## Public Methods

| Method Name                                                 | Parameters                                                        | Description                                                                 |
| ----------------------------------------------------------- | ---------------------------------------------------------------- | --------------------------------------------------------------------------- |
| `request(request: JinHaoRequest, complete: ((JinHaoResult) -> Void)?)` | `request: JinHaoRequest`<br> `complete: ((JinHaoResult) -> Void)?` | Sends a single request to the JinHao accessory and provides a callback for the result. |
| `request(requests: [JinHaoRequest], complete: (() -> Void)?)` | `requests: [JinHaoRequest]`<br> `complete: (() -> Void)?`         | Sends multiple requests to the JinHao accessory and provides a callback when complete. |
| `readBattery()`                                             | None                                                             | Requests the current battery level of the JinHao accessory. and the             |

## Method Details

### `request(request: JinHaoRequest, complete: ((JinHaoResult) -> Void)?)`

- **Parameters**:
  - `request`: A `JinHaoRequest` representing the request to be sent to the accessory (e.g., for volume control, program selection).
  - `complete`: A closure callback that returns the result of the request (`JinHaoResult`), typically indicating success or error.

- **Description**: Sends a single request to the JinHao accessory and provides a callback for the result. If the accessory is not connected, the callback returns a `.disconnected` error.

### `request(requests: [JinHaoRequest], complete: (() -> Void)?)`

- **Parameters**:
  - `requests`: An array of `JinHaoRequest` objects to be sent to the accessory.
  - `complete`: A closure callback that is called once all requests have been processed.

- **Description**: Sends multiple requests to the JinHao accessory. The provided callback is invoked when all requests are completed.****

### `readBattery()`

- **Parameters**: None
- **Description**: Requests the current battery level of the JinHao accessory, triggering the `batteryDidChanged(_ accessory: JinHaoAccessory, bat: Int)` method in the `JinHaoAccessoryDelegate`.


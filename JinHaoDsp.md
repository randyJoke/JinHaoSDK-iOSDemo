# JinHaoDsp Protocol

The `JinHaoDsp` protocol defines the required properties and methods for DSP (Digital Signal Processing) configuration used by the JinHao accessory. It includes properties for controlling the audio direction, noise level, MPO (Maximum Power Output), and various equalizer settings for different frequency bands.

## Properties

| Property  | Type              | Description                                                                                                                                 |
|-----------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| `direction` | `JinHaoDirection` | The direction of the audio signal. Possible values include `.normal`, `.tv`, `.meeting`, `.face`, `.unknown`.                             |
| `noise`    | `JinHaoNoise`     | The noise reduction level. Possible values include `.off`, `.weak`, `.medium`, `.strong`.                                                   |
| `mpo`      | `JinHaoMPO?`       | The Maximum Power Output (MPO) level. Possible values include `.off`, `.low`, `.medium`, `.high`.                                          |
| `eq250`    | `Int`              | The equalizer setting for the 250Hz frequency.                                                                                               |
| `eq500`    | `Int`              | The equalizer setting for the 500Hz frequency.                                                                                               |
| `eq1000`   | `Int`              | The equalizer setting for the 1000Hz frequency.                                                                                              |
| `eq1500`   | `Int`              | The equalizer setting for the 1500Hz frequency.                                                                                              |
| `eq2000`   | `Int`              | The equalizer setting for the 2000Hz frequency.                                                                                              |
| `eq2500`   | `Int`              | The equalizer setting for the 2500Hz frequency.                                                                                              |
| `eq3000`   | `Int`              | The equalizer setting for the 3000Hz frequency.                                                                                              |
| `eq3500`   | `Int`              | The equalizer setting for the 3500Hz frequency.                                                                                              |
| `eq4000`   | `Int`              | The equalizer setting for the 4000Hz frequency.                                                                                              |
| `eq5000`   | `Int`              | The equalizer setting for the 5000Hz frequency.                                                                                              |
| `eq6000`   | `Int`              | The equalizer setting for the 6000Hz frequency.                                                                                              |
| `eq7000`   | `Int`              | The equalizer setting for the 7000Hz frequency.                                                                                              |
| `minEQValue`   | `Int`          | the minimum gain or attenuation setting for a specific frequency                                                                                      |
| `maxEQValue`   | `Int`          | the maximum gain or attenuation setting for a specific frequency                                                                 |
## Initializer

| Method        | Parameters        | Description                                                                 |
|---------------|-------------------|-----------------------------------------------------------------------------|
| `init(data:)` | `data: Data`      | Initializes a `JinHaoDsp` object using the provided `Data` object. The data is parsed to populate all properties of the DSP configuration. |

## Methods

| Method     | Return Type | Description                                                                 |
|------------|-------------|-----------------------------------------------------------------------------|
| `toData()` | `Data`      | Converts the current DSP configuration into a `Data` object that can be transmitted or saved. |

## Enum Definitions

### JinHaoDirection
Defines the audio signal direction. Possible values include:

- `.normal`: Normal audio direction.
- `.tv`: Audio direction for TV.
- `.meeting`: Audio direction for meetings.
- `.face`: Audio direction for face-to-face communication.
- `.unknown`: Unknown audio direction.

### JinHaoNoise
Defines the noise reduction level. Possible values include:

- `.off`: No noise reduction.
- `.weak`: Weak noise reduction.
- `.medium`: Medium noise reduction.
- `.strong`: Strong noise reduction.

### JinHaoMPO
Defines the Maximum Power Output (MPO) level. Possible values include:

- `.off`: MPO is off.
- `.low`: Low MPO level.
- `.medium`: Medium MPO level.
- `.high`: High MPO level.

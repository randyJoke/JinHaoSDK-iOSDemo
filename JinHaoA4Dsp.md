# JinHaoA4Dsp

`JinHaoA4Dsp` is a struct that implements the `JinHaoDsp` protocol, used for processing DSP (Digital Signal Processing) parameters. It supports various audio processing features like direction modes, noise suppression, maximum power output, and more.

## Enum

### `MPO`

The `MPO` enum defines the Maximum Power Output (MPO) levels:

| Value    | Description  |
|----------|--------------|
| `off`    | Off         |
| `low`    | Low         |
| `medium` | Medium      |
| `high`   | High        |

## Properties

### `direction`

| Property      | Type                | Description                          |
|---------------|---------------------|--------------------------------------|
| `direction`   | `JinHaoDirection`   | A computed property that defines the audio direction mode. It supports the following modes: |
|               |                     | - `normal` (Normal mode)             |
|               |                     | - `tv` (TV mode)                    |
|               |                     | - `meeting` (Meeting mode)          |
|               |                     | - `face` (Face-to-face mode)        |
|               |                     | - `unknown` (Unknown mode)          |

### `noise`

| Property      | Type                | Description                          |
|---------------|---------------------|--------------------------------------|
| `noise`       | `JinHaoNoise`       | A computed property that defines the noise suppression level. It supports the following levels: |
|               |                     | - `off` (Off)                       |
|               |                     | - `weak` (Weak suppression)         |
|               |                     | - `medium` (Medium suppression)     |
|               |                     | - `strong` (Strong suppression)     |

### `mpo`

| Property      | Type                | Description                          |
|---------------|---------------------|--------------------------------------|
| `mpo`         | `MPO?`              | An optional `MPO` enum representing the Maximum Power Output (MPO) level. It supports the following values: |
|               |                     | - `off` (Off)                       |
|               |                     | - `low` (Low)                       |
|               |                     | - `medium` (Medium)                 |
|               |                     | - `high` (High)                     |

### `frequences`

| Property      | Type                | Description                          |
|---------------|---------------------|--------------------------------------|
| `frequences`  | `[Int]`             | An array that returns the frequencies used by the DSP configuration. |

### `minEQValue`

| Property      | Type                | Description                          |
|---------------|---------------------|--------------------------------------|
| `minEQValue`  | `Int`               | The minimum EQ value, which is `0`.  |

### `maxEQValue`

| Property      | Type                | Description                          |
|---------------|---------------------|--------------------------------------|
| `maxEQValue`  | `Int`               | The maximum EQ value, which is `15`. |

## Initialization

### `init(data: Data)`

| Method            | Description                                      |
|-------------------|--------------------------------------------------|
| `init(data: Data)`| Initializes a `JinHaoA4

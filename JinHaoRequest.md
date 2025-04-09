# JinHaoRequest Enum

The `JinHaoRequest` enum defines various types of requests that can be made to a JinHao accessory. These requests are categorized into different groups: **Read**, **Write**, **Control**, **H01**, and **Hearing Test**.

## Read Requests

| Request Name                | Parameters                                     | Description                                           |
|-----------------------------|------------------------------------------------|-------------------------------------------------------|
| `readProgramVolume`          | None                                           | Reads the current program and volume. we can get `accessory.volume, accessory.program` if request successfully           |
| ~~`readVolume(program:)`~~       | ~~`program: Int (0-3)`~~                           | ~~Reads the volume for a specific program (0-3). we can get `accessory.program` if request successfully~~   |
| `readDsp(program:)`          | `program: Int (0-3)`                           | Reads the DSP settings for a specific program (0-3). we can get `accessory.dsp` if request successfully |
| `readNumberOfPrograms(chip:)`| `chip: JinHaoChip`                             | Reads the number of programs available for a chip. we can get `accessory.numberOfProgram` if request successfully  |
| `readScenesOfProgram`        | None                                           | Reads the scenes for program. we can get `accessory.scenesOfProgram` if request successfully |
| `readGlobalDsp(chip:)`       | `chip: JinHaoChip`                             | Reads the global DSP configuration for a chip.       |
| `readProfile(type:)`         | `type: JinHaoProfileType`                      | Reads a specific profile based on the provided type.  we can get `accessory.profile` if request successfully, please refer to [JinHaoProfileType](Enum.md#jinhaoprofiletype-enum) and [JinHaoProfile](JinHaoProfile.md#jinhaoprofile-class) about more details|

## Write Requests

| Request Name                | Parameters                                     | Description                                           |
|-----------------------------|------------------------------------------------|-------------------------------------------------------|
| `writeDsp(dsp:withResponse:)`| `dsp: any JinHaoDsp`, `program: Int (0-3)`, `withResponse: Bool` | Writes DSP settings for a program (0-3). If `withResponse` is `true`, the settings are saved to the hearing aid and persist even if the hearing aid loses power. If `withResponse` is `false`, the settings are not saved, and the changes will be lost after the hearing aid is powered off. |
| `writeDspData(data:withResponse:)` | `data: Data`, `program: Int (0-3)`, `withResponse: Bool` | Writes DSP data for a specific program (0-3). If `withResponse` is `true`, the data is saved to the hearing aid and remains even after power loss. If `withResponse` is `false`, the data is not saved and will be lost after the device is powered off. |
| `writeGlobalDsp(global:withResponse:)` | `global: JinHaoGlobalDsp`, `chip: JinHaoChip`, `withResponse: Bool` | Writes global DSP configuration for a chip. If `withResponse` is `true`, the configuration is saved to the hearing aid and is not lost upon power loss. If `withResponse` is `false`, the configuration is not saved, and it will be lost if the device is powered off. |
| `writeGlobalDspData(data:withResponse:)` | `data: Data`, `chip: JinHaoChip`, `withResponse: Bool` | Writes global DSP data for a chip. If `withResponse` is `true`, the data is saved and persists after the device loses power. If `withResponse` is `false`, the data is not saved and will be lost upon power-off. |
| `writeProfile(data:type:)`   | `data: Data`, `type: JinHaoProfileType`        | Writes a profile based on the provided data and type. |
| `writeProtocolData(data:)`   | `data: JinHaoRawData`                          | Writes raw protocol data to the accessory.            |

## Control Requests

| Request Name                | Parameters                                     | Description                                           |
|-----------------------------|------------------------------------------------|-------------------------------------------------------|
| `controlVolume(volume:program:)` | `volume: Int`, `program: Int (0-3)`          | adjust the volume for a specific program (0-3). The `volume` can be set in two ranges: <br>**Range 1:** `volume` from **0 to 10** representing a total of 10 volume levels. <br>**Range 2:** `volume` from **0 to 5**, representing a total of 6 volume levels.|
| `controlProgram(program:)`   | `program: Int (0-3)`                           | switch the active program (0-3).                     |
| `controlLockChip`            | None                                           | Locks the chip, preventing further changes.          |
| `controlMute(mute:)`         | `mute: Bool`                                   | Mutes or unmutes the device.                          |
| `controlBeep(value:)`        | `value: Int`                                   | Controls the beep sound of the accessory.             |
| `controlShip`                | None                                           | Shuts down or disables the accessory.                 |

## H01 Requests（Can only be called when bleChip is h01）

| Request Name                | Parameters                                     | Description                                           |
|-----------------------------|------------------------------------------------|-------------------------------------------------------|
| `enterDUT`                   | None                                           | Enters DUT (Device Under Test) mode.                  |
| `setTransparency(level:)`    | `level: Int`                                   | Sets the transparency level for the device.           |
| `setBrEdr(enable:)`          | `enable: Bool`                                 | Enables or disables BR/EDR (Bluetooth Classic) mode.  |
| `getTransparencyLevel`       | None                                           | Retrieves the current transparency level.             |
| `beginFind`                  | None                                           | Begins a search for devices.                          |
| `endFind`                    | None                                           | Ends the search for devices.                         |
| `resetFactory`               | None                                           | Resets the device to factory settings.                |

## Hearing Test Requests （Can only be called when hearingSupported is true）

| Request Name                | Parameters                                     | Description                                           |
|-----------------------------|------------------------------------------------|-------------------------------------------------------|
| `hearingSupported`           | None                                           | Checks if the hearing test feature is supported.      |
| `enterHearingMode(enter:)`   | `enter: Bool`                                  | Enters or exits hearing test mode.                    |
| `setBaseAmplitude(freq:amp:)`| `freq: UInt16`, `amp: Int16`                   | Sets the base amplitude for a specific frequency.     |
| `playSine(freq:dB:timestamp:)`| `freq: UInt16`, `dB: UInt8`, `timestamp: Int32` | Plays a sine wave at a specific frequency and dB level. |
| `playSineAmplitude(freq:amp:timestamp:)` | `freq: UInt16`, `amp: Int16`, `timestamp: Int32` | Plays a sine wave with amplitude at a specific frequency. |
| `stopPlaySine`               | None                                           | Stops the sine wave playback.                         |

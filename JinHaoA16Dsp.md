# JinHaoA16Dsp Class Documentation

## Class Overview
The `JinHaoA16Dsp` struct extends `JinHaoDsp` and is used to manage DSP settings, including frequency, direction, noise, EQ, and other parameters for hearing aid devices.

## Properties

| Property Name     | Type           | Description                                                                                  |
|-------------------|----------------|----------------------------------------------------------------------------------------------|
| `frequences`      | `[Int]`        | An array of frequencies.                                                                      |
| `direction`       | `JinHaoDirection` | The current direction mode of the device (e.g., normal, TV, meeting, face).                  |
| `noise`           | `JinHaoNoise`  | The noise reduction level (e.g., off, weak, medium, strong).                                  |
| `minEQValue`      | `Int`          | The minimum EQ value. Always `0`.                                                             |
| `maxEQValue`      | `Int`          | The maximum EQ value. Always `20`.                                                            |

## Methods

| Method Name                     | Return Type     | Description                                                                                   | Parameter Range                                                                                                  |
|----------------------------------|-----------------|-----------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| `init(data: Data)`               | `JinHaoA16Dsp`  | Initializes the `JinHaoA16Dsp` instance with the provided data, creating a `DspContent` object. | `data`: A `Data` object containing the DSP content.                                                             |
| `toData()`                       | `Data`          | Converts the current DSP object back into a `Data` object.                                    | N/A                                                                                                              |
| `setEq(eq: Int, at frequence: Int)` | `Void`         | Sets the EQ value for the specified frequency.                                                 | `eq`: A value between `0` and `20`, representing the EQ setting.<br>`frequence`: A frequency value.             |
| `getEq(at frequence: Int)`       | `Int?`          | Gets the EQ value for the specified frequency. Returns `nil` if the frequency is not found.     | `frequence`: A frequency value.                                                                                  |
| `setCompressRatioLevel(compressRatioLevel: Int, at frequence: Int)` | `Void` | Sets the compression ratio level for the specified frequency.                                  | `compressRatioLevel`: A value between `0` and `35`.<br>`frequence`: A frequency value.                         |
| `getCompressRatioLevel(at frequence: Int)` | `Int?` | Gets the compression ratio level for the specified frequency. Returns `nil` if the frequency is not found. | `frequence`: A frequency value.                                                                                  |
| `getCompressRatioValue(level: Int)` | `Float?`      | Converts the compression ratio level to its corresponding value.                               | `level`: A value between `0` and `35`.                                                                            |
| `setCompressThresholdLevel(compressThresholdLevel: Int, at frequence: Int)` | `Void` | Sets the compression threshold level for the specified frequency.                              | `compressThresholdLevel`: A value between `0` and `20`.<br>`frequence`: A frequency value.                     |
| `getCompressThresholdLevel(at frequence: Int)` | `Int?` | Gets the compression threshold level for the specified frequency. Returns `nil` if the frequency is not found. | `frequence`: A frequency value.                                                                                  |
| `getCompressThresholdValue(level: Int)` | `Int?`      | Converts the compression threshold level to its corresponding value.                           | `level`: A value between `0` and `20`.                                                                            |
| `setMpoLevel(mpoLevel: Int, at frequence: Int)` | `Void` | Sets the MPO level for the specified frequency.                                                | `mpoLevel`: A value between `0` and `11`.<br>`frequence`: A frequency value.                                    |
| `getMpoLevel(at frequence: Int)` | `Int?`          | Gets the MPO level for the specified frequency. Returns `nil` if the frequency is not found.   | `frequence`: A frequency value.                                                                                  |
| `getMpoValue(level: Int)`       | `Int?`          | Converts the MPO level to its corresponding value.                                             | `level`: A value between `0` and `11`.                                                                            |
| `attackTimeLevel`               | `Int`           | Gets or sets the attack time level for the device.                                            | `attackTimeLevel`: A value between `0` and `10`.                                                                 |
| `releaseTimeLevel`              | `Int`           | Gets or sets the release time level for the device.                                           | `releaseTimeLevel`: A value between `0` and `10`.                                                                |
| `getAttackTimeValue(level: Int)` | `Void`         | (Empty method for future implementation).                                                     | `level`: A value between `0` and `10`.                                                                           |
| `getReleaseTimeValue(level: Int)` | `Void`        | (Empty method for future implementation).                                                     | `level`: A value between `0` and `10`.                                                                           |

---

## MPO
| Level                         | Value         | Description
|-------------------------------|----------------|-------------------------------------------------|
| 0                         | 0             |  off |
| 1                         | -1            |  MUO |
| 2                         | -2             | None|
| 3                         | -4              | None| 
| 4                         | -6              | None| 
| 5                         | -8              | None| 
| 6                         | -10             | None| 
| 7                         | -12             | None| 
| 8                         | -14             | None| 
| 9                         | -16             | None| 
| 10                         | -18            | None| 
| 11                         | -20            | None| 


## Compression Threshold
| Level                         | Value         | Description
|-------------------------------|----------------|-------------------------------------------------|
| 0                         | 20             |  None |
| 1                         | 22            |  None |
| 2                         | 24             | None|
| 3                         | 26              | None| 
| 4                         | 28              | None| 
| 5                         | 30              | None| 
| 6                         | 32             | None| 
| 7                         | 34             | None| 
| 8                         | 36             | None| 
| 9                         | 38             | None| 
| 10                         | 40            | None| 
| 11                         | 42            | None| 
| 12                         |44            | None|
| 13                         | 46              | None| 
| 14                         | 48             | None| 
| 15                         | 50              | None| 
| 16                         | 52             | None| 
| 17                         | 54             | None| 
| 18                         | 56             | None| 
| 19                         | 58             | None| 
| 20                         | 60            | None| 
| 21                         | 62            |  None |
| 22                         | 64             | None|
| 23                         | 66              | None| 
| 24                         | 68              | None| 
| 25                         | 70              | None| 
| 26                         | 72             | None| 
| 27                         | 74             | None| 
| 28                         | 76             | None| 
| 29                         | 78             | None| 
| 30                         | 80            | None| 
| 31                         | 82            | None| 

## Compression Ratio
| Level                         | Value         | Description
|-------------------------------|----------------|-------------------------------------------------|
| 0                         | 1             |  None |
| 1                         | 1.03            |  None |
| 2                         | 1.05             | None|
| 3                         | 1.08             | None| 
| 4                         | 1.11              | None| 
| 5                         | 1.14              | None| 
| 6                         | 1.18             | None| 
| 7                         | 1.21             | None| 
| 8                         | 1.25             | None| 
| 9                         | 1.29            | None| 
| 10                         | 1.33           | None| 
| 11                         | 1.38            | None| 
| 12                         |1.43            | None|
| 13                         | 1.48              | None| 
| 14                         | 1.54             | None| 
| 15                         | 1.60              | None| 
| 16                         | 1.67             | None| 
| 17                         | 1.74             | None| 
| 18                         | 1.82             | None| 
| 19                         | 1.90             | None| 
| 20                         | 2.00           | None| 
| 21                         | 2.11            |  None |
| 22                         | 2.22             | None|
| 23                         | 2.35              | None| 
| 24                         | 2.50              | None| 
| 25                         | 2.67              | None| 
| 26                         | 2.86             | None| 
| 27                         | 3.08             | None| 
| 28                         | 3.33             | None| 
| 29                         | 3.64             | None| 
| 30                         | 4.00            | None| 
| 31                         | 4.44            | None| 
| 32                         | 5.00             | None| 
| 33                        | 5.71             | None| 
| 34                         | 6.67            | None| 
| 35                        | 8.00            | None| 

## Attack Time
| Level                         | Value         | Description
|-------------------------------|----------------|-------------------------------------------------|
| 0                         | 2             |  ms |
| 1                         |5            |  ms |
| 2                         |10             | ms|
| 3                         | 20              | ms| 

## Release Time
| Level                         | Value         | Description
|-------------------------------|----------------|-------------------------------------------------|
| 0                         | 30             |  ms |
| 1                         | 60            |  ms |
| 2                         | 120             | ms|
| 3                         | 240              | ms| 
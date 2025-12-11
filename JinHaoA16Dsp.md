# JinHaoA16Dsp Class Documentation

## Overview
The `JinHaoA16Dsp` struct contains all DSP configuration parameters for JinHao A16 hearing aid devices. This document details all properties of the data model.

## Property Categories

### 1. Basic DSP Settings

#### Input Mode
**Property:** `inputMode`
**Type:** `JinHaoA16DspEnum.InputMode`
**Default:** `.ai1Mic1`
**Description:** Defines the input source selection for the DSP. Options include various microphone combinations and audio input modes.

#### Analog Pre-Amplifier Gains
- **`analogPreGainP0`**: Analog gain for path P0 (default: `.db0`, 0 dB)
- **`analogPreGainP1`**: Analog gain for path P1 (default: `.db0`, 0 dB)

**Type:** `JinHaoA16DspEnum.AnalogPreGain`
**Range:** 0 dB to 36 dB in 3 dB increments

#### Digital Pre-Amplifier Gains
- **`digitalPreGainP1`**: Digital gain for path P1 (default: `.db0`, 0 dB)
- **`digitalPreGainP2`**: Digital gain for path P2 (default: `.db0`, 0 dB)

**Type:** `JinHaoA16DspEnum.DigitalPreGain`
**Range:** 0 dB, 6 dB, 12 dB, 18 dB

#### Matrix Gain Components
- **`matrixGainMantissa`**: Mantissa component of matrix gain calculation
- **`matrixGainExponent`**: Exponent component of matrix gain calculation

**Type:** `Int`
**Usage:** These two properties work together to represent matrix gain values from 0 dB to -47 dB. Use the provided helper methods `setMatrixGain()` and `getMatrixGain()` for easier manipulation.

#### Signal Processing Features
- **`feedbackCanceler`**: Feedback cancellation algorithm setting (default: `.off`)
- **`noiseReduction`**: Noise reduction level (default: `.off`)
- **`lowLevelExpansion`**: Low-level expansion (soft sounds enhancement) switch (default: `.off`)
- **`windNoiseReduction`**: Wind noise reduction switch (default: `.off`)

### 2. Equalizer Settings

#### Equalizer Array
**Property:** `equalizerArray`
**Type:** `[JinHaoA16DspEnum.EqualizerGain]`
**Size:** 16 elements
**Default:** All elements set to `.db0` (0 dB)
**Description:** Contains gain values for each of the 16 frequency bands in the equalizer. Each element corresponds to a specific frequency band.

**Reserved Fields:**
- `em1`: Experimental/reserved field 1
- `em2`: Experimental/reserved field 2

### 3. Compression Settings

#### Compression Ratio Array
**Property:** `compressionRatioArray`
**Type:** `[JinHaoA16DspEnum.CompressionRatio]`
**Size:** 16 elements
**Default:** All elements set to `.ratio1_00` (1.00:1 ratio)
**Description:** Compression ratio settings for each frequency band.

**Reserved Fields:**
- `em3`: Experimental/reserved field 3
- `em4`: Experimental/reserved field 4

#### Compression Constant Array
**Property:** `compressionConstantArray`
**Type:** `[JinHaoA16DspEnum.CompressionConstant]`
**Size:** 16 elements
**Default:** All elements set to `.constant0`
**Description:** Time constant settings for compression release times in each frequency band.

#### Compression Threshold Array
**Property:** `compressionThresholdArray`
**Type:** `[JinHaoA16DspEnum.CompressionThreshold]`
**Size:** 16 elements
**Default:** All elements set to `.db40` (40 dB)
**Description:** Threshold levels for compression activation in each frequency band.

**Reserved Fields:**
- `em5`: Experimental/reserved field 5
- `em6`: Experimental/reserved field 6
- `em7`: Experimental/reserved field 7

### 4. Maximum Power Output (MPO) Settings

#### MPO Array
**Property:** `maximumPowerOutputArray`
**Type:** `[JinHaoA16DspEnum.MaximumPowerOutput]`
**Size:** 16 elements
**Default:** All elements set to `.muo` (Max Undistorted Output)
**Description:** Maximum output power limits for each frequency band.

**Reserved Field:**
- `em8`: Experimental/reserved field 8

#### MPO Time Constants
- **`mpoAttackTime`**: Attack time for MPO limiting (default: `.ms10`, 10 ms)
- **`mpoReleaseTime`**: Release time for MPO limiting (default: `.ms40`, 40 ms)

**Reserved Field:**
- `em9`: Experimental/reserved field 9

### 5. Additional Audio Processing

#### Remote Mix Ratio
**Property:** `remoteMixRatio`
**Type:** `JinHaoA16DspEnum.RemoteMixRatio`
**Default:** `.db0` (0 dB)
**Description:** Controls the mix ratio for remote microphone input.

#### Low Cut Input Filter
**Property:** `lowCutInputFilter`
**Type:** `JinHaoA16DspEnum.LowCutFilter`
**Default:** `.off`
**Description:** Configures the low-frequency cutoff filter for input signals.

### 6. Frequency Reference

#### Frequency Array
**Property:** `frequalizerArray`
**Type:** `[Int]` (constant)
**Value:** `[250, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500]`
**Description:** Contains the center frequencies (in Hz) for each of the 16 equalizer bands. This array is read-only and provides reference frequencies for the other parameter arrays.

## Array Index Mapping

All 16-element arrays use the following frequency band mapping:

| Index | Frequency | Enum Value |
|-------|-----------|------------|
| 0 | 250 Hz | `.hz250` |
| 1 | 500 Hz | `.hz500` |
| 2 | 1000 Hz | `.hz1000` |
| 3 | 1500 Hz | `.hz1500` |
| 4 | 2000 Hz | `.hz2000` |
| 5 | 2500 Hz | `.hz2500` |
| 6 | 3000 Hz | `.hz3000` |
| 7 | 3500 Hz | `.hz3500` |
| 8 | 4000 Hz | `.hz4000` |
| 9 | 4500 Hz | `.hz4500` |
| 10 | 5000 Hz | `.hz5000` |
| 11 | 5500 Hz | `.hz5500` |
| 12 | 6000 Hz | `.hz6000` |
| 13 | 6500 Hz | `.hz6500` |
| 14 | 7000 Hz | `.hz7000` |
| 15 | 7500 Hz | `.hz7500` |

## Reserved Fields

The `em0` through `em9` fields are reserved for experimental features or future expansion. These fields should not be modified unless specifically documented for a particular use case.

## Default Values

When a new `JinHaoA16Dsp` instance is created using the default initializer, all properties are set to their safe default values, which represent a neutral configuration suitable for most users.

## Overview
The `JinHaoA16Dsp` struct represents the complete DSP configuration for JinHao A16 devices. It provides functionality to serialize and deserialize DSP parameters from byte arrays, as well as convenient access methods for all DSP settings.

## Struct Definition

### `JinHaoA16Dsp`
A Swift struct that models all DSP parameters for the JinHao A16 device.

## Properties

### Basic DSP Settings
- `inputMode`: Input mode selection (default: `.ai1Mic1`)
- `analogPreGainP0`: Analog pre-amplifier gain for path P0 (default: `.db0`)
- `analogPreGainP1`: Analog pre-amplifier gain for path P1 (default: `.db0`)
- `digitalPreGainP1`: Digital pre-amplifier gain for path P1 (default: `.db0`)
- `digitalPreGainP2`: Digital pre-amplifier gain for path P2 (default: `.db0`)
- `matrixGainMantissa`: Mantissa part of matrix gain calculation
- `matrixGainExponent`: Exponent part of matrix gain calculation
- `feedbackCanceler`: Feedback cancellation setting (default: `.off`)
- `noiseReduction`: Noise reduction level (default: `.off`)
- `lowLevelExpansion`: Low-level expansion switch (default: `.off`)
- `windNoiseReduction`: Wind noise reduction switch (default: `.off`)
- `em0`: Reserved/experimental field 0

### Equalizer Settings
- `equalizerArray`: Array of 16 equalizer gain values (one for each frequency band)
- `em1`: Reserved/experimental field 1
- `em2`: Reserved/experimental field 2

### Compression Settings
- `compressionRatioArray`: Array of 16 compression ratio values
- `em3`: Reserved/experimental field 3
- `em4`: Reserved/experimental field 4
- `compressionConstantArray`: Array of 16 compression time constant values
- `compressionThresholdArray`: Array of 16 compression threshold values
- `em5`: Reserved/experimental field 5
- `em6`: Reserved/experimental field 6
- `em7`: Reserved/experimental field 7

### Maximum Power Output Settings
- `maximumPowerOutputArray`: Array of 16 maximum power output values
- `em8`: Reserved/experimental field 8
- `mpoAttackTime`: MPO attack time constant (default: `.ms10`)
- `mpoReleaseTime`: MPO release time constant (default: `.ms40`)
- `em9`: Reserved/experimental field 9
- `remoteMixRatio`: Remote microphone mix ratio (default: `.db0`)
- `lowCutInputFilter`: Low-cut input filter setting (default: `.off`)

### Frequency Reference
- `frequalizerArray`: Constant array of frequency values for each band: [250, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500] Hz


## Methods

### Set Matrix Gain
Public mutating method that sets the matrix gain using a single integer value. Accepts an integer parameter representing the desired matrix gain in dB. The method internally calculates the corresponding mantissa and exponent components and stores them in the `matrixGainMantissa` and `matrixGainExponent` properties. The input value must be in the valid range of -47 to -1, representing matrix gain values from -1 dB to -47 dB. If an invalid value is provided, the method will throw a fatal error.

### Get Matrix Gain
Public method that calculates and returns the current matrix gain as a single integer value. Uses the stored `matrixGainMantissa` and `matrixGainExponent` properties to compute the actual gain value through an internal calculation formula. Returns an integer representing the current matrix gain in dB.

### Matrix Gain Display Value
Public computed property that returns the matrix gain as a human-readable string. Retrieves the current matrix gain value using the `getMatrixGain()` method, then attempts to find a corresponding `MatrixGain` enum case. If found, returns the enum's display name; otherwise returns "Unknown". This property provides a user-friendly representation of the matrix gain setting.

## Frequency Band Operation Methods

### Get Equalizer Gain
Public method that retrieves the equalizer gain for a specific frequency band. Accepts a `FrequencyBand` enum parameter indicating which frequency to query. Checks if the frequency's raw value is within the bounds of the `equalizerArray`. Returns the equalizer gain value for the specified frequency band, or returns the default `.db0` if the index is out of bounds.

### Set Equalizer Gain
Public mutating method that sets the equalizer gain for a specific frequency band. Accepts two parameters: a `EqualizerGain` enum value and a `FrequencyBand` enum value. Checks if the frequency's raw value is within the bounds of the `equalizerArray`. If valid, updates the corresponding element in the `equalizerArray` with the new gain value.

### Get Compression Ratio
Public method that retrieves the compression ratio for a specific frequency band. Accepts a `FrequencyBand` enum parameter indicating which frequency to query. Checks if the frequency's raw value is within the bounds of the `compressionRatioArray`. Returns the compression ratio value for the specified frequency band, or returns the default `.ratio1_00` if the index is out of bounds.

### Set Compression Ratio
Public mutating method that sets the compression ratio for a specific frequency band. Accepts two parameters: a `CompressionRatio` enum value and a `FrequencyBand` enum value. Checks if the frequency's raw value is within the bounds of the `compressionRatioArray`. If valid, updates the corresponding element in the `compressionRatioArray` with the new ratio value.

### Get Compression Constant
Public method that retrieves the compression time constant for a specific frequency band. Accepts a `FrequencyBand` enum parameter indicating which frequency to query. Checks if the frequency's raw value is within the bounds of the `compressionConstantArray`. Returns the compression constant value for the specified frequency band, or returns the default `.constant0` if the index is out of bounds.

### Set Compression Constant
Public mutating method that sets the compression time constant for a specific frequency band. Accepts two parameters: a `CompressionConstant` enum value and a `FrequencyBand` enum value. Checks if the frequency's raw value is within the bounds of the `compressionConstantArray`. If valid, updates the corresponding element in the `compressionConstantArray` with the new constant value.

### Get Compression Threshold
Public method that retrieves the compression threshold for a specific frequency band. Accepts a `FrequencyBand` enum parameter indicating which frequency to query. Checks if the frequency's raw value is within the bounds of the `compressionThresholdArray`. Returns the compression threshold value for the specified frequency band, or returns the default `.db40` if the index is out of bounds.

### Set Compression Threshold
Public mutating method that sets the compression threshold for a specific frequency band. Accepts two parameters: a `CompressionThreshold` enum value and a `FrequencyBand` enum value. Checks if the frequency's raw value is within the bounds of the `compressionThresholdArray`. If valid, updates the corresponding element in the `compressionThresholdArray` with the new threshold value.

### Get Maximum Power Output
Public method that retrieves the maximum power output setting for a specific frequency band. Accepts a `FrequencyBand` enum parameter indicating which frequency to query. Checks if the frequency's raw value is within the bounds of the `maximumPowerOutputArray`. Returns the maximum power output value for the specified frequency band, or returns the default `.muo` if the index is out of bounds.

### Set Maximum Power Output
Public mutating method that sets the maximum power output for a specific frequency band. Accepts two parameters: a `MaximumPowerOutput` enum value and a `FrequencyBand` enum value. Checks if the frequency's raw value is within the bounds of the `maximumPowerOutputArray`. If valid, updates the corresponding element in the `maximumPowerOutputArray` with the new maximum power output value.
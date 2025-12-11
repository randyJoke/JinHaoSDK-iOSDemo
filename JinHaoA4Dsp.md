# JinHaoA4Dsp

## Overview
The `JinHaoA4Dsp` struct provides a comprehensive model for managing DSP configuration in JinHao A4 hearing aid devices. This document details all properties and methods.

## Properties

### 1. Basic DSP Settings

#### Input Mode
**Property:** `inputMode`
**Type:** `JinHaoA4DspEnum.InputMode`
**Default:** `.ai1Mic1`
**Description:** Defines the input source selection for the DSP. Controls which microphone or audio input is used as the primary source.

#### Pre-Amplifier Gains
- **`preGainMic1`**: Pre-amplifier gain for microphone 1 (default: `.db0`, 0 dB)
- **`preGainMic2`**: Pre-amplifier gain for microphone 2 (default: `.db0`, 0 dB)

**Type:** `JinHaoA4DspEnum.PreampGain`
**Range:** 0 dB to 30 dB in specific increments (0, 12, 15, 18, 21, 24, 27, 30 dB)

#### Matrix Gain Components
- **`matrixGainMantissa`**: Mantissa component of matrix gain calculation
- **`matrixGainExponent`**: Exponent component of matrix gain calculation

**Type:** `Int`
**Usage:** These two properties work together to represent matrix gain values. The actual gain value can be calculated using the `getMatrixGain()` method.

#### Signal Processing Features
- **`feedbackCanceler`**: Feedback cancellation algorithm (default: `.off`)
- **`expansion`**: Expansion (noise gate) functionality (default: `.off`)
- **`lowCutFilter`**: Low-frequency cutoff filter (default: `.hz200`, 200 Hz)
- **`highCutFilter`**: High-frequency cutoff filter (default: `.hz8000`, 8000 Hz/off)
- **`maximumPowerOutput`**: Maximum output power limiting (default: `.muo`, Max Undistorted Output)
- **`noiseReduction`**: Noise reduction level (default: `.off`)
- **`notCare`**: Reserved field for internal use

### 2. Compression Settings

#### Compression Ratios
- **`compressionRatio1`**: Compression ratio for band 1 (default: `.ratio1_0`, 1.00:1)
- **`compressionRatio2`**: Compression ratio for band 2 (default: `.ratio1_0`, 1.00:1)
- **`compressionRatio3`**: Compression ratio for band 3 (default: `.ratio1_0`, 1.00:1)
- **`compressionRatio4`**: Compression ratio for band 4 (default: `.ratio1_0`, 1.00:1)

#### Compression Threshold
**Property:** `compressionThreshold`
**Type:** `JinHaoA4DspEnum.CompressionThreshold`
**Default:** `.db40` (40 dB)
**Description:** The sound level at which compression begins to take effect.

### 3. Equalizer Settings

#### Equalizer Array
**Property:** `equalizerArray`
**Type:** `[JinHaoA4DspEnum.EqualizerGain]`
**Size:** 12 elements
**Default:** All elements set to `.db0` (0 dB)
**Description:** Contains gain values for each of the 12 frequency bands in the equalizer.

### 4. Frequency Reference

#### Frequency Array
**Property:** `frequalizerArray`
**Type:** `[Int]` (constant)
**Value:** `[250, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 5000, 6000, 7000]`
**Description:** Contains the center frequencies (in Hz) for each of the 12 equalizer bands. This array is read-only.

## Array Index Mapping

The equalizer array uses the following frequency band mapping:

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
| 9 | 5000 Hz | `.hz5000` |
| 10 | 6000 Hz | `.hz6000` |
| 11 | 7000 Hz | `.hz7000` |

## Methods

### 1. Matrix Gain Methods

#### Set Matrix Gain
Sets the matrix gain using a single integer value, automatically calculating mantissa and exponent components. Takes an integer parameter representing the desired matrix gain, which must be in the valid range of -47 to -1. Throws a fatal error if the input value is outside the valid range.

#### Get Matrix Gain
Calculates and returns the current matrix gain as a single integer value. Returns the matrix gain as an integer based on the current mantissa and exponent properties.

#### Matrix Gain Display Value
A computed property that returns the matrix gain as a human-readable string. Returns a string like "0 dB", "-15 dB", etc., or "Unknown" if the calculated gain value is invalid.

### 2. Equalizer Methods

#### Get Equalizer Gain
Retrieves the equalizer gain for a specific frequency band. Takes a FrequencyBand enum parameter specifying which frequency to query. Returns the equalizer gain value for the specified frequency band.

#### Set Equalizer Gain
Sets the equalizer gain for a specific frequency band. Takes two parameters: a gain value and a frequency band. Modifies the equalizer array at the index corresponding to the specified frequency.


# JinHao A16 DSP Parameter Documentation

## Overview
This document describes the DSP parameter constants and enumerations for the JinHao A16 DSP system. The code is written in Swift and provides type-safe access to all DSP parameters.

## Constants

### `JinHaoA16DspParameterLabels`
Contains all display string constants for DSP parameters.

#### Input Multiplexer Values
- `"AI1 (Mic1)"`
- `"AI2 (DAI or Streaming)"`
- `"AI0 (TC)"`
- `"AI3 (Mic2)"`
- `"Fixed Cardioid (AI1-AI3)"`
- `"Fixed SuperCardioid"`
- `"Fixed HyperCardioid"`
- `"Adaptive Cardioid"`
- `"Adaptive SuperCardioid"`
- `"Adaptive HyperCardioid"`
- `"Noise Generator"`
- `"MIC1 + TC"`
- `"Mic1 + (DAI or Streaming)"`
- `"MIC1 + Noise Generator"`
- `"Fixed Cardioid + Streaming"`
- `"Adaptive Cardioid + Streaming"`

#### Analog Pre-Amp Gain Values
- `"0 dB"`
- `"3 dB"`
- `"6 dB"`
- `"9 dB"`
- `"12 dB"`
- `"15 dB"`
- `"18 dB"`
- `"21 dB"`
- `"24 dB"`
- `"27 dB"`
- `"30 dB"`
- `"33 dB"`
- `"36 dB"`

#### Digital Pre-Amp Gain Values
- `"0 dB"`
- `"6 dB"`
- `"12 dB"`
- `"18 dB"`

#### Matrix Gain Values
Range from `"0 dB"` to `"-47 dB"` in 1 dB steps.

#### Feedback Canceler Values
- `"OFF"`
- `"Normal"`
- `"Aggressive"`

#### Noise Reduction Values
- `"Off"`
- `"Low"`
- `"Medium"`
- `"High"`
- `"Max"`

#### Low Level Expansion Values
- `"Off"`
- `"On"`

#### Wind Values
- `"Off"`
- `"On"`

#### Low Cut Values
- `"Off"`
- `"250 Hz"`
- `"500 Hz"`
- `"750 Hz"`
- `"1000 Hz"`
- `"1250 Hz"`
- `"1500 Hz"`
- `"2000 Hz"`
- `"2500 Hz"`
- `"3000 Hz"`

#### Remote Mix Values
- `"0 dB"`
- `"-3 dB"`
- `"-6 dB"`
- `"-9 dB"`
- `"-12 dB"`

#### MPO Attack Constants Values
- `"10 ms"`
- `"20 ms"`
- `"30 ms"`
- `"40 ms"`

#### MPO Release Constants Values
- `"40 ms"`
- `"80 ms"`
- `"150 ms"`
- `"350 ms"`

#### Compression Ratios Values
Range from `"1.00 : 1"` to `"8.00 : 1"` with 36 different ratio values.

#### Compression Thresholds Values
Range from `"20 dB"` to `"82 dB"` in 2 dB steps (32 values total).

#### Compression Time Constants Values
- `"3 ms / 120 ms"`
- `"3 ms / 300 ms"`
- `"3 ms / 800 ms"`
- `"50 ms / 300 ms; 3 ms / 50 ms"`
- `"100 ms / 800 ms; 3 ms / 100 ms"`
- `"100 ms / 2000 ms; 3 ms / 100 ms"`
- `"400 ms / 15000 ms; 3 ms / 100 ms; 12 dB / 600 ms"`
- `"400 ms / 15000 ms; 3 ms / 100 ms; 18 dB / 600 ms"`
- `"400 ms / 15000 ms; 3 ms / 100 ms; 24 dB / 600 ms"`

#### Maximum Power Output Threshold Values
- `"Off"`
- `"Max Undistorted Output (MUO)"`
- `"-2 dB"`
- `"-4 dB"`
- `"-6 dB"`
- `"-8 dB"`
- `"-10 dB"`
- `"-12 dB"`
- `"-14 dB"`
- `"-16 dB"`
- `"-18 dB"`
- `"-20 dB"`
- `"-22 dB"`
- `"-24 dB"`
- `"-26 dB"`
- `"-28 dB"`

#### Compression Band EQs Values
Range from `"-40 dB"` to `"0 dB"` in 2 dB steps.

## Enumerations

### `JinHaoA16DspEnum`

#### `InputMode`
**Values:**
- `ai1Mic1` (0) - "AI1 (Mic1)"
- `ai2DAIStreaming` (1) - "AI2 (DAI or Streaming)"
- `ai0TC` (2) - "AI0 (TC)"
- `ai3Mic2` (3) - "AI3 (Mic2)"
- `fixedCardioid` (4) - "Fixed Cardioid (AI1-AI3)"
- `fixedSuperCardioid` (5) - "Fixed SuperCardioid"
- `fixedHyperCardioid` (6) - "Fixed HyperCardioid"
- `adaptiveCardioid` (7) - "Adaptive Cardioid"
- `adaptiveSuperCardioid` (8) - "Adaptive SuperCardioid"
- `adaptiveHyperCardioid` (9) - "Adaptive HyperCardioid"
- `noiseGenerator` (10) - "Noise Generator"
- `mic1TC` (11) - "MIC1 + TC"
- `mic1DAI` (12) - "Mic1 + (DAI or Streaming)"
- `mic1NoiseGenerator` (13) - "MIC1 + Noise Generator"
- `fixedCardioidStreaming` (14) - "Fixed Cardioid + Streaming"
- `adaptiveCardioidStreaming` (15) - "Adaptive Cardioid + Streaming"

**Properties:**
- `displayName`: Returns the human-readable string for each input mode

#### `AnalogPreGain`
**Values:**
Range from `db0` (0 dB) to `db36` (36 dB) in 3 dB steps.

**Properties:**
- `displayName`: Returns the gain value as a string (e.g., "0 dB", "3 dB")
- `valueInDB`: Returns the gain value as an integer

#### `DigitalPreGain`
**Values:**
- `db0` (0 dB)
- `db6` (6 dB)
- `db12` (12 dB)
- `db18` (18 dB)

**Properties:**
- `displayName`: Returns the gain value as a string
- `valueInDB`: Returns the gain value as an integer

#### `MatrixGain`
**Values:**
Range from `db0` (0 dB) to `dbMinus47` (-47 dB) in 1 dB steps.

**Properties:**
- `displayName`: Returns the gain value as a string
- `valueInDB`: Returns the gain value as an integer (negative values)

#### `FeedbackCanceler`
**Values:**
- `off` - "OFF"
- `normal` - "Normal"
- `aggressive` - "Aggressive"

**Properties:**
- `displayName`: Returns the human-readable string

#### `NoiseReduction`
**Values:**
- `off` - "Off"
- `low` - "Low"
- `medium` - "Medium"
- `high` - "High"
- `max` - "Max"

**Properties:**
- `displayName`: Returns the human-readable string

#### `SwitchState`
**Values:**
- `off` - "Off"
- `on` - "On"

**Properties:**
- `displayName`: Returns the human-readable string

#### `LowCutFilter`
**Values:**
- `off` - "Off"
- `hz250` - "250 Hz"
- `hz500` - "500 Hz"
- `hz750` - "750 Hz"
- `hz1000` - "1000 Hz"
- `hz1250` - "1250 Hz"
- `hz1500` - "1500 Hz"
- `hz2000` - "2000 Hz"
- `hz2500` - "2500 Hz"
- `hz3000` - "3000 Hz"

**Properties:**
- `displayName`: Returns the human-readable string
- `frequency`: Returns the cutoff frequency as an optional integer (nil for "Off")

#### `RemoteMixRatio`
**Values:**
- `db0` (0 dB)
- `dbMinus3` (-3 dB)
- `dbMinus6` (-6 dB)
- `dbMinus9` (-9 dB)
- `dbMinus12` (-12 dB)

**Properties:**
- `displayName`: Returns the ratio value as a string
- `valueInDB`: Returns the ratio value as an integer

#### `MPOAttackTime`
**Values:**
- `ms10` (10 ms)
- `ms20` (20 ms)
- `ms30` (30 ms)
- `ms40` (40 ms)

**Properties:**
- `displayName`: Returns the time value as a string
- `timeInMS`: Returns the time value as an integer

#### `MPOReleaseTime`
**Values:**
- `ms40` (40 ms)
- `ms80` (80 ms)
- `ms150` (150 ms)
- `ms350` (350 ms)

**Properties:**
- `displayName`: Returns the time value as a string
- `timeInMS`: Returns the time value as an integer

#### `CompressionRatio`
**Values:**
Range from `ratio1_00` (1.00:1) to `ratio8_00` (8.00:1) with 36 different ratio values.

**Properties:**
- `displayName`: Returns the compression ratio as a string
- `ratioValue`: Returns the compression ratio as a Double

#### `CompressionThreshold`
**Values:**
Range from `db20` (20 dB) to `db82` (82 dB) in 2 dB steps.

**Properties:**
- `displayName`: Returns the threshold value as a string
- `thresholdInDB`: Returns the threshold value as an integer

#### `CompressionConstant`
**Values:**
- `constant0` - "3 ms / 120 ms"
- `constant1` - "3 ms / 300 ms"
- `constant2` - "3 ms / 800 ms"
- `constant3` - "50 ms / 300 ms; 3 ms / 50 ms"
- `constant4` - "100 ms / 800 ms; 3 ms / 100 ms"
- `constant5` - "100 ms / 2000 ms; 3 ms / 100 ms"
- `constant6` - "400 ms / 15000 ms; 3 ms / 100 ms; 12 dB / 600 ms"
- `constant7` - "400 ms / 15000 ms; 3 ms / 100 ms; 18 dB / 600 ms"
- `constant8` - "400 ms / 15000 ms; 3 ms / 100 ms; 24 dB / 600 ms"

**Properties:**
- `displayName`: Returns the time constants as a string

#### `MaximumPowerOutput`
**Values:**
- `off` - "Off"
- `muo` - "Max Undistorted Output (MUO)"
- `dbMinus2` - "-2 dB"
- `dbMinus4` - "-4 dB"
- `dbMinus6` - "-6 dB"
- `dbMinus8` - "-8 dB"
- `dbMinus10` - "-10 dB"
- `dbMinus12` - "-12 dB"
- `dbMinus14` - "-14 dB"
- `dbMinus16` - "-16 dB"
- `dbMinus18` - "-18 dB"
- `dbMinus20` - "-20 dB"
- `dbMinus22` - "-22 dB"
- `dbMinus24` - "-24 dB"
- `dbMinus26` - "-26 dB"
- `dbMinus28` - "-28 dB"

**Properties:**
- `displayName`: Returns the human-readable string

#### `EqualizerGain`
**Values:**
Range from `dbMinus40` (-40 dB) to `db0` (0 dB) in 2 dB steps.

**Properties:**
- `displayName`: Returns the gain value as a string
- `valueInDB`: Returns the gain value as an integer

#### `FrequencyBand`
**Values:**
- `hz250` (250 Hz)
- `hz500` (500 Hz)
- `hz1000` (1000 Hz)
- `hz1500` (1500 Hz)
- `hz2000` (2000 Hz)
- `hz2500` (2500 Hz)
- `hz3000` (3000 Hz)
- `hz3500` (3500 Hz)
- `hz4000` (4000 Hz)
- `hz4500` (4500 Hz)
- `hz5000` (5000 Hz)
- `hz5500` (5500 Hz)
- `hz6000` (6000 Hz)
- `hz6500` (6500 Hz)
- `hz7000` (7000 Hz)
- `hz7500` (7500 Hz)

**Properties:**
- `displayName`: Returns the frequency with "Hz" suffix
- `frequency`: Returns the frequency value as an integer

## Usage Notes
1. All enums implement `CaseIterable` protocol, allowing iteration over all cases
2. All enums have raw integer values starting from 0
3. The `displayName` property provides the human-readable string for each enum case
4. The `JinHaoA16DspParameterLabels` class is marked as `final` with a private initializer to prevent instantiation
5. The raw integer values correspond directly to byte values used in communication with the hearing aid hardware
6. Some enums include computed properties for convenient access to numeric values (e.g., `valueInDB`, `frequency`)
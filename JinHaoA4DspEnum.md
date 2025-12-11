# JinHao A4 DSP Parameter Documentation

## Overview
This document describes the DSP parameter constants and enumerations for the JinHao A4 DSP system. The code is written in Swift and provides type-safe access to all DSP parameters.

## Constants

### `JinHaoA4DspParameterLabels`
Contains all display string constants for DSP parameters.

#### Input Multiplexer Values
- `"AI0 (TC)"`
- `"AI1 (Mic1)"`
- `"AI2 (DAI/AUX)"`
- `"AI3 (Mic2)"`
- `"Fixed Hyper Cardioid(Mic1+Mic2)"`
- `"AI1+AI2(Mic1+DAI)"`
- `"AI0+AI3(TC+MIC2)"`

#### Preamp Gain Values
- `"0 dB"`
- `"12 dB"`
- `"15 dB"`
- `"18 dB"`
- `"21 dB"`
- `"24 dB"`
- `"27 dB"`
- `"30 dB"`

#### Matrix Gain Values
Range from `"0 dB"` to `"-47 dB"` in 1 dB steps.

#### Expansion Values
- `"OFF"`
- `"On"`

#### Feedback Canceler Values
- `"OFF"`
- `"On"`

#### Noise Reduction Values
- `"Off"`
- `"Low(-7dB)"`
- `"Medium(-10dB)"`
- `"High(-13dB)"`

#### Low Cut Filter Values
- `"200 Hz"`
- `"500 Hz"`
- `"750 Hz"`
- `"1000 Hz"`
- `"1500 Hz"`
- `"2000 Hz"`
- `"3000 Hz"`

#### High Cut Filter Values
- `"8000(off)"`
- `"4000 Hz"`
- `"3150 Hz"`
- `"2500 Hz"`
- `"2000 Hz"`
- `"1600 Hz"`
- `"1250 Hz"`

#### Compression Ratios Values
- `"1.00 : 1"`
- `"1.14 : 1"`
- `"1.33 : 1"`
- `"1.60 : 1"`
- `"2.00 : 1"`
- `"2.56 : 1"`
- `"4.00 : 1"`

#### Compression Thresholds Values
- `"40 dB"`
- `"45 dB"`
- `"50 dB"`
- `"55 dB"`
- `"60 dB"`
- `"65 dB"`
- `"70 dB"`

#### Maximum Power Output Threshold Values
- `"Max Undistorted Output (MUO)"`
- `"-4 dB"`
- `"-8 dB"`
- `"-12 dB"`
- `"-16 dB"`
- `"-20 dB"`
- `"-24 dB"`

#### Compression Band EQs Values
Range from `"-30 dB"` to `"0 dB"` in 2 dB steps.

## Enumerations

### `JinHaoA4DspEnum`

#### `InputMode`
**Values:**
- `ai0TC` (0) - "AI0 (TC)"
- `ai1Mic1` (1) - "AI1 (Mic1)"
- `ai2DAIAUX` (2) - "AI2 (DAI/AUX)"
- `ai3Mic2` (3) - "AI3 (Mic2)"
- `fixedHyperCardioid` (4) - "Fixed Hyper Cardioid(Mic1+Mic2)"
- `ai1Ai2` (5) - "AI1+AI2(Mic1+DAI)"
- `ai0Ai3` (6) - "AI0+AI3(TC+MIC2)"

#### `PreampGain`
**Values:**
- `db0` (0 dB)
- `db12` (12 dB)
- `db15` (15 dB)
- `db18` (18 dB)
- `db21` (21 dB)
- `db24` (24 dB)
- `db27` (27 dB)
- `db30` (30 dB)

**Properties:**
- `valueInDB`: Returns the gain value as an integer

#### `FeedbackCanceler`
**Values:**
- `off` - "OFF"
- `on` - "On"

#### `Expansion`
**Values:**
- `off` - "OFF"
- `on` - "On"

#### `NoiseReduction`
**Values:**
- `off` (0 dB reduction)
- `low` (-7 dB reduction)
- `medium` (-10 dB reduction)
- `high` (-13 dB reduction)

**Properties:**
- `reductionInDB`: Returns the noise reduction value as an integer

#### `LowCutFilter`
**Values:**
- `hz200` (200 Hz)
- `hz500` (500 Hz)
- `hz750` (750 Hz)
- `hz1000` (1000 Hz)
- `hz1500` (1500 Hz)
- `hz2000` (2000 Hz)
- `hz3000` (3000 Hz)

**Properties:**
- `frequency`: Returns the cutoff frequency as an integer

#### `HighCutFilter`
**Values:**
- `hz8000` (8000 Hz)
- `hz4000` (4000 Hz)
- `hz3150` (3150 Hz)
- `hz2500` (2500 Hz)
- `hz2000` (2000 Hz)
- `hz1600` (1600 Hz)
- `hz1250` (1250 Hz)

**Properties:**
- `frequency`: Returns the cutoff frequency as an integer

#### `CompressionRatio`
**Values:**
- `ratio1_0` (1.00:1)
- `ratio1_14` (1.14:1)
- `ratio1_33` (1.33:1)
- `ratio1_60` (1.60:1)
- `ratio2_0` (2.00:1)
- `ratio2_56` (2.56:1)
- `ratio4_0` (4.00:1)

**Properties:**
- `ratio`: Returns the compression ratio as a Double

#### `CompressionThreshold`
**Values:**
- `db40` (40 dB)
- `db45` (45 dB)
- `db50` (50 dB)
- `db55` (55 dB)
- `db60` (60 dB)
- `db65` (65 dB)
- `db70` (70 dB)

**Properties:**
- `thresholdInDB`: Returns the threshold value as an integer

#### `MaximumPowerOutput`
**Values:**
- `muo` - "Max Undistorted Output (MUO)"
- `dbMinus4` (-4 dB)
- `dbMinus8` (-8 dB)
- `dbMinus12` (-12 dB)
- `dbMinus16` (-16 dB)
- `dbMinus20` (-20 dB)
- `dbMinus24` (-24 dB)

#### `EqualizerGain`
**Values:**
- Range from `dbMinus30` (-30 dB) to `db0` (0 dB) in 2 dB steps

**Properties:**
- `valueInDB`: Returns the gain value as an integer (from -30 to 0 in steps of 2)

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
- `hz5000` (5000 Hz)
- `hz6000` (6000 Hz)
- `hz7000` (7000 Hz)

**Properties:**
- `frequency`: Returns the frequency value as an integer
- `displayName`: Returns the frequency with "Hz" suffix

## Usage Notes
1. All enums implement `CaseIterable` protocol, allowing iteration over all cases
2. All enums have raw integer values starting from 0
3. The `displayName` property provides the human-readable string for each enum case
4. The classes are marked as `final` to prevent inheritance
5. Initializers are private to prevent instantiation
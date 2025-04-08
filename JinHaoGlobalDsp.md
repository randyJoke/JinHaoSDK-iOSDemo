# JinHaoGlobalDsp Protocol

The `JinHaoGlobalDsp` protocol defines the required properties and methods for managing global DSP (Digital Signal Processing) configurations used by the JinHaoAccessory. It includes a property to get the number of programs and methods to convert between `Data` and the global DSP configuration.

## Properties

| Property           | Type        | Description                                                       |
|--------------------|-------------|-------------------------------------------------------------------|
| `numberOfPrograms` | `Int`       | The total number of programs available in the DSP configuration. |

## Initializer

| Method        | Parameters        | Description                                                                 |
|---------------|-------------------|-----------------------------------------------------------------------------|
| `init(data:)` | `data: Data`      | Initializes a `JinHaoGlobalDsp` object using the provided `Data` object. The data is parsed to populate the `numberOfPrograms` property. |

## Methods

| Method     | Return Type | Description                                                                 |
|------------|-------------|-----------------------------------------------------------------------------|
| `toData()` | `Data`      | Converts the current global DSP configuration into a `Data` object that can be transmitted or saved. |

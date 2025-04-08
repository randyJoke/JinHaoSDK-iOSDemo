# Accessory API Documentation

## Overview

The `Accessory` class represents a Bluetooth accessory, providing functionality to connect, disconnect, and manage Bluetooth services and characteristics. It also provides delegate methods to notify about updates in the accessory's state, services, and connection status.

---

## `Accessory` Class

### Properties

| Property                         | Type                     | Description                                                                 |
| --------------------------------- | ------------------------ | --------------------------------------------------------------------------- |
| `name`                            | `String`                 | The name of the accessory.                                                   |
| `localName`                       | `String?`                | The local name of the accessory, if available.                              |
| `deviceId`                        | `String`                 | The unique identifier of the accessory, derived from its `CBPeripheral` UUID.|
| `mfgData`                         | `Data`                   | Manufacturer data associated with the accessory.                            |
| `state`                           | `AccessoryState`         | The current connection state of the accessory.                              |
| `alphaDelegate`                   | `CBPeripheralDelegate?`  | A delegate for handling low-level `CBPeripheral` delegate methods.          |
| `peripheral`                      | `CBPeripheral`           | The underlying `CBPeripheral` object representing the Bluetooth device.     |

---

### Methods

#### `init(peripheral:mfgData:manager:)`
- **Parameters:**
  - `peripheral: CBPeripheral`: The `CBPeripheral` instance representing the Bluetooth device.
  - `mfgData: Data`: The manufacturer data associated with the accessory.
  - `manager: AccessoryManager`: The manager responsible for handling the accessory.
- **Return Type**: `Accessory`
- **Description**: Initializes an `Accessory` object with a peripheral, manufacturer data, and manager.

#### `setDelegate(delegate:)`
- **Parameters:**
  - `delegate: AccessoryDelegate?`: The delegate object that will receive updates about the accessory.
- **Return Type**: `Void`
- **Description**: Sets the delegate for the accessory. This delegate will be notified of state updates, service discoveries, connection events, etc.

#### `connect(with delegate:duration:tag:)`
- **Parameters:**
  - `delegate: AccessoryDelegate`: The delegate that will handle connection-related events.
  - `duration: TimeInterval`: The time duration to wait for a connection attempt before considering it a failure.
  - `tag: String?`: An optional tag to associate with the connection attempt.
- **Return Type**: `Void`
- **Description**: Attempts to connect to the accessory. If the connection is not established within the specified duration, a failure event will be triggered.

#### `connect(with delegate:tag:)`
- **Parameters:**
  - `delegate: AccessoryDelegate`: The delegate that will handle connection-related events.
  - `tag: String?`: An optional tag to associate with the connection attempt.
- **Return Type**: `Bool`
- **Description**: Attempts to connect to the accessory. Returns `true` if the connection attempt is initiated successfully, otherwise `false`.

#### `disconnect()`
- **Parameters**: None
- **Return Type**: `Bool`
- **Description**: Disconnects from the currently connected accessory. Returns `true` if the disconnection is initiated successfully, otherwise `false`.

#### `updateValueForNumberOfPrograms(_:)`
- **Parameters:**
  - `numberOfPrograms: Int`: The number of programs to update.
- **Return Type**: `Void`
- **Description**: Updates the number of programs available on the accessory. This method should be overridden in subclasses.

---

### Delegate Methods

#### `AccessoryDelegate`

The `AccessoryDelegate` protocol provides methods that notify the delegate of updates to the accessory’s state and services.

| Method Name                          | Parameters                                   | Description                                                                  |
| ------------------------------------- | -------------------------------------------- | ---------------------------------------------------------------------------- |
| `device(_:didUpdate:)`                | `device: Accessory, state: AccessoryState`   | Called when the accessory's connection state changes.                        |
| `device(_:didDiscoverServices:)`      | `device: Accessory, didDiscoverServices: [AccessoryService]` | Called when services are discovered on the accessory. |
| `device(_:didConnect:)`               | `device: Accessory, error: Error?`           | Called when the accessory has successfully connected.                         |
| `device(_:didDisconnect:)`            | `device: Accessory, error: Error?`           | Called when the accessory has been disconnected.                             |
| `device(_:didFailToConnect:)`         | `device: Accessory, error: Error?`           | Called when the connection attempt fails.                                    |

---

## Usage Example

```swift
// Initialize an accessory object with a CBPeripheral and manufacturer data
let accessory = Accessory(peripheral: cbPeripheral, mfgData: manufacturerData, manager: accessoryManager)

// Set the delegate
accessory.setDelegate(delegate: self)

// Attempt to connect to the accessory with a timeout duration
accessory.connect(with: self, duration: 10.0, tag: "AccessoryTag")

// Disconnect from the accessory
accessory.disconnect()














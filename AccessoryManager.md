# AccessoryManager API Documentation

## Overview

The `AccessoryManager` class is responsible for managing Bluetooth devices, including scanning for peripherals. It communicates with the delegate methods to notify the status of scanning and available accessories.

---

## `AccessoryManager` Class

### Properties

| Property                          | Type                    | Description                                                                 |
| ---------------------------------- | ----------------------- | --------------------------------------------------------------------------- |
| `hasDiscoveredAccessories`         | `Bool`                  | Returns `true` if accessories have been discovered, otherwise `false`.     |
| `accessories`                      | `[Accessory]`           | Returns an array of `Accessory` objects that have been discovered during the scanning process. |
| `isScanning`                       | `Bool`                  | Indicates whether the manager is currently scanning for peripherals. If `true`, scanning is ongoing. If `false`, no scanning is in progress. |
| `isAvailable`                      | `Bool`                  | Indicates whether Bluetooth is available. If `true`, Bluetooth is available. If `false`, Bluetooth is off or not accessible. |
| `statusDelegate`                   | `AccessoryManagerStatusDelegate?` | Delegate that receives updates on the Bluetooth manager's availability (powered on/off). |
| `scanningDelegate`                 | `AccessoryManagerScanningDelegate?` | Delegate that receives updates during the scanning process (e.g., new accessory discovery, scanning status). |
| `accessorySelectorDelegate`        | `AccessorySelectorDelegate` | Delegate that handles the selection of discovered peripherals. |

---

### Methods

| Method Name                        | Parameters              | Return Type             | Description                                                                 |
| ----------------------------------- | ----------------------- | ----------------------- | --------------------------------------------------------------------------- |
| `init()`                            | None                    | `AccessoryManager`       | Initializes an instance of `AccessoryManager` to be used for managing Bluetooth devices. |
| `blueState()`                       | None                    | `CBManagerState`        | Returns the Bluetooth state of the central manager. This provides the current status of Bluetooth (whether it is powered off, on, or in an unknown state). |
| `openBluetooth()`                   | None                    | `Void`                  | Attempts to turn on Bluetooth if it is powered off. If Bluetooth is already on, this method does nothing. |
| `startScan()`                       | None                    | `Void`                  | Begins scanning for Bluetooth peripherals indefinitely. The scan continues until manually stopped by calling `stopScan()`. |
| `startScan(duration:)`              | `duration`: `TimeInterval` | `Void`                  | Starts scanning for Bluetooth peripherals for a specific duration (`duration`). After this duration elapses, scanning stops automatically. |
| `stopScan()`                        | None                    | `Void`                  | Stops the ongoing scan for Bluetooth peripherals. |
| `clearAccessories()`                | None                    | `Void`                  | Clears all previously discovered accessories from the list, essentially resetting the discovered devices. |
| `connectToPeripheral(_:)`           | `peripheral`: `CBPeripheral` | `Void`                  | Attempts to establish a connection to the specified peripheral. The `CBPeripheral` object is used to identify the device and initiate the connection. |
| `disconnectFromPerpheral(_:)`      | `peripheral`: `CBPeripheral` | `Void`                  | Disconnects from the specified peripheral, terminating the Bluetooth connection. |

---

## Delegate Protocols

### `AccessoryManagerStatusDelegate`

| Method Name                        | Parameters              | Return Type             | Description                                                                 |
| ----------------------------------- | ----------------------- | ----------------------- | --------------------------------------------------------------------------- |
| `accessoryManager(_:isAvailable:)`  | `manager`: `AccessoryManager?`, `isAvailable`: `Bool` | `Void` | This method is called when the availability of Bluetooth changes. It notifies the delegate when Bluetooth is powered on or off. |

### `AccessoryManagerScanningDelegate`

| Method Name                        | Parameters              | Return Type             | Description                                                                 |
| ----------------------------------- | ----------------------- | ----------------------- | --------------------------------------------------------------------------- |
| `accessoryManager(_:isScanning:)`   | `manager`: `AccessoryManager?`, `isScanning`: `Bool` | `Void` | This method is called whenever the scanning status changes, notifying the delegate whether the scanning process has started or stopped. |
| `accessoryManager(_:didDiscover:)`  | `manager`: `AccessoryManager?`, `device`: `Accessory?`, `rssi`: `NSNumber?` | `Void` | This method is called when a new accessory is discovered during the scan. The device and its signal strength are passed to the delegate. |
| `accessoryManager(_:didUpdate:)`    | `manager`: `AccessoryManager?`, `device`: `Accessory?`, `rssi`: `NSNumber?` | `Void` | This method is called when the RSSI value of an already discovered accessory is updated. This allows the delegate to track the strength of the connection over time. |

---

## Usage Example

```swift
let accessoryManager = AccessoryManager()

// Set delegate for status and scanning updates
accessoryManager.statusDelegate = self
accessoryManager.scanningDelegate = self

// Start scanning for peripherals
accessoryManager.startScan(duration: 30.0)

// Stop scanning after a while
DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
    accessoryManager.stopScan()
}

// Open Bluetooth if it's not powered on
accessoryManager.openBluetooth()

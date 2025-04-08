# AccessoryManager API Documentation

## Overview

The `AccessoryManager` class is responsible for managing Bluetooth devices, including scanning for peripherals， It communicates with the delegate methods to notify the status of scanning and available accessories.

---

## `AccessoryManager` Class

### Properties

| Property                          | Type                    | Description                                                                 |
| ---------------------------------- | ----------------------- | --------------------------------------------------------------------------- |
| `hasDiscoveredAccessories`         | `Bool`                  | Returns `true` if no accessories have been discovered, otherwise `false`.  |
| `accessories`                      | `[Accessory]`           | Returns an array of discovered accessories.                                |
| `isScanning`                       | `Bool`                  | Indicates whether the manager is currently scanning for peripherals.       |
| `isAvailable`                      | `Bool`                  | Indicates whether the Bluetooth manager is available (powered on).        |
| `statusDelegate`                   | `AccessoryManagerStatusDelegate?` | Delegate for status updates (e.g., Bluetooth availability). |
| `scanningDelegate`                 | `AccessoryManagerScanningDelegate?` | Delegate for scanning updates (e.g., discovery of accessories). |
| `accessorySelectorDelegate`        | `AccessorySelectorDelegate` | Delegate for selecting accessories from discovered peripherals. |

---

### Methods

| Method Name                        | Parameters              | Return Type             | Description                                                                 |
| ----------------------------------- | ----------------------- | ----------------------- | --------------------------------------------------------------------------- |
| `init()`                            | None                    | `AccessoryManager`       | Initializes the `AccessoryManager` object and prepares it for use.          |
| `blueState()`                       | None                    | `CBManagerState`        | Returns the Bluetooth state of the central manager.                         |
| `openBluetooth()`                   | None                    | `Void`                  | Opens Bluetooth if it is powered off, otherwise does nothing.               |
| `startScan()`                       | None                    | `Void`                  | Starts scanning for Bluetooth peripherals indefinitely.                     |
| `startScan(duration:)`              | `duration: TimeInterval`| `Void`                  | Starts scanning for Bluetooth peripherals for a specified duration.        |
| `stopScan()`                        | None                    | `Void`                  | Stops scanning for Bluetooth peripherals.                                   |
| `clearAccessories()`                | None                    | `Void`                  | Clears all discovered accessories from the list.                            |
| `connectToPeripheral(_:)`           | `peripheral: CBPeripheral` | `Void`                  | Connects to a specified peripheral (used by an `Accessory`).               |
| `disconnectFromPerpheral(_:)`      | `peripheral: CBPeripheral` | `Void`                  | Disconnects from a specified peripheral (used by an `Accessory`).          |

---

## Delegate Protocols

### `AccessoryManagerStatusDelegate`

| Method Name                        | Parameters              | Return Type             | Description                                                                 |
| ----------------------------------- | ----------------------- | ----------------------- | --------------------------------------------------------------------------- |
| `accessoryManager(_:isAvailable:)`  | `manager: AccessoryManager?`, `isAvailable: Bool` | `Void` | Called when the Bluetooth manager's availability changes. |

### `AccessoryManagerScanningDelegate`

| Method Name                        | Parameters              | Return Type             | Description                                                                 |
| ----------------------------------- | ----------------------- | ----------------------- | --------------------------------------------------------------------------- |
| `accessoryManager(_:isScanning:)`   | `manager: AccessoryManager?`, `isScanning: Bool` | `Void` | Called when scanning starts or stops.                                       |
| `accessoryManager(_:didDiscover:)`  | `manager: AccessoryManager?`, `device: Accessory?`, `rssi: NSNumber?` | `Void` | Called when a new accessory is discovered.                                  |
| `accessoryManager(_:didUpdate:)`    | `manager: AccessoryManager?`, `device: Accessory?`, `rssi: NSNumber?` | `Void` | Called when an already discovered accessory is updated.                     |

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

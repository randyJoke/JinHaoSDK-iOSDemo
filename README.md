# JinHaoSDK API Documentation

## Table of Contents
- [JinHaoSDK API Documentation](#jinhaosdk-api-documentation)
	- [Table of Contents](#table-of-contents)
	- [Introduction](#introduction)
	- [Requirements](#requirements)
	- [Installation](#installation)
		- [1. Add the `JinHaoSDK.xcframework` to Your Project](#1-add-the-jinhaosdkxcframework-to-your-project)
		- [2. Configure Framework Search Paths](#2-configure-framework-search-paths)
		- [3. Link the Framework](#3-link-the-framework)
		- [4. Embed \& Sign the Framework](#4-embed--sign-the-framework)
	- [Usage](#usage)
		- [Initialization](#initialization)
		- [Scan](#scan)
		- [Connect](#connect)
		- [Sending Commands to Hearing Aid](#sending-commands-to-hearing-aid)



---

## Introduction
The JinHaoSDK provides a set of APIs to communicate with Bluetooth Low Energy (BLE) hearing aids. The SDK allows you to connect to hearing aids, adjust volume, switch hearing modes, and manage sound settings like equalizer (EQ) and noise cancellation.

This guide will walk you through the steps to integrate the SDK into your iOS app and demonstrate how to use the SDK’s key functionalities.

## Requirements
- iOS 11.0+


## Installation

### 1. Add the `JinHaoSDK.xcframework` to Your Project
- Drag the `JinHaoSDK.xcframework` file into your Xcode project.
- In the "Add to Project" dialog, select "Copy items if needed" and add it to the appropriate targets.

### 2. Configure Framework Search Paths
- Go to **Build Settings** > **Framework Search Paths**.
- Add the path where the `JinHaoSDK.xcframework` is located, e.g., `$(PROJECT_DIR)/Frameworks`.

### 3. Link the Framework
- In **Build Phases** > **Link Binary With Libraries**, click **+** and select your `.xcframework`.

### 4. Embed & Sign the Framework
- In the **General** tab, under **Frameworks, Libraries, and Embedded Content**, find your `.xcframework`.
- Set "Embed" to **Embed & Sign**.


## Usage


### Initialization
First, we need to create an instance of [AccessoryManager](AccessoryManager.md#accessorymanager-class) and assign the appropriate delegates. This will enable the app to manage Bluetooth accessory scanning and track its status.

```swift
// Create an instance of AccessoryManager
let deviceManager = AccessoryManager()

// Set the scanning delegate to handle device scanning events
deviceManager.scanningDelegate = self

// Set the status delegate to monitor the Bluetooth status
deviceManager.statusDelegate = self
```
 [AccessoryManagerStatusDelegate](AccessoryManager.md#accessorymanagerstatusdelegate) will be called when the Bluetooth status changes
 ```
func accessoryManager(_ manager: AccessoryManager?, isAvailable: Bool) {
	if isAvailable {
		// Bluetooth is available and enabled
		print("Bluetooth is available.")
		// Proceed with scanning or other Bluetooth-related tasks
	} else {
		// Bluetooth is not available or is turned off
		print("Bluetooth is not available.")
		// Handle the scenario where Bluetooth is unavailable
	}
}
```
### Scan
The `startScan` or `startScan(duration:)` method in the [AccessoryManager](AccessoryManager.md#methods) class is used to initiate the scanning process for nearby Bluetooth devices. Once called, it begins searching for Bluetooth accessories within range. This method works in conjunction with the `AccessoryManagerScanningDelegate` methods to handle the scanning and discovery of devices.

```
deviceManager.startScan()
```
[AccessoryManagerScanningDelegate](AccessoryManager.md#accessorymanagerscanningdelegate) will be called when scanning

```
/// This method is called when the scanning process starts or stops.
func accessoryManager(_ manager: AccessoryManager?, isScanning: Bool) {
     if isScanning {
        print("Scanning started...")
    } else {
        print("Scanning stopped.")
    }
}

/// This method is called when a new Bluetooth device is discovered during the scan.
func accessoryManager(_ manager: AccessoryManager?, didDiscover device: Accessory?, rssi: NSNumber?) {
    guard let device = device as? JinHaoAccessory else { return }
    print("Discovered device: \(device.deviceName), RSSI: \(rssi ?? 0)")
    // Handle device discovery (e.g., update UI or store device)
}

/// This method is called when the information of an already discovered device is updated during scanning (e.g., when the RSSI value changes).
func accessoryManager(_ manager: AccessoryManager?, didUpdate device: Accessory?, rssi: NSNumber?) {
     guard let device = device as? JinHaoAccessory else { return }
    if let updatedRSSI = rssi {
        print("Updated RSSI for device \(device.deviceName): \(updatedRSSI)")
        // Handle updated device info (e.g., update UI with new RSSI value)
    }
}
```

### Connect
- You can use the [JinHaoAccessory](JinHaoAccessory.md#jinhaoaccessory-class) object to call the connect(with: tag:) method to establish the connection.
```
if accessory.state == AccessoryState.disconnected {
	let _ = accessory.connect(with: self, tag: "")
	//disconnect -- accessory.disconnect()
}
```
- [AccessoryDelegate](Accessory.md#accessorydelegate) will be called when the Accessory device's connection state changes or when an error occurs during connection attempts.
```
// Handle connection state update
func device(_ device: Accessory, didUpdate state: AccessoryState) {
	switch state {
	case .connected:
		print("Hearing aid connected.")
		// Update UI to reflect connection state
		
	case .disconnected:
		print("Hearing aid disconnected.")
		// Update UI or handle disconnection
		
	default:
		break
	}
}

// Handle services discovered on the device
func device(_ device: Accessory, didDiscoverServices services: [AccessoryService]) {
	print("Discovered services: \(services)")
	//you can safely execute commands by calling the `request(request: JinHaoRequest, complete: ((JinHaoResult) -> Void)?)` method
}

// Handle successful connection
func device(_ device: Accessory, didConnect error: Error?) {
	if let error = error {
		print("Failed to connect with error: \(error.localizedDescription)")
	} else {
		print("Successfully connected to the hearing aid.")
		// Update UI to indicate successful connection
	}
}

// Handle disconnection
func device(_ device: Accessory, didDisconnect error: Error?) {
	if let error = error {
		print("Error during disconnection: \(error.localizedDescription)")
	} else {
		print("Successfully disconnected from the hearing aid.")
		// Handle post-disconnection actions
	}
}

// Handle failed connection
func device(_ device: Accessory, didFailToConnect error: Error?) {
	if let error = error {
		print("Failed to connect to the hearing aid: \(error.localizedDescription)")
		// Show error message to user
	}
}
```
- you can also call `accessory.disconnect()` to disconnect from the hearing aid. 

### Sending Commands to Hearing Aid
- 1. The command execution must be triggered after the `device(_ device: Accessory, didDiscoverServices services: [AccessoryService])` method is called. This is because the services of the device need to be discovered first before any command can be sent to the device.

- 2. To send a command to the hearing aid (e.g., to adjust volume, change program, etc.), you can use the `request(request: JinHaoRequest, complete: ((JinHaoResult) -> Void)?)` method. This method allows you to issue various requests to the device and receive the result via a completion handler.
  
- 3. The [JinHaoRequest](JinHaoRequest.md#jinhaorequest-enum) enum contains the supported commands for the JinHaoAccessory, such as volume adjustments, mode changes, etc. 

- 4. The [JinHaoResponse](JinHaoResult.md#jinhaoresponse-enum)  provides feedback on whether the command was successful or if there was an error.

```
func device(_ device: Accessory, didDiscoverServices services: [AccessoryService]) {
	guard let device = device as? JinHaoAccessory else { return }
	//get number of program
	device.request(request: .readNumberOfPrograms(chip: device.hearChip), complete: { r in
		if case .success = r, let number = device.numberOfProgram {
			//program
			print("number of programs is \(number), so device.program is 0 ~ \(number - 1)")
		}
	})

	//obtain the scene mode corresponding to each program, for example, the scene mode of program 0 is scenesOfProgram[0]
	device.request(request: .readScenesOfProgram, complete: { r in
		if case .success = r {
			print("mode of programs is \(device.profile.programs)")
			for (index, value) in device.profile.programs.enumerated() {
				print("program is: \(index), mode is: \(value)")
			}
		} else {
			//if error, this is default
			print("mode of programs is \(device.profile.programs)")
			for (index, value) in device.profile.programs.enumerated() {
				print("program is: \(index), scene is: \(value)")
			}
		}
	})

	//Read current programe and volume
	device.request(request: .readProgramVolume, complete: { [weak self] in
		if let program = device.program {
			print("current program is \(program), scene is \(device.scenesOfProgram[program])")
			//Read current dsp
			device.request(request: .readDsp(program: 0), complete: { [weak self] in
				if let dsp = device.dsp {
					print("current program is \(program), dsp is \(dsp)")
				}
			})
		}
    })
}



//read volume

//adjust volume
self.accessory.request(request: .controlVolume(volume: 1, program: 0),
						complete: { [weak self] result in
	switch result {
	case let .success(data: response):
		print("success \(response)")
	case let .error(error)
		print("error \(error)")

	}
})
```
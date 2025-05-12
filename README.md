# JinHaoSDK 
The JinHaoSDK provides a set of APIs to communicate with Bluetooth Low Energy (BLE) hearing aids. The SDK allows you to connect to hearing aids, adjust volume, switch hearing modes, and manage sound settings like equalizer (EQ) and noise cancellation.
This guide will walk you through the steps to integrate the SDK into your iOS app and demonstrate how to use the SDK’s key functionalities.
## Index
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
        - [Reading Hearing Aid Information](#reading-hearing-aid-information)
        - [Adjust Volume](#adjust-volume)
        - [Switching Programs](#switching-programs)
        - [Frequence](#frequence)
        - [EQ](#eq)
        - [MPO](#mpo)
        - [Noise](#noise)
        - [Direction](#change-direction)
        - [Compression Threshold](#compression-threshold)
        - [Compression Ratio](#compression-ratio)
        - [Attack Time](#attack-time)
        - [Release Time](#release-time)
        - [Data Log](#data-log)
        - [Read Battery](#read-battery)
        - [Notify](#notify)
- [API Document](#api-document)

## Requirements
- **iOS 11.0+**
- **Swift 5 or later recommended**

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
```
import JinHaoSDK
```

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
  
- 3. The [JinHaoRequest](JinHaoRequest.md#jinhaorequest-enum) enum contains the supported commands for the JinHaoAccessory, such as volume adjustments, programs changes, etc. 

- 4. The [JinHaoResponse](JinHaoResult.md#jinhaoresponse-enum)  provides feedback on whether the command was successful or if there was an error.
  
- 5. The method `func didUpdateValue(_ accessory: JinHaoAccessory, request: JinHaoRequest)`([JinHaoAccessoryDelegate](JinHaoAccessory.md#jinhaoaccessorydelegate)) will be called when send command to Hearing Aid

#### Reading Hearing Aid Information
Before adjusting the volume, switching the program, or executing any other commands, we must first retrieve the relevant information from the hearing aid.

We can send a single command using `device.request(request: , complete:)` to retrieve information. For more details, Please refer to the related [commands](JinHaoRequest.md#read-requests) for reading data.

- **get number of program**
```
//you can get number of program
device.readNumberOfProgram(complete: { r in
    if case .success = r, let number = device.numberOfProgram {
        //program
        print("number of programs is \(number), so device.program is 0 ~ \(number)")
    }
})
```

- **obtain the scene mode corresponding to each program, for example, the scene mode of program 0 is scenesOfProgram[0]**
```
device.readScenesOfProgram(complete: { r in
    if case .success = r {
        print("scene mode of programs is \(device.profile.programs)")
        for (index, value) in device.profile.programs.enumerated() {
            print("program is: \(index), scene mode is: \(value)")
        }
    } else {
        //if error, this is default
        print("scene mode of programs is \(device.profile.programs)")
        for (index, value) in device.profile.programs.enumerated() {
            print("program is: \(index), scene mode is: \(value)")
        }
    }
})
```

- **Read current programe、volume、dsp**
```
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
```

- **Send a request to the hearing aid to fetch the SKU code.**
```
device.request(request: .readProfile(type: JinHaoProfileType.productSku), complete: { [weak self] r in
    if case .success = r {
        self.volumeSlider.minimumValue = Float(device.profile.minVolume)
        self.volumeSlider.maximumValue = Float(device.profile.maxVolume)
        print("sku code is \(device.profile.skuCode), minVolume is \(device.profile.minVolume), maxVolume is \(device.profile.maxVolume)")
    }
})
```

#### Adjust Volume 
The volume adjustment range of the hearing aid is either 0–10 or 0–5, depending on the `profile` property of `JinHaoAccessory`. You can refer to [JinHaoRequest.controlVolume](JinHaoRequest.md#control-requests).
- Before adjusting the volume, we must first call the `readProfile(type: JinHaoProfileType.productSku)` to determine the maximum and minimum volume values.
```
device.request(request: .readProfile(type: JinHaoProfileType.productSku), complete: {  [weak self] r in
    guard let `self` = self else { return }
    if case .success = r {
        self.volumeSlider.minimumValue = Float(device.profile.minVolume)
        self.volumeSlider.maximumValue = Float(device.profile.maxVolume)
        print("sku code is \(device.profile.skuCode), minVolume is \(device.profile.minVolume), maxVolume is \(device.profile.maxVolume)")
    }
})
```
- Sets the device's volume level.
```
self.accessory.request(request: .controlVolume(volume: 1, program: 0), complete: { [weak self] result in
    switch result {
    case let .success(data: response):
        print("success \(response)")
    case let .error(error)
        print("error \(error)")

    }
})
```

#### Switching Programs
After switching programs, we need to re-fetch the DSP (Digital Signal Processing) data to ensure the hearing aid's data is updated in a timely manner.
```
self.accessory.request(request: .controlProgram(program: sender.selectedSegmentIndex), complete: { [weak self] _ in
    if let program = self?.program {
        self?.accessory.request(request: .readDsp(program: program)) { [weak self] _ in

        }
    }
})
```

#### Frequence
When modifying MPO, noise, direction, and so on, we should first obtain the frequency modification range supported by the hearing aid.
```
 device.request(request: .readDsp(program: program)) { [weak self] r2 in
    guard let `self` = self, let dsp = device.dsp, case .success = r2  else { return }
    let frequences = device.dsp?.frequences
    print("frequences is \(frequences)")
}
```
- **JinHaoA4Dsp**
    if dsp is JinHaoA4Dsp, frequences = [250, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 5000, 6000, 7000]
- **JinHaoA16Dsp**
    if dsp is JinHaoA16Dsp, frequences = [250, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500]

#### EQ
Before modifying the EQ, we must first obtain the JinHaoDsp for the current program.
```
 device.request(request: .readDsp(program: program)) { [weak self] r2 in
    guard let `self` = self, let dsp = device.dsp, case .success = r2  else { return }
    let frequences = dsp.frequences
    let eq =  dsp.getEq(at: frequences[0])
}
```
then we can refer to the [JinHaoDsp](./JinHaoDsp.md) API to modify the EQ. for example:
```
if var dsp = self.accessory.dsp, let p = self.accessory.program {
    let step: Float = 1
    let roundedValue = round(sender.value / step) * step
    sender.value = roundedValue
    dsp.setEq(eq: Int(roundedValue), at: 250)
    self.showSpinnerView(in: self)
    self.accessory.request(request: .writeDsp(dsp: dsp, program: p, withResponse: true),
                            complete: { [weak self] _ in
        self?.hideSpinnerView()
    })
}
```

#### MPO

Before modifying the MPO, we must first obtain the JinHaoDsp for the current program; if it has already been obtained, there's no need to call it again.
```
device.request(request: .readDsp(program: program)) { [weak self] r2 in
    guard let `self` = self, let dsp = device.dsp, case .success = r2  else { return }
    if let dsp = accessory.dsp as? JinHaoA4Dsp {
        print("A4 mpo is \(dsp.mpo) in all frequence")
    }
    if let dsp = accessory.dsp as? JinHaoA16Dsp {
        print("A16 mpo level is \(dsp.getMpoLevel(at: 250)) in 250 Hz, value is \(dsp.getMpoValue(level: dsp.getMpoLevel(at: 250) ?? 0))")
    }
}
```
There are two cases when modifying the MPO, because the JinHaoDsp may be either [JinHaoA4Dsp](./JinHaoA4Dsp.md) or [JinHaoA16Dsp](./JinHaoA16Dsp.md). Below, we will set the MPO based on each case.

- **JinHaoA4Dsp**
```
if var dsp = self.accessory.dsp as? JinHaoA4Dsp, let p = self.accessory.program {
    switch sender.selectedSegmentIndex {
    case 0:
        dsp.mpo = .off
    case 1:
        dsp.mpo = .low
    case 2:
        dsp.mpo = .medium
    case 3:
        dsp.mpo = .high
        
    default: break
    }
    self.showSpinnerView(in: self)
    self.accessory.request(request: .writeDsp(dsp: dsp, program: p, withResponse: true),
                            complete: { [weak self] _ in
        self?.hideSpinnerView()
    })
}
```
- **JinHaoA16Dsp**
```
if var dsp = accessory.dsp as? JinHaoA16Dsp, let program = accessory.program {
    dsp.setMpoLevel(mpoLevel: 0, at: 250)
    accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
        
    }
}
```

#### Noise
Before modifying the Noise, we must first obtain the JinHaoDsp for the current program; if it has already been obtained, there's no need to call it again.
```
device.request(request: .readDsp(program: program)) { [weak self] r2 in
    guard let `self` = self, let dsp = device.dsp, case .success = r2  else { return }

}
```
then we can refer to the [JinHaoDsp](./JinHaoDsp.md) API to modify the [Noise](./JinHaoDsp.md#noise). for example:
```
if var dsp = self.accessory.dsp, let p = self.accessory.program {
    switch sender.selectedSegmentIndex {
    case 0:
        dsp.noise = .off
    case 1:
        dsp.noise = .weak
    case 2:
        dsp.noise = .medium
    case 3:
        dsp.noise = .strong
        
    default: break
    }
    self.showSpinnerView(in: self)
    self.accessory.request(request: .writeDsp(dsp: dsp, program: p, withResponse: true),
                            complete: { [weak self] _ in
        self?.hideSpinnerView()
    })
}
```

#### Direction
Before modifying the Direction, we must first obtain the JinHaoDsp for the current program; if it has already been obtained, there's no need to call it again.
```
device.request(request: .readDsp(program: program)) { [weak self] r2 in
    guard let `self` = self, let dsp = device.dsp, case .success = r2  else { return }

}
```
then we can refer to the [JinHaoDsp](./JinHaoDsp.md) API to modify the [Direction](./JinHaoDsp.md#direction). for example:
```
if var dsp = self.accessory.dsp, let p = self.accessory.program {
    switch sender.selectedSegmentIndex {
    case 0:
        dsp.direction = .normal
    case 1:
        dsp.direction = .tv
    case 2:
        dsp.direction = .meeting
    case 3:
        dsp.direction = .face
        
    default: break
    }
    self.showSpinnerView(in: self)
    self.accessory.request(request: .writeDsp(dsp: dsp, program: p, withResponse: true),
                            complete: { [weak self] _ in
        self?.hideSpinnerView()
    })
}
```

#### Compression Threshold
The compression threshold applies only to [JinHaoA16Dsp](./JinHaoA16Dsp.md). Before modifying the Compression Threshold, we must first obtain the JinHaoDsp for the current program; if it has already been obtained, there's no need to call it again. 
```
device.request(request: .readDsp(program: program)) { [weak self] r2 in
    guard let `self` = self, let dsp = device.dsp, case .success = r2  else { return }
    if let dsp = accessory.dsp as? JinHaoA16Dsp {
        print("A16 compress threshold level is \(dsp.getCompressThresholdLevel(at: 250)) in 250 Hz, value is \(dsp.getCompressThresholdValue(level: dsp.getCompressThresholdLevel(at: 250) ?? 0))")
    }
}
```
then we can refer to the [JinHaoA16Dsp](docs/JinHaoA16Dsp.md) API to modify the [compression threshold](docs/JinHaoA16Dsp.md#compression-threshold). for example:
```
private func changeA16CompressThreshold() {
    if var dsp = accessory.dsp as? JinHaoA16Dsp, let program = accessory.program {
        dsp.setCompressRatioLevel(compressRatioLevel: 0, at: 250)
        accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
            
        }
    }
}
```

#### Compression Ratio
The compression ratio applies only to [JinHaoA16Dsp](./JinHaoA16Dsp.md). Before modifying the compression ratio, we must first obtain the JinHaoDsp for the current program; if it has already been obtained, there's no need to call it again. 
```
device.request(request: .readDsp(program: program)) { [weak self] r2 in
    guard let `self` = self, let dsp = device.dsp, case .success = r2  else { return }
    if let dsp = accessory.dsp as? JinHaoA16Dsp {
        print("A16 compress ratio level is \(dsp.getCompressRatioLevel(at: 250)) in 250 Hz, value is \(dsp.getCompressRatioValue(level: dsp.getCompressRatioLevel(at: 250) ?? 0))")
    }
}
```
then we can refer to the [JinHaoA16Dsp](./JinHaoA16Dsp.md) API to modify the [compression ratio](./JinHaoA16Dsp.md#compression-ratio). for example:
```
private func changeA16CompressRatio() {
    if var dsp = accessory.dsp as? JinHaoA16Dsp, let program = accessory.program {
        dsp.setCompressRatioLevel(compressRatioLevel: 0, at: 250)
        accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
            
        }
    }
}
```

#### Attack Time
The attack time applies only to [JinHaoA16Dsp](./JinHaoA16Dsp.md). Before modifying the attack time, we must first obtain the JinHaoDsp for the current program; if it has already been obtained, there's no need to call it again. 
```
device.request(request: .readDsp(program: program)) { [weak self] r2 in
    guard let `self` = self, let dsp = device.dsp, case .success = r2  else { return }
    if let dsp = accessory.dsp as? JinHaoA16Dsp {
        print("A16 attack time level is \(dsp.attackTimeLevel), value is \(dsp.getAttackTimeValue(level: dsp.attackTimeLevel))")

    }
}
```
then we can refer to the [JinHaoA16Dsp](./JinHaoA16Dsp.md) API to modify the [attack time](.docs/JinHaoA16Dsp.md#attack-time). for example:
```
private func changeA16AttackTime() {
    if var dsp = accessory.dsp as? JinHaoA16Dsp, let program = accessory.program {
        dsp.attackTimeLevel = 0
        accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
            
        }
    }
}
```

#### Release Time
The release time applies only to [JinHaoA16Dsp](./JinHaoA16Dsp.md). Before modifying the release time, we must first obtain the JinHaoDsp for the current program; if it has already been obtained, there's no need to call it again. 
```
device.request(request: .readDsp(program: program)) { [weak self] r2 in
    guard let `self` = self, let dsp = device.dsp, case .success = r2  else { return }
    if let dsp = accessory.dsp as? JinHaoA16Dsp {
        print("A16 release time level is \(dsp.releaseTimeLevel), value is \(dsp.getReleaseTimeValue(level: dsp.releaseTimeLevel))")
    }
}
```
then we can refer to the [JinHaoA16Dsp](./JinHaoA16Dsp.md) API to modify the [release time](./JinHaoA16Dsp.md#release-time). for example:
```
private func changeA16ReleaseTime() {
    if var dsp = accessory.dsp as? JinHaoA16Dsp, let program = accessory.program {
        dsp.releaseTimeLevel = 0
        accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
            
        }
    }
}
```

#### Data Log
Reading the DataLog is only applicable to `JinHaoA16Accessory`. for example:
```
if let d = device as? JinHaoA16Accessory {
    print("device is A16 Accessory")
    d.requestSummaryDataLog { dataLog in
        
    }
}
```
For more details, please refer to [JinHaoDataLog](./JinHaoDataLog.md).

#### Read Battery

 Requests the current battery level of the JinHao accessory, triggering the `batteryDidChanged(_ accessory: JinHaoAccessory, bat: Int)` method in the `JinHaoAccessoryDelegate`
 ```
accessory.readBattery()
```
#### Notify
When the battery level changes, the hearing aid's volume or program is switched through the button, or a command is sent to the hearing aid via the request method, the relevant methods in the [JinHaoAccessoryDelegate](JinHaoAccessory.md#jinhaoaccessorydelegate) will be triggered.
```
/// Notifies When we switch programs through the hearing aid's button
func didNotifyProgram(_ accessory: JinHaoSDK.JinHaoAccessory, previous: Int, current: Int) {
    self.programSeg.selectedSegmentIndex = current
}

/// Notifies When we adjust volume through the hearing aid's button
func didNotifyVolume(_ accessory: JinHaoSDK.JinHaoAccessory, previous: Int, current: Int) {
    self.volumeSlider.value = Float(current)
}

/// - bat: 0~100
func batteryDidChanged(_ accessory: JinHaoSDK.JinHaoAccessory, bat: Int) {
    
}

//'device.request(request: JinHaoRequest, complete: ((JinHaoResult)->Void)?)' will trigger this method
func didUpdateValue(_ accessory: JinHaoSDK.JinHaoAccessory, request: JinHaoSDK.JinHaoRequest) {
    if let v = accessory.volume {
        self.volumeSlider.value = Float(v)
    }
    if let p = accessory.program{
        self.programSeg.selectedSegmentIndex = p
    }
    if let dsp = accessory.dsp {
        switch dsp.noise {
        case .off: noiseSeg.selectedSegmentIndex = 0
        case .weak: noiseSeg.selectedSegmentIndex = 1
        case .medium: noiseSeg.selectedSegmentIndex = 2
        case .strong: noiseSeg.selectedSegmentIndex = 3
        default:
            directionSeg.selectedSegmentIndex = UISegmentedControl.noSegment
            break
        }
        
        switch dsp.mpo {
        case .off: mpoSeg.selectedSegmentIndex = 0
        case .low: mpoSeg.selectedSegmentIndex = 1
        case .medium: mpoSeg.selectedSegmentIndex = 2
        case .high: mpoSeg.selectedSegmentIndex = 3
        default:
            directionSeg.selectedSegmentIndex = UISegmentedControl.noSegment
            break
        }
        
        eq250Slider.value = Float(dsp.eq250)
        eq1000Slider.value = Float(dsp.eq1000)
        eq2000Slider.value = Float(dsp.eq2000)
        /// eq2500 ~ eq7000
    }
}

```

## API Document
- [AccessoryManager](AccessoryManager.md)
- [AccessoryManagerStatusDelegate](AccessoryManager.md#accessorymanagerstatusdelegate)
- [AccessoryManagerScanningDelegate](AccessoryManager.md#accessorymanagerscanningdelegate)
- [Accessory](Accessory.md)
- [JinHaoAccessory](JinHaoAccessory.md)
- [JinHaoAccessoryDelegate](JinHaoAccessory.md#jinhaoaccessorydelegate)
- [JinHaoDsp](JinHaoDsp.md)
- [JinHaoA4Dsp](JinHaoA4Dsp.md)
- [JinHaoA16Dsp](JinHaoA16Dsp.md)
- [JinHaoGlobalDsp](JinHaoGlobalDsp.md)
- [JinHaoProfile](JinHaoProfile.md)
- [JinHaoRequest](JinHaoRequest.md)
- [JinHaoResult](JinHaoResult.md)
- [JinHaoChip](Enum.md#jinhaochip-enum)
- [JinHaoProgram](Enum.md#jinhaoprogram-enum)
- [JinHaoBLEChip](Enum.md#jinhaoblechip-enum)
- [JinHaoProfileType](Enum.md#jinhaoprofiletype-enum)
- [JinHaoDataLog](./JinHaoDataLog.md)
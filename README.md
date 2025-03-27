# JinHaoSDK-iOSDemo

## JinHaoAccessory
public class JinHaoAccessory: Accessory {
    
    // Mac address
    public var address: String = ""
    
    // left、right、unassigned
    public var orientation: AccessoryOrientation = .unassigned
    
    // a4、h01、a16
    public var hearChip: JinHaoChip = .unassigned
    
    // u87、tiny600、unassigned
    public var bleChip: JinHaoBLEChip = .unassigned
    
    // 0 ~ 100
    public var bat: Int?
    
    // 0 ~ 3
    public var program: Int?
    
    //You can access the total number of programs in the hearing aid, but no more than four.
    public var numberOfProgram: Int? 
    
    //You can obtain the scene mode corresponding to each program, for example, the scene mode of program 0 is scenesOfProgram[0]
    public var scenesOfProgram: [JinHaoProgram] 
    
    // 0 ~ 10
    public var volume: Int? {
        if let p = program {
            return self.volumeDic[p]
        } else {
            return nil
        }
    }
    
    // key: Program, value: Volume
    public var volumeDic = [Int: Int]()
    
    // key: Program, value: JinHaoDsp
    public var dspDic = [Int: any JinHaoDsp]()
    
    // mpo、noise、direction、eq
    public var dsp: (any JinHaoDsp)? 
     
    // Please do not modify this property, as it is not currently used.
    public var global: JinHaoGlobalDsp?
    
    // Information such as the model, serial number, and software version of the hearing aid.
    public var profile = JinHaoProfile()
    
    // Please do not modify this property, as it is not currently used.
    public var brEdr: Bool = false
    
    // Please do not modify this property, as it is not currently used.
    public var transEnable: Bool = false
    
    // Please do not modify this property, as it is not currently used.
    public var transLevel: Int?
    
    // Please do not modify this property, as it is not currently used.
    public var hearingSupported: Bool = false
}

## Scan
```
import JinHaoSDK

/// init deviceManager
let deviceManager = AccessoryManager()
       
deviceManager.statusDelegate = self
       
/// set scan delegate
deviceManager.scanningDelegate = self

/// start scan 
deviceManager.startScan(duration: kScanDuration)

/// stop scan
deviceManager.stopScan()
```

## AccessoryManagerStatusDelegate

```
/// Invoked whenever the bluetooth's state has been updated. 
func accessoryManager(_ manager: AccessoryManager?, isAvailable: Bool) {
    
}
```


## AccessoryManagerScanningDelegate
```
func accessoryManager(_ manager: AccessoryManager?, isScanning: Bool) {
    
}

func accessoryManager(_ manager: AccessoryManager?, didDiscover device: Accessory?, rssi: NSNumber?) {
     /// JinHaoAccessory is a subclass of Accessory.
     guard let device = device as? JinHaoAccessory else { return }
     
     
    //you can get number of programs
    device.request(request: .readNumberOfPrograms(chip: device.hearChip), complete: { r in
        if case .success = r, let number = device.numberOfProgram {
            //program
            print("number of programs is \(number), so device.program is 0 ~ \(number - 1)")
        }
    })

    //you can get the mode of programs
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
                print("program is: \(index), mode is: \(value)")
            }
        }
    })

    device.request(
        requests: [
            //read current program(runMode) and volume
            .readProgramVolume,
            //read dsp with program 0 ~ 3
    //                .readDsp(program: 0),    device.program is 0 ~ (device.numberOfProgram - 1)
        ],
        complete: { [weak self] in
            self?.hideSpinnerView()
            if let program = device.program {
                print("current program is \(program), mode is \(device.scenesOfProgram[program])")
            }
        })
}

func accessoryManager(_ manager: AccessoryManager?, didUpdate device: Accessory?, rssi: NSNumber?) {
    /// JinHaoAccessory is a subclass of Accessory.
    guard let device = device as? JinHaoAccessory else { return }

}
```

## Connect

```
    /// self implements `JinHaoAccessoryDelegate`.
    let _ = accessory.connect(with: self, tag: "")
    
```

## JinHaoAccessoryDelegate

`JinHaoAccessoryDelegate` conforms to `AccessoryDelegate`.
```
/// AccessoryDelegate
func device(_ device: Accessory, didUpdate state: AccessoryState) {
    guard let device = device as? JinHaoAccessory else { return }
}

func device(_ device: Accessory, didConnect error: Error?) {
}

func device(_ device: Accessory, didDisconnect error: Error?) {
    
}

func device(_ device: Accessory, didFailToConnect error: Error?) {
    
}

func device(_ device: Accessory, didDiscoverServices: [AccessoryService]) {
    guard let device = device as? JinHaoAccessory else { return }
    
}


/// JinHaoAccessoryDelegate

func batteryDidChanged(_ accessory: JinHaoAccessory, bat: Int) {

}

// This method is triggered when the button on the hearing aid activates a change in the hearing mode.
func didNotifyProgram(_ accessory: JinHaoAccessory, previous: Int, current: Int) {

}

//This method is triggered when the button on the hearing aid activates a volume change.
func didNotifyVolume(_ accessory: JinHaoAccessory, previous: Int, current: Int) {

}

// 
func didUpdateValue(_ accessory: JinHaoAccessory, request: JinHaoRequest) {

}
```

## Send Data

You can send data to the hearing aid by calling the following two methods. and `func didUpdateValue(_ accessory: JinHaoAccessory, request: JinHaoRequest)` will be called 

1. `public func request(request: JinHaoRequest, complete: ((JinHaoResult)->Void)?)`
```
device.request(request: .readProgramVolume,
                       complete: { [weak self] result in
    switch result {
    case let .success(data):
        break
        
    case let .error(error):
        break
    }
})
```
    
2. `public func request(requests: [JinHaoRequest], complete: (()->Void)?)`
```
device.request(
    requests: [
        //read current program(runMode) and volume
        .readProgramVolume,
        //read dsp with program 1 ~ 4
        .readDsp(program: 1),
        .readDsp(program: 2),
        .readDsp(program: 3),
        .readDsp(program: 4)
    ],
    complete: { [weak self] in
        
    })
```




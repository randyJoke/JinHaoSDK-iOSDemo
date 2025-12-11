//
//  SettingsViewController.swift
//  BLELibraryDemo
//
//  Created by liuyuanhan on 2024/10/18.
//

import UIKit
import JinHaoSDK

class SettingsViewController: BaseViewController {
    
    // MARK: - Properties
    /// Stored Properties
    var accessoryManager: AccessoryManager
    var accessory: JinHaoAccessory
    
    @IBOutlet weak var batterylabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider! {
        didSet {
            volumeSlider.minimumValue = 0
            volumeSlider.maximumValue = 10
        }
    }
    @IBOutlet weak var programSeg: UISegmentedControl!
    @IBOutlet weak var noiseSeg: UISegmentedControl!
    @IBOutlet weak var mpoSeg: UISegmentedControl!
    @IBOutlet weak var directionSeg: UISegmentedControl!
    
    @IBOutlet weak var eq250Slider: UISlider!
    @IBOutlet weak var eq1000Slider: UISlider!
    @IBOutlet weak var eq2000Slider: UISlider!
    
    @IBOutlet weak var fbcSlider: UISlider!
    @IBOutlet weak var inputModeSlider: UISlider!

    // MARK: - Lifecycle
    init(deviceManager: AccessoryManager, accessory: JinHaoAccessory) {
        self.accessoryManager = deviceManager
        self.accessory = accessory
        super.init(nibName: String(describing: SettingsViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        if accessory.state == AccessoryState.disconnected {
            let _ = accessory.connect(with: self, tag: "")
            //disconnect -- accessory.disconnect()
        } else {
            
        }
        
        JinHaoLog.enable = true
        print("sdk version is \(JinHaoLog.sdkVersion())")
        configureBaseController(withTitle: accessory.name)
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
    }
    
    @IBAction func changeVolume(_ sender: UISlider) {
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        self.showSpinnerView(in: self)
        self.accessory.request(request: .controlVolume(volume: Int(roundedValue), program: programSeg.selectedSegmentIndex),
                               complete: { [weak self] result in
            switch result {
            case let .success(data: response):
                print("success \(response)")
                
            case let .error(error):
                print("error \(error)")
                
            default:
                break
            }
            self?.hideSpinnerView()
        })
    }
    
    @IBAction func changeProgram(_ sender: UISegmentedControl) {
        /**
            Each program corresponds to a DSP, so when switching programs, you need to read the DSP.
         */
        self.showSpinnerView(in: self)
        self.accessory.request(request: .controlProgram(program: sender.selectedSegmentIndex),
                               complete: { [weak self] _ in
            
            self?.accessory.request(request: .readDsp(program: sender.selectedSegmentIndex)) { [weak self] _ in
                self?.hideSpinnerView()
            }
        })
        
        self.accessory.readBattery()
    }
    
    @IBAction func changeNoise(_ sender: UISegmentedControl) {
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
    }
    
    @IBAction func changeMPO(_ sender: UISegmentedControl) {
        if var dsp = self.accessory.dsp as? JinHaoA4Dsp, let p = self.accessory.program {
            switch sender.selectedSegmentIndex {
            case 0:
                dsp.maximumPowerOutput = .muo
            case 1:
                dsp.maximumPowerOutput = .dbMinus4
            case 2:
                dsp.maximumPowerOutput = .dbMinus8
            case 3:
                dsp.maximumPowerOutput = .dbMinus12
                
            default: break
            }
            self.showSpinnerView(in: self)
            self.accessory.request(request: .writeDsp(dsp: dsp, program: p, withResponse: true),
                                   complete: { [weak self] _ in
                self?.hideSpinnerView()
            })
        }
    }
    
    @IBAction func changeDirection(_ sender: UISegmentedControl) {
        // Changing the directionality can affect the values of EQ250 and EQ500.
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
    }
    
    @IBAction func inModelAction(_ sender: UISlider) {
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        if var dsp = accessory.dsp as? JinHaoA16Dsp,
           let program = accessory.program,
           let inputMode = JinHaoA16DspEnum.InputMode(rawValue: Int(sender.value)){
            dsp.inputMode = inputMode
            self.showSpinnerView(in: self)
            accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
                self.hideSpinnerView()
            }
        }
    }
    
    
    @IBAction func fbcAction(_ sender: UISlider) {
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        if var dsp = accessory.dsp as? JinHaoA16Dsp,
           let program = accessory.program,
           let fbc = JinHaoA16DspEnum.FeedbackCanceler(rawValue: Int(sender.value)){
            dsp.feedbackCanceler = fbc
            self.showSpinnerView(in: self)
            accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
                self.hideSpinnerView()
            }
        }
    }
    
    @IBAction func eq250Action(_ sender: UISlider) {
        // Changing EQ250 and EQ500 can also affect the directionality.
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
    }
    
    @IBAction func eq1000Action(_ sender: UISlider) {
        if var dsp = self.accessory.dsp, let p = self.accessory.program {
            let step: Float = 1
            let roundedValue = round(sender.value / step) * step
            sender.value = roundedValue
            dsp.setEq(eq: Int(roundedValue), at: 1000)
            self.showSpinnerView(in: self)
            self.accessory.request(request: .writeDsp(dsp: dsp, program: p, withResponse: true),
                                   complete: { [weak self] _ in
                self?.hideSpinnerView()
            })
        }
    }
    
    @IBAction func eq2000Action(_ sender: UISlider) {
        if var dsp = self.accessory.dsp, let p = self.accessory.program {
            let step: Float = 1
            let roundedValue = round(sender.value / step) * step
            sender.value = roundedValue
            dsp.setEq(eq: Int(roundedValue), at: 2000)
            self.showSpinnerView(in: self)
            self.accessory.request(request: .writeDsp(dsp: dsp, program: p, withResponse: true),
                                   complete: { [weak self] result in
                switch result {
                case let .success(data):
                    break
                    
                case let .error(error):
                    break
                }
                self?.hideSpinnerView()
            })
        }
    }
    
    private func changeA16MPO() {
        if var dsp = accessory.dsp as? JinHaoA16Dsp, let program = accessory.program {
            dsp.setMaximumPowerOutput(.dbMinus10, for: .hz250)
            accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
                
            }
        }
    }
    
    private func changeA16AttackTime() {
        if var dsp = accessory.dsp as? JinHaoA16Dsp, let program = accessory.program {
            dsp.mpoAttackTime = .ms10
            accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
                
            }
        }
    }
    
    private func changeA16ReleaseTime() {
        if var dsp = accessory.dsp as? JinHaoA16Dsp, let program = accessory.program {
            dsp.mpoReleaseTime = .ms40
            accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
                
            }
        }
    }
    
    private func changeA16CompressThreshold() {
        if var dsp = accessory.dsp as? JinHaoA16Dsp, let program = accessory.program {
            dsp.setCompressionThreshold(.db20, for: .hz250)
            accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
                
            }
        }
    }
    
    private func changeA16CompressRatio() {
        if var dsp = accessory.dsp as? JinHaoA16Dsp, let program = accessory.program {
            dsp.setCompressionRatio(.ratio1_00, for: .hz250)
            accessory.request(request: .writeDsp(dsp: dsp, program: program, withResponse: true)) { result in
                
            }
        }
    }
}


extension SettingsViewController: AccessoryDelegate {
    
    func device(_ device: Accessory, didUpdate state: AccessoryState) {
        guard let device = device as? JinHaoAccessory else { return }
        self.stateLabel.text = String(describing: state)
    }
    
    func device(_ device: Accessory, didConnect error: Error?) {
    }
    
    func device(_ device: Accessory, didDisconnect error: Error?) {
        
    }
    
    func device(_ device: Accessory, didFailToConnect error: Error?) {
        
    }
    
    func device(_ device: Accessory, didDiscoverServices: [AccessoryService]) {
        guard let device = device as? JinHaoAccessory else { return }
        self.showSpinnerView(in: self)
        print("name is \(device.name)")
        print("local name is \(device.localName ?? "nil")")
        print("orientation is \(device.orientation)")
        print("mac address is \(device.address)")
        
        if let d = device as? JinHaoA16Accessory {
            print("device is A16 Accessory")
            d.requestSummaryDataLog { dataLog in
                
            }
        }
        
        device.request(request: .readProfile(type: JinHaoProfileType.productSku), complete: {  [weak self] r in
            guard let `self` = self else { return }
            if case .success = r {
                self.volumeSlider.minimumValue = Float(device.profile.minVolume)
                self.volumeSlider.maximumValue = Float(device.profile.maxVolume)
                print("sku code is \(device.profile.skuCode), minVolume is \(device.profile.minVolume), maxVolume is \(device.profile.maxVolume)")
            }
        })
        
        device.request(request: .readProfile(type: JinHaoProfileType.productPattern), complete: { r in
            if case .success = r {
                print("pattern code is \(device.profile.patternCode)")
            }
        })
        
        //you can get number of program
        device.readNumberOfProgram(complete: { r in
            if case .success = r, let number = device.numberOfProgram {
                //program
                print("number of programs is \(number), so device.program is 0 ~ \(number)")
            }
        })
        
        //You can obtain the scene mode corresponding to each program, for example, the scene mode of program 0 is scenesOfProgram[0]
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

        device.request(request: .readProgramVolume, complete: { r in
            if case .success = r {
                if let program = device.program, let volume = device.volume {
                    print("current program is \(program), scene is \(device.scenesOfProgram[program]), volume is \(volume)")
                    device.request(request: .readDsp(program: program)) { [weak self] r2 in
                        guard let `self` = self, let dsp = device.dsp, case .success = r2 else { return }
                        self.hideSpinnerView()
                        self.eq250Slider.minimumValue = Float(dsp.minEQValue)
                        self.eq250Slider.maximumValue = Float(dsp.maxEQValue)
                        self.eq1000Slider.minimumValue = Float(dsp.minEQValue)
                        self.eq1000Slider.maximumValue = Float(dsp.maxEQValue)
                        self.eq2000Slider.minimumValue = Float(dsp.minEQValue)
                        self.eq2000Slider.maximumValue = Float(dsp.maxEQValue)
                        let frequences = device.dsp?.frequences
                        print("frequences is \(frequences)")
                    }
                }
            } else {
                self.hideSpinnerView()
            }
        })
        
        /***
        device.request(
            requests: [
                .readProfile(type: JinHaoProfileType.productSku),
                .readProfile(type: JinHaoProfileType.productPattern),
                .readNumberOfPrograms(chip: device.hearChip),
                .readScenesOfProgram,
                .readProgramVolume
            ],complete: {
                //sku code
                print("sku code is \(device.profile.skuCode)")
                //pattern code
                print("pattern code is \(device.profile.patternCode)")
                //number of program
                print("number of programs is \(device.profile.programs)")
                //scene mode
                for (index, value) in device.profile.programs.enumerated() {
                    print("program is: \(index), scene mode is: \(value)")
                }
                //scene mode
                //program and volume
                if let program = device.program, let volume = device.volume {
                    print("current program is \(program), scene is \(device.scenesOfProgram[program]), volume is \(volume)")
                }
            })
         */
    }
}

extension SettingsViewController: JinHaoAccessoryDelegate {
    
    func didSendRequest(_ accessory: JinHaoSDK.JinHaoAccessory, request: JinHaoSDK.JinHaoRequest) {
        
    }
    
    func didNotifyProgram(_ accessory: JinHaoSDK.JinHaoAccessory, previous: Int, current: Int) {
        self.programSeg.selectedSegmentIndex = current
        accessory.request(request: .readDsp(program: current), complete: nil)
    }
    
    func didNotifyVolume(_ accessory: JinHaoSDK.JinHaoAccessory, previous: Int, current: Int) {
        self.volumeSlider.value = Float(current)
    }
    
    /// - bat: 0~100
    func batteryDidChanged(_ accessory: JinHaoSDK.JinHaoAccessory, bat: Int) {
        self.batterylabel.text = String(bat)
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
            self.eq250Slider.minimumValue = Float(dsp.minEQValue)
            self.eq250Slider.maximumValue = Float(dsp.maxEQValue)
            self.eq1000Slider.minimumValue = Float(dsp.minEQValue)
            self.eq1000Slider.maximumValue = Float(dsp.maxEQValue)
            self.eq2000Slider.minimumValue = Float(dsp.minEQValue)
            self.eq2000Slider.maximumValue = Float(dsp.maxEQValue)
            
            switch dsp.noise {
            case .off: noiseSeg.selectedSegmentIndex = 0
            case .weak: noiseSeg.selectedSegmentIndex = 1
            case .medium: noiseSeg.selectedSegmentIndex = 2
            case .strong: noiseSeg.selectedSegmentIndex = 3
            default:
                directionSeg.selectedSegmentIndex = UISegmentedControl.noSegment
                break
            }
            
            switch dsp.direction {
            case .normal: directionSeg.selectedSegmentIndex = 0
            case .tv: directionSeg.selectedSegmentIndex = 1
            case .meeting: directionSeg.selectedSegmentIndex = 2
            case .face: directionSeg.selectedSegmentIndex = 3
            case .unknown: directionSeg.selectedSegmentIndex = UISegmentedControl.noSegment
            default:
                break
            }
            
            eq250Slider.value = Float(dsp.getEq(at: 250) ?? 0)
            eq1000Slider.value = Float(dsp.getEq(at: 1000) ?? 0)
            eq2000Slider.value = Float(dsp.getEq(at: 2000) ?? 0)
        }
        
        if let dsp = accessory.dsp as? JinHaoA4Dsp {
            switch dsp.maximumPowerOutput {
            case .muo: mpoSeg.selectedSegmentIndex = 0
            case .dbMinus4: mpoSeg.selectedSegmentIndex = 1
            case .dbMinus8: mpoSeg.selectedSegmentIndex = 2
            case .dbMinus12: mpoSeg.selectedSegmentIndex = 3
            default:
                directionSeg.selectedSegmentIndex = UISegmentedControl.noSegment
                break
            }
            print("A4 mpo is \(dsp.maximumPowerOutput) in all frequence")
        }
        
        if let dsp = accessory.dsp as? JinHaoA16Dsp {
            self.inputModeSlider.value = Float(dsp.inputMode.rawValue)
            self.fbcSlider.value = Float(dsp.feedbackCanceler.rawValue)
            
            print("A16 attack time is \(dsp.mpoAttackTime.displayName)")
            print("A16 release time is \(dsp.mpoReleaseTime.displayName)")
            print("A16 compress ratio is \(dsp.getCompressionRatio(for: .hz250).displayName) in 250 Hz")
            print("A16 compress threshold level is \(dsp.getCompressionThreshold(for: .hz250).displayName) in 250 Hz")
            print("A16 mpo level is \(dsp.getMaximumPowerOutput(for: .hz250).displayName) in 250 Hz")
        }
    }

}


extension SettingsViewController: DFUServiceDelegate, DFUProgressDelegate {
    
    func dfuStateDidChange(to state: JinHaoSDK.DFUState) {
        print("dfuStateDidChange \(state)")
    }
    
    func dfuError(_ error: JinHaoSDK.DFUError, didOccurWithMessage message: String) {
        print("dfuError \(error)")
    }
    
    func dfuProgressDidChange(to progress: Int, currentSpeedBytesPerSecond: Double, avgSpeedBytesPerSecond: Double) {
        print("dfuProgressDidChange \(progress)")
    }
    
}

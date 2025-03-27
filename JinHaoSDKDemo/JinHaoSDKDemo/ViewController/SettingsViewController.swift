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
        
        JinHaoLog.enable = false
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
                               complete: { [weak self] _ in
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
        if var dsp = self.accessory.dsp, let p = self.accessory.program {
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
    
    @IBAction func eq250Action(_ sender: UISlider) {
        // Changing EQ250 and EQ500 can also affect the directionality.
        if var dsp = self.accessory.dsp, let p = self.accessory.program {
            let step: Float = 1
            let roundedValue = round(sender.value / step) * step
            sender.value = roundedValue
            dsp.eq250 = Int(roundedValue)
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
            dsp.eq1000 = Int(roundedValue)
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
            dsp.eq2000 = Int(roundedValue)
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
    
    /**
         func fitting() {
             let params = [250:30, 500:30, 1000:30, 1500:50, 2000:50, 3000:35, 4000:35, 6000:45]
             let fitting = Fitting.calculate(params: params)
             if var dsp = self.accessory.dsp, let p = self.accessory.program {
                 dsp.eq250 = fitting.eq1
                 dsp.eq500 = fitting.eq2
                 dsp.eq1000 = fitting.eq3
                 dsp.eq1500 = fitting.eq4
                 dsp.eq2000 = fitting.eq5
                 dsp.eq2500 = fitting.eq6
                 dsp.eq3000 = fitting.eq7
                 dsp.eq3500 = fitting.eq8
                 dsp.eq4000 = fitting.eq9
                 dsp.eq6000 = fitting.eq11
                 
                 self.showSpinnerView(in: self)
                 self.accessory.request(request: .writeDsp(dsp: dsp, program: p, withResponse: true),
                                        complete: { [weak self] _ in
                     self?.hideSpinnerView()
                 })
             }
         }
     */
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
        switch device.hearChip {
        case .a4, .h01:
            eq250Slider.minimumValue = 0
            eq250Slider.maximumValue = 15
            eq1000Slider.minimumValue = 0
            eq1000Slider.maximumValue = 15
            eq2000Slider.minimumValue = 0
            eq2000Slider.maximumValue = 15
            /// eq2500 ~ eq7000 ...
            
        default:
            break
        }
        self.showSpinnerView(in: self)
        print("name is \(device.name)")
        print("local name is \(device.localName ?? "nil")")
        print("orientation is \(device.orientation)")
        print("mac address is \(device.address)")
        
        //you can get number of program
        device.request(request: .readNumberOfPrograms(chip: device.hearChip), complete: { r in
            if case .success = r, let number = device.numberOfProgram {
                //program
                print("number of programs is \(number), so device.program is 0 ~ \(number - 1)")
            }
        })
        
        //You can obtain the scene mode corresponding to each program, for example, the scene mode of program 0 is scenesOfProgram[0]
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
}

extension SettingsViewController: JinHaoAccessoryDelegate {
    
    
    func didNotifyProgram(_ accessory: JinHaoSDK.JinHaoAccessory, previous: Int, current: Int) {
        self.programSeg.selectedSegmentIndex = current
        accessory.request(request: .readDsp(program: current), complete: nil)
    }
    
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
            
            switch dsp.direction {
            case .normal: directionSeg.selectedSegmentIndex = 0
            case .tv: directionSeg.selectedSegmentIndex = 1
            case .meeting: directionSeg.selectedSegmentIndex = 2
            case .face: directionSeg.selectedSegmentIndex = 3
            case .unknown: directionSeg.selectedSegmentIndex = UISegmentedControl.noSegment
            default:
                break
            }
            
            eq250Slider.value = Float(dsp.eq250)
            eq1000Slider.value = Float(dsp.eq1000)
            eq2000Slider.value = Float(dsp.eq2000)
            /// eq2500 ~ eq7000
        }
    }

}

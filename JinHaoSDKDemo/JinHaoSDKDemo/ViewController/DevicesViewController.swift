//
//  ViewController.swift
//  BLELibraryDemo
//
//  Created by liuyuanhan on 2024/10/17.
//

import UIKit
import CoreBluetooth
import JinHaoSDK

class DevicesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, AccessoryManagerScanningDelegate, AccessoryManagerStatusDelegate, DeviceCellDelegate {

    // MARK: - Properties
    /// Constants
    let kScanDuration: TimeInterval = 5.0
    
    /// Stored Properties
    var selectedDevice: JinHaoAccessory?
    var deviceManager: AccessoryManager?
    var devices: [JinHaoAccessory] = []
    var rssiDictionary: [String : NSNumber] = [:]
    
    /// UI Properties
    private lazy var scanBarButtonItem: UIBarButtonItem = {
        let button = UIButton(type: . system)
        button.setTitle("Scan", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.addTarget(self,
                         action: #selector(rescan),
                         for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    private lazy var connectBarButtonItem: UIBarButtonItem = {
        let button = UIButton(type: . system)
        button.setTitle("Connect", for: .normal)
        button.isEnabled = false
        button.titleLabel?.textAlignment = .center
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.addTarget(self,
                         action: #selector(connect),
                         for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DeviceSetTableViewCell.self, forCellReuseIdentifier: DeviceSetTableViewCell.reuseIdentifier)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.alwaysBounceVertical = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        devices = []
        tableView.reloadData()
        updateConnectButton()
        configureBaseController(withTitle: "Devices")
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        devices = []
        rssiDictionary = [:]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        deviceManager = AccessoryManager()
        deviceManager?.scanningDelegate = self
        deviceManager?.statusDelegate = self
        updateConnectButton()

        navigationItem.leftBarButtonItem?.isEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deviceManager?.stopScan()
    }

    /// UI Methods
    private func configureUI() {
        navigationItem.leftBarButtonItem = scanBarButtonItem
        navigationItem.rightBarButtonItem = connectBarButtonItem
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
    }
    
    /// Selector Methods
    @objc private func rescan() {
        deviceManager?.startScan(duration: kScanDuration)
    }
    
    @objc private func connect() {
        buildDeviceSetForSelection()
        navigateToSettings()
    }
    
    /// Helper Methods
    private func refreshTable() {
        devices = deviceManager!.accessories.compactMap({$0 as? JinHaoAccessory})
        ///deviceManager?.clearAccessories(), you can remove all accessories
        tableView.reloadData()
    }
    
    private func refreshCells() {
        for indexPath in tableView.indexPathsForVisibleRows ?? [] {
            let cell = tableView.cellForRow(at: indexPath) as? DeviceSetTableViewCell
            let deviceForRow = devices[indexPath.row]
            cell?.rssiLabel.text = cell?.rssiString(from: deviceForRow, using: rssiDictionary)
        }
    }
    
    private func updateConnectButton() {
        var doEnable = false
        var isLegal = false
        navigationItem.rightBarButtonItem?.isEnabled = false
        guard let selectedCells = tableView.indexPathsForSelectedRows else { return }
        
        if selectedCells.count == 1 {
            isLegal = true
        }
        
        if isLegal {
            buildDeviceSetForSelection()
            if selectedDevice != nil {
                doEnable = true
            }
        }
        
        connectBarButtonItem.isEnabled = doEnable
    }
    
    @objc private func buildDeviceSetForSelection() {
        let selectedCells = tableView.indexPathsForSelectedRows
        for indexPath in selectedCells ?? [] {
            selectedDevice = devices[indexPath.row]
        }
    }
    

    // MARK: - Navigation Methods
    private func navigateToSettings() {
        if let deviceManager = deviceManager, let device = selectedDevice {
            let viewController = SettingsViewController(deviceManager: deviceManager, accessory: device)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}


// MARK: - UITableViewDataSource protocols methods
extension DevicesViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DeviceSetTableViewCell.height
    }
}

// MARK: - UITableViewDelegate protocols methods
extension DevicesViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let device = devices[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceSetTableViewCell.reuseIdentifier, for: indexPath) as! DeviceSetTableViewCell
        cell.configureWithData(with: device, using: rssiDictionary, from: self)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { updateConnectButton() }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { updateConnectButton() }
}

// MARK: - AccessoryManagerScanningDelegate protocol methods
extension DevicesViewController {
    func accessoryManager(_ manager: AccessoryManager?, isScanning: Bool) {
        scanBarButtonItem.isEnabled = !isScanning
    }
    
    func accessoryManager(_ manager: AccessoryManager?, didDiscover device: Accessory?, rssi: NSNumber?) {
        guard let device = device as? JinHaoAccessory else { return }
        rssiDictionary[device.deviceId] = rssi
        refreshTable()
    }
    
    func accessoryManager(_ manager: AccessoryManager?, didUpdate device: Accessory?, rssi: NSNumber?) {
        guard let device = device as? JinHaoAccessory else { return }

        if let rssi = rssi {
            var strength = rssi.intValue
            
            if strength < -99 {
                strength = -99
            }
            
            if strength < 0 {
                rssiDictionary[device.deviceId] = strength as NSNumber
                refreshCells()
            }
        }
    }
}

// MARK: - AccessoryManagerStatusDelegate protocol methods
extension DevicesViewController {
    func accessoryManager(_ manager: AccessoryManager?, isAvailable: Bool) {
        refreshTable()
    }
}

// MARK: - DeviceCellDelegate protocol methods
extension DevicesViewController {
    func orientationControlChange() {
        updateConnectButton()
    }
}

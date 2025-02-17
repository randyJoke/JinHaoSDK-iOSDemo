//
//  DeviceSetTableViewCell.swift
//  Euphony
//
//  Created by Anthony Benitez on 1/10/22.
//

import UIKit
import JinHaoSDK

protocol DeviceCellDelegate: AnyObject {
    func orientationControlChange()
}

class DeviceSetTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    /// Constants
    static let reuseIdentifier = String(describing: DeviceSetTableViewCell.self)
    static let height: CGFloat = 112
    
    /// Stored Properties
    weak var delegate: DeviceCellDelegate?

    /// UI Properties
    var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkText
        label.textAlignment = .left
        return label
    }()
    
    private var serialTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "SN"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private var serialLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkText
        label.textAlignment = .left
        return label
    }()
    
    private var rssiTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "RSSI"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    var rssiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods    
    /// UI Methods
    private func configureUI() {
        let containerView = UIView()
        contentView.addSubview(containerView)
        containerView.anchor(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 8,
                             paddingLeft: 8,
                             paddingBottom: 8,
                             paddingRight: 8)
        
        let nameStackView = UIStackView(arrangedSubviews: [nameTitleLabel, nameLabel])
        nameStackView.axis = .vertical
        nameStackView.spacing = 4
        nameStackView.distribution = .fillProportionally
        containerView.addSubview(nameStackView)
        nameStackView.anchor(top: containerView.topAnchor,
                             left: containerView.leftAnchor,
                             paddingTop: 8,
                             paddingLeft: 8)
        
        let serialStackView = UIStackView(arrangedSubviews: [serialTitleLabel, serialLabel])
        serialStackView.axis = .vertical
        serialStackView.spacing = 4
        serialStackView.distribution = .fillProportionally
        containerView.addSubview(serialStackView)
        serialStackView.anchor(left: containerView.leftAnchor,
                               bottom: containerView.bottomAnchor,
                               paddingLeft: 8,
                               paddingBottom: 8)
        
        let rssiStackView = UIStackView(arrangedSubviews: [rssiTitleLabel, rssiLabel])
        rssiStackView.axis = .vertical
        rssiStackView.spacing = 4
        rssiStackView.distribution = .fillProportionally
        containerView.addSubview(rssiStackView)
        rssiStackView.anchor(top: containerView.topAnchor,
                             right: containerView.rightAnchor,
                             paddingTop: 8,
                             paddingRight: 8)
    }
    
    /// Helper Methods
    public func configureWithData(with device: Accessory?, using rssiDictionary: [String : NSNumber]?, from viewController: UIViewController) {
        guard let device = device else { return }
//        
//        let nameSubstring = device.name[..<device.name.index(device.name.startIndex, offsetBy: 4)]
//        nameLabel.text = String(nameSubstring)
//
//        let serialSubstring = device.name[device.name.index(device.name.startIndex, offsetBy: 5)...device.name.index(before: device.name.endIndex)]
//        serialLabel.text = String(serialSubstring)
        nameLabel.text = device.name
        if let rssiDictionary = rssiDictionary { rssiLabel.text = rssiString(from: device, using: rssiDictionary) }
    }
    
    public func configureWithPL5Data(with device: Accessory?, using rssiDictionary: [String : NSNumber]?, from viewController: UIViewController) {
        guard let device = device else { return }
    
        nameLabel.text = String(device.name)
        
        if let rssiDictionary = rssiDictionary { rssiLabel.text = rssiString(from: device, using: rssiDictionary) }
    }
    
    func rssiString(from device: Accessory, using rssiDictionary: [String : NSNumber]) -> String {
        let rssi: NSNumber? = rssiDictionary[device.deviceId]
        return (rssi != nil) ? rssi!.description : "=="
    }
    
    private func orientationString(from device: Accessory) -> String {
       return ""
    }

}

//
//  TrainInformationTableViewCell.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit
import Foundation

final class TrainInformationTableViewCell: UITableViewCell {
    private let labelPaddingTopAndBottom: CGFloat = -4
    
    private lazy var iconColorView = UIView.autoLayout()
    
    private var tubeLineName = UILabel(font: .systemFont(ofSize: 18))
    
    private var tubeInformationStackView = UIStackView(distribution: .fill,
                                                       alignment: .leading,
                                                       axis: .vertical,
                                                       spacing: 4)
    
    private var tubeServicesInformationStackView = UIStackView(distribution: .fill,
                                                               alignment: .leading,
                                                               axis: .horizontal,
                                                               spacing: 10)
    
    var configure: TrainInformationModel? {
        didSet {
            updateCellData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(iconColorView)
        contentView.addSubview(tubeInformationStackView)
        tubeInformationStackView.addArrangedSubview(tubeLineName)
        tubeInformationStackView.addArrangedSubview(tubeServicesInformationStackView)
        self.activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tubeServicesInformationStackView.removeAllArrangedSubviews()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            iconColorView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            iconColorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            iconColorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            iconColorView.widthAnchor.constraint(equalToConstant: 8),
            
            tubeInformationStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 16),
            tubeInformationStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            tubeInformationStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            tubeInformationStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
        ])
    }
    
    private func updateCellData() {
        guard let configure = configure else {
            return
        }
        tubeServicesInformationStackView.removeAllArrangedSubviews()
        
        tubeLineName.text = configure.tubeLineName
        let services = configure.services
        iconColorView.backgroundColor = configure.color
        
        if services.isEmpty {
            return
        }
        let label = UILabel(font: .systemFont(ofSize: 14))
        label.text = "Services:"
        tubeServicesInformationStackView.addArrangedSubview(label)
        
        for serviceType in services {
            let label = UILabel(font: .systemFont(ofSize: 14))
            label.text = serviceType
            label.transformToPillShape()
            tubeServicesInformationStackView.addArrangedSubview(label)
        }
    }
}

final class ActivityIndicatorView: UIView {
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView.autoLayout()
        view.style = .large
        view.color = .gray
        view.startAnimating()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        generateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateUI() {
        addSubview(activityView)
            
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityView.widthAnchor.constraint(equalToConstant: 40),
            activityView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

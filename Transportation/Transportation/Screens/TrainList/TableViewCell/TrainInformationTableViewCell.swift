//
//  TrainInformationTableViewCell.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit
import Foundation

final class TrainInformationTableViewCell: UITableViewCell {
    typealias Spacing = AppConstant.Spacing
    typealias Font = AppConstant.Font
    typealias Anchor = AppConstant.Anchor
        
    private var iconColorView = UIView.autoLayout()
    
    private var tubeLineName = UILabel(font: .systemFont(ofSize: Font.big.value))
    
    private var tubeInformationStackView = UIStackView(distribution: .fill,
                                                       alignment: .leading,
                                                       axis: .vertical,
                                                       spacing: Spacing.standard.rawValue)
    
    private var tubeServicesInformationStackView = UIStackView(distribution: .fill,
                                                               alignment: .leading,
                                                               axis: .horizontal,
                                                               spacing: Spacing.standard.rawValue)
    
    private static let barTopSpacer: CGFloat = 1
    private static let barBottomSpacer: CGFloat = 1
    private static let iconColorViewWidth: CGFloat = 8

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
            iconColorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: TrainInformationTableViewCell.barBottomSpacer),
            iconColorView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: TrainInformationTableViewCell.barTopSpacer),
            iconColorView.widthAnchor.constraint(equalToConstant: TrainInformationTableViewCell.iconColorViewWidth),
            
            tubeInformationStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: Anchor.standard.value),
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
        let label = UILabel(font: .systemFont(ofSize: Font.medium.value))
        label.text = StringConstant.services.localized()
        tubeServicesInformationStackView.addArrangedSubview(label)
        
        for serviceType in services {
            let label = UILabel(font: .systemFont(ofSize: Font.medium.value))
            label.text = serviceType
            label.transformToPillShape()
            tubeServicesInformationStackView.addArrangedSubview(label)
        }
    }
}

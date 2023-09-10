//
//  StationInformationTableViewCell.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit
import Foundation

final class StationInformationTableViewCell: UITableViewCell {
    private let labelPaddingTopAndBottom: CGFloat = -4

    private lazy var iconColorVerticalBar = UIView.autoLayout()
    
    private lazy var iconColorHorizontalBar = UIView.autoLayout()
    
    private lazy var trainStopName: UILabel = {
        let label = UILabel(font: .systemFont(ofSize: 18))
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tubeInformationStackView: UIStackView = {
        return UIStackView(distribution: .fill, alignment: .leading, axis: .vertical, spacing: 4)
    }()
     
    
    var configure: StationItemViewState? {
        didSet {
           updateCellData()
         }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(iconColorVerticalBar)
        contentView.addSubview(iconColorHorizontalBar)
        contentView.addSubview(trainStopName)
        self.activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
     }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            iconColorVerticalBar.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            iconColorVerticalBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            iconColorVerticalBar.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconColorVerticalBar.widthAnchor.constraint(equalToConstant: 4),
            
            iconColorHorizontalBar.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            iconColorHorizontalBar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -2),
            iconColorHorizontalBar.widthAnchor.constraint(equalToConstant: 30),
            iconColorHorizontalBar.heightAnchor.constraint(equalToConstant: 4),

            trainStopName.leadingAnchor.constraint(equalTo: iconColorHorizontalBar.trailingAnchor, constant: 16),
            trainStopName.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            trainStopName.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            trainStopName.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

        ])
    }
    
    private func updateCellData() {
        guard let configure = configure else {
            return
        }

        [iconColorVerticalBar, iconColorHorizontalBar].forEach({ $0.backgroundColor = configure.color })
        trainStopName.text = configure.stationName
     }
}

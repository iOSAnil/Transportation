//
//  StationInformationTableViewCell.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit
import Foundation

final class StationInformationTableViewCell: UITableViewCell {
    typealias Spacing = AppConstant.Spacing
    typealias Font = AppConstant.Font
    typealias Anchor = AppConstant.Anchor

    private static var horizontalBarHeight: CGFloat = 30
    private static var horizontalBarYOffset: CGFloat = -2

    private var iconColorVerticalBar = UIView.autoLayout()
    
    private var iconColorHorizontalBar = UIView.autoLayout()
    
    private var trainStopName = UILabel(font: .systemFont(ofSize: Font.big.value),
                                             multiline: true)
    
    private var tubeInformationStackView = UIStackView(distribution: .fill,
                                                       alignment: .leading,
                                                       axis: .vertical,
                                                       spacing: Spacing.standard.value)
     
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
            iconColorVerticalBar.widthAnchor.constraint(equalToConstant: Spacing.standard.value),
            
            iconColorHorizontalBar.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            iconColorHorizontalBar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,
                                                            constant: StationInformationTableViewCell.horizontalBarYOffset),
            iconColorHorizontalBar.widthAnchor.constraint(equalToConstant: StationInformationTableViewCell.horizontalBarHeight),
            iconColorHorizontalBar.heightAnchor.constraint(equalToConstant: Spacing.standard.value),

            trainStopName.leadingAnchor.constraint(equalTo: iconColorHorizontalBar.trailingAnchor,
                                                   constant: Anchor.standard.value),
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

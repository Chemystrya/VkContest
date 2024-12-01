//
//  RepositoriesListCell.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import UIKit

struct RepositoriesListCellViewModel: Hashable {
    let title: String
    let description: String
    let icon: URL
}

final class RepositoriesListCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

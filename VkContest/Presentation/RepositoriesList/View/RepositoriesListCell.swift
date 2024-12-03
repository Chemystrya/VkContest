//
//  RepositoriesListCell.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import UIKit
import Kingfisher

struct RepositoriesListCellViewModel: Hashable {
    let title: String
    let description: String
    let avatarUrl: URL?
}

final class RepositoriesListCell: UITableViewCell {
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubview(containerView)
        let subviews: [UIView] = [titleLabel, descriptionLabel, avatarImageView]
        subviews.forEach { containerView.addSubview($0) }
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        descriptionLabel.numberOfLines = 30
        containerView.backgroundColor = .white
        backgroundColor = .clear

        setupConstraints()
    }

    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [
                containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

                avatarImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
                avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                avatarImageView.heightAnchor.constraint(equalToConstant: 64),
                avatarImageView.widthAnchor.constraint(equalToConstant: 64),

                titleLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                titleLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),

                descriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
                descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
            ]
        )
    }
}

extension RepositoriesListCell {
    func setup(with viewModel: RepositoriesListCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        let processor = DownsamplingImageProcessor(size: avatarImageView.bounds.size)
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(
            with: viewModel.avatarUrl,
            options: [.processor(processor), .cacheOriginalImage]
        )
    }
}

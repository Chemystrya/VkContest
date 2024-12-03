//
//  TextField.swift
//  VkContest
//
//  Created by Fedorova Maria on 03.12.2024.
//

import UIKit

protocol TextFieldDelegate: AnyObject {
    func textFieldDidEndEditing(for type: TextFieldViewModel.FieldType, with text: String?)
}

struct TextFieldViewModel {
    let name: String
    let value: String?
    let type: FieldType
    weak var delegate: TextFieldDelegate?

    enum FieldType {
        case title
        case description
    }
}

final class TextField: UIView {
    private let rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 8
        return view
    }()

    private let labelContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = .white
        return label
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .footnote)
        return textField
    }()

    weak var delegate: TextFieldDelegate?

    var type: TextFieldViewModel.FieldType?

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        let views: [UIView] = [rectangleView, labelContainerView, textField]
        views.forEach { addSubview($0) }
        labelContainerView.addSubview(label)
        textField.delegate = self

        setupConstraints()
    }

    private func setupConstraints() {
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rectangleView.heightAnchor.constraint(equalToConstant: 54),
            rectangleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rectangleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rectangleView.topAnchor.constraint(equalTo: topAnchor),
            rectangleView.bottomAnchor.constraint(equalTo: bottomAnchor),

            labelContainerView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -6),
            labelContainerView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 6),
            labelContainerView.centerYAnchor.constraint(equalTo: rectangleView.topAnchor),
            labelContainerView.heightAnchor.constraint(equalToConstant: 20),

            label.leadingAnchor.constraint(equalTo: rectangleView.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: rectangleView.topAnchor),

            textField.topAnchor.constraint(equalTo: rectangleView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: rectangleView.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: rectangleView.leadingAnchor, constant: 4),
            textField.trailingAnchor.constraint(equalTo: rectangleView.trailingAnchor, constant: -4),
        ])
    }
}

extension TextField {
    func setup(with viewModel: TextFieldViewModel) {
        label.text = viewModel.name
        textField.text = viewModel.value
        type = viewModel.type
        delegate = viewModel.delegate
    }
}

extension TextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let type else { return }

        delegate?.textFieldDidEndEditing(for: type, with: textField.text)
    }
}

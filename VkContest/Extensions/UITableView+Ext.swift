//
//  UITableView+Ext.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import UIKit

extension UITableView {

    // MARK: - Reuse

    public func dequeueReusableCellWithRegistration<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: T.self)

        register(T.self, forCellReuseIdentifier: reuseIdentifier)

        guard let cell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T else {
            assertionFailure("Could not dequeue cell with reuseId \(reuseIdentifier)")
            return T()
        }

        return cell
    }
}

//
//  TransitionHandler.swift
//  VkContest
//
//  Created by Fedorova Maria on 04.12.2024.
//

import UIKit

protocol TransitionHandler: AnyObject {
    func pushModule(with viewController: UIViewController, animated: Bool)
    func back()
}

extension UIViewController: TransitionHandler {
    func pushModule(with viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func back() {
        guard let navigationController else {
            dismiss(animated: true)
            return
        }

        if navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {
            navigationController.dismiss(animated: true)
        }
    }
}

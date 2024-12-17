//
//  MainViewController.swift
//  Homework-2-4-Colors
//
//  Created by Алексей Журкин on 17.12.2024.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func didSelectColor(_ color: UIColor)
}

final class MainViewController: UIViewController {
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.mainColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func didSelectColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}


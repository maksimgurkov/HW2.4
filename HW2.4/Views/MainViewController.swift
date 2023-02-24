//
//  MainViewController.swift
//  HW2.4
//
//  Created by Максим Гурков on 24.02.2023.
//

import UIKit

class MainViewController: UIViewController {

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SetupColorViewController else { return }
        settingVC.color = view.backgroundColor
        settingVC.delegate = self
    }
    

}

extension MainViewController: SetupViewProtocol {
    func setup(color: UIColor) {
        view.backgroundColor = color
    }
    
    
}

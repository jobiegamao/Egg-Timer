//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
         super.viewDidLoad()
    }
    
    @IBAction func eggButtonTapped(_ sender: UIButton) {
        if let buttonText = sender.currentTitle,
            let eggButtonTapped = Egg(rawValue: buttonText) {
    
            let vc = storyboard?.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
            vc.eggButtonTapped = eggButtonTapped
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
}

enum Egg: String {
    case Soft
    case Medium
    case Hard
    
    var timer: Int {
        switch self {
        case .Soft:
            return 5
        case .Medium:
            return 8
        case .Hard:
            return 12
        }
    }
}

//
//  ViewController.swift
//  Three Buttons
//
//  Created by Владимир on 05.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let buttonTitles = ["Short", "MediumBtn", "Loong Button"]
    
    lazy var buttons = buttonTitles.map { title in
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.setImage(UIImage(systemName: "swift"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonReleased(_:)), for: .touchUpInside)
        
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        buttonConfiguration.imagePadding = 8
        buttonConfiguration.imagePlacement = .trailing
        button.configuration = buttonConfiguration
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons(buttons)
    }
    
    func setupButtons(_ buttons: [UIButton]) {
        var previousButton: UIButton?
        
        buttons.forEach { button in
            view.addSubview(button)
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            if let previousButton = previousButton {
                button.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 20).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            }
            
            previousButton = button
        }
    }
    
    func animateButton(_ button: UIButton, isPressed: Bool) {
        let animationDuration: TimeInterval = 0.2
        let scaleFactor: CGFloat = isPressed ? 0.9 : 1.0
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            button.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        }, completion: nil)
    }
    
    @objc func buttonReleased(_ sender: UIButton) {
        animateButton(sender, isPressed: false)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        animateButton(sender, isPressed: true)
        guard sender == buttons.last else { return }
        buttons.forEach { button in 
            button.backgroundColor = .systemGray
        }
        let modalViewController = UIViewController()
        modalViewController.modalPresentationStyle = .formSheet
        modalViewController.presentationController?.delegate = self
        modalViewController.view.backgroundColor = .white
        present(modalViewController, animated: true)
    }
}

extension ViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        buttons.forEach { button in
            button.backgroundColor = .systemGreen
        }
    }
}

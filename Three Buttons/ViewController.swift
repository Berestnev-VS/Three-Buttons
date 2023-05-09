//
//  ViewController.swift
//  Three Buttons
//
//  Created by Владимир on 05.05.2023.
//

import UIKit

class Button: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setImage(.init(systemName: "bird.flll")?.withRenderingMode(.alwaysTemplate), for: .normal)
        setImage(.init(systemName: "bird.flll")?.withRenderingMode(.alwaysTemplate), for: .highlighted)
        
        tintColorDidChange()
        
        layer.cornerRadius = 12
        layer.cornerCurve = .continuous        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.beginFromCurrentState, .allowUserInteraction]) { 
                self.transform = self.isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity 
            }
        }
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        if tintAdjustmentMode == .dimmed {
            self.imageView?.tintColor = .systemGray3
            self.setTitleColor(.systemGray3, for: .normal)
            self.backgroundColor = .systemGray2
        } else {
            self.imageView?.tintColor = .white
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = .systemGreen
        }
    }
}

class ViewController: UIViewController {
    
    let buttonTitles = ["First Button", "Second Button", "Third Button"]
    
    lazy var buttons = buttonTitles.map { title in
        let button = Button(title: title)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit() // Чтобы размер зависел от контента. Работает и без него  
        button.setImage(UIImage(systemName: "bird.fill"), for: .normal) 
        button.setImage(UIImage(systemName: "bird.fill"), for: .highlighted)
        
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        buttonConfiguration.imagePadding = 8
        button.tintColor = .white
        buttonConfiguration.imagePlacement = .trailing
        button.configuration = buttonConfiguration
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons(buttons)
        buttons.last?.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchDown)
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
    
    
//    func animateButton(_ button: UIButton, isPressed: Bool) {
//        let animationDuration: TimeInterval = 0.2
//        let scaleFactor: CGFloat = isPressed ? 0.9 : 1.0
//        
//        UIView.animate(withDuration: animationDuration, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
//            button.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
//        }, completion: nil)
//    }
//    
//    @objc func buttonReleased(_ sender: UIButton) {
//        animateButton(sender, isPressed: false)
//    }
    
    @objc func buttonTapped(_ sender: UIButton) {
//        animateButton(sender, isPressed: true)
        let modalViewController = UIViewController()
        modalViewController.modalPresentationStyle = .formSheet
        modalViewController.view.backgroundColor = .white
        present(modalViewController, animated: true)
    }
}



//
//  ViewController.swift
//  Playground-UIKit
//
//  Created by Takahiro Toya on 20/9/2024.
//
import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = DetailsViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
}


class DetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test!"
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let button = createSNPButtonForToolbar(title: "Button")
        setSNPToolbar(with: button)
    }
    
    func createSNPButtonForToolbar(title: String) -> UIButton {
        let interfaceIdiom = view.traitCollection.userInterfaceIdiom
        let height: CGFloat = interfaceIdiom == .phone ? 48 : 54
        let padding: CGFloat = interfaceIdiom == .phone ? 40 : 100
        let buttonFrameWidth = self.view.frame.width - padding
        
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle(title, for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = interfaceIdiom == .phone ? UIFont.boldSystemFont(ofSize:20) : UIFont.boldSystemFont(ofSize:20)
        button.titleLabel?.textColor = .white
        button.frame = CGRect(x: 0, y: 0, width: buttonFrameWidth, height: height)
        return button
    }
    
    func setSNPToolbar(with button: UIButton, width: CGFloat? = nil) {
        let buttonFrameWidth = width ?? self.view.frame.width - 40
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.width = buttonFrameWidth
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.setToolbarItems([flexibleSpace, barButtonItem, flexibleSpace], animated: false)
    }
}

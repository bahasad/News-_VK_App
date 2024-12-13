//
//  StartVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/13/24.
//


import UIKit





class StartVC: UIViewController {
    
    
    let viewBuilder = ViewBuilder()
    
    private lazy var loginButton = viewBuilder.button(title: "Войти", titleColor: .white, backgroundColor: .black, cornerRadius: 20,  action: #selector(loginButtonTapped),target: self)
    
    private lazy var loggingImage: UIImageView = {
        $0.image = UIImage(named: "startBackground")
        $0.contentMode = .scaleAspectFill
        $0.frame = view.bounds
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return $0
    }(UIImageView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [loginButton, loggingImage ].forEach {
            view.addSubview($0)
        }
        setupUI()
        view.bringSubviewToFront(loginButton)
    }
    
    
    @objc func loginButtonTapped() {
        let vc = AuthModuleBuilder.build()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -86),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
    
    
    
}




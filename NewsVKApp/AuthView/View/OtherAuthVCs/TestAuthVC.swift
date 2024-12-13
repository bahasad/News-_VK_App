//
//  TestAuthVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/10/24.
//
//import VKID_VKIDCore
import UIKit

class TestAuthVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("TestAuthVC viewDidLoad: Initialized")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("TestAuthVC viewDidAppear: View is now in the window hierarchy")
        let loginVC = VKAuthVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true) {
            print("TestAuthVC: Presented VKLoginViewController")
        }
    }
}


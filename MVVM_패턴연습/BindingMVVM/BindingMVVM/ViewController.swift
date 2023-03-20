//
//  ViewController.swift
//  BindingMVVM
//
//  Created by mun on 2023/03/16.
//

import UIKit

class ViewController: UIViewController {

    private var loginViewModel = LoginViewModel()
    
    private unowned var userNameTextField: BindingTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel.userName.bind(callBack: { [unowned self] text in
            self.userNameTextField.text = text
        })
        setUpUI()
    }

    private func setUpUI() {
        let userNameTextField = BindingTextField()
        userNameTextField.placeholder = "Enter username"
        userNameTextField.backgroundColor = .lightGray
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.bind(callBack: { [unowned self] in
            self.loginViewModel.userName.value = $0
        })
        self.userNameTextField = userNameTextField
        
        let passwordTextField = BindingTextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Enter password"
        passwordTextField.backgroundColor = .lightGray
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.bind(callBack: { [unowned self] in
            self.loginViewModel.password.value = $0
        })
        
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .gray
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        let fetchLoginInfoButton = UIButton()
        fetchLoginInfoButton.setTitle("Fetch Login Info", for: .normal)
        fetchLoginInfoButton.backgroundColor = .blue
        fetchLoginInfoButton.addTarget(self, action: #selector(fetchLoginInfo),
                                       for: .touchUpInside)
        let stackView = UIStackView(arrangedSubviews: [userNameTextField,
                                                       passwordTextField,
                                                       loginButton,
                                                       fetchLoginInfoButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        self.view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    @objc
    private func login() {
        print(self.loginViewModel.userName.value+"/"+self.loginViewModel.password.value)
    }
    
    @objc
    private func fetchLoginInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [weak self] in
            self?.loginViewModel.userName.value = "MaryDoe"
        })
    }
}


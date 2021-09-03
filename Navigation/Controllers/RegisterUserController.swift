//
//  RegisterUserController.swift
//  Navigation
//
//  Created by Misha on 01.09.2021.
//

import Foundation
import UIKit
import Firebase

class RegisterUserController: UIViewController {
    
    private var emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Email"
        emailTextField.leftViewMode = .always
        return emailTextField
    }()
    
    private var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.leftViewMode = .always
        return passwordTextField
    }()
    
    private var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.layer.borderColor = UIColor.white.cgColor
        userNameTextField.layer.cornerRadius = 10
        userNameTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "Name"
        userNameTextField.leftViewMode = .always
        return userNameTextField
    }()
    
    private lazy var signUpButton: CustomButton = {
        let button = CustomButton(title: "Sign Up", titleColor: .black ) {
            //self.generatePassword(passwordLength: 10)
        }
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func registerUser() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let userName = userNameTextField.text else { return }
                
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                print(error.localizedDescription)
            return
            }
            print("Successfully logged")
        }
        
        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
            changeRequest.displayName = userName
            changeRequest.commitChanges { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                print("User display name changed")
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(userNameTextField)
        
        let constraints = [
            
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            emailTextField.heightAnchor.constraint(equalToConstant: 50.0),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
            
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userNameTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50.0),
            
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            signUpButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            signUpButton.heightAnchor.constraint(equalToConstant: 50.0),
            
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
}

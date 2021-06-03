//
//  Header.swift
//  Navigation
//
//  Created by Misha on 31.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

//class Header: UIView {
//
//    private var statusText: String?
//    
//    @IBOutlet weak var userName: UILabel! {
//        didSet {
//        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        userName.textAlignment = .center
//        userName.text = "Ice Cream"
//        userName.textColor = .black
//        }
//    }
//    
//    @IBOutlet weak var currentStatus: UILabel! {
//        didSet {
//        currentStatus.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        currentStatus.text = "Waiting for something..."
//        currentStatus.textColor = .gray
//        currentStatus.textAlignment = .center
//        }
//    }
//    
//    @IBOutlet weak var newStatus: UITextField! {
//        didSet {
//        newStatus.layer.borderWidth = 1
//        newStatus.layer.borderColor = UIColor.black.cgColor
//        newStatus.backgroundColor = .white
//        newStatus.layer.cornerRadius = 12
//        newStatus.addTarget(self, action: #selector(statusTextChange), for: .editingChanged)
//        newStatus.leftViewMode = .always
//        }
//    }
//    
//    @IBOutlet weak var actionButton: UIButton! {
//        didSet {
//         actionButton.layer.shadowRadius = 4
//         actionButton.layer.shadowColor = UIColor.black.cgColor
//         actionButton.layer.shadowOffset = CGSize(width: 4, height: 4)
//         actionButton.layer.shadowOpacity = 0.7
//         actionButton.layer.cornerRadius = 4
//         actionButton.clipsToBounds = false
//         actionButton.backgroundColor = .systemBlue
//         actionButton.setTitleColor(.white, for: .normal)
//         actionButton.setTitle("Show status", for: .normal)
//        
//        actionButton.addTarget(self, action: #selector(self.actionButtonPressed), for: .touchUpInside)
//        
//        }
//    }
//    
//    @IBOutlet weak var avatar: UIImageView! {
//        didSet {
//         avatar.contentMode = .scaleAspectFill
//         avatar.image = #imageLiteral(resourceName: "эко-мороженое 1")
//         avatar.layer.borderWidth = 3
//         avatar.layer.borderColor = UIColor.white.cgColor
//         avatar.clipsToBounds = true
//         avatar.layer.cornerRadius = avatar.frame.height / 2
//        }
//    }
//
//    @objc private func statusTextChange(_ newStatus: UITextField) {
//        statusText = String(newStatus.text!)
//        print(statusText ?? " ")
//    
//    }
//    @objc private func actionButtonPressed() {
//        currentStatus.text = statusText
//        print(currentStatus.text ?? "no status")
//    }
//    
//}



//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Misha on 13.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private var statusText: String?
    
    //MARK: Create elements
    private let spaceView: UIView = {
        let spaceView = UIView()
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        return spaceView
        }()
    
    private let userName: UILabel = {
        let userName = UILabel()
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        userName.text = "Ice Cream"
        userName.textAlignment = .center
        userName.textColor = .black
        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
        }()
    
    private let newStatus: UITextField = {
        let newStatus = UITextField()
        newStatus.layer.borderWidth = 1
        newStatus.layer.borderColor = UIColor.black.cgColor
        newStatus.backgroundColor = .white
        newStatus.layer.cornerRadius = 12
        newStatus.addTarget(self, action: #selector(statusTextChange), for: .editingChanged)
        newStatus.leftViewMode = .always
        newStatus.translatesAutoresizingMaskIntoConstraints = false
        return newStatus
        }()
    
    private let currentStatus: UILabel = {
        let currentStatus = UILabel()
        currentStatus.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        currentStatus.text = "Waiting for something..."
        currentStatus.textColor = .gray
        currentStatus.textAlignment = .center
        currentStatus.translatesAutoresizingMaskIntoConstraints = false
        return currentStatus
        }()
    
    private let actionButton: UIButton = {
     let actionButton = UIButton()
     actionButton.layer.shadowRadius = 4
     actionButton.layer.shadowColor = UIColor.black.cgColor
     actionButton.layer.shadowOffset = CGSize(width: 4, height: 4)
     actionButton.layer.shadowOpacity = 0.7
     actionButton.layer.cornerRadius = 4
     actionButton.clipsToBounds = false
     actionButton.backgroundColor = .systemBlue
     actionButton.setTitleColor(.white, for: .normal)
     actionButton.setTitle("Show status", for: .normal)
     actionButton.translatesAutoresizingMaskIntoConstraints = false
     actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    return actionButton
    }()
        
    //MARK: Create Actions
    @objc private func actionButtonPressed() {
        currentStatus.text = statusText
        print(currentStatus.text ?? "no status")
    }
    
    @objc private func statusTextChange(_ newStatus: UITextField) {
           statusText = String(newStatus.text!)
           print(statusText ?? " ")
    }
    
    //MARK: Initials for reusable raws
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
    //MARK: Setup Gesture
        //let tap1 = UITapGestureRecognizer(target: self, action: #selector(tap))
        //avatar.isUserInteractionEnabled = true
        //avatar.addGestureRecognizer(tap1)
        //self.contentView.bringSubviewToFront(avatar)
        
        //let stopAnimationTap = UITapGestureRecognizer(target: self, action: #selector(tapToClose))
        //closeButton.isUserInteractionEnabled = true
        //closeButton.addGestureRecognizer(stopAnimationTap)
    }
    
    @objc func tap() {
        //animate()
        //animateKeyFrame()
        //animateBasicAnimation()
        //()
        print("tapHeader")
    }
    
    @objc func tapToClose() {
        closeAnimate()
    }
    
    func closeAnimate() {
        
//        let closeAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
                //let changeConstraintsPosition = [
                    //self.avatar.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -270),
                    //]
                    //NSLayoutConstraint.activate(changeConstraintsPosition)
                    //self.avatar.transform = self.avatar.transform.translatedBy(x: 16, y: -200)
                    
//                    self.avatar.layer.cornerRadius = 100 / 2
//                    self.avatar.clipsToBounds = true
//                    self.avatar.layer.borderWidth = 3
            
                    //self.closeButton.isHidden = true
            
                    //self.greyViewForAction.backgroundColor = UIColor.init(white: 1, alpha: 0)
//            }
//            closeAnimator.startAnimation()
//    }
   
//    func animateAnimator() {
//        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
//            let changeConstraintsPosition = [
//                self.closeButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
//                self.closeButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -10),
//                ]
//                NSLayoutConstraint.activate(changeConstraintsPosition)
//            
//                self.closeButton.translatesAutoresizingMaskIntoConstraints = false
//                self.closeButton.isHidden = false
//            
//
                
//                self.greyViewForAction.translatesAutoresizingMaskIntoConstraints = false
//                self.greyViewForAction.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
//        }
//        animator.startAnimation()
    }
    
    //MARK: Add subviews
    fileprivate func setupViews() {
        contentView.addSubview(userName)
        contentView.addSubview(newStatus)
        contentView.addSubview(currentStatus)
        contentView.addSubview(actionButton)
        
        newStatus.leftView = spaceView
        contentView.addSubview(spaceView)
        
    //MARK: Setup constraints
    let constraints = [
                userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
                userName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                userName.heightAnchor.constraint(equalToConstant: 40),
                
                currentStatus.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 20),
                currentStatus.leadingAnchor.constraint(equalTo: userName.leadingAnchor, constant: 0),
                
                newStatus.topAnchor.constraint(equalTo: currentStatus.bottomAnchor, constant: 20),
                newStatus.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
                newStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                newStatus.heightAnchor.constraint(equalToConstant: 40),
                
                spaceView.topAnchor.constraint(equalTo: newStatus.topAnchor),
                spaceView.leadingAnchor.constraint(equalTo: newStatus.leadingAnchor, constant: 10),
                spaceView.widthAnchor.constraint(equalToConstant: 20),
                spaceView.bottomAnchor.constraint(equalTo: newStatus.bottomAnchor),
                
                actionButton.topAnchor.constraint(equalTo: newStatus.bottomAnchor, constant: 20),
                //actionButton.centerXAnchor.constraint(equalTo: userName.centerXAnchor),
                actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                //actionButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                //actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ]
            NSLayoutConstraint.activate(constraints)
        }
}
 


//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Misha on 13.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private var statusText: String?
    
    //MARK: Create elements
    private let spaceView: UIView = {
        let spaceView = UIView()
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        return spaceView
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
    
    private let actionButton: CustomButton = {
        let button = CustomButton(title: "Обновить статус", titleColor: .green) {
            print("change status")
        }
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.cornerRadius = 4
        button.clipsToBounds = false
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        return button
        }()
        
    //MARK: Create Actions
    @objc private func actionButtonPressed() {
//        currentStatus.text = statusText
//        print(currentStatus.text ?? "no status")
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
    
    //MARK: Add subviews
    fileprivate func setupViews() {
        contentView.addSubview(newStatus)

        contentView.addSubview(actionButton)
        
        newStatus.leftView = spaceView
        contentView.addSubview(spaceView)
        
    //MARK: Setup constraints
        
        newStatus.snp.makeConstraints { make in
            make.bottom.equalTo(actionButton.snp.top).offset(-20)
            make.left.equalToSuperview().offset(200)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
            
        spaceView.snp.makeConstraints { make in
            make.top.equalTo(newStatus.snp.top)
            make.left.equalTo(newStatus.snp.left).offset(10)
            make.width.equalTo(20)
            make.bottom.equalTo(newStatus.snp.bottom)
        }
        
        actionButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-16)
        }
            
}
 
}

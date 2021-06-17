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
        //currentStatus.text = statusText
        //print(currentStatus.text ?? "no status")
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

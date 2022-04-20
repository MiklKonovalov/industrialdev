//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Misha on 22.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: -Properties
    
    var user: User
    
    let viewModel = CheckModel()
    
    let currentStatusLabel: UILabel = {
        let currentStatus = UILabel()
        currentStatus.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        currentStatus.text = "Waiting for something..."
        currentStatus.textColor = UIColor.appColor(.titlecolor)
        currentStatus.textAlignment = .center
        currentStatus.translatesAutoresizingMaskIntoConstraints = false
        return currentStatus
        }()
    
    let userNameLabel: UILabel = {
        let userName = UILabel()
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        userName.text = "Ice Cream"
        userName.textAlignment = .center
        userName.textColor = UIColor.appColor(.titlecolor)
        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
        }()
    
    lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFill
        avatar.image = UIImage(named: "эко-мороженое 1")
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.isUserInteractionEnabled = true
        return avatar
    }()
    
    var greyViewForAction: UIView = {
        var greyViewForAction = UIView()
        greyViewForAction.translatesAutoresizingMaskIntoConstraints = false
        return greyViewForAction
        }()
    
    let closeButton: UIButton = {
        let closeButton = UIButton(type: .close)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.isHidden = true
        closeButton.alpha = 0.0
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return closeButton
    }()
    
    var howToConstraint = [NSLayoutConstraint]()
    var howToConstraintActivate = [NSLayoutConstraint]()
    var deactivateAnimation = [NSLayoutConstraint]()
    var buttonAnimation = [NSLayoutConstraint]()
    
    var header = ProfileTableHeaderView()
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    let reuseId = "cellid"
    let collectionId = "cellidTwo"

    //MARK: -Inicialization
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
        
    //Создаём инициализатор, который будет принимать userService и userName
    //init(userService: UserService, userName: String) {
        //self.userService = userService
        //self.userName = userName
        //Получаем именно того пользователя, имя которого мы передаём в инициализаторе (получаем объект пользователя)
        //self.userService.getUser(userName: self.userName)

        //super.init(nibName: nil, bundle: nil)
    //}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Selectors
    
    @objc private func closeButtonPressed() {
        closeAnimate()
        closeButtonAnimation()
    }
    
    @objc func tap() {
        animateAnimatorVC()
        animateButtonAnimatorVC()
    }
    
    //MARK: -Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setupTableView()
        
        avatar.layer.cornerRadius = 100 / 2
        avatar.clipsToBounds = true
        
        self.view.bringSubviewToFront(avatar)
        
        //let user = userService.getUser(userName: userName)
        avatar.image = user.avatar
        userNameLabel.text = user.name
        currentStatusLabel.text = user.status
        
        tableView.backgroundColor = .systemBackground
        
        //MARK: Setup constraints
        let avatarTopAnchor =
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        let avatarLeadingAnchor = avatar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
            
        let avatarHeight = avatar.heightAnchor.constraint(equalToConstant: 100)
        let avatarWidth =  avatar.widthAnchor.constraint(equalToConstant: 100)
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        currentStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(20)
            make.left.equalTo(userNameLabel.snp.left).offset(0)
        }
        
        howToConstraint.append(avatarTopAnchor)
        howToConstraint.append(avatarLeadingAnchor)
        howToConstraint.append(avatarHeight)
        howToConstraint.append(avatarWidth)
        
        NSLayoutConstraint.activate(howToConstraint)
        
        //MARK: Setup Animate constraints
        let greyViewForActionTopAnchor = greyViewForAction.topAnchor.constraint(equalTo: view.topAnchor)
        let greyViewForActionLeadingAnchor = greyViewForAction.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let greyViewForActionBottomAnchor = greyViewForAction.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let greyViewForActionTrailingAnchor = greyViewForAction.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        let avatarNewTopPosition = avatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        let avatarNewCenterPosition = avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let avatarNewWidthPosition = avatar.widthAnchor.constraint(equalTo: view.widthAnchor)
        let avatarNewHeighPosition = avatar.heightAnchor.constraint(equalTo: view.widthAnchor)
        
        howToConstraintActivate.append(greyViewForActionTopAnchor)
        howToConstraintActivate.append(greyViewForActionLeadingAnchor)
        howToConstraintActivate.append(greyViewForActionBottomAnchor)
        howToConstraintActivate.append(greyViewForActionTrailingAnchor)
        
        howToConstraintActivate.append(avatarNewTopPosition)
        howToConstraintActivate.append(avatarNewCenterPosition)
        howToConstraintActivate.append(avatarNewWidthPosition)
        howToConstraintActivate.append(avatarNewHeighPosition)
        
        //MARK: Setup Button Animation
        let closeButtonTop = closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        let closeButtonTrailing = closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        
        buttonAnimation.append(closeButtonTop)
        buttonAnimation.append(closeButtonTrailing)
        
        //MARK: Setup Return Animation constraints
        let returnAvatarPosition = self.avatar.topAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 16)
        
        deactivateAnimation.append(returnAvatarPosition)
    }
    
    //MARK: Setup table
    private func setupTableView() {
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileTableHeaderView.self)) //регистрируем хедер
        tableView.register(FlowTableViewCell.self, forCellReuseIdentifier: reuseId) //регистрируем секцию из 4 ячеек
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: collectionId) //регистрируем секцию из одной ячейки с 4 фотографиями
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        view.addSubview(avatar)
        view.addSubview(greyViewForAction)
        view.addSubview(closeButton)
        view.addSubview(userNameLabel)
        view.addSubview(currentStatusLabel)
        
        let tapVC = UITapGestureRecognizer(target: self, action: #selector(tap))
        avatar.addGestureRecognizer(tapVC)
        
        let constraintsTableView = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraintsTableView)
    }
    
    //MARK: Setup animation
    func animateAnimatorVC() {
        NSLayoutConstraint.activate(self.howToConstraintActivate)
        NSLayoutConstraint.deactivate(self.howToConstraint)
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
                
                self.greyViewForAction.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
            
                self.avatar.layer.borderWidth = 0
                self.avatar.layer.cornerRadius = 0
                self.avatar.clipsToBounds = false
            
                self.view.layoutIfNeeded()
        }
        animator.startAnimation()
    }
    
    //MARK: Setup button animation
    func animateButtonAnimatorVC() {
        NSLayoutConstraint.activate(buttonAnimation)
        self.closeButton.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0.8, options: [
            .beginFromCurrentState,
            ], animations: {
                    self.closeButton.alpha = 3.0
                    self.view.layoutIfNeeded()
                }, completion: nil)
        
    }
    
    //MARK: Close button animation
    func closeButtonAnimation() {
        NSLayoutConstraint.deactivate(buttonAnimation)
        self.closeButton.isHidden = false
        UIView.animate(withDuration: 0, delay: 0, options: [

            ], animations: {
                    self.closeButton.alpha = 0.0
                    self.view.layoutIfNeeded()
                }, completion: nil)
        
    }
    
    //MARK: Close animation
    func closeAnimate() {
        NSLayoutConstraint.activate(self.deactivateAnimation)
        NSLayoutConstraint.activate(self.howToConstraint)
        NSLayoutConstraint.deactivate(self.howToConstraintActivate)
        UIView.animate(withDuration: 0.3, delay: 0.1, options: [

        ], animations: {
                    self.avatar.layer.cornerRadius = 100 / 2
                    self.avatar.clipsToBounds = true
                    self.avatar.layer.borderWidth = 3
            
                    self.greyViewForAction.backgroundColor = UIColor.init(white: 1, alpha: 0)
            
                    self.view.layoutIfNeeded()
            }, completion: nil)
    }
}

//MARK: DataSource

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 //возвращаем количество секций у TableView
        
    }
    //задаём количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // если секция 0, то 1 ячейка
        } else {
            return Flow.sections.fasting.count // в другом случае, показываем количество ячеек, раное количеству объектов в fasting
        }
    }
    
    //создаём ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: collectionId, for: indexPath) as? PhotosTableViewCell else {
            return UITableViewCell()
            }
            cell.images = Flow.photos.imageArray[indexPath.row]
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: collectionId, for: indexPath) as? FlowTableViewCell else {
            return UITableViewCell()
            }
            cell.fasting = Flow.sections.fasting[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: collectionId, for: indexPath)
//        if indexPath.section == 0 {
//            let collection = Flow.photos.imageArray[indexPath.row]
//            (cell as! PhotosTableViewCell).images = collection
//            return cell
//        }
//        let cellTwo = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
//        if indexPath.section == 1 {
//            let posts = Flow.sections.fasting[indexPath.row]
//            (cellTwo as! FlowTableViewCell).fasting = posts
//            return cellTwo
//        }
//
//            return cell
        }
    //MARK: pushViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photosViewController = PhotosViewController()
        
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
    //MARK: - Возвращаем UIView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileTableHeaderView.self)) as? ProfileTableHeaderView else { return nil }
    
        return (section == 0) ? headerView : nil
    }
        
    //MARK: -
}
//MARK: Delegate (для создания высоты)

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0) ? 230 : 5
    }
    
}




//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Misha on 22.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //Зависимость: В классе ProfileViewController добавить свойство с типом UserService и инициализатор, который принимает объект UserService и имя пользователя, введённое на экране LogInViewController. При инициализации объекта ProfileViewController передать объект CurrentUserService.
    //var userService: UserService
    
    //var userName: String
      
    var user: User
    
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
    
    var howToConstraint = [NSLayoutConstraint]()
    var howToConstraintActivate = [NSLayoutConstraint]()
    var deactivateAnimation = [NSLayoutConstraint]()
    var buttonAnimation = [NSLayoutConstraint]()
    
    var header = ProfileTableHeaderView()
    
    //MARK: -Create subview's for animation
    let currentStatusLabel: UILabel = {
        let currentStatus = UILabel()
        currentStatus.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        currentStatus.text = "Waiting for something..."
        currentStatus.textColor = .gray
        currentStatus.textAlignment = .center
        currentStatus.translatesAutoresizingMaskIntoConstraints = false
        return currentStatus
        }()
    
    let userNameLabel: UILabel = {
        let userName = UILabel()
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        userName.text = "Ice Cream"
        userName.textAlignment = .center
        userName.textColor = .black
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

    @objc private func closeButtonPressed() {
        closeAnimate()
        closeButtonAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let reuseId = "cellid"
    private let collectionId = "cellidTwo"
    
    //MARK: viewDidLoad
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
        
        
        //MARK: Setup constraints
        var avatarTopAnchor =
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        var avatarLeadingAnchor = avatar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
            
        var avatarHeight = avatar.heightAnchor.constraint(equalToConstant: 100)
        var avatarWidth =  avatar.widthAnchor.constraint(equalToConstant: 100)
        
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
        var greyViewForActionTopAnchor = greyViewForAction.topAnchor.constraint(equalTo: view.topAnchor)
        var greyViewForActionLeadingAnchor = greyViewForAction.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        var greyViewForActionBottomAnchor = greyViewForAction.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        var greyViewForActionTrailingAnchor = greyViewForAction.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        var avatarNewTopPosition = avatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        var avatarNewCenterPosition = avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        var avatarNewWidthPosition = avatar.widthAnchor.constraint(equalTo: view.widthAnchor)
        var avatarNewHeighPosition = avatar.heightAnchor.constraint(equalTo: view.widthAnchor)
        
        howToConstraintActivate.append(greyViewForActionTopAnchor)
        howToConstraintActivate.append(greyViewForActionLeadingAnchor)
        howToConstraintActivate.append(greyViewForActionBottomAnchor)
        howToConstraintActivate.append(greyViewForActionTrailingAnchor)
        
        howToConstraintActivate.append(avatarNewTopPosition)
        howToConstraintActivate.append(avatarNewCenterPosition)
        howToConstraintActivate.append(avatarNewWidthPosition)
        howToConstraintActivate.append(avatarNewHeighPosition)
        
        //MARK: Setup Button Animation
        var closeButtonTop = closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        var closeButtonTrailing = closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        
        buttonAnimation.append(closeButtonTop)
        buttonAnimation.append(closeButtonTrailing)
        
        //MARK: Setup Return Animation constraints
        var returnAvatarPosition = self.avatar.topAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 16)
        
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
    //MARK: Tap
    @objc func tap() {
        animateAnimatorVC()
        animateButtonAnimatorVC()
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

//MARK: Создаём 'ColorSet' используя Hex-code
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                        self.init(red: r, green: g, blue: b, alpha: a)
                        return
                }
            }
        }

        return nil
    }
}

    let color = UIColor(hex: "#4885CC")

    //MARK: DataSource
    extension ProfileViewController: UITableViewDataSource {

    //реализуем протокол dataSource
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: collectionId, for: indexPath)
        if indexPath.section == 0 {
            let collection = Flow.photos.imageArray[indexPath.row]
            (cell as! PhotosTableViewCell).images = collection
            //cell.accessoryType = .disclosureIndicator
            return cell
        }
        let cellTwo = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        if indexPath.section == 1 {
            let posts = Flow.sections.fasting[indexPath.row]
            (cellTwo as! FlowTableViewCell).fasting = posts
            return cellTwo
        }

            return cell
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




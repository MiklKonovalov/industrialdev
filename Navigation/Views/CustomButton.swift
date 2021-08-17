//
//  CustomButton.swift
//  Navigation
//
//  Created by Misha on 14.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

//1. Создайте собственный класс CustomButton, название на ваше усмотрение, где:
class CustomButton: UIButton {
    
    //1.1 будет собственный инициализатор, в который передаются, к примеру, параметры title, titleColor и другие по желанию
//    var title: String
//    var titleColor: UIColor
    //1.2 замыкание, в котором вызывающий объект, контроллер или родительское UIView, определят действие по нажатию кнопки
    var onTap: (() -> Void)?
    
    init(title: String, titleColor: UIColor, onTap: (() -> Void)?) {
        self.onTap = onTap
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //@objc private func buttonTapped() будет спрятана внутрь реализации CustomButton, и на уровне родительского UIView фигурировать не будет
    @objc private func tapped() {
        onTap?()
    }
    
}

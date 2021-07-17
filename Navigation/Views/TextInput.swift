//
//  TextInput.swift
//  Navigation
//
//  Created by Misha on 15.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class TextInput: UITextField {
    
    var onText: ((String) -> Void)?
    
    init(onText: ((String) -> Void)?) {
        self.onText = onText
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(textPrinted), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Вью создаёт экшн для контроллера
    @objc private func textPrinted() {
        guard let text = text, !text.isEmpty else { return }
        onText?(text)
    }
    
}

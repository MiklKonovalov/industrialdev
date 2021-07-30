//
//  NextController.swift
//  Navigation
//
//  Created by Misha on 26.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class NextController: UIViewController {
    
    private var viewModel: NextViewOutput
    
    // можем принимать и отправлять любые данные
    // но контроллер ничего не знает о navigationController, он только устанавливает название и цвет
    init(viewModel: NextViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.moduleTitle
        view.backgroundColor = .magenta
    }
    
}

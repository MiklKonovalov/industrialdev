//
//  NextViewModel.swift
//  Navigation
//
//  Created by Misha on 26.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol NextViewOutput {
    
    var moduleTitle: String { get }
}

final class NextViewModel: NextViewOutput {
    
    var moduleTitle: String {
        return "NEXT MODULE"
    }
    
    
}

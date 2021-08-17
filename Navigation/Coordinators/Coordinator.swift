//
//  Coordinator.swift
//  Navigation
//
//  Created by Misha on 25.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
}

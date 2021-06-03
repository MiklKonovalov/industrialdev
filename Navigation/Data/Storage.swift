//
//  Storage.swift
//  Navigation
//
//  Created by Misha on 10.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

struct Fasting {
    var autor: String
    var description: String
    var image: UIImage
    var numberOfLikes: Int
    var numberOfviews: Int
}

struct FastingSections {
    var fasting: [Fasting]
}

struct Images {
    var image: UIImage
    var secondImage: UIImage
    var thirdImage: UIImage
    var fourthImage: UIImage
    var title: String
    var arrow: String
}

struct PhotosSection {
    var imageArray: [Images]
}

struct Flow {
    
    static let sections = FastingSections(
            fasting: [
                Fasting(autor: "Gustav", description: "Today i did eat this", image: UIImage(named: "эко-мороженое 1")!, numberOfLikes: 100, numberOfviews: 100),
                Fasting(autor: "Dasha", description: "I love this watch", image: UIImage(named: "часы")!, numberOfLikes: 200, numberOfviews: 200),
                Fasting(autor: "Misha", description: "Playing rugby with my friends", image: UIImage(named: "регби")!, numberOfLikes: 300, numberOfviews: 300),
                Fasting(autor: "Nikita", description: "Soon...", image: UIImage(named: "cosmos")!, numberOfLikes: 400, numberOfviews: 400),
                    ]
                    )

    static let photos = PhotosSection(
            imageArray: [
                Images(image: UIImage(named: "регби")!, secondImage: UIImage(named: "cosmos")!, thirdImage: UIImage(named: "эко-мороженое 1")!, fourthImage: UIImage(named: "часы")!, title: "Photos", arrow: "\u{2192}"),
                        ]
                        )
    }

struct RugbyPhotos {
    var rugbyImage: UIImage
}

struct SectionOfRugbyPhotos {
    var imageArrayOfRugbyPhotos: [RugbyPhotos]
}

struct RugbyFlow {
    static let rugbySections = SectionOfRugbyPhotos(
        imageArrayOfRugbyPhotos: [
            RugbyPhotos(rugbyImage: UIImage(named: "1")!),
            RugbyPhotos(rugbyImage: UIImage(named: "2")!),
            RugbyPhotos(rugbyImage: UIImage(named: "3")!),
            RugbyPhotos(rugbyImage: UIImage(named: "4")!),
            RugbyPhotos(rugbyImage: UIImage(named: "5")!),
            RugbyPhotos(rugbyImage: UIImage(named: "6")!),
            RugbyPhotos(rugbyImage: UIImage(named: "7")!),
            RugbyPhotos(rugbyImage: UIImage(named: "8")!),
            RugbyPhotos(rugbyImage: UIImage(named: "9")!),
            RugbyPhotos(rugbyImage: UIImage(named: "10")!),
            RugbyPhotos(rugbyImage: UIImage(named: "11")!),
            RugbyPhotos(rugbyImage: UIImage(named: "12")!),
            RugbyPhotos(rugbyImage: UIImage(named: "13")!),
            RugbyPhotos(rugbyImage: UIImage(named: "14")!),
            RugbyPhotos(rugbyImage: UIImage(named: "15")!),
            RugbyPhotos(rugbyImage: UIImage(named: "16")!),
            RugbyPhotos(rugbyImage: UIImage(named: "17")!),
            RugbyPhotos(rugbyImage: UIImage(named: "18")!),
            RugbyPhotos(rugbyImage: UIImage(named: "19")!),
            RugbyPhotos(rugbyImage: UIImage(named: "20")!),
    
    ]
    )
}


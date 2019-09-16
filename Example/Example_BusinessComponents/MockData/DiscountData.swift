//
//  ExampleViewController+DiscountBoxData.swift
//  MLBusinessComponents
//
//  Created by Esteban Adrian Boffa on 29/08/2019.
//  Copyright © 2019 Juan Sanzone. All rights reserved.
//

import UIKit
import MLBusinessComponents

class DiscountData: NSObject, MLBusinessDiscountBoxData {
    func getTitle() -> String? {
        return "200 descuentos"
    }

    func getSubtitle() -> String? {
        return "por ser nivel 3"
    }

    func getItems() -> [MLBusinessSingleItemProtocol] {
        var array: [MLBusinessSingleItemProtocol] = [MLBusinessSingleItemProtocol]()
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/McDonald%27s_Golden_Arches.svg/1200px-McDonald%27s_Golden_Arches.svg.png"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY0eFECzyTCa83gOV3smCYDOSIggdUxSPirwtt5rS3LcWlzefo"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://upload.wikimedia.org/wikipedia/commons/b/b3/Logo-freddo.jpg"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://urbancomunicacion.com/wp-content/uploads/2017/04/Logotipos-famosos-Starbucks-Urban-comunicacion-1.png"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://www.stickpng.com/assets/images/5a1c3211f65d84088faf13e8.png"))
        array.append(SingleItemData(title: "Hasta", subtitle: "$ 200", iconImageUrl: "https://pbs.twimg.com/profile_images/1124417403566395394/9Wuzg8pf.png"))
        return array
    }
}

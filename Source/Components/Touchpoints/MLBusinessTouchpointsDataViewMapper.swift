//
//  MLBusinessTouchpointsDataViewMapper.swift
//  MLBusinessComponents
//
//  Created by Gaston Maspero on 17/02/2021.
//

import Foundation

protocol MLBusinessTouchpointsDataViewMapperProtocol {
    func mapAdditionalInsets(from dictionary: [String : Any]?) -> UIEdgeInsets?
}

class MLBusinessTouchpointsDataViewMapper: MLBusinessTouchpointsDataViewMapperProtocol {
    func mapAdditionalInsets(from dictionary: [String : Any]?) -> UIEdgeInsets? {
        guard let dictionary = dictionary else { return nil }
        
        return UIEdgeInsets(top: getInset(from: dictionary, for: "top"),
                            left: getInset(from: dictionary, for: "left"),
                            bottom: getInset(from: dictionary, for: "bottom"),
                            right: getInset(from: dictionary, for: "right"))
    }
    
    private func getInset(from dictionary: [String : Any], for key: String) -> CGFloat {
        return CGFloat(truncating: dictionary[key] as? NSNumber ?? 0)
    }
}

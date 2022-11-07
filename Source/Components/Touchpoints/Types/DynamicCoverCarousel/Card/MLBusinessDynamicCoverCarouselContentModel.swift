//
//  MLBusinessDynamicCoverCarouselContentModel.swift
//  MLBusinessComponents
//
//  Created by Flavio Andres Gomez on 03/11/2022.
//

import Foundation

public struct MLBusinessDynamicCarouselContentModel: Codable {
    private let type: String
    private let content: String
    private let color: String
    private let background: String?
    private let compressible: Bool?
    
    public init(type: String,
                content: String,
                color: String,
                background: String?,
                compressible: Bool?) {
        
        self.type = type
        self.content = content
        self.color = color
        self.background = background
        self.compressible = compressible
    }
}


//public protocol BaseContentDynamicCarousel: Codable {
//    static var type: String { get }
//}
//
//public struct MLBussinessDynamicCarouselContentBadge: BaseContentDynamicCarousel {
//
//  public static var type: String { return "badge" }
//
//  public let background: String?
//}
//
//public struct MLBussinessDynamicCarouselContentText: BaseContentDynamicCarousel {
//
//  public static var type: String { return "text" }
//
//  public let compress: Bool?
//}
//
//public struct MLBusinessContentDynamicCarousel: Codable {
//
//    let value: BaseContentDynamicCarousel
//
//    public func encode(to encoder: Encoder) throws {
//        fatalError()
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case type
//    }
//
//    public init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        let type = try values.decode(String.self, forKey: CodingKeys.type)
//        switch type {
//        case MLBussinessDynamicCarouselContentBadge.type:
//            value = try! MLBussinessDynamicCarouselContentBadge(from: decoder)
//        case MLBussinessDynamicCarouselContentText.type:
//            value = try! MLBussinessDynamicCarouselContentText(from: decoder)
//        default:
//            fatalError()
//        }
//    }
//}

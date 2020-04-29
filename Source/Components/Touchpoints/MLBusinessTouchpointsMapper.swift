//
//  MLBusinessTouchpointsMapper.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 22/04/2020.
//

import Foundation

protocol MLBusinessTouchpointsMapperProtocol {
    func map(dictionary: MLBusinessCodableDictionary) -> Codable?
}

class MLBusinessTouchpointsMapper<Model: Codable>: MLBusinessTouchpointsMapperProtocol {
    func map(dictionary: MLBusinessCodableDictionary) -> Codable? {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let encodedContent = try encoder.encode(dictionary)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Model.self, from: encodedContent)
        } catch {
            // TODO: handle error
            return nil
        }
    }
}

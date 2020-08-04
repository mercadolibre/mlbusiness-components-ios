//
//  MLBusinessMapper.swift
//  MLBusinessComponents
//
//  Created by Vicente Veltri on 04/08/2020.
//

import Foundation

protocol MLBusinessMapperProtocol {
    func map(dictionary: MLBusinessCodableDictionary) -> Codable?
}

class MLBusinessMapper<Model: Codable>: MLBusinessMapperProtocol {
    func map(dictionary: MLBusinessCodableDictionary) -> Codable? {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let encodedContent = try encoder.encode(dictionary)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Model.self, from: encodedContent)
        } catch {
            return nil
        }
    }
}

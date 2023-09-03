//
//  GeoJSON.swift
//  Earthquakes-iOS
//
//  Created by Rodrigo Kroef Tarouco on 29/08/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation

struct GeoJSON: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case features
    }
    private enum FeatureCodingKeys: String, CodingKey {
        case properties
    }
    
    private(set) var quakes: [Quake] = []
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var featuresContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features)
        
        while !featuresContainer.isAtEnd {
            let properties = try featuresContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
            
            if let properties = try? properties.decode(Quake.self, forKey: .properties) {
                quakes.append(properties)
            }
        }
    }
}

//
//  QuakeClient.swift
//  Earthquakes-iOS
//
//  Created by Rodrigo Kroef Tarouco on 03/09/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation

class QuakeClient {
    
    var quakes: [Quake] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allQuakes = try decoder.decode(GeoJSON.self, from: data)
            return allQuakes.quakes
        }
    }
    
    private lazy var decoder: JSONDecoder = {
      let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
}

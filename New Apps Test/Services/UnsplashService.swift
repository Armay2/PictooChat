//
//  UnsplashService.swift
//  New Apps Test
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import Foundation

class UnsplashService {
    private let networker = Networker()

    private let appId = "575727"
    private let accessKey = "8j7cdQS9HM1tfIomk_dUwqrIZ7wnymEECz6xk6OPP6k"
    private let baseURL = "https://api.unsplash.com/"
    
    func getFeaturedPhotos() async -> [String] {
        guard let url =  URL(string: baseURL + "/photos/?client_id=" + accessKey) else {
            return []
        }
        
        do {
            let data = try await networker.fetchData(from: url)
            let imageInfos = try JSONDecoder().decode([ImageInfo].self, from: data)
            return imageInfos.map { $0.urls.regular }
        } catch {
            print("Error fetching or decoding data: \(error)")
            return []
        }
    }
}

struct ImageInfo: Codable {
    let urls: ImageUrl
}

struct ImageUrl: Codable {
    let regular: String
}

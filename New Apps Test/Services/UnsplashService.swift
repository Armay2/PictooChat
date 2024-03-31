//
//  UnsplashService.swift
//  New Apps Test
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import Foundation

/// A service for fetching photos from the Unsplash API.
struct UnsplashService {
    /// The networker responsible for executing network requests.
    private let networker = Networker()

    /// The application ID provided by Unsplash when you register your application.
    private let appId = "575727"
    
    /// The access key provided by Unsplash, used to authenticate API requests.
    private let accessKey = "8j7cdQS9HM1tfIomk_dUwqrIZ7wnymEECz6xk6OPP6k"
    
    /// The base URL for the Unsplash API.
    private let baseURL = "https://api.unsplash.com/"
    
    /// Fetches an array of featured photo URLs from Unsplash.
    /// - Returns: An array of strings, each representing the URL of a regular-sized photo from Unsplash. Returns an empty array if the request fails or if decoding fails.
    func getFeaturedPhotos() async -> [String] {
        guard let url = URL(string: baseURL + "/photos/?client_id=" + accessKey) else {
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

/// A structure representing the response for a photo fetched from Unsplash.
struct ImageInfo: Codable {
    /// A structure containing various URL formats of a photo.
    let urls: ImageUrl
}

/// A structure representing different sizes of URLs for a single photo from Unsplash.
struct ImageUrl: Codable {
    let regular: String
}


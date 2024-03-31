//
//  Networker.swift
//  New Apps Test
//
//  Created by Arnaud NOMMAY on 31/03/2024.
//

import Foundation

enum NetworkError: Error {
    case badURL, requestFailed, decodingError, unknown
}

class Networker {
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        
        return data
    }
}

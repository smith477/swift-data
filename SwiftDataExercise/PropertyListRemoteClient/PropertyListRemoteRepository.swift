//
//  PropertyListRemoteRepository.swift
//  SwiftDataExercise
//
//  Created by Dusan Kovacevic on 8/8/23.
//

import Foundation

protocol PropertyAccesing {
    func getPropertyList(in cityId: Int) async throws -> PropertyListDTO
}

class PropertyListRemoteRepository: PropertyAccesing {
    var baseURL: String {
        guard let object = Bundle.main.object(forInfoDictionaryKey: Keys.BackendHost) as? String else {
            fatalError("Error")
        }
        return object
    }

    func getPropertyList(in cityId: Int) async throws -> PropertyListDTO {
        let url = URL(string: "https://" + baseURL + Enpoint.getProduct(id: cityId).path)!
        var request = URLRequest(url: url)
        request.httpMethod = Keys.HTTPMethods.get
        let (response, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        return try decoder.decode(PropertyListDTO.self, from: response)
    }

    enum Enpoint {
        case getProduct(id: Int)

        var path: String {
            switch self {
            case .getProduct(let id): "/cities/\(id)/properties/"
            }
        }
    }
}

struct Keys {
    static let BackendHost = "BASE_URL"

    struct HTTPMethods {
        static let get = "GET"
    }
}

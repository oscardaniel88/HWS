//
//  APIService.swift
//  PetfinderSwiftExample
//
//  Created by Daniel Camarena on 2/18/24.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    func createAccessTokenRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIConstants.host
        components.path = "/v2/oauth2/token"
        
        guard let url = components.url else {
            throw NetworkError.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        urlRequest.httpMethod =  "POST"
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: APIConstants.bodyParams)
        
        return urlRequest
    }
    
    func getAccessToken() async throws -> Token {
        let urlRequest = try createAccessTokenRequest()
        
        let (data, httpResponse) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let results = try decoder.decode(Token.self, from: data)
        return results
    }
    
    func search(tokenType: String, token: String, type: petType, pageNumber page: Int) async throws -> [Animal] {
        let components = type._links.breeds.href.split(separator:"/")
        guard let url = URL(string: "https://api.petfinder.com/v2/animals?type=\(components[2])&page=\(page)") else {
            throw NetworkError.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(tokenType + " " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, httpResponse) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        let results = try decoder.decode(Response.self, from: data)
        
        return results.animals
    }
    
    func getTypes(tokenType: String, token: String) async throws -> [petType] {
        guard let url = URL(string: "https://api.petfinder.com/v2/types") else {
            throw NetworkError.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(tokenType + " " + token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, httpResponse) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        let results = try decoder.decode(petTypeResponse.self, from: data)
        
        return results.types
    }
}

struct Token: Codable {
    let tokenType: String
    let expiresIn: Int
    let accessToken: String
}

struct Response: Codable {
    let animals: [Animal]
}

struct petTypeResponse: Codable {
    let types: [petType]
}

struct Animal: Codable, Identifiable, Hashable {
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let url: String
    let photos: [Photo]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Photo: Codable{
    let small: String
    let medium: String
    let large: String
    let full: String
}

struct petType: Codable, Hashable{
    let name: String
    let _links: Links
}

struct Links: Codable, Hashable {
    let breeds: Href
}

struct Href: Codable, Hashable {
    let href: String
}

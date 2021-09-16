//
//  NetworkService.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import Foundation
import Alamofire

struct NetworkService {
    public static var shared = NetworkService()
    
    public init() { }
    
    @discardableResult
    func makeRequest(url: URL, completition: @escaping (Data?, Error?) -> Void) -> Request {
        let request = AF.request(url)
        
        request.validate().responseJSON { (response) -> Void in
            completition(response.data, response.error)
        }
        return request
    }
    
    func decodeJSON<Type: Decodable>(type: Type.Type, from data: Data?) -> Type? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = data else { return nil }
        do {
            let response = try decoder.decode(type.self, from: data)
            return response
            
        } catch let error {
            #if DEBUG
            print(error)
            #endif
            
            return nil
        }
    }
}

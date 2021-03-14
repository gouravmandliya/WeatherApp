//
//  APIManager.swift
//  WeatherApp
//
//  Created by Gourav on 14/02/21.
//

import Foundation

enum APIError:Error
{
    case invalidResponse
    case invalidData
    case error(err:String)
    case decodingError(err:String)
}

final class APIManager<T:Codable>{
    static func fetch(for url:URL,completion:@escaping (Result<T,APIError>) -> Void)
    {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(String(describing: error!))
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            guard let httpReponse = response as? HTTPURLResponse,httpReponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do{
                let json = try JSONDecoder().decode(T.self, from: data)
                print(json)
                completion(.success(json))
            }
            catch let err {
                print(String(describing: err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
        }.resume()
    }
    
}

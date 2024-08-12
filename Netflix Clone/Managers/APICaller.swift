//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Cuong Chau on 2024/08/04.
//

import Foundation
import Combine
struct Constants {
    static let API_KEY = "1597366d13f48611db793048c87f0658"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    var cancellable: Set<AnyCancellable> = []
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: TrendingTitlesResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completionStatus in
                switch completionStatus {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                    completion(.failure(APIError.failedToGetData))
                }
            },
                  receiveValue: { results in completion(.success(results.results)) }
            ).store(in: &cancellable)
    }
    
    func getTrendingTVs(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: TrendingTitlesResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completionStatus in
                switch completionStatus {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                    completion(.failure(APIError.failedToGetData))
                }
            },
                  receiveValue: { results in completion(.success(results.results)) }
            ).store(in: &cancellable)
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: TrendingTitlesResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completionStatus in
                switch completionStatus {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                    completion(.failure(APIError.failedToGetData))
                }
            },
                  receiveValue: { results in completion(.success(results.results)) }
            ).store(in: &cancellable)
    }
}

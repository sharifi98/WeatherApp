//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Hossein Sharifi on 23/03/2023.
//

import Foundation

class WeatherService {
    private let apiKey = "23b0a45c305c96897396bb01eaac22aa"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"

    func fetchWeather(city: String, completion: @escaping (Weather?, Error?) -> Void) {
        let urlString = "\(baseURL)?q=\(city)&appid=\(apiKey)&units=imperial"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil, nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil, nil)
                return
            }

            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(weather, nil)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil, error)
            }
        }.resume()
    }
}

//
//  ContentView.swift
//  WeatherApp
//
//  Created by Hossein Sharifi on 23/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var city: String = ""
    @State private var weather: Weather?
    private let weatherService = WeatherService()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Weather App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 60)
                
                TextField("Enter city name", text: $city)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .padding(.horizontal, 40)
                    .padding(.top, 40)
                
                Button(action: {
                    weatherService.fetchWeather(city: city) { fetchedWeather, error in
                        if let error = error {
                            print("Error fetching weather: \(error.localizedDescription)")
                        } else {
                            weather = fetchedWeather
                        }
                    }
                }) {
                    Text("Get Weather")
                        .frame(width: 200, height: 50)
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
                
                
                if let weather = weather {
                    VStack {
                        Text("Temperature: \(weather.main.temp, specifier: "%.1f")°F")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .padding(.top, 40)
                        Text("Description: \(weather.weather.first?.description.capitalized ?? "")")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

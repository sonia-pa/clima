//
//  WeatherManager.swift
//  Clima
//
//  Created by Sonia Puertas Acosta on 1/19/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//
import CoreData

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4102513fd5ee3ad22c089c3910bf97c8&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String)  {
        let urlString = "\(weatherURL)&q=\(cityName)"
        self.performRequest(urlString: urlString)
        print(urlString)
    }
    
    /* Inside a closure, we msut put self, if we are calling the methid that belongs to the class. Otherwise, it will confuse */
    func performRequest(urlString: String){
        //1. create a URL
        
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            // called to method handle and the cin
            let task = session.dataTask(with: url) {(data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                    
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        let weatherVC = WeatherViewController()
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                    //                let dataString = String(data: safeData, encoding: .utf8)
                    //                print(dataString)
                    
                }
            }
            /* json is a javascript objec (string) that shrinks a lit of data   */
            //4. Start the task
            task.resume()
            
            
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            // the decoder will create a weather data object
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            print(decodedData.weather[0].description)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
//            print(weather.conditionName)
        } catch {
            print(error)
            return nil
        }
    }
    
   
}



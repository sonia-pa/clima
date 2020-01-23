
//  WeatherManager.swift
//  Clima
//  Created by Sonia Puertas Acosta on 1/19/20.
import CoreData
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailedWithError(error: Error)
    
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4102513fd5ee3ad22c089c3910bf97c8&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String)  {
        let urlString = "\(weatherURL)&q=\(cityName)"
        self.performRequest(with: urlString)
//        print(urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        self.performRequest(with: urlString)
    }
    
    /* Inside a closure, we msut put self, if we are calling the method that belongs to the class. Otherwise, it will confuse */
    func performRequest(with urlString: String){
        //1. create a URL
        
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            // called to method handle and the cin
            let task = session.dataTask(with: url) {(data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailedWithError(error: error!)
//                    print(error!)
                    return
                    
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        let weatherVC = WeatherViewController()
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    //                let dataString = String(data: safeData, encoding: .utf8)
                    //                print(dataString)
                    
                }
            }
            //4. Start the task
            task.resume()
            
            
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
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
        } catch {
            delegate?.didFailedWithError(error: error)
            return nil
        }
    }
    
   
}




import Foundation
/*
 Codable protocol decodes and decodes objects
 */
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}
/* property name must match the names of the data of the JSON file. Otherwise, it will not know what to decode*/
/* We need a struct because we are trying to acces an Object "temp" since it's  a JSON file*/
struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}


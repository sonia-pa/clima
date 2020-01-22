
//  ViewController.swift
//  Clima

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
   
//    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    var cityName = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        // initialize delegates who is the delegate
        searchTextField.delegate = self
        
        
    }
    @IBAction func searchPressed(_ sender: UIButton) {
        
//        searchTextField.endEditing(true)
        cityName = searchTextField.text!
        
        cityLabel.text = cityName
        print(searchTextField.text!)
         searchTextField.endEditing(true)
    }
    
//    @IBAction func searchPressed(_ sender: UIButton) {
//        /*Tells that we are done editing so hide the keyboard */
//        searchTextField.endEditing(true)
//        print(searchTextField.text!)
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        searchTextField.endEditing(true)
        print(searchTextField.text ?? "ew")
        
        searchTextField.endEditing(true)
//        print("dmk")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Enter a city name"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        // user searchTextField.text to get the weather of the city
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        print(weather.temperature)
       }
       
//    func didUpdateWeather(weather: WeatherModel){
//        print(weather.temperature)
//    }
    
}



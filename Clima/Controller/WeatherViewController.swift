import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
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
    
}
//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        cityName = searchTextField.text!
        cityLabel.text = cityName
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text ?? "ew")
        searchTextField.endEditing(true)
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
        /* user searchTextField.text to get the weather of the city */
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        /*DispatchQueue is used to make sure we are running asyn and the compeltion handler finish its task before we attempt to display into the View controller */
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        
        //        print(weather.temperature)
    }
    
    func didFailedWithError(error: Error) {
        print(error)
    }
}

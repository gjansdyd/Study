//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by mun on 2023/03/15.
//

import UIKit

protocol AddWeatherDelegate: AnyObject {
    func addWeahterDidSave(vm: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
    @IBOutlet weak var cityNameTextField: UITextField!
    
    private var addWeatherVM = AddWeatherViewModel()
    internal weak var delegate: AddWeatherDelegate?
    
    @IBAction func saveCityButtonPressed() {
        guard let city = cityNameTextField.text, !city.isEmpty
        else { return }
        
        addWeatherVM.addWeather(for: city, completion: { [weak self] vm in
            self?.delegate?.addWeahterDidSave(vm: vm)
            
            DispatchQueue.main.async {
                self?.dismiss(animated: true)
            }
        })
    }
    
    @IBAction func close() {
        self.dismiss(animated: true)
    }
}

//
//  ViewController.swift
//  GoodWeather
//
//  Created by mun on 2023/03/04.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityNameTextField.rx
            .controlEvent(.editingDidEndOnExit) // 작성상태가 비활성화될 때 동작
            .asObservable()
            .map({ self.cityNameTextField.text })
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp) ℉"
            self.humidityLabel.text = "\(weather.humidity) 🤩"
        } else {
            self.temperatureLabel.text = "🙈"
            self.humidityLabel.text = "⍁"
            
        }
    }
    
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded)
        else { return }
        
        let resource = Resouce<WeatherResult>(url: url)
        
        //===기본적인 연결방법
//        URLRequest.load(resource: resource)
//            .observeOn(MainScheduler.instance)
//            .catchErrorJustReturn(WeatherResult.empty)
//            .subscribe(onNext: { result in
//                let weather = result.main
//                self.displayWeather(weather)
//            }).disposed(by: disposeBag)
        
        
        //==BIND로 하는 법
//        let search = URLRequest.load(resource: resource)
//            .observeOn(MainScheduler.instance)
//            .catchErrorJustReturn(WeatherResult.empty)
//
//        search.map { "\($0.main.temp) ℉"}
//            .bind(to: self.temperatureLabel.rx.text )
//            .disposed(by: disposeBag)
//
//        search.map { "\($0.main.humidity) 🍀" }
//            .bind(to: self.humidityLabel.rx.text)
//            .disposed(by: disposeBag)
        
        //=== Improve Project using Driver/ Control Property
        let search = URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: WeatherResult.empty)
        
        search.map { "\($0.main.temp) ℉"}
            .drive(self.temperatureLabel.rx.text )
            .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity) 🍀" }
            .drive(self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
    }

}


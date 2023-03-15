//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by mun on 2023/03/15.
//

import UIKit

class WeatherListTableViewController: UITableViewController,
                                        AddWeatherDelegate,
                                      SettingsDelegate {
    private var weahterListViewModel = WeatherListViewModel()
    private var lastUnitSelection: Unit!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherCityViewController" {
            prepareSegueForAddWeatherCityViewController(segue: segue)
        }
        if segue.identifier == "SettingsTableViewController" {
            prepareSegueForSettingsTableViewController(segue: segue)
        }
    }
    
    func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        guard let naviVc = segue.destination as? UINavigationController,
              let vc = naviVc.viewControllers.first as? AddWeatherCityViewController
        else { return }
        vc.delegate = self
    }
    
    func prepareSegueForSettingsTableViewController(segue: UIStoryboardSegue) {
        guard let naviVc = segue.destination as? UINavigationController,
              let vc = naviVc.viewControllers.first as? SettingsTableViewController
        else { return }
        vc.delegate = self
    }
    
    func addWeahterDidSave(vm: WeatherViewModel) {
        weahterListViewModel.addWeahterViewModel(vm)
        self.tableView.reloadData()
    }
    
    func settingsDone(vm: SettingsViewModel?) {
        guard let vm = vm else { return }
        if lastUnitSelection != vm.selectedUnit {
            weahterListViewModel.updateUnit(to: vm.selectedUnit)
            tableView.reloadData()
            lastUnitSelection = vm.selectedUnit
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        lastUnitSelection = SettingsViewModel().selectedUnit
        
//        let resource = Resource<WeatherResponse>(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?q=houston&appid=f5a13152f438248fd8f95ec999c7ddb2&units=standard")!, parse: { data in
//            return try? JSONDecoder().decode(WeatherResponse.self,
//                                             from: data)
//        })
//
//        WebService().load(resource: resource,
//                          completion: { weatherResponse in
//            if let weatherResponse = weatherResponse {
//                print(weatherResponse)
//            }
//        })
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return weahterListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell",
                                                 for: indexPath) as? WeatherCell
        else { fatalError("WeatherCell cannot find out") }
        
        let vm = weahterListViewModel.modelAt(indexPath.row)
        cell.configure(vm)
        return cell
    }
}

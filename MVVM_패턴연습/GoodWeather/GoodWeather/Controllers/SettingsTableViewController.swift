//
//  SettingsTableViewController.swift
//  GoodWeather
//
//  Created by mun on 2023/03/15.
//

import UIKit

protocol SettingsDelegate: AnyObject {
    func settingsDone(vm: SettingsViewModel?)
}
class SettingsTableViewController: UITableViewController {
    private var settingsViewModel = SettingsViewModel()
    internal weak var delegate: SettingsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func done() {
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.settingsDone(vm: self?.settingsViewModel)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsItem = settingsViewModel.units[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell",
                                                 for: indexPath)
        cell.textLabel?.text = settingsItem.displayName
        if settingsViewModel.selectedUnit == settingsItem {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let unit = Unit.allCases[indexPath.row]
            settingsViewModel.selectedUnit = unit
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}

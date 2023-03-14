//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by mun on 2023/03/13.
//

import Foundation
import UIKit

protocol AddCoffeeOrderDelegate: AnyObject {
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController)
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController)
}


class AddOrderViewController: UIViewController,
                              UITableViewDelegate,
                              UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var viewModel = AddCoffeeOrderViewModel()
    private var coffeeSizesSegmentedControl: UISegmentedControl!
    weak var delegate: AddCoffeeOrderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        self.coffeeSizesSegmentedControl = UISegmentedControl(items: self.viewModel.sizes)
        self.coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeeSizesSegmentedControl)
        self.coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor,
                                                              constant: 20).isActive = true
        self.coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
    }
    
    @IBAction func save() {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        let selectedSize = self.coffeeSizesSegmentedControl.titleForSegment(at: self.coffeeSizesSegmentedControl.selectedSegmentIndex)
        guard let indexPath = self.tableView.indexPathForSelectedRow
        else { fatalError("Error in selecting coffee!")}
        
        self.viewModel.name = name
        self.viewModel.email = email
        self.viewModel.selectedSize = selectedSize
        self.viewModel.selectedType = self.viewModel.types[indexPath.row]
        
        WebService().load(resource: Order.create(vm: self.viewModel),
                          completion: { result in
            switch result {
            case .success(let success):
                print(success)
                if let success = success, let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.addCoffeeOrderViewControllerDidSave(order: success,
                                                                     controller: self)
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        })
    }
    
    @IBAction func close() {
        if let delegate = self.delegate {
            delegate.addCoffeeOrderViewControllerDidClose(controller: self)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        cell.textLabel?.text = self.viewModel.types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

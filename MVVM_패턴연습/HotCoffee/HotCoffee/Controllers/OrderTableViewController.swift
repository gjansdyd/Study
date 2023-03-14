//
//  OrderTableViewController.swift
//  HotCoffee
//
//  Created by mun on 2023/03/13.
//

import Foundation
import UIKit

class OrderTableViewController: UITableViewController, AddCoffeeOrderDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let addCoffeeOrderVC = navC.viewControllers.first as? AddOrderViewController
        else { fatalError("Error performing segue!") }
        
        addCoffeeOrderVC.delegate = self
    }
    
    //delegate functions of AddCoffeeOrderDelegate
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true) {
            self.orderListViewModel.ordersViewModel.append(OrderViewModel(order: order))
            self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count-1, section: 0)],
                                      with: .automatic)
        }
    }
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true)
    }
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    private func populateOrders() {
        WebService().load(resource: Order.all,
                          completion: { [weak self] result in
            switch result {
            case .success(let orders):
                print(orders)
                self?.orderListViewModel.ordersViewModel = orders.map {
                    OrderViewModel($0)
                }
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.orderListViewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell",
                                                 for: indexPath)
        cell.textLabel?.text = viewModel.type
        cell.detailTextLabel?.text = viewModel.size
        return cell
    }
}

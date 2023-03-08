//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    
    let viewModel = MenuListViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.menuObservable //menuobservable값이 바뀌면 bind 된 ui를 바꿔라.
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "MenuItemTableViewCell",
                  cellType: MenuItemTableViewCell.self)) { index, item, cell in
                cell.title.text = item.name
                cell.price.text = "\(item.price)"
                cell.count.text = "\(item.count)"
                
                cell.onChange = { [weak self] increase in
                    self?.viewModel.changeCount(item, increase)
                }
            }.disposed(by: disposeBag)
        
        // RxCocoa는 RxSwift의 요소들을
        // UIKit의 extension에 종속시킨 녀석들
        
        // Binder? Bind시킬 수 있다.
        // subscribe를 하지 않고
        // bind해서
        
        viewModel.itemsCount
            .map { "\($0)" }
            .observeOn(MainScheduler.instance)
            .bind(to: itemCountLabel.rx.text) // 순환참조 우려 없음
            .disposed(by: disposeBag)
        
        viewModel.totalPrice
            .map { $0.currencyKR() }
            .observeOn(MainScheduler.instance)
            .bind(to: totalPrice.rx.text)
            .disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        if identifier == "OrderViewController",
            let orderVC = segue.destination as? OrderViewController {
            // TODO: pass selected menus
        }
    }

    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }

    // MARK: - InterfaceBuilder Links

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var itemCountLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!

    @IBAction func onClear() {
        viewModel.clearAllItemSelections()
    }

    @IBAction func onOrder(_ sender: UIButton) {
        // TODO: no selection
        // showAlert("Order Fail", "No Orders")
//        performSegue(withIdentifier: "OrderViewController", sender: nil)
//        self.viewModel.itemsCount += 1
//        viewModel.me.onNext(100)
        viewModel.onOrder()
    }
}

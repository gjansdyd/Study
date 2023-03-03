//
//  ViewController.swift
//  CameraFilter
//
//  Created by mun on 2023/03/02.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var applyFilterButton: UIButton!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let photoCVC = navC.viewControllers.first as? PhotosCollectionViewController
        else { fatalError() }
        
        photoCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
            
        }).disposed(by: disposeBag)
    }

    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.applyFilterButton.isHidden = false
    }
    @IBAction func applyFilterButtonPressed(_ sender: Any) {
        guard let sourceImage = self.photoImageView.image else {
            return
        }
        FiltersService().applyFilter(to: sourceImage).subscribe(onNext: { [weak self] filteredImage in
            DispatchQueue.main.async {
                self?.photoImageView.image = filteredImage
            }
        }).disposed(by: disposeBag)
    }
}


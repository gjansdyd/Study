//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by mun on 2023/03/02.
//

import Foundation
import UIKit
import Photos
import RxSwift

class PhotosCollectionViewController: UICollectionViewController {
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populatePhotos()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { fatalError() }
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: 300,
                                                height: 300),
                             contentMode: .aspectFit,
                             options: nil,
                             resultHandler: { image, _ in
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
        })
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset,
                                              targetSize: CGSize(width: 300, height: 300),
                                              contentMode: .aspectFit,
                                              options: nil,
                                              resultHandler: { [weak self] image, info in
            guard let info = info else { return }
            
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            if isDegradedImage {
                if let image = image {
                    self?.selectedPhotoSubject.onNext(image)
                    self?.dismiss(animated: true)
                }
            }
        })
    }
    
    
    private func populatePhotos() {
        // PhotoLibrary접근하기 위한 함수
        // info.plist에 "Privacy - Photo Library Usage Description" key적용
        PHPhotoLibrary.requestAuthorization(for: .readWrite,
                                            handler: { [weak self] status in
            
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image,
                                                 options: nil)
                assets.enumerateObjects({ (object, count, stop) in
                    self?.images.append(object)
                })
                
                self?.images.reverse()
                print(self?.images)
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        })
    }
}

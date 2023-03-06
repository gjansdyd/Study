//
//  FilterService.swift
//  CameraFilter
//
//  Created by mun on 2023/03/03.
//

import Foundation
import UIKit
import CoreImage
import RxSwift

class FiltersService {
    private var context: CIContext
    init() {
        self.context = CIContext()
    }
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            filter.setValue(sourceImage,
                             forKey: kCIInputImageKey)
            if let cgImg = self.context.createCGImage(filter.outputImage!,
                                                      from: filter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgImg,
                                             scale: inputImage.scale,
                                             orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create({ observer in
            self.applyFilter(to: inputImage) { filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        })
    }
}

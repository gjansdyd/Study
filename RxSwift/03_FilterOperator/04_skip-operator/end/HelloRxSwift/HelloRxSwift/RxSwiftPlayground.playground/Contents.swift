import UIKit
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

Observable.of("A","B","C","D","E","F")
.skip(4)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)





















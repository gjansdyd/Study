import UIKit
import RxSwift

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.takeUntil(trigger)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

subject.onNext("1")
subject.onNext("2")

trigger.onNext("X")

subject.onNext("3")





















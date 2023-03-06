import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// MARK: Take Until
// TakeUntil: event를 가진다(take). trigger가 동작하기 전까지(until)

let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.takeUntil(trigger) // trigger로 동작하는 Observable을 받음
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

subject.onNext("1")
subject.onNext("2")
trigger.onNext("X")
subject.onNext("3")

// 1, 2: trigger가 동작한 이후 Subscriber에게 event는 전달되지 않는다

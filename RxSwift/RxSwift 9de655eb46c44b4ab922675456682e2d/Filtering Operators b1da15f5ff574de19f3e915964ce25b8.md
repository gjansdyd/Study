# Filtering Operators

### Ignore

```swift
import UIKit
import RxSwift
import RxCocoa

let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()
enum ErrTest: Error {
    case notDefined
}

strikes
    .ignoreElements()
    .subscribe({ _ in
        print("subscription!")
    }).disposed(by: disposeBag)

strikes.onNext("A")
strikes.onNext("B")
strikes.onNext("C")
// ignoreElements()함수 때문에
// 위의 것들은 전부 무시된다. 
// 즉, "subscription!"이라는 문자열이 출력되지 않는다

strikes.onError(ErrTest.notDefined) // 또는 strikes.onCompleted()
// onCompleted나 onError일때, 
// 즉 sequence가 끝나는 시점에만 "subscription!"이라는 문자열이 출력된다.
// 그래서 ignoreElements()함수는 보통
// 해당 subscribe가 끝나는 시점에 관심이 있을 때 사용한다.
```

### Element At

```swift
import UIKit
import RxSwift
import RxCocoa

let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()

// MARK: Element At
strikes
    .elementAt(2) //모든 이벤트가 아닌 2번째에만 Subscriber가 반응하도록 하는 함수
    .subscribe({ _ in
        print("You are out!")
    }).disposed(by: disposeBag)
strikes.onNext("X")
strikes.onNext("X")
strikes.onNext("X")

// 물론 onNext가 아닌 onCompleted나 onError와 같이,
// sequence가 종료될 때에도 반응한다.
```

### Filter

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// MARK: Filter
Observable.of(1, 2, 3, 4, 5, 6, 7)
    .filter { $0 % 2 == 0 } // even number 출력을 위해 filtering
    .subscribe({
        print($0)
    }).disposed(by: disposeBag)
// next(2) next(4) next(6) completed
```

### Skip

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// MARK: Skip
Observable.of("A","B","C","D","E","F")
    .skip(3) // Subscriber는 3개의 event를 건너 뛴다.
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// D E F
```

### Skip While

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// MARK: Skip While
// SkipWhile: Skip한다. 연산에 통과하는 동안(while)
// predicate에서 통과하지 못한 이벤트가 등장하면
// 해당 이벤트와 이후 이벤트들은 모두 Subscriber에게 전달된다
Observable.of(1, 2, 3, 4, 5)
    .skipWhile { $0 % 2 == 1 }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 2, 3, 4, 5: 2부터 통과되지 못했으므로 해당 이벤트를 비롯한 이후의 것들 모두 전달

Observable.of(1, 2, 3, 4, 5)
    .skipWhile { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 1, 2, 3, 4, 5: 1부터 통과되지 못했으므로 해당 이벤트를 비롯한 이후의 것들 모두 전달
```

### Skip Until

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// MARK: Skip Until
// SkipUntil: Skip한다. trigger가 있기 전 까지(until)
let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject
    .skipUntil(trigger)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

subject.onNext("A")
subject.onNext("B")
// A, B모두 Skip한다.

trigger.onNext("C")
// trigger 작동.
// 이후 event는 Subscriber들이 받을 수 있다.

subject.onNext("D")
subject.onNext("E")
subject.onNext("F")
// D E F
```

### Take

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// MARK: Take
Observable.of(1, 2, 3, 4, 5)
    .take(3) // 앞에서부터 3번째까지의 이벤트만 Subscribing한다.
    .subscribe(onNext: {
        print($0)
    })
```

### Take While

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// MARK: Take While
// TakeWhile: event를 가진다(take). predicate가 참인 동안(while)
Observable.of(1, 2, 3, 4, 5, 6, 7)
    .takeWhile { $0 % 2 == 1 }
    .subscribe(onNext: {
        print($0)
    })
// 1: 2부터 takeWhile { predicate }가 거짓임.
// 한 번 false가 된 후에는 어떤 이벤트도 Subscriber에게 전달되지 않음.
```

### Take Until

```swift
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
```
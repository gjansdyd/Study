# Combining Operators

### startWith

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()
let numbers = Observable.of(2, 3, 4)

// startWith(<T>)
let observable = numbers.startWith(1)
observable.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag) // 1, 2, 3, 4
//startWith(T): 특정 observable의 시작을 T로하여 새로운 sequence를 만든다
```

### concat

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

//2. concat: "A" sequence concat "B" sequence -> AB seqeunce
// Observable"A".concat(Observable"B")
let first = Observable.of(1, 2, 3)
let second = Observable.of(4, 5, 6)
first.concat(second)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag) // 1 2 3 4 5 6
// concat: 특정 observable뒤에 다른 Observable을 붙여 새로운 Observable을 return
```

### merge

```swift

import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

//3. merge: concat은 A 뒤에 B를 붙이는 방식인 반면,
// merge연산은 두 Observable을 하나의 sequence로 만들 때
// 시간 흐름순에 따라 event를 발생시킨다.
//Observable.of(Observable”A”, Observable”B”).merge()
let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let source = Observable.of(left.asObservable(), right.asObservable())
let observable2 = source.merge()
observable2.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

left.onNext(5)
left.onNext(3)
right.onNext(2)
right.onNext(1)
left.onNext(99) // 5 3 2 1 99
```

### combineLatest

이미지가 100번의 설명보다 나을 때가 있다.

![R1280x0.png](Combining%20Operators/R1280x0.png)

```swift
import UIKit
import RxSwift
import RxCocoa

// combineLastest
let disposeBag = DisposeBag()

let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let observable = Observable.combineLatest(left, right, resultSelector: { lastLeft, lastRight in
    "[\(lastLeft)" + "," + "\(lastRight)]"
})

let disposable = observable.subscribe(onNext: { value in
    print(value)
})

left.onNext(45)
right.onNext(1)
left.onNext(30)
right.onNext(1)
right.onNext(2) // [45,1] [30,1] [30,1] [30, 2]
```

### withLastestFrom

두 `Observable`중 첫번째 `Observable`에서 아이템이 방출될 때마다 그 아이템을 두번째 `Observable`
의 **가장 최근 아이템과 결합**해 방출

![RxSwift - withLatestFrom.png](Combining%20Operators/RxSwift_-_withLatestFrom.png)

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// withLastestFrom
// ^Observable A^.withLastestFrom(^Observable B^)
// A에게 이벤트가 발생했을 때 B의 가장 최신 element를 방출해라
// resultSelector를 활용하면 두 값을 조작하여 하나의 element로 만들 수도 있음.
let button = PublishSubject<Int>()
let textField = PublishSubject<String>()

let observable = button.withLatestFrom(textField,
                                       resultSelector: { btnElement, txtFieldElement in
    return "\(btnElement): " + txtFieldElement
})
let disposable = observable.subscribe(onNext: {
    print($0)
})

textField.onNext("Sw")
textField.onNext("Swif")
textField.onNext("Swift")
textField.onNext("Swift Rocks!")
button.onNext(999) // 999: Swift Rocks!
```

### reduce

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let source = Observable.of(1, 2, 3)
source.reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag) // 6
// element로 전달되는 모든 들을 합친 후 Subscriber에게 전달

//아래는 위의 accumulator를 좀 더 자세하게 기술한 코드
source.reduce(0, accumulator: { summary, newValue in
    return summary + newValue
}).subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag) // 6
```

### scan

scan 함수는 Observable이 방출하는 아이템들을 누적해가는 연산자이다. scan은 reduce와 유사하지만 scan은 누적 과정 중간 결과를 모두 Subscriber에게 전달한다는 점에서 차이가 있다.
scan은 초기값과 accumulation closure를 인자로 전달받아 아이템이 방출될 때마다 accumulation closure를 호출하여 이전 누적값과 새로운 아이템값을 합산하고 그 결과를 Subscriber에게 방출하면서 다음 누적 계산을 위해 저장해 둔다.
따라서 scan 연산자는 시퀀스가 모두 완료된 후에 최종 누적값을 Subscriber에게 전달하는 reduce와 달리 누적 과정 중간 결과를 실시간으로 Subscriber에게 제공한다.

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let source = Observable.of(1, 2, 3, 4, 5, 6)
source.scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag) // 1 3 6 10 15 21
```

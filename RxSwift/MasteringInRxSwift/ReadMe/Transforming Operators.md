# Transforming Operators

### toArray()

```swift
import UIKit
import RxSwift

let disposeBag = DisposeBag()

//1. toArray
Observable.of(1, 2, 3, 4, 5)
    .toArray()
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag) //[1, 2, 3, 4, 5]
// 개별요소들을 하나의 집합 요소로 변형
```

### map()

```swift
import UIKit
import RxSwift

let disposeBag = DisposeBag()

//2. map
Observable.of(1, 2, 3, 4, 5)
    .map({
        return $0*2
    }).subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag) // 2 4 6 8 10
// 개별요소들에 추가 map내 추가 연산을 하여 이벤트를 전달
```

### flatMap()

```swift
import UIKit
import RxSwift

let disposeBag = DisposeBag()

//3. flatMap
struct Student {
    var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 90))
let mary = Student(score: BehaviorRelay(value: 95))

let student = PublishSubject<Student>()
student.asObservable()
    .flatMap({
        $0.score.asObservable()
    }).subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
student.onNext(john) // 90
john.score.accept(100) // 100
student.onNext(mary) // 95
mary.score.accept(70) // 70
// flatMap은 이벤트를 다른 Observable로 바꾼다.
// map함수의 경우 closure내부에서 연산값을 return해주어야 하는 반면
// flatMap은 Observable을 return해주어야 한다.
```

### flatMapLatest()

```swift
import UIKit
import RxSwift

let disposeBag = DisposeBag()

//3. flatMap
struct Student {
    var score: BehaviorRelay<Int>
}

//4. flatMap Latest
let john = Student(score: BehaviorRelay(value: 75))
let mary = Student(score: BehaviorRelay(value: 95))

let student = PublishSubject<Student>()
student.asObservable()
    .flatMap({
        $0.score.asObservable()
    }).subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
student.onNext(john) //75
john.score.accept(100) // 100
student.onNext(mary) // 95
john.score.accept(45)

// flatMap일 때에는 출력값: 75 100 95 45
// flatMapLatest일 때에는 출력값: 75, 100, 95
// 가장 최근 Subject(student)에 전달된 Observable만
// 유효한 Subscribe로 취급한다
```
import UIKit
import RxSwift
import RxCocoa

print("PublishSubject\n")
let disposeBag = DisposeBag()
let subject = PublishSubject<String>() // 기본값이 필요없음

subject.onNext("Issue 1")
// 이것만으로는 아무일도 일어나지 않음. Because of No Subscriber

subject.subscribe { event in
    print(event)
}
// 이것으로도 확인할 수 없다. 왜냐하면 이미 "Issue 1"이라는
// event는 방출되었고 subject가 현재 가진 event는 없기 때문에.

subject.onNext("Issue 2")
// 이 때 비로소 위의 subscriber는 Issue 2라는 이벤트를 받을 수 있다.

subject.onNext("Issue 3")
// 해당 이벤트 역시 받을 수 있다.

subject.onCompleted() // 이 이후 이벤트들은 모두 무시된다
subject.dispose() // 해당 subject의 메모리를 해제된다.

subject.onNext("Issue 4") //해당 이벤트는 무시된다
print("\n=====================================")


// BehaviorSubject
// PublishSubject와 거의 유사하지만 한 가지가 다르다
// 그것은 바로 초깃값을 넘겨주어야 한다는 점.
// Subscriber는 구독과 동시에 가장 최근 emit했던 Event를 받게 된다.
print("\n=====================================")
print("BehaviorSubject\n")
let behaviorSubject = BehaviorSubject(value: "Initial Value")
behaviorSubject.onNext("Last Issue")
behaviorSubject.subscribe { event in
    print(event)
} // "Initial Value"가 아닌 "Last Issue"출력된다.
// 왜냐하면 가장 최근 emit했던 event를 전달받기 때문에
behaviorSubject.onNext("Issue 1")
// "Issue 1"을 출력한다
print("\n=====================================")


// ReplaySubject
// ReplaySubject는 Subscriber에게 최근 전달한 값을 전달한다는 점에서
// BehaviorSubject과 유사하지만 다른 점이 있다.
// 그것은 바로 크기이다.
// 초기에 설정하는 bufferSize만큼 새로운 Subscriber에게 값을 전달한다.
print("\n=====================================")
print("ReplaySubject\n")

let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
replaySubject.onNext("Issue 1")
replaySubject.onNext("Issue 2")
replaySubject.onNext("Issue 3")
replaySubject.subscribe {
    print($0)
} //next(Issue 2), next(Issue 3)
replaySubject.onNext("Issue 4")
replaySubject.onNext("Issue 5")
replaySubject.onNext("Issue 6")
replaySubject.onNext("Issue 7")

print("[Subscription 2]")
replaySubject.subscribe {
    print($0)
} //next(Issue 6) next(Issue 7)
print("\n=====================================")

print("\n=====================================")
print("Variable\n")
//Variables
// Variable은 BehaviorSubject의 현재 값을 state로 가지며
// 그냥 일반적인 값을 Observable처럼 wrapping하는 것으로 생각하면 쉽다.
// Variable 타입을 subscribe하기 위해서는 asObservable()이라는 함수로
// Observable로 unwrapping해준다.
// 초기값을 변경하기 위해서는 .value 를 통해 접근할 수 있다.
let variable = Variable("Initial Value")
variable.value = "Hello world"
variable.asObservable().subscribe({
    print($0)
}) // Variable은 미래에 deprecate될 예정이므로 BehaviorReplay를 대신해서 써야 함.
// 출력은 Hello world로 정상적.

variable.value = "Hello world2"
// value를 변경하면 Subscriber가 마치 Observable에서 onNext로 event를 받은 듯
// Hello world2를 출력한다

// Variable은 에러가 발생하지 않으며, 할당 해제시 자동으로 완료가 되어
// onError나 onCompleted를 호출할 필요가 없다.
// Observable처럼 값을 받을 수만 있는 상황,
// Subject처럼 값을 주고 받는 상황,
// Subscribe없이 하나의 값만 있어도 되는 상황에서 주로 쓰인다

let variable2 = Variable([String]())
variable2.value.append("Item 1") // [Item 1]
variable2.asObservable().subscribe {
    print($0)
}
variable2.value.append("Item 2") // [Item 2]


// BehaviorRelay
// Variable의 대체제.
let relay = BehaviorRelay(value: "Initial Value")
relay.asObservable().subscribe {
    print($0)
} // 여기까지는 Variable과 동작방식이 동일하다.


//relay.value = "Hello World"
//여기서부터 문제 발생
// BehaviorRelay.value는 읽기전용이라 직접 접근 불가능
relay.accept("Hello World")

let relay2 = BehaviorRelay(value: ["Item 1"])
relay2.asObservable().subscribe({
    print($0)
})
relay2.accept(["Item 2"]) // 이렇게 하면 Item 1이 사라진다.
// 따라서 다음과 같이 구현
relay2.accept(relay2.value + ["Item 1"])

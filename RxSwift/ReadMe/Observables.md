# Observables

Observable은 이벤트를 방출(emit)하면 Observer를 통해 이벤트를 구독하는 구독자(subscriber)에게 전달한다. 구독자는 이벤트가 방출될 때마다 이벤트에 포함된 값을 처리한다. 이러한 Observable과 Observer 사이의 관계를 방출-구독(Publish-Subscribe)이라 한다. Observable은 Observable sequence로도 불리며 단순하게 sequence라고도 한다. 

 Observable은 시간의 흐름에 따라 0개 이상의 항목을 생성하는 것을 의미한다. Observable sequence는 "cold" 혹은 "hot"일 수 있다. Cold Observable은 구독하기 전까지 아무런 항목도 방출하지 않는다. Hot Observable은 구독과 상관없이 항목을 계속 방출한다. Observable은 단방향일 뿐만 아니라 여러 Observer를 가질 수 있다. 이는 Observable이 다중 캐스트(multicast) 기능을 제공한다는 것을 의미한다. 또한 Observable은 한 Observer가 더 이상 항목을 처리하지 않을 때 dispose()를 호출하여 구독을 취소할 수 있다.

 Observable은 비동기 프로그래밍을 위한 중요한 개념이다. 그것은 이벤트 기반 아키텍처를 사용하여 애플리케이션의 비동기 측면을 처리한다. 또한 Observable은 함수형 프로그래밍 패러다임을 따르며, 이는 코드를 더 간결하고 오류가 적은 상태로 유지하는 데 도움이 된다.

 Observable은 크게 3가지 기능을 가진다. 먼저 next는 구성요소를 계속해서 방출할 수 있는 것이다. 이 때 방출된 이벤트를 해당 Observable의 Subscriber에게 전달한다. completed는 이벤트를 종료시킬 수 있는 기능이다. 이는 Subscriber에게 더이상 이벤트가 오지 않음을 알릴 수 있다. error는 이벤트에 오류가 있음을 알고 중간에 종료시키는 기능이다. **만약 Subscriber가 Observable로부터 Completed나 Error를 받는다면 이후 이벤트는 모두 무시한다.** 

 Observable를 만들고 생성하는 방법은 다음과 같다.

```swift
Observable.just([1]) // 오직 하나의 요소를 포함하는 Sequence생성

// of는 배열뿐 아니라 단일 개체로도 전달할 수 있다.
// 만약 배열로 묶는다면 하나의 이벤트로,
// 콤마를 통해 개별 요소들로 전달하면 각각 이벤트의 역할을 한다.
Observable.of(1, 2, 3) 
Observable.of([1, 2, 3])

// from은 배열로만 전달할 수 있으며 배열 요소마다 하나씩 이벤트로 기능한다
Observable.from([1, 2, 3, 4, 5])
```

 하지만 Observable을 만들고 생성하는 것만으로, 그 Observable이 의의를 가질 수는 없다. Observable이 event를 emit할 때 이것들을 받아서 각자 처리하는 Subcriber가 있어야 비로소 의미가 있게 된다. Subscriber를 만드는 방법은 다음과 같다.

```swift
// 1
Observable.of(1, 2, 3).subscribe {
	print($0) // next(1) next(2) next(3) completed
}

// 2
Observable.of(1, 2, 3).subscribe {
	if let element = $0.element {
		print(element) 
	}
}

// 3
Observable.of(1, 2, 3).subscribe(onNext: {
	print($0) // 1, 2, 3
})

// 4 다른 방식으로 Observable만들기
Observable<String>.create({ observer in
    observer.onNext("A")
    observer.onCompleted()
    return Disposables.create() // <- 일회용
}).subscribe(onNext: {
    print($0)
}, onError: {
    print($0)
}, onCompleted: {
    print("Completed")
}, onDisposed: {
    print("Disposed")
})
```

 1의 코드 중 출력된 `next` 는 **다음 emit이 올 수 있다**는 상태를, `completed` 는 **생성된 Observable이 completed되어 더 이상 event를 방출하지 않는다**는 상태를 의미한다. 상태가 아닌 실제 전달된 요소들만 확인하고 싶다면 2의 코드처럼 element를 unwrapping하거나 3과 같이 overloading된  subscribe함수를 사용한다. 

 Observable이 Subscribed되고 모든 emit이 완료되면 반드시 dispose되어야 하는데 이 때에는 다음과 같은 방법을 쓴다

```swift
let observable = Observable.from([1, 2, 3, 4, 5]) // Observable생성
let subscription = observable.subscribe(onNext: { event in 
    print(event)
}) // 이 때 subscription은 disposable 타입의 객체이다
subscription.dispose() // dispose함수를 통해 메모리 해제
```

 하지만 위의 방법으로 매번 disposable한 객체들을 dispose하는 것은 귀찮기도 하고 혹시 잊었을 때 메모리 누수의 위험이 있다. 따라서 위 코드보다는 아래 코드와 같은 방법을 권장한다.

```swift
let disposeBag = DisposeBag()
Observable.of("A", "B", "C")
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)
```
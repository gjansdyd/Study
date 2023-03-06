//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

// RxSwift
// 나중에생기는데이터 == Observable
class 나중에생기는데이터<T> {
    private let task: (@escaping (T) -> Void) -> Void
    init(task: @escaping (@escaping (T) -> Void) -> Void) {
        self.task = task
    }
    
    // RxSwift
    // subscribe == 나중에오면
    func 나중에오면(_ f: @escaping (T) -> Void) {
        task(f)
    }
}
class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }

    // completion이 아니라 return 값으로 전달받고 싶음
//    func downloadJson(_ url: String, completion: @escaping ((String) -> Void)) {
//        let url = URL(string: url)!
//
//        DispatchQueue.global().async {
//            let data = try! Data(contentsOf: url)
//            let json = String(data: data, encoding: .utf8)
//
//            DispatchQueue.main.async {
//                completion (json ?? "")
//            }
//        }
//    }
    
    // Observable의 생명주기
    // 1. Create
    // 2. Subscribe <- Observable은 이 때 실행된다.
    // 3. onNext
    // 4. onCompleted || onError
    // 5. Disposed
    // 동작이 끝난 Observable은 재사용을 할 수 없다.
    
    // 1. 비동기로 생기는 데이터를 Observable로 감싸서 리턴하는 방법
    func downloadJson(_ url: String) -> Observable<String?> {
        // 나중에생기는데이터() == Observable.create()
//        return Observable.create { emitter in
//            emitter.onNext("Hello world")!
//            emitter.onCompleted()
//            return Disposables.create()
//        }
        
        return Observable.just("Hello world")
        // just: 딱 하나만 보낼 수 있다. 배열로 보내면 배열이 하나의 이벤트
        // from: 배열로 보낼 수 있음. 배열 요소마다 하나의 이벤트
        //
    }
    
    // MARK: SYNC
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        self.setVisibleWithAnimation(self.activityIndicator, true)
        // 네트워크로부터 받아오는 경우 비동기 처리 필요
        
        // 2. Observable로 오는 데이터를 받아서 처리하는 방법
        let observable = downloadJson(MEMBER_LIST_URL)
        let disposable = observable
            .map { json in json?.count ?? 0 } // operator
            .filter { cnt in cnt > 0 }  // operator
            .map { "\($0), "} // operator
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe(onNext: { json in
                self.editView.text = json
                self.setVisibleWithAnimation(self.activityIndicator,
                                             false)
            })
        // subscribeOn? 맨 위에 시작할 스레드를 지정.
        // 해당 함수의 시작을 어디에서 할 것인가?
        // observeOn? 이 다음 실행할 스레드를 지정
        disposable.dispose()
    }
}

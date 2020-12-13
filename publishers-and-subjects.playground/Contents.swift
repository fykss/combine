import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "Type erasure") {
    // 1
    let subject = PassthroughSubject<Int, Never>()
    
    // 2
    let publisher = subject.eraseToAnyPublisher()
    // Publisher has type AnyPublisher
    
    // 3
    publisher
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    // 4
    subject.send(0)
    
}

// -----------------------------

//example(of: "CurrentValueSubject") {
//
//    var subscriptions = Set<AnyCancellable>()
//
//    var subject = CurrentValueSubject<Int, Never>(0)
//
//    subject
//        .print()
//        .sink { print($0) }
//        .store(in: &subscriptions)
//
//    print("Current value \(subject.value)")
//    subject.send(2)
//    print("Current value \(subject.value)")
//
//    subject
//        .print()
//        .sink { print("Second \($0)") }
//        .store(in: &subscriptions)
//}

// -----------------------------

//example(of: "PassthroughSubject") {
//    // 1
//    enum MyError: Error {
//        case test
//    }
//
//    // 2
//    final class StringSubscriber: Subscriber {
//        typealias Input = String
//        typealias Failure = MyError
//
//        func receive(subscription: Subscription) {
//            subscription.request(.max(2))
//        }
//
//        func receive(_ input: String) -> Subscribers.Demand {
//            print("Received value", input)
//            // 3
//            return input == "World" ? .max(1) : .none
//        }
//
//        func receive(completion: Subscribers.Completion<MyError>) {
//            print("Received completion", completion)
//        }
//    }
//
//    // 4
//    let subscriber = StringSubscriber()
//
//    // 5
//    let subject = PassthroughSubject<String, MyError>()
//
//    // 6
//    subject.subscribe(subscriber)
//
//    // 7
//    let subscription = subject
//        .sink(
//            receiveCompletion: { completion in
//                print("Received completion (sink)", completion)
//            },
//            receiveValue: { value in
//                print("Received value (sink)", value)
//            }
//        )
//
//    subject.send("Hello")
//    subject.send("World")
//
//    subscription.cancel()
//
//    subject.send("Still here?")
//
//    subject.send(completion: .failure(MyError.test))
//    subject.send(completion: .finished)
//    subject.send("Another")
//}

// -----------------------------

//example(of: "Future") {
//    func futureIncrement(
//        integer: Int,
//        afterDelay delay: TimeInterval) -> Future<Int, Never> {
//        Future<Int, Never> { promise in
//            print("Original")
//            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
//                promise(.success(integer + Int(delay)))
//            }
//        }
//    }
//
//    let future = futureIncrement(integer: 1, afterDelay: 3)
//
//    future
//        .sink(receiveCompletion: { print($0) },
//              receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//    future
//        .sink(receiveCompletion: { print("Second", $0) },
//        receiveValue: { print("Second", $0) })
//        .store(in: &subscriptions)
//}

// -----------------------------

//example(of: "assign(to:)") {
//    class SomeObject {
//        @Published var value: Int = 0
//    }
//
//    let object = SomeObject()
//
//    object.$value.sink {
//        print($0)
//    }
//
//    (0..<10).publisher.assign(to: &object.$value)
//}

// -----------------------------

//example(of: "Just") {
//    // 1
//    let just = Just("Hello world!")
//
//    // 2
//    _ = just
//        .sink(
//            receiveCompletion: {
//                print("Received completion", $0)
//            },
//            receiveValue: {
//                print("Received value", $0)
//            })
//}

// -----------------------------

//example(of: "Subscriber") {
//    let myNotification = Notification.Name("MyNotification")
//
//    let publisher = NotificationCenter.default
//        .publisher(for: myNotification, object: nil)
//
//    let center = NotificationCenter.default
//
//    // 1
//    let subscription = publisher.sink { _ in
//        print("Notification received from a publisher!")
//    }
//
//    // 2
//    center.post(name: myNotification, object: nil)
//    // 3
//    subscription.
//
// -----------------------------
//
//example(of: "Publisher") {
//    // 1
//    let myNotification = Notification.Name("MyNotification")
//
//    // 2
//    let publisher = NotificationCenter.default
//        .publisher(for: myNotification, object: nil)
//
//    // 3
//    let center = NotificationCenter.default
//
//    // 4
//    let observer = center.addObserver(
//        forName: myNotification,
//        object: nil,
//        queue: nil) { notification in
//        print("Notification received!")
//    }
//
//    // 5
//    center.post(name: myNotification, object: nil)
//
//    // 6
//    center.removeObserver(observer)
//}

public func example(of description: String,
                    action: () -> Void) {
    print("\n——— Example of:", description, "———")
    action()
}

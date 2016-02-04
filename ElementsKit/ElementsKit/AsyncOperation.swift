import Foundation

public class AsyncOperation<T>: NSOperation {
  private var _executing = false
  private var _finished = false
  private let onComplete: Outcome<T> -> Void

  public init(onComplete: Outcome<T> -> Void) {
    self.onComplete = onComplete
    super.init()
  }

  override private(set) public var executing: Bool {
    get {
      return _executing
    }
    set {
      willChangeValueForKey("isExecuting")
      _executing = newValue
      didChangeValueForKey("isExecuting")
    }
  }

  override private(set) public var finished: Bool {
    get {
      return _finished
    }
    set {
      willChangeValueForKey("isFinished")
      _finished = newValue
      didChangeValueForKey("isFinished")
    }
  }

  override public var asynchronous: Bool {
    return true
  }

  override public func start() {
    if cancelled {
      finished = true
      return
    }

    executing = true
    autoreleasepool {
      run()
    }
  }

  public func run() {
    preconditionFailure("AsyncOperation.run() abstract method must be overridden.")
  }

  func finishedExecutingOperation() {
    executing = false
    finished = true
  }

  public func finishedExecutingOperationWithOutcome(outcome: Outcome<T>) {
    finishedExecutingOperation()
    onComplete(outcome)
  }
}

import Foundation

public protocol Action {
  var executing: Bool { get }
  var finished: Bool { get }
  var cancelled: Bool { get }

  func start()
  func cancel()
}

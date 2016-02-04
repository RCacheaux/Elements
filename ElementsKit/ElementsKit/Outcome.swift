import Foundation

public typealias VoidOutcome = Outcome<Void>

public enum Outcome<T> {
  case Success(T)
  case Error(ErrorType)
  case Cancelled

  public init(resultOrNil: T?, errorOrNil: ErrorType?) {
    if let error = errorOrNil {
      self = .Error(error)
      return
    }
    if let result = resultOrNil {
      self = .Success(result)
      return
    }
    self = .Error(ProgrammerError.EncounteredNilResultAndNilErrorOutcome)
  }

  public init<A>(somethingOrNothing: A?, resultIfSomething: T, errorIfNothing: ErrorType) {
    if let _ = somethingOrNothing {
      self = .Success(resultIfSomething)
    } else {
      self = .Error(errorIfNothing)
    }
  }
}

enum ProgrammerError: ErrorType {
  case EncounteredNilResultAndNilErrorOutcome
}

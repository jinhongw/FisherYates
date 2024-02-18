//
//  random.swift
//
//
//  Created by jinhong on 2024/2/17.
//

#if os(Linux)
  import Glibc
#else
  import Darwin.C
#endif

#if canImport(Darwin)
import Darwin

public func random<T: BinaryInteger> (_ n: T) -> T {
  return numericCast( arc4random_uniform( numericCast(n) ) )
}

#elseif canImport(Glibc)

import Glibc

public func random<T: BinaryInteger> (_ n: T) -> T {
  precondition(n > 0)

  let upperLimit = RAND_MAX - RAND_MAX % numericCast(n)

  while true {
    let x = Glibc.random()
    if x < upperLimit { return numericCast(x) % n }
  }
}

#else
#error("unsupported platform")
#endif

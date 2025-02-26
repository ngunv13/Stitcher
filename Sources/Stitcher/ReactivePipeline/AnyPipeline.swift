//
//  AnyPipeline.swift
//
//
//  Created by Αθανάσιος Κεφαλάς on 12/3/24.
//

import Foundation

#if canImport(Combine)
import Combine
#endif

struct AnyPipeline<Output>: Pipeline {
    
    private final class NoneProvider {
        let id = UUID()
    }
    
    let erasedProvider: Any
    
    init() {
        erasedProvider = NoneProvider()
    }
    
    init<P: Pipeline>(_ other: P) where P.Output == Output {
        self.erasedProvider = other.erasedProvider
    }
    
    @available(iOS 13.0, macOS 10.15, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
    init(_ other: Combine.AnyPublisher<Output, Never>) {
        self.erasedProvider = other
    }
}

extension Pipeline {
    
    func erasedToAnyPipeline() -> AnyPipeline<Output> {
        AnyPipeline(self)
    }
}

@available(iOS 13.0, macOS 10.15, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
extension Combine.Publisher where Failure == Never {
    
    func erasedToAnyPipeline() -> AnyPipeline<Output> {
        AnyPipeline(self.eraseToAnyPublisher())
    }
}

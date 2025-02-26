//
//  PipelineSubject.swift
//
//
//  Created by Αθανάσιος Κεφαλάς on 12/3/24.
//

import Foundation

#if canImport(Combine)
import Combine
#endif

class PipelineSubject<Output>: Pipeline {
    
    private let provider: AnyObject
    private let _send: (Output) -> Void
    
    let erasedProvider: Any
    
    init() {
        
            let subject = Combine.PassthroughSubject<Output, Never>()
            self.provider = subject
            self.erasedProvider = subject.eraseToAnyPublisher()
            self._send = { subject.send($0) }
        
    }
    
    deinit {
        print("")
    }
    
    func send(_ value: Output) {
        _send(value)
    }
}

extension PipelineSubject where Output == Void {
    
    func send() {
        self.send(())
    }
}

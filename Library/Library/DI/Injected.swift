//
//  Injected.swift
//  Library
//
//  Created by endurovojta173 on 25.05.2026.
//

@propertyWrapper
struct Injected<T> {
    let wrappedValue: T

    init() {
        wrappedValue = DIContainer.shared.resolve()
    }
}

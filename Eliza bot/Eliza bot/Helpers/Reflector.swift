//
//  Reflector.swift
//  Eliza bot
//
//  Created by Тимур Чеберда on 10.03.2023.
//

import Foundation

struct Reflector {
    func reflect(sentence: String) -> String {
        let reflected = sentence
            .components(separatedBy: .whitespaces)
            .map { reflect(word: $0, with: StaticData.reflections) }
        
        return reflected
            .dropFirst()
            .reduce("\(reflected[0])", { $0 + " " + $1 })
    }
}

private extension Reflector {
    func reflect(word: String, with reflections: [String: String]) -> String {
        reflections[word] ?? word
    }
}

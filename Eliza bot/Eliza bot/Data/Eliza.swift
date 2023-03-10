//
//  Eliza.swift
//  Eliza bot
//
//  Created by Тимур Чеберда on 10.03.2023.
//

import Foundation

extension String {
    func removingAllSymbols() -> String {
        filter { character in
            character
                .unicodeScalars
                .allSatisfy { !CharacterSet.symbols.contains($0) }
        }
    }
}

struct Eliza {
    func reply(to message: String) -> String {
        let message = message
            .removingAllSymbols()
            .lowercased()
        
        return transform(message: message)
    }
}

private extension Eliza {
    func transform(message: String) -> String {
        StaticData.rules
            .map { ($0, $0.matchFor(sentence: message)) }
            .first(where: { (rule, result) in result != nil })
            .map { (rule, result) -> String in
                guard let result else { return "" }
                
                return rule.replies[Int.random(in: 0 ..< rule.replies.count)]
                    .replacingOccurrences(of: "*", with: Reflector().reflect(sentence: result))
            } ?? "..."
    }
}

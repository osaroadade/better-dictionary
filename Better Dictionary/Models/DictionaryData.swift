//
//  DictionaryData.swift
//  Better Dictionary
//
//  Created by Osaro on 11/07/2024.
//

import Foundation



struct DictionaryData: Codable {
    let word: String
    let phonetics: [Phonetics]
    let meanings: [Meanings]
}

struct Phonetics: Codable {
    let text: String
}

struct Meanings: Codable {
    let partOfSpeech: String
    let definitions: [Definitions]
}

struct Definitions: Codable {
    let definition: String
}

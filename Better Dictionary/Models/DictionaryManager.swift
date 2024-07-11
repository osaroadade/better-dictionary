//
//  DictionaryManager.swift
//  Better Dictionary
//
//  Created by Osaro on 11/07/2024.
//

import Foundation

protocol DictionaryManagerDelegate {
    func didFetchDefinition(_ dictionaryManager: DictionaryManager, dictionary: DictionaryModel)
}

struct DictionaryManager {

    var delegate: DictionaryManagerDelegate?
    
    let baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    func defineWord(word: String) {
        let urlString = baseURL + word
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let safeData = data else { return }
        
            
            guard let dictionary = self.parseJSON(safeData) else { return }
            
            
            self.delegate?.didFetchDefinition(self, dictionary: dictionary)
        }
        
        task.resume()
    }
    
    func parseJSON(_ dictionaryData: Data) -> DictionaryModel? {
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode([DictionaryData].self, from: dictionaryData)
            let definedWord = decodedData[0].word
            let phonentics = decodedData[0].phonetics[0].text
            let wordMeaning = decodedData[0].meanings[0].definitions[0].definition
            let partSpeech = decodedData[0].meanings[0].partOfSpeech
            
            let dictionary = DictionaryModel(word: definedWord, phonetics: phonentics, meaning: wordMeaning, partOfSpeech: partSpeech)
            
            return dictionary
            
        } catch {
            print("This is what failed")
            return nil
        }
    }
}

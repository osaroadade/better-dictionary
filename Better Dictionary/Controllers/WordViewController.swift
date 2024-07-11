//
//  ViewController.swift
//  Better Dictionary
//
//  Created by Osaro on 10/07/2024.
//

import UIKit

class WordViewController: UIViewController {
    
    var definedWord = ""
    var phonentics = ""
    var wordMeaning = ""
    var partSpeech = ""
    
    var dictionaryManager = DictionaryManager()
    
    @IBOutlet weak var wordInputText: UITextField!
    @IBOutlet weak var pageDescription: UILabel!
    @IBOutlet var uiView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dictionaryManager.delegate = self
    }

    @IBAction func getDefinitionButton(_ sender: UIButton) {
        
        guard let word = wordInputText.text, !word.isEmpty else {
            pageDescription.text = "Please input a word to search for."
            pageDescription.textColor = .productBrown
            return
        }
        
        dictionaryManager.defineWord(word: wordInputText.text!)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDefinition" {
            let destinationVC = segue.destination as! DefinitionViewController
            DispatchQueue.main.async {
                destinationVC.word = self.definedWord
                destinationVC.fetchedPartOfSpeech = self.partSpeech
                destinationVC.fetchedPhoneticsText = self.phonentics
                destinationVC.fetchedWordMeaning = self.wordMeaning
            }
        }
    }
}

extension WordViewController: DictionaryManagerDelegate {
    func didFetchDefinition(_ dictionaryManager: DictionaryManager, dictionary: DictionaryModel) {
        DispatchQueue.main.async {
            self.definedWord = dictionary.word
            self.phonentics = dictionary.phonetics
            self.wordMeaning = dictionary.meaning
            self.partSpeech = dictionary.partOfSpeech
            
            print(self.definedWord)
            
            self.performSegue(withIdentifier: "goToDefinition", sender: self)
            print(self.definedWord)
            self.wordInputText.text = ""
        }
    }
    
}

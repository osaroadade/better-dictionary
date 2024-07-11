//
//  DefinitionViewController.swift
//  Better Dictionary
//
//  Created by Osaro on 10/07/2024.
//

import UIKit

class DefinitionViewController: UIViewController {
    
    var word = ""
    var fetchedPartOfSpeech = ""
    var fetchedPhoneticsText = ""
    var fetchedWordMeaning = ""
    
    
    @IBOutlet weak var definedWord: UILabel!
    @IBOutlet weak var partOfSpeech: UILabel!
    @IBOutlet weak var phoneticsText: UILabel!
    @IBOutlet weak var wordMeaning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async {
            self.definedWord.text = self.word
            self.partOfSpeech.text = self.fetchedPartOfSpeech
            self.phoneticsText.text = self.fetchedPhoneticsText
            self.wordMeaning.text = self.fetchedWordMeaning
        }
        
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }

}

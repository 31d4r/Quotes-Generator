//
//  ViewController.swift
//  RandomQuotes
//
//  Created by Eldar Tutnjic on 01/05/2020.
//  Copyright © 2020 Eldar Tutnjic. All rights reserved.
//

import UIKit
import SafariServices

struct Quotes: Decodable{
    let text: String
    let author: String?
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var quoteText: UILabel!
    @IBOutlet weak var quoteAuthor: UILabel!
    @IBOutlet weak var generateBtn: UIButton!
    
    
    @IBAction func generateQuoteBtn(_ sender: Any) {
        
    }
    
    @IBAction func openSafariDonateBtn(_ sender: Any) {
        showSafariVC(for: "https://www.paypal.me/eldartutnjic")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://type.fit/api/quotes"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            
            do {
                let quoteData = try JSONDecoder().decode([Quotes].self, from: data)
                 DispatchQueue.main.async {
                    let quoteAuthorIndex = quoteData.randomElement()
                    self.quoteText.text = quoteAuthorIndex?.text
                    self.quoteAuthor.text = quoteAuthorIndex?.author
                }
                
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func showSafariVC(for url: String){
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
}

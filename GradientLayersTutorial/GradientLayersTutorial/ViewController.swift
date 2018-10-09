//
//  ViewController.swift
//  GradientLayersTutorial
//
//  Created by Stephen Feuerstein on 10/9/18.
//  Copyright © 2018 Refactor Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let cellID = "Cell"
    let gradientLayer = CAGradientLayer()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.cellID)
            tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTopFade()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: tableView.frame.origin.y, width: tableView.bounds.width, height: 40.0)
    }
    
    func addTopFade() {
        gradientLayer.frame = CGRect(x: 0, y: tableView.frame.origin.y, width: tableView.bounds.width, height: 40.0)
        gradientLayer.colors = [UIColor(white: 1, alpha: 1).cgColor, UIColor(white: 1, alpha: 0.0).cgColor]
        view.layer.addSublayer(gradientLayer)
    }
    
    func randomString(ofLength length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""
        
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        
        return randomString
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellID, for: indexPath)
        let length = Int.random(in: 5..<25)
        cell.textLabel?.text = randomString(ofLength: length)
        return cell
    }
}

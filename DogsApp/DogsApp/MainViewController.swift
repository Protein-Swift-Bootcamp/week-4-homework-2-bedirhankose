//
//  MainViewController.swift
//  DogsApp
//
//  Created by Bedirhan Köse on 08.01.23.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var smallImageView: UIImageView!
    @IBOutlet weak var largeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    @IBAction func buttonTapped(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            present(vc, animated: true)
        }
    }
    

}


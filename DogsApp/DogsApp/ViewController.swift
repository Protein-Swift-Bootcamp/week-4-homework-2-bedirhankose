//
//  ViewController.swift
//  DogsApp
//
//  Created by Bedirhan Köse on 07.01.23.
//

import UIKit

class ViewController: UIViewController {
    
    var dogAllData : DogData?
    var dogImageAllLinks = [String]()
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    
    func fetchData() {
        let url = URL(string: "https://dog.ceo/api/breed/eskimo/images")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil
            else {
                print("Error Occured While Accesing Data")
                return
                
            }
            var dogObject : DogData?
            do {
                dogObject = try JSONDecoder().decode(DogData.self, from: data)
            }
            catch {
                print("Error Occured While Decoding JSON into Swift Structure \(error)")
            }
            self.dogAllData = dogObject
            self.dogImageAllLinks = self.dogAllData!.message
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
            
        }
        task.resume()
    }
}

extension UIImageView {
    func downloadImage(from url : URL) {
        let activitiyIndicator = UIActivityIndicatorView(style: .medium)
        activitiyIndicator.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        activitiyIndicator.hidesWhenStopped = true
        activitiyIndicator.startAnimating()
        //activitiyIndicator.translatesAutoresizingMaskIntoConstraints = false
        activitiyIndicator.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.addSubview(activitiyIndicator)
        contentMode = .scaleToFill
        image = nil
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, let mimeType = response?.mimeType, mimeType.hasPrefix("image"), let data = data, error == nil, let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
                activitiyIndicator.stopAnimating()
            }
        }
        dataTask.resume()
    }
}
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogImageAllLinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! myTableViewCell
        let urlImage = URL(string: (dogAllData?.message[indexPath.row])!)
        cell.myImageView.downloadImage(from: urlImage!)
        cell.myImageView.layer.cornerRadius = 50
        return cell
    }
}

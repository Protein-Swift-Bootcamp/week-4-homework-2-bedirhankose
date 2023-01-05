//
//  ViewController.swift
//  DogApp
//
//  Created by Bedirhan Köse on 03.01.23.
//

import UIKit

class ViewController: UIViewController {

    var dogAllData : DogData?
    var dogImageAllLinks = [String]()
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()

    }
    func fetchData() {
        let url = URL(string: "https://dog.ceo/api/breed/hound/images")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data = data , error == nil else {
                print("Error Occured While Accessing WebAPI")
                return
            }
            var dogObject: DogData?
            do {
                dogObject = try JSONDecoder().decode(DogData.self, from: data)
            } catch {
                print("Error While Decoding JSON into Swift Structure \(error)")
            }
            self.dogAllData = dogObject
            self.dogImageAllLinks = self.dogAllData!.message
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
            
        }
        task.resume()
    }


}
extension UIImageView {
    func downloadImage(from url: URL) {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.addSubview(activityIndicator)
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
                activityIndicator.stopAnimating()
            }
                  
            
        }
        dataTask.resume()
    }
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogImageAllLinks.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        let urlImage = URL(string: dogImageAllLinks[indexPath.row])
        cell.myImageView.downloadImage(from: urlImage!)
        cell.myImageView.layer.cornerRadius = 50
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
    
    
}


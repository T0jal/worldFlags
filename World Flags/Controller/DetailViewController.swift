//
//  DetailViewController.swift
//  World Flags
//
//  Created by António Rocha on 22/10/2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var selectedFlagNumber = 0
    var totalFlags = 0
    var countriesNames = [String?]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "\(countriesNames[selectedFlagNumber-1]!.uppercased())"
        
        //Give a border to the image
        imageView.layer.borderWidth = 1
        //Make the border gray
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    @objc func shareFlag() {
        //Get the image safely, managing the possible error. Also make a small compression (0 it's min and 1 is max)
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8)
        else {
            print("No image found")
            return
        }
        
        guard let imageName = countriesNames[selectedFlagNumber-1]?.uppercased()
        else {
            print("Unknown")
            return
        }
        
        let shareName = "Flag of \(imageName)"
        
        let items: [Any] = [image, shareName]
        
        //Indicate what will be shared
        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
        //Necessary because of iPads to indicate where the popover comes from
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

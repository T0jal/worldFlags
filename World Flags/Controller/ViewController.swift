//
//  ViewController.swift
//  World Flags
//
//  Created by António Rocha on 21/10/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()
    var countriesNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "World Flags"
        //Makes the title larger
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Load the project images. It looks for them in the project folder.
        let fm      = FileManager.default
        let path    = Bundle.main.resourcePath!
        let items   = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            //Filter the images I want to use based on the sufix
            if item.hasSuffix("2x.png") {
                flags.append(item)
                //Get the countries' names to the use them on the Details Page
                let start = item.index(item.startIndex, offsetBy: 0)
                let end = item.index(item.endIndex, offsetBy: -7)
                let range = start..<end
                let countryName = item[range]
                countriesNames.append(String(countryName))
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flags.count
    }
    
    //Show the flags on the list
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        return cell
    }
    
    //Enlarge the height of the rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //Send the necessary Data to the DetailViewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = flags[indexPath.row]
            vc.selectedFlagNumber = indexPath.row + 1
            vc.totalFlags = flags.count
            vc.countriesNames = countriesNames
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



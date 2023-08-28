//
//  DetailViewController.swift
//  CatLib
//
//  Created by Carlos Eduardo dos Santos on 17/08/23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catOrigin: UILabel!
    @IBOutlet weak var catLifespan: UILabel!
    @IBOutlet weak var catWeight: UILabel!
    @IBOutlet weak var catTemperament: UILabel!
    @IBOutlet weak var catDescriptions: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
    
    var cat: Cat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catImageView.layer.masksToBounds = true
        catImageView.contentMode = .scaleAspectFill
        catImageView.backgroundColor = .gray
        
        configure(with: cat)
    }

    func configure(with cat: Cat) {
        catName.text = cat.name
        catOrigin.text = cat.origin
        catLifespan.text = "\(cat.lifespan) years"
        catWeight.text = "\(cat.weight) kg"
        catTemperament.text = cat.temperament
        catDescriptions.text = cat.description
        catImageView.download(from: cat.url)
    }
}

//
//  UIImaveView+Download.swift
//  CatLib
//
//  Created by Carlos Eduardo dos Santos on 17/08/23.
//

import UIKit

extension UIImageView {
    func download(from imagePath: String) {
        let url = URL(string: imagePath)!

        URLSession.shared.dataTask(with: .init(url: url)) { data, _, error in
            if error != nil { return }

            if let data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } else { return }
        }.resume()
    }
}

//
//  ImagenViewController.swift
//  AppNoticias
//
//  Created by Mac4 on 26/10/21.
//

import UIKit
import SafariServices

class ImagenViewController: UIViewController {

    @IBOutlet weak var IV_ImagenURL: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let url = URL(string: "https://programacion.net/files/article/20161110041116_image-not-found.png")
        {
            DispatchQueue.global().async { [weak self] in
                //Se crea un objeto de tipo data a partir de una URL
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.IV_ImagenURL.image = image
                        }
                    }
                }
            }
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

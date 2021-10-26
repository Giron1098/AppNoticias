//
//  NoticiasViewController.swift
//  AppNoticias
//
//  Created by Mac4 on 26/10/21.
//

import UIKit

//MARK:- Estructuras necesarias

struct Noticias:Codable {
    var articles:[Noticia]
}

struct Noticia:Codable {
    var source:Fuente?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
}

struct Fuente:Codable {
    var name:String?
}

class NoticiasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var noticias = [Noticia]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Casteo del objeto celda a la nueva celda personalizada
        let celda = TBL_V_News.dequeueReusableCell(withIdentifier: "celdaNoticias", for: indexPath) as! NoticiaTableViewCell
        celda.LBL_Titulo.text = noticias[indexPath.row].title
        celda.LBL_Description.text = noticias[indexPath.row].description
        celda.LBL_Fuente.text = "Fuente: \(noticias[indexPath.row].source?.name ?? "")"
        
        
        if let url = URL(string: noticias[indexPath.row].urlToImage!)
        {
            DispatchQueue.global().async { [weak self] in
                //Se crea un objeto de tipo data a partir de una URL
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            celda.IV_Noticia.image = image
                        }
                    }
                }
            }
        } else {
            if let url_error = URL(string: "https://programacion.net/files/article/20161110041116_image-not-found.png")
            {
                DispatchQueue.global().async { [weak self] in
                    //Se crea un objeto de tipo data a partir de una URL
                    if let data = try? Data(contentsOf: url_error) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                celda.IV_Noticia.image = image
                            }
                        }
                    }
                }
            }
            
        }
        
        return celda
    }
    

    @IBOutlet weak var TBL_V_News: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registrar la celda personalizada que creamos
        
        TBL_V_News.register(UINib(nibName: "NoticiaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaNoticias")
        
        //Métodos para el TableView
        TBL_V_News.delegate = self
        TBL_V_News.dataSource = self
        
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=f0797ef3b62d4b90a400ed224e0f82b7&country=mx"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
             parse(json: data)
            }
        }

    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        print("Se parsea y crea el decoder")
        if let jsonPeticion = try? decoder.decode(Noticias.self, from: json) {
            print("Peticiones: \(jsonPeticion.articles.count)")
            noticias = jsonPeticion.articles
            print("news: \(noticias.count)")
            TBL_V_News.reloadData()
        } else {
            print("No entró")
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

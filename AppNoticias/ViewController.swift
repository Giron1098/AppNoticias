//
//  ViewController.swift
//  AppNoticias
//
//  Created by Mac4 on 25/10/21.
//

import UIKit

//MARK:- Estructuras necesarias

struct Petition:Codable {
    var title:String
    var body:String
}

struct Petitions:Codable {
    var results:[Petition]
}

class ViewController: UIViewController {
    
    //Arreglo para guardar la inforación de las peticiones JSON
    
    var petitions = [Petition]()

    @IBOutlet weak var TBL_V_Noticias: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registrar la celda personalizada que creamos
        TBL_V_Noticias.register(UINib(nibName: "NoticiaTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        //Métodos del TableView
    
        TBL_V_Noticias.delegate = self
        TBL_V_Noticias.dataSource = self
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString)
        {
            if let data = try? Data(contentsOf: url)
            {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            TBL_V_Noticias.reloadData()
        }
    }


}


//Se implementan los métodos de delegado para la TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Casteo del objeto celda a la nueva celda personalizada
        let celda = TBL_V_Noticias.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! NoticiaTableViewCell
        celda.LBL_Titulo.text = petitions[indexPath.row].title
        celda.LBL_Description.text = petitions[indexPath.row].body
        celda.LBL_Fuente.text = "FUENTE"
        celda.IV_Noticia.image = UIImage(systemName: "note.text")
        
        return celda
        
    }
    
    
}

//
//  NoticiaTableViewCell.swift
//  AppNoticias
//
//  Created by Mac4 on 26/10/21.
//

import UIKit

class NoticiaTableViewCell: UITableViewCell {

    @IBOutlet weak var IV_Noticia: UIImageView!
    @IBOutlet weak var LBL_Titulo: UILabel!
    @IBOutlet weak var LBL_Description: UILabel!
    @IBOutlet weak var LBL_Fuente: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  LibroDetalleController.swift
//  BuscadorLibrosTablas
//
//  Created by Ulises Ramirez on 16/6/17.
//  Copyright © 2017 Ulises Ramirez. All rights reserved.
//

import UIKit

class LibroDetalleController: UIViewController {
    
    var libro : Libro!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var portadaImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Detalle del libro"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tituloLabel.text = self.libro.titulo
        isbnLabel.text = "ISBN: " + self.libro.isbn
        autorLabel.text = self.formatearAutores(self.libro.autores)
        portadaImageView.image = self.libro.imagen
    }

    func formatearAutores (_ authors: [String]) -> String {
        
        var prefix = String()
        var authorList = String()
        
        for author in authors {
            
            authorList = authorList + prefix + author
            prefix = "\n"
        }
        
        return authorList
    }
}

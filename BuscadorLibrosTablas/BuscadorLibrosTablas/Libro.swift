//
//  Libro.swift
//  BuscadorLibrosTablas
//
//  Created by Ulises Ramirez on 16/6/17.
//  Copyright © 2017 Ulises Ramirez. All rights reserved.
//

import Foundation
import UIKit

struct Libro {
    
    var isbn : String!
    var titulo = "Sin Título"
    var autores = ["Sin Autores"]
    var imagen = UIImage()
    
    init (isbnCode: String) {
        
        self.isbn = isbnCode
    }
    
    init (isbnCode: String, title: String, authors: [String], cover: UIImage) {
        
        self.isbn = isbnCode
        self.titulo = title
        self.autores = authors
        self.imagen = cover
    }
}

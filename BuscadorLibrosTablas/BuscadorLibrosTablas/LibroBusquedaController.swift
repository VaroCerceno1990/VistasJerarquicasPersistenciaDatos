//
//  LibroBusquedaController.swift
//  BuscadorLibrosTablas
//
//  Created by Ulises Ramirez on 16/6/17.
//  Copyright © 2017 Ulises Ramirez. All rights reserved.
//

import UIKit

class LibroBusquedaController: UIViewController {
    
    @IBOutlet weak var isbnTextField: UITextField!
    var libro : Libro!
    var listadoLibro : ListadoLibrosController!
    let baseurl = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Búsqueda"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        isbnTextField.text = nil
        (segue.destination as! LibroDetalleController).libro = self.libro

    }
    
    func BuscarInfoLibro (isbnBusqueda: String) -> Libro?{
        
        var book = Libro(isbnCode: isbnBusqueda, title: "Título No Definido", authors: [ "Autor No Definido" ], cover: UIImage())
        
        if Reachability.shared.isConnectedToNetwork()
        {
           let url=NSURL(string: baseurl + isbnBusqueda)
            let datos:NSData?=NSData(contentsOf: url! as URL)
                       do{
                if let json = try JSONSerialization.jsonObject(with: datos! as Data, options:
                    JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]{
                    if let bookJson = json["ISBN:" + isbnBusqueda] as? [String : AnyObject] {
                        
                        if let authors = bookJson["authors"] as? [AnyObject] {
                            
                          book.autores.removeAll()
                            
                            
                            for author in authors {
                                book.autores.append(author["name"] as! String)
                            }
                        }
                        
                        if let title = bookJson["title"] as? String {
                            
                            book.titulo = title
                        }
                        
                        if let cover = bookJson["cover"]?["large"] as? String {
                            
                            if let coverImg = UIImage(data: try! Data(contentsOf: URL(string: cover)!)) {
                                
                               book.imagen = coverImg
                            }
                        }
                    }
                    else{
                       
                        showAlertMessage(title: "Error", message: "El ISBN digitado no existe", owner: self)
                       
                        return nil
                    }
                }
               
            }

            catch  _ {
                
            }
            
        }
            
        else{
            
            showAlertMessage(title: "Error", message: "Por favor revise la conexión de internet e intente nuevamente", owner: self)
            isbnTextField.text=""
                       return nil
        
        }
               return book
        
    }
    
    
    func BuscarLibroEnTabla (isbn: String) -> Libro! {
        
        var libroEncontrado : Libro!
        
        for libro in listadoLibro.listadoLibros {
            
            if isbn == libro.isbn{
                
                libroEncontrado = libro
                break
            }
        }
        
        return libroEncontrado
    }
    
    
   
    
  
    
    
    @IBAction func BuscarLibro(_ sender: UITextField) {
        sender.resignFirstResponder()
        if let isbn = sender.text, !isbn.isEmpty {
         
            if let book = BuscarLibroEnTabla(isbn: isbn) {
                
                self.libro = book
                performSegue(withIdentifier: "LibroSegue", sender: sender)
                
            } else {
              
                let bookAux:Libro?=BuscarInfoLibro(isbnBusqueda: isbn)
              
                if((bookAux) != nil)
                {
                self.libro = bookAux
                self.listadoLibro.listadoLibros.append(bookAux!)
                
                self.performSegue(withIdentifier: "LibroSegue", sender: sender)
                }
                
            }
        }
        else{
             showAlertMessage(title: "Error", message: "Por favor digite el ISBN a buscar e intente nuevamente", owner: self)
        }

    }
    
    func showAlertMessage (title: String, message: String, owner:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (ACTION :UIAlertAction!)in
        }))
        self.present(alert, animated: true, completion: nil)
    }


}

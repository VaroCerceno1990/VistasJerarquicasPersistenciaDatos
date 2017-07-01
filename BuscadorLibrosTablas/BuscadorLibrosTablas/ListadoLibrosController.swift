//
//  ListadoLibrosController.swift
//  BuscadorLibrosTablas
//
//  Created by Ulises Ramirez on 16/6/17.
//  Copyright © 2017 Ulises Ramirez. All rights reserved.
//

import UIKit
import CoreData

class ListadoLibrosController: UITableViewController{

    
    var listadoLibros = [Libro]()
     var context: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        CargarLibros()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listadoLibros.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaLibro", for: indexPath)
        
        cell.textLabel?.text = listadoLibros[indexPath.row].titulo

        // Configure the cell...

        return cell
    }
 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (sender is UITableViewCell) {
            
            (segue.destination as! LibroDetalleController).libro = listadoLibros[tableView.indexPathForSelectedRow!.row]
        }
        
        if (sender is UIBarButtonItem) {
            
            (segue.destination as! LibroBusquedaController).listadoLibro = self
        }
    }
    
    
//Cargue libros de la BD
func CargarLibros () {
    
    let bookEntity = NSEntityDescription.entity(forEntityName: "Libro", in: context!)
    
    let fetchAllBooks = bookEntity?.managedObjectModel.fetchRequestTemplate(forName: "TodosLibros")
    
    do {
    
    let libroEncontrados = try context.fetch(fetchAllBooks!)
    
    for libroEncontrado in libroEncontrados {
    
    let isbnLibro = (libroEncontrado as AnyObject).value(forKey: "isbnLibro") as! String
    let titleLibro = (libroEncontrado as AnyObject).value(forKey: "tituloLibro") as! String
    let authorLibro = (libroEncontrado as AnyObject).value(forKey: "autorLibro") as! [String]
    let portadaLibro = (libroEncontrado as AnyObject).value(forKey: "imagenLibro")


    var libro=Libro(isbnCode: isbnLibro, title: titleLibro, authors: authorLibro, cover: UIImage())
    
        if portadaLibro != nil {
            libro.imagen = UIImage(data: portadaLibro as! Data)!
        }
        
        listadoLibros.append(libro)
      }
    
    } catch {
    
    print("\(#function): Unable to execute fetch request!")
    }
    }

  
}

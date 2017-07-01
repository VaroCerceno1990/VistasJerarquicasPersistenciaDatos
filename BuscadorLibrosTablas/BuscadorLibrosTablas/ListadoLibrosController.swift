//
//  ListadoLibrosController.swift
//  BuscadorLibrosTablas
//
//  Created by Ulises Ramirez on 16/6/17.
//  Copyright © 2017 Ulises Ramirez. All rights reserved.
//

import UIKit

class ListadoLibrosController: UITableViewController{

    
    var listadoLibros = [Libro]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

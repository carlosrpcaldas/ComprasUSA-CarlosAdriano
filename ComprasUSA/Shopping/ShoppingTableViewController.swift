//
//  TableViewController.swift
//  ComprasUSA
//
//  Created by admin on 4/17/18.
//  Copyright © 2018 Carlos P Caldas. All rights reserved.
//

import UIKit
import CoreData

class ShoppingTableViewController: UITableViewController {

    let labelLista = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
    var retrieveResultController: NSFetchedResultsController<Product>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        labelLista.text = "Sua lista está vazia!"
        labelLista.textAlignment = .center
        
        loadAllProdutcts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddProductViewController, let indexPath = tableView.indexPathForSelectedRow {
            vc.produto = retrieveResultController.object(at: indexPath)
        }
    }
    
    func loadAllProdutcts() {
        let retrieveRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        retrieveRequest.sortDescriptors = [sortDescriptor]
        
        retrieveResultController = NSFetchedResultsController(fetchRequest: retrieveRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        retrieveResultController.delegate = self
        
        do {
            try retrieveResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = retrieveResultController.fetchedObjects?.count {
            tableView.backgroundView = (count == 0) ? labelLista : nil
            return count
        } else {
            tableView.backgroundView = labelLista
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProdutoTableViewCell
        
        let product = retrieveResultController.object(at: indexPath)
        
        cell.lbProductName.text = product.name
        
        cell.lbValor.text = "$ \(String(format: "%.2f", product.value))"
        
        if let stateName = product.states?.name {
            cell.lbEstado.text = stateName
        }
        
        if let image = product.title as? UIImage {
            cell.ivTitle.image = image
        }
        
        cell.lbSimNao.text = product.card ? "Cartão" : ""
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let product = retrieveResultController.object(at: indexPath)
            context.delete(product)
            do {
                try context.save()
                loadAllProdutcts()
            } catch {
                print(error.localizedDescription)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
}

extension ShoppingTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
    
    



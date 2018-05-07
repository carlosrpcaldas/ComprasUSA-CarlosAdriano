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
    
/*
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
    
 //   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 //       if let vc = segue.destination as? AddProductViewController, let indexPath = tableView.indexPathForSelectedRow {
 //           vc.produto = retrieveResultController.object(at: indexPath)
 //       }
 //   }
    


    
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
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // nao tem
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
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
        
        cell.lbValor.text = "$ \(String(format: "%.2f", product.value.description))"
        
        cell.lbEstado.text = product.states?.name
        print("Nome do estado CoreData: \(product.states?.name)")
        /// descr
        ///cell.iptinlbNomeProduto.text = produto.nome
        //cell.lbValor.text =  produto.valor.description
        //cell.lbEstado.text = produto.states?.nome
        //cell.lbCartao.text = produto.cartao ? "Sim" : "Não"
        
        if let image = product.title as? UIImage {
            cell.ivTitle.image = image
        }
        
        cell.lbSimNao.text = product.card ? "Sim" : "Não"
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let product = retrieveResultController.object(at: indexPath)
        
        context.delete(product)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddProductViewController {
            if tableView.indexPathForSelectedRow != nil {
                vc.produto = retrieveResultController.object(at: tableView.indexPathForSelectedRow!)
            }
        }
    }
    
    
}

extension ShoppingTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
    
    
*/

    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
    var fetchedResultController: NSFetchedResultsController<Product>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProdutos()
        
        tableView.estimatedRowHeight = 106
        tableView.rowHeight = UITableViewAutomaticDimension
        
        label.text = "Sua lista está vazia!"
        label.textAlignment = .center
        label.textColor = .black
        
    }
    
    func loadProdutos() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedResultController.fetchedObjects?.count {
            tableView.backgroundView = (count == 0) ? label : nil
            return count
        } else {
            tableView.backgroundView = label
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProdutoTableViewCell
        let produto = fetchedResultController.object(at: indexPath)
        
        cell.lbProductName.text = produto.name
        cell.lbValor.text =  produto.value.description
        cell.lbEstado.text = produto.states?.name
        cell.lbSimNao.text = produto.card ? "Sim" : "Não"
        if let image = produto.title as? UIImage {
            cell.ivTitle.image = image
        } else {
            cell.ivTitle.image = nil
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let produto = fetchedResultController.object(at: indexPath)
        context.delete(produto)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddProductViewController {
            if tableView.indexPathForSelectedRow != nil {
                vc.produto = fetchedResultController.object(at: tableView.indexPathForSelectedRow!)
            }
        }
    }
    
}
extension ShoppingTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}



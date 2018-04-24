//
//  SettingViewController.swift
//  ComprasUSA
//
//  Created by admin on 4/19/18.
//  Copyright © 2018 Carlos P Caldas. All rights reserved.
//


import UIKit
import CoreData

enum Type {
    case add
    case edit
}

class SettingViewController: UIViewController {
    
    
    @IBOutlet weak var tfQuotation: UITextField!
    @IBOutlet weak var tdIOF: UITextField!
    @IBOutlet weak var tvState: UITableView!
    
    var product: Product!
    var data : [State] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfQuotation.keyboardType = .decimalPad
        tdIOF.keyboardType = .decimalPad
        
        tvState.delegate = self
        tvState.dataSource = self
        
        loadState()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadState() {
        let fetchRequest: NSFetchRequest<State> = State.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            data = try context.fetch(fetchRequest)
            tvState.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(Double(tfQuotation.text!), forKey: "dolar_preference")
        UserDefaults.standard.set(Double(tdIOF.text!), forKey: "iof_preference")
    }
    
    override func viewWillAppear(_ animated: Bool) {
       tfQuotation.text = UserDefaults.standard.string(forKey: "dolar_preference")!
        tdIOF.text = UserDefaults.standard.string(forKey: "iof_preference")!
    }
    
    func showAlert(type: Type, estado: State?) {
        let title = (type == .add) ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: "\(title) estado", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textStateField: UITextField) in
            textStateField.placeholder = "Nome do estado"
            if let name = estado?.name {
                textStateField.text = name
            }
        }
        
        alert.addTextField { (textImpostoField: UITextField) in
            textImpostoField.placeholder = "Imposto"
            textImpostoField.keyboardType = .decimalPad
            if let imposto = estado?.taxes {
                textImpostoField.text = String( imposto )
            }
        }
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action: UIAlertAction) in
            let state = estado ?? State(context: self.context)
            state.name = alert.textFields?.first?.text
            let valeu = alert.textFields![1].text
            state.taxes = Double( valeu! )!
            do {
                try self.context.save()
                self.loadState()
            } catch {
                print(error.localizedDescription)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func add(_ sender: Any) { showAlert(type: .add, estado: nil)
    }
    
    
}


extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let state = dataSource[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)!
        if cell.accessoryType == .none {
            //cell.accessoryType = .checkmark
        } else {
            //cell.accessoryType = .none
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Excluir") { (action: UITableViewRowAction, indexPath: IndexPath) in
            let estado = self.data[indexPath.row]
            self.context.delete(estado)
            try! self.context.save()
            self.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Editar") { (action: UITableViewRowAction, indexPath: IndexPath) in
            let estado = self.data[indexPath.row]
            tableView.setEditing(false, animated: true)
            self.showAlert(type: .edit, estado: estado)
        }
        editAction.backgroundColor = .blue
        return [editAction, deleteAction]
    }
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StateTableViewCell
        let estado = data[indexPath.row]
        cell.lbState?.text = estado.name
        cell.lbTax?.text = String( estado.taxes )
        return cell
    }
    
}

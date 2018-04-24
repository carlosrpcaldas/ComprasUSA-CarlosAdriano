//
//  TaxesViewController.swift
//  ComprasUSA
//
//  Created by admin on 4/19/18.
//  Copyright © 2018 Carlos P Caldas. All rights reserved.
//
//  Copyright © 2018 Adriano R P L. All rights reserved.
//


import UIKit
import CoreData


var data: [Product] = []


    class TotalViewController: UIViewController {
        
        
        @IBOutlet weak var lbTotalUS: UILabel!
        @IBOutlet weak var lbTotalRS: UILabel!
        

        var formatter = NumberFormatter()
        var quota: Double = 0
        var iof: Double = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            // Do any additional setup after loading the view.
            loadProdutos()
            var totalGrossValue: Double = 0
            var totalNetValue: Double = 0
            for product in data {
                totalGrossValue += product.value
                totalNetValue += calculateNetValue(product)
            }
            
            lbTotalUS.text = String( totalGrossValue )
            lbTotalRS.text = String( totalNetValue )
        }
        
        func loadProdutos() {
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            do {
                
               data = try context.fetch(fetchRequest)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func calculateNetValue(_ product: Product) -> Double {
            
            let cotacao = UserDefaults.standard.double(forKey: "dolar_preference")
            let iof = UserDefaults.standard.double(forKey: "iof_preference")
            let realValue = (product.value * cotacao)
            let stTaxes: Double
            
            //data = formater.string(from: product.states!.taxes)
            // formatter.locale = Locale(identifier: "pt-BR")
            // formater.numberstyle = .none
            // print(textfield.text!)
            
            if Int(product.states!.taxes) <= 0 {
                stTaxes = product.states!.taxes
            }else {
                stTaxes = 1.0
            }
            
            let netValue = realValue * (1 + stTaxes/100)
            
            return product.card ? netValue * (1 + iof/100) : netValue
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
       
}

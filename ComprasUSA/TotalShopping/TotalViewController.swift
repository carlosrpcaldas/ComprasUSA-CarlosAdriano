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
                totalNetValue += calculateTotal(product)
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
        
        func calculateTotal(_ product: Product) -> Double {
            
            let cotacao = UserDefaults.standard.double(forKey: "dolar_preference")
            let iof = UserDefaults.standard.double(forKey: "iof_preference")
            let stTaxes: Double
            let totalDolarTaxes: Double
            var totalRValue: Double
            
            print("Valor do imposto CoreData: \(product.states?.taxes)")
            
            // calculo dolar total + % imposto estado
            if Int(product.states!.taxes) > 0 {
                stTaxes = product.states!.taxes
                print("Valor do imposto : \(stTaxes)")
                //number=(percentage/100)*totalNumber
                totalDolarTaxes = ((product.states!.taxes/100) * product.value) + product.value
            }else {
                totalDolarTaxes = product.value
            }

            
            // total de dolar com imposto  - exibe na tela
            
            print("total de dolar com imposto: \(totalDolarTaxes)")

            // calculo de com imposto * cotacao do dolar
            // valor em reais
            let realValue = totalDolarTaxes * cotacao
            totalRValue = realValue
            print("valor em reais: \(totalRValue)")
            

//            if iof > 0{
//                totalRValue = realValue * (realValue * iof/100)
//            }
            
            // valor em reias * o IOF
            // Total em reais - exibe na tela

            return product.card ? totalRValue + ((iof/100) * totalRValue)  : totalRValue

            //data = formater.string(from: product.states!.taxes)
            // formatter.locale = Locale(identifier: "pt-BR")
            // formater.numberstyle = .none
            // print(textfield.text!)
            

            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
       
}

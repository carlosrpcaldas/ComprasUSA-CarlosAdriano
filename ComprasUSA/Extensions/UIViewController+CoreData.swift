//
//  UIViewController+CoreData.swift
//  ComprasUSA
//
//  Created by admin on 4/21/18.
//  Copyright © 2018 Carlos P Caldas. All rights reserved.
//

import UIKit

import CoreData

extension UIViewController {

    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
}


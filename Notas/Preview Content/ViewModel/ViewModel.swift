//
//  ViewModel.swift
//  Notas
//
//  Created by Jose Bayon on 19/12/24.
//

import Foundation
import CoreData
import SwiftUI

//En ViewModel pongo la logica del CoreData

class ViewModel: ObservableObject {
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show : Bool = false
    @Published var updateItem : Notas!
 
    
    //CoreData metodo para Guardar datos
    
    func saveData(context: NSManagedObjectContext){
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha
        
        do {
            try context.save()
            print("Guardado ok")
            show.toggle()//para cerrar la vista modal
        } catch let error as NSError {
            print("No se guardo ", error.localizedDescription)
        }
        
    }
    
    //Metodo para borrar datos
    
    func deleteData(item: Notas, context: NSManagedObjectContext){
        context.delete(item)
        
        do {
            try context.save()
            print("Guardado ok")
        } catch let error as NSError {
            print("No se guardo ", error.localizedDescription)
        }
    }
    
    //Metodo poder editar datos
    
    func sendData(item: Notas) {
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    
    //Metodo para editar datos y guardar
    
    func editData(context: NSManagedObjectContext){
        updateItem.nota = nota
        updateItem.fecha = fecha
        
        do {
            try context.save()
            print("Editado ok")
            show.toggle()
        } catch let error as NSError {
            print ("Editado no guardado ", error.localizedDescription)
        }
    }
}

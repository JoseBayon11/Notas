//
//  addView.swift
//  Notas
//
//  Created by Jose Bayon on 19/12/24.
//

import SwiftUI

struct addView: View {
    
    @ObservedObject var model : ViewModel
    @Environment(\.managedObjectContext) var context //Conecta las vistas de SwiftUI con CoreData
    
    var body: some View {
        
        VStack {
            Text(model.updateItem != nil ? "Editar nota" : "Agregar una nota")
                .font(.headline)
                .bold()
            Spacer()
            
            TextEditor(text: $model.nota) //Accedo a la variable model que es de la clase ViewModel a la variable nota (dentro de la clase de ViewModel)
            Divider()
            DatePicker("Fecha", selection: $model.fecha)
            Spacer()
            
            Button (action: {
                
            }) {
            
                Button (action: {
                    if model.updateItem != nil {
                        model.editData(context: context)
                    } else {
                        model.saveData(context: context)
                    }
                }) {
                    Text("Guardar").foregroundColor(.white)
                }
 
            }.padding()
                .background(model.nota.isEmpty ? Color.gray :Color.blue)
                .cornerRadius(10)
                .disabled(model.nota.isEmpty)
        }.padding()
    }
}


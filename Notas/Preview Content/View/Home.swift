//
//  Home.swift
//  Notas
//
//  Created by Jose Bayon on 19/12/24.
//

import SwiftUI

struct Home: View {
    
    //Pongo StateObject porque no queremos que se resetee
    //La variable la igualo a ViewModel porque es la vista principal y no quiero darle ningun parametro
    @StateObject var model = ViewModel()
    
    @Environment(\.managedObjectContext) var context //Conecta las vistas de SwiftUI con CoreData
    
    //FetchRequest sirve para mostrar los datos guardados en la base de datos.
    @FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)],animation: .spring()) var results: FetchedResults<Notas>
    
    var body: some View {
        
        NavigationView {
            //Lista de los elementos de la variable results (dentro del Fetch request) Recorro item en un VStack y mostrara el texto de nota y fecha
            List {
                ForEach (results) { item in
                    VStack (alignment: .leading) {
                        Text(item.nota ?? "Sin notas")
                        Text(item.fecha ?? Date(), style: .date)
                        
                        
                        //Context menu es para dejar pulsado el botom y accione dos botones, editar y eliminar
                    }.contextMenu(ContextMenu(menuItems: {
                        Button (action: {
                            model.sendData(item: item)
                        }) {
                            Label(title: {
                                Text("Editar")
                            }, icon: {
                                Image(systemName: "pencil")
                            })
                        }
                        
                        Button (action: {
                            model.deleteData(item: item, context: context)
                        }) {
                            Label(title: {
                                Text("Eliminar")
                            }, icon: {
                                Image(systemName: "trash")
                            })
                        }
                    } ))
                    
                }
                
            }.navigationTitle("Notas")//Titulo de la app
            
                //Con navigationBarItems en trailing, colocamos el boton de + a la derecha
                .navigationBarItems(trailing: Button (action: { //Creamos un boton que al pulsarlo activa el toggle
                    model.show.toggle()
                }) {
                    //imagen del + para agregar notas
                    Image(systemName: "plus").bold()
                }.sheet(isPresented: $model.show, content: {
                    addView(model: model)
                }))
        }
        
        
    }
}

#Preview {
    Home()
}

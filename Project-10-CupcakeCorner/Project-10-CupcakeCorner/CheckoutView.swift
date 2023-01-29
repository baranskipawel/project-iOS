//
//  CheckoutView.swift
//  Project-10-CupcakeCorner
//
//  Created by Pawel Baranski on 18/01/2023.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    
    @State private var conformatingMessage = ""
    @State private var showingConfirmation = false
    
    @State private var showingAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order"){
                    Task{
                        await placeOrder()
                    }
                }.alert(isPresented: $showingAlert){
                    Alert(title: Text("Operation failed..."))
                    
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank u!", isPresented: $showingConfirmation){
            Button("OK") {
                
            }
        } message: {
            Text(conformatingMessage)
        }
        
    }
    
    func placeOrder() async{
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode data")
            return
        }
        
        do {
            
            let url = URL(string: "https://reqres.in/api/cupcakes")!
            var request = URLRequest(url : url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            conformatingMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        }
        catch {
            showingAlert = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}

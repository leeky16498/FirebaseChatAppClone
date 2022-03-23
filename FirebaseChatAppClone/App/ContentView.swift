//
//  ContentView.swift
//  FirebaseChatAppClone
//
//  Created by Kyungyun Lee on 23/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoginMode : Bool = false
    @State var email : String = ""
    @State var password : String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    Picker(selection: $isLoginMode, label : Text("Picker")) {
                        Text("Log in")
                            .tag(true)
                        Text("Create account")
                            .tag(false)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    if isLoginMode {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                        })
                    }
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                    
                    Button(action: {
                        
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Create Account")
                                .foregroundColor(.white)
                                .padding()
                            Spacer()
                        }
                        .background(.blue)
                        .cornerRadius(20)
                        .padding()
                    })
                    
                }
            }
            .navigationBarTitle("Create Account")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

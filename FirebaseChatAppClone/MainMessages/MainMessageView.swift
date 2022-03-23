//
//  MainMessageView.swift
//  FirebaseChatAppClone
//
//  Created by Kyungyun Lee on 23/03/2022.
//

import SwiftUI

struct MainMessageView: View {
    
    @State var showLogout : Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Image(systemName: "person.fill")
                        .font(.largeTitle.bold())
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Username")
                                .font(.largeTitle.bold())
                            Spacer()
                            Button(action: {
                                showLogout.toggle()
                            }, label: {
                                Image(systemName: "gear")
                            })
                            
                        }
                        .padding(.horizontal)
                        .actionSheet(isPresented: $showLogout) {
                            getActionSheet()
                        }
                        
                        HStack {
                            Circle()
                                .fill(.green)
                                .frame(width : 10, height: 10)
                            Text("Online")
                                .padding(.horizontal)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        .padding(.top, -20)
                    }
                }
                .padding(.horizontal)
                Divider()
                //custom nav bar
                ScrollView {
                    ForEach(0..<10, id: \.self) {num in
                        HStack{
                            Image(systemName: "person.fill")
                                .font(.largeTitle.bold())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 44)
                                        .stroke(.gray, lineWidth: 2)
                                )
                            
                            VStack(alignment: .leading) {
                                Text("username")
                                Text("message sent to user")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("22d")
                                .font(.callout)
                        }
                        .padding(.horizontal)
                        Divider()
                    }
                }
                
                Button(action: {
                    
                }, label: {
                    Text("New Message +")
                        .font(.headline)
                })
                
                .navigationBarHidden(true)
            }
        }
    }
    
    func getActionSheet() -> ActionSheet {
        
        let button1 : ActionSheet.Button = .destructive(Text("Sign out"))
        let button2 : ActionSheet.Button = .cancel(Text("Cancel"))
        
        return ActionSheet(title: Text("Settings"), message: Text("select your choice"), buttons: [button1, button2])
    }
}

struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageView()
    }
}

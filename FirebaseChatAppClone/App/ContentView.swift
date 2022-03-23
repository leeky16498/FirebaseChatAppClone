//
//  ContentView.swift
//  FirebaseChatAppClone
//
//  Created by Kyungyun Lee on 23/03/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

class FirebaseManager : NSObject {
    
    let auth : Auth
    let storage : Storage
    let firestore : Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        super.init()
    }
}

struct ContentView: View {
    
    @State var isLoginMode : Bool = false
    @State var email : String = ""
    @State var password : String = ""
    @State var shouldShowImagePicker : Bool = false
    @State var image : UIImage?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing : 16){
                    Picker(selection: $isLoginMode, label : Text("Picker")) {
                        Text("Log in")
                            .tag(true)
                        Text("Create account")
                            .tag(false)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    if !isLoginMode {
                        Button(action: {
                            shouldShowImagePicker.toggle()
                        }, label: {
                            VStack{
                                if let image = image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width : 80, height : 80)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 64))
                                        .padding()
                                }
                            }
                        })
                    }
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .background(.white)
                        .padding()
                    
                    
                    SecureField("Password", text: $password)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .background(.white)
                        .padding()
                    
                    Button(action: {
                        handleAction()
                    }, label: {
                        HStack{
                            Spacer()
                            Text(isLoginMode ? "Log in" : "Create Account")
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
            .navigationBarTitle(isLoginMode ? "Log in" : "Create Account")
            .fullScreenCover(isPresented : $shouldShowImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)
            }
            .background(Color(.init(gray: 0, alpha: 0.05)))
        }
    }
    
    func handleAction() {
        if isLoginMode {
            loginAccount(email: email, password: password)
        } else {
            createNewAccount(email: email, password: password)
        }
    }
    
    func loginAccount(email : String, password : String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error login")
                return
            }
            print("login success")
            return print(result?.user.uid ?? "")
        }
    }
    
    func createNewAccount(email : String, password : String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("There is error = \(error)")
                return
            }
            print(result?.user.uid ?? "")
            self.persistImageToStorage()
        }
    }
    
    func persistImageToStorage() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else {return}
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error image saving")
                return
            }
            ref.downloadURL { url, error in
                if let error = error {
                    print("error to download image")
                    return
                }
                print("success! \(url?.absoluteString ?? "")") // 저장에 성공한 경우의 함수
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

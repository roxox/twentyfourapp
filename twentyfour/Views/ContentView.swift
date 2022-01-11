//
//  ContentView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 09.03.21.
//

import SwiftUI
import CoreData

var offsetForMenu: CGFloat = -20

struct ContentView: View {
    //
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // viewModels
    @EnvironmentObject var usersViewModel: UsersViewModel
    @EnvironmentObject var appSettingsViewModel: AppSettingsViewModel
//    @ObservedObject var appSettingsViewModel = AppSettingsViewModel()
    @ObservedObject var chatDetailsViewModel = ChatDetailsViewModel()
    
    
    //
    
    @State var loggedIn = UserDefaults.standard.value(forKey: "isLoggedIn") as? Bool ?? false
    @State var newProfile = UserDefaults.standard.value(forKey: "newProfile") as? Bool ?? false
    @State var showLogin = UserDefaults.standard.value(forKey: "showLogin") as? Bool ?? false
    @State var showRegister = UserDefaults.standard.value(forKey: "showRegister") as? Bool ?? false
    @State var userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
    
    @State var viewIndex = 0
    
    @State private var isLogInPresented = false
    
    @State var showSideMenu = false
    
    
    func printUsersCount() {
        print("User Count \(usersViewModel.users.count)")
    }
    
    func dismissLoginView() {
        appSettingsViewModel.showLogin = false
        print("hallo")
    }
    
    var body: some View {
//        NavigationView() {
        GeometryReader { geometry in
            VStack() {
                if userId.isEmpty {
                    ZStack(){
                        Image("50")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width)
                            .edgesIgnoringSafeArea(.all)
                        
                        LogInView()
                            .edgesIgnoringSafeArea(.all)
                        
//                        Overlay if Screen is open
                        Color.black.opacity(showLogin ? 0.85 : showRegister ? 0.85 : 0.0)
                                    .edgesIgnoringSafeArea(.all)
                                .animation(.easeInOut(duration: 0.4))
                        
                        SignInView()
                            .edgesIgnoringSafeArea(.all)
                            .offset(y: showLogin ? 35 : screenHeight)
                                            .animation(.easeInOut)
                        
                        SignUpView()
//                            .edgesIgnoringSafeArea(.all)
                            .offset(y: showRegister ? 35 : screenHeight)
                    }
//                    .animation(.easeInOut)
                    
                } else {
                    ZStack() {
                        
                            Image("back21")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width)
                                .edgesIgnoringSafeArea(.all)
                        
                        HomeView()
                            .edgesIgnoringSafeArea(.all)
                        
                        
                        if showSideMenu {
                            Color.clear
                                .edgesIgnoringSafeArea(.all)
                        }
                        
                        SideMenu(showSideMenu: $showSideMenu)
                            .edgesIgnoringSafeArea(.all)
                            .offset(x: showSideMenu ? screenWidth/2 : screenWidth)
                                            .animation(.easeInOut)
                    }
//                    TabTestView()
                }
            }
            
            .onAppear {
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("showLoginChange"), object: nil, queue: .main) { (_) in
                    let showLogin = UserDefaults.standard.value(forKey: "showLogin") as? Bool ?? false
                    self.showLogin = showLogin
                }
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("showRegisterChange"), object: nil, queue: .main) { (_) in
                    let showRegister = UserDefaults.standard.value(forKey: "showRegister") as? Bool ?? false
                    self.showRegister = showRegister
                }
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("isLoggedInChange"), object: nil, queue: .main) { (_) in
                    let loggedIn = UserDefaults.standard.value(forKey: "isLoggedIn") as? Bool ?? false
                    self.loggedIn = loggedIn
                }
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("userIdChange"), object: nil, queue: .main) { (_) in
                    let userId = UserDefaults.standard.value(forKey: "userId") as? String ?? ""
                    self.userId = userId
                }
                
                usersViewModel.fetchData({ (success) -> Void in
                    print(success)
                   //
                })
                chatDetailsViewModel.fetch()
            }
            
        }
//        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct BlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        return view
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {

    }

}

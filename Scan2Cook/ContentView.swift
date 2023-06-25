//
//  ContentView.swift
//  Scan2Cook
//
//  Created by Haikal Lazuardi Fadil on 20/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            //TODO: Uncomment on final version
//            Group {
//                if (UserDefaults.standard.object(forKey: "isNotFirstTimer") != nil) {
//                    HomeView()
//                } else {
//                    OnboardingView()
//                }
//            }
//            OnboardingView()
            
            //Camera View
            CameraView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  HomeView.swift
//  TotalityAssesment
//
//  Created by Varun Bagga on 27/09/23.
//
import SwiftUI

struct HomeView: View {
    
    // Namespace for Geometry animation connecting elements
    @Namespace private var namespace
    
    @State var isShowingExpandedScreen : Bool = false
    @State var selectedID: UUID = UUID()
    
    var body: some View {
        ZStack {
            if !isShowingExpandedScreen {
                // For Home Cards
                ScrollView {
                    ForEach(User.samples) { user in
                        CardView(namespace: namespace, isShowingExpandedScreen: $isShowingExpandedScreen, selectedID: $selectedID, user: user)
                            .padding()
                    }
                }
            } else {
                // For Expanded Cards View
                ForEach(User.samples) { user in
                    if user.id == selectedID {
                        CardExpandView(namespace: namespace, isShowingExpandedScreen: $isShowingExpandedScreen, user: user)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

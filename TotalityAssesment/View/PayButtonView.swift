//
//  PayButtonView.swift
//  TotalityAssesment
//
//  Created by Varun Bagga on 27/09/23.
//

import SwiftUI

struct PayButtonView: View {
    
    var namespace: Namespace.ID
    
    @Binding var isDownloaded: Bool
    
    var user: User = User.samples[0]

    @State var isPayPressed: Bool = false
    @State private var isBlinking = false
    
    // Tracking the blinking timing
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .foregroundColor(.blue)
                .frame(width: UIScreen.main.bounds.width - 40, height: 60)
                .matchedGeometryEffect(id: "button2\(user.id)", in: namespace)
            Text("PLAY")
                .foregroundColor(.white)
                .font(.title2)
        }
        .offset(y: isDownloaded ? 0 : UIScreen.main.bounds.height)
        .opacity(isDownloaded ? 1 : 0)
        .opacity(isBlinking ? 0.5 : 1)
        .animation(.easeIn(duration: 0.4), value: isDownloaded)
        .transition(.move(edge: .bottom))
        // Toggling isBlinking again and again after 0.4s
        .onReceive(timer){ _ in
            withAnimation(.spring()){
                isBlinking.toggle()
            }
        }
        .onTapGesture {
            // For Navigating to next screen
            withAnimation(.spring()) {
                isPayPressed.toggle()
            }
            // Turn of toggle animation isBlinking and Timer
            isBlinking = false
            timer.upstream.connect().cancel()
        }
        .sheet(isPresented: $isPayPressed) {
            PayButtonPressedView(namespace: namespace, user: user)
                .presentationDetents([.fraction(0.4)])
        }
    }
}

struct PayButtonView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        PayButtonView(namespace: namespace, isDownloaded: .constant(true))
    }
}

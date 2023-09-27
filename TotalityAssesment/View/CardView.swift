//
//  CardView.swift
//  TotalityAssesment
//
//  Created by Varun Bagga on 25/09/23.
//
import SwiftUI

struct CardView: View {
    
    var namespace: Namespace.ID
    @Binding var isShowingExpandedScreen: Bool
    @Binding var selectedID : UUID
    
    var user: User = User.samples[0]
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                profileImage
                Spacer()
                downloadButtonView
                    .matchedGeometryEffect(id: "button\(user.id)", in: namespace)
                    .matchedGeometryEffect(id: "button2\(user.id)", in: namespace)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height / 2)
            .background(
                Color.orange
                    .cornerRadius(32)
            )
        }
        .onTapGesture {
            selectedID = user.id
            withAnimation(.spring()){
                isShowingExpandedScreen.toggle()
            }
        }
    }
    
    private var profileImage: some View {
        HStack {
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(.yellow)
                .frame(width: 100, height: 100)
                .cornerRadius(32)
                .clipped()
                .matchedGeometryEffect(id: user.id, in: namespace)
            Spacer()
        }
    }
    
    private var downloadButtonView: some View {
        RoundedRectangle(cornerRadius: 32)
            .foregroundColor(.green)
            .frame(width: UIScreen.main.bounds.width - 60, height: 60)
    }
}

struct CardView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
            CardView(namespace: namespace, isShowingExpandedScreen: .constant(false), selectedID: .constant(User.samples[0].id))
    }
}

//
//  SheetViewTwo.swift
//  TotalityAssesment
//
//  Created by Varun Bagga on 27/09/23.
//

import SwiftUI

struct SheetViewTwo: View {
    
    var namespace: Namespace.ID
    
    @Binding var viewAppear : [Bool]
    @State var selectedButton: Int = 5
    
    var user: User = User.samples[0]
    
    var body: some View {
        
        VStack {
            
            profileName
            
            amount
                .offset(x: viewAppear[1] ? 0 : UIScreen.main.bounds.width)
                .animation(.easeIn(duration: 0.6).delay(0.3), value: viewAppear[1])
            
            walletAmount
                .matchedGeometryEffect(id: "wallet", in: namespace)
                .animation(.easeIn(duration: 0.6).delay(0.6), value: viewAppear[1])
            
        }
    }
    
    private var profileName: some View {
        VStack {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 180,height: 30)
                .foregroundColor(.gray.opacity(0.3))
                .font(viewAppear[1] ? .system(size: 24) : .system(size: 8))
                .animation(.spring(response: 0.6, blendDuration: 1), value: viewAppear[0])
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 140,height: 30)
                .foregroundColor(.gray.opacity(0.3))
                .font(.subheadline)
                .opacity(viewAppear[1] ? 1 : 0)
        }
    }
    
    private var amount: some View {
        HStack (spacing: 32){
            ZStack {
                Circle()
                    .foregroundColor(selectedButton == 5 ? .green : .gray)
                    .frame(width: 60)
                Text("5")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .onTapGesture {
                withAnimation(.linear){
                    selectedButton = 5
                }
            }
            
            ZStack {
                Circle()
                    .foregroundColor(selectedButton == 10 ? .green : .gray)
                    .frame(width: 60)
                Text("10")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .onTapGesture {
                withAnimation(.linear){
                    selectedButton = 10
                }

            }
            
            ZStack {
                Circle()
                    .foregroundColor(selectedButton == 15 ? .green : .gray)
                    .frame(width: 60)
                Text("15")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .onTapGesture {
                
                withAnimation(.linear){
                selectedButton = 15
                }
            }
        }
    }
    
    private var walletAmount: some View {
        HStack {
            Text("Wallet Amount :")
                .foregroundColor(.primary)
                .font(.subheadline)
             RoundedRectangle(cornerRadius: 4)
                .frame(width: 70,height: 25)
                .foregroundColor(.gray.opacity(0.3))
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 4)
               .frame(width: 40,height: 30)
               .foregroundColor(.gray.opacity(0.3))
            RoundedRectangle(cornerRadius: 4)
               .frame(width: 20,height: 20)
               .foregroundColor(.gray.opacity(0.3))
        }
        .padding()
        .opacity(viewAppear[1] ? 1 : 0)
        .offset(y: viewAppear[1] ? 0 : 50)
    }
}

struct SecondSheetView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SheetViewTwo(namespace: namespace, viewAppear: .constant([false, true, true]))
    }
}

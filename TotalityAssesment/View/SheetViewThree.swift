//
//  SheetViewThree.swift
//  TotalityAssesment
//
//  Created by Varun Bagga on 27/09/23.
//

import SwiftUI

struct SheetViewThree: View {
    var namespace: Namespace.ID
    
    @Binding var viewAppear : [Bool]
    
    var body: some View {
        VStack {
            
            nameLabel
            
            level
                .offset(x: viewAppear[2] ? 0 : UIScreen.main.bounds.width)
                .animation(.easeIn(duration: 0.6).delay(0.3), value: viewAppear[2])
            
            walletAmount
                .matchedGeometryEffect(id: "wallet", in: namespace)
        }

    }
    
    private var nameLabel: some View {
        VStack {
            Text("READY TO PLAY")
                .frame(height: 30)
                .font(viewAppear[2] ? .system(size: 20) : .system(size: 8))
                .animation(.spring(response: 0.6, blendDuration: 1), value: viewAppear[0])
                .foregroundColor(.primary)
            
            Text("OSWALD")
                .frame(height: 30)
                .font(viewAppear[2] ? .system(size: 24) : .system(size: 8))
                .animation(.spring(response: 0.6, blendDuration: 1), value: viewAppear[0])
                .foregroundColor(.primary)
            HStack{
                RoundedRectangle(cornerRadius: 4)
                   .frame(width: 100,height: 25)
                   .foregroundColor(.gray.opacity(0.3))
                RoundedRectangle(cornerRadius: 4)
                   .frame(width: 60,height: 25)
                   .foregroundColor(.gray.opacity(0.3))
            }
           
        }
    }
    
    private var level: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: 90, height: 60)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: 90, height: 60)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: 90, height: 60)
            }
        }
        .padding(.vertical, 10)
    }
    
    private var walletAmount: some View {
        HStack {
            Text("Wallet Amount : ")
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
        .padding(.horizontal)
    }
}

struct ThirdSheetView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SheetViewThree(namespace: namespace, viewAppear: .constant([false, false, true]))
    }
}

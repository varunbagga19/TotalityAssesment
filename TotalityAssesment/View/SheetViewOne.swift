//
//  SheetViewOne.swift
//  TotalityAssesment
//
//  Created by Varun Bagga on 27/09/23.
//

import SwiftUI

struct SheetViewOne: View {
    @Binding var viewAppear : [Bool]
    var user: User = User.samples[0]
    
    var body: some View {
        VStack {
            profileName
            VStack {
                profileImage
                    .offset(x: viewAppear[0] ? 0 : UIScreen.main.bounds.width)
                    .animation(.easeIn(duration: 0.6), value: viewAppear[0])
            }
        }
    }
    
    private var profileName: some View {
        RoundedRectangle(cornerRadius: 4)
            .foregroundColor(.gray.opacity(0.3))
            .frame(width: 150, height: 30)
            .animation(.spring(response: 0.6, blendDuration: 1), value: viewAppear[0])
    }
    
    private var profileImage: some View {
        HStack (spacing: 32){
            
            VStack {
                
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(width: 90, height: 100)
                    .clipped()
                    .clipShape(Circle())
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 120,height: 20)
                    .foregroundColor(.gray.opacity(0.3))
                    .font(.system(size: 16))
                    .animation(.easeIn(duration: 0.4), value: viewAppear[0])
                    .foregroundColor(.primary)
                
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 80,height: 20)
                    .foregroundColor(.gray.opacity(0.3))
                    .animation(.easeIn(duration: 0.3), value: viewAppear[0])
                
                
            }
            
            VStack {
                RoundedRectangle(cornerRadius: 18)
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(width: 90, height: 100)
                    .clipped()
                    .clipShape(Circle())
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 120,height: 20)
                    .foregroundColor(.gray.opacity(0.3))
                    .font(.system(size: 16))
                    .animation(.easeIn(duration: 0.4), value: viewAppear[0])
                    .foregroundColor(.primary)
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 80,height: 20)
                    .foregroundColor(.gray.opacity(0.3))
                    .animation(.easeIn(duration: 0.3), value: viewAppear[0])
                
            }
        }
    }
}

struct FirstSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetViewOne(viewAppear: .constant([true, false, false]))
    }
}

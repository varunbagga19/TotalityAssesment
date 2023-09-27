//
//  PayButtonPressedView.swift
//  TotalityAssesment
//
//  Created by Varun Bagga on 27/09/23.
//

import SwiftUI

struct PayButtonPressedView: View {
    var namespace: Namespace.ID
    
    var user: User = User.samples[0]
    
    @State var nextButtonPressedTimes = 0
    
    @State var viewAppear  = [false, false, false]
    @State var selectedButton : Int = 5
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            if nextButtonPressedTimes == 0 {
                SheetViewOne(viewAppear: $viewAppear)
            }
            if nextButtonPressedTimes == 1 {
                SheetViewTwo(namespace: namespace, viewAppear: $viewAppear)
            }
            if nextButtonPressedTimes == 2 {
                SheetViewThree(namespace: namespace, viewAppear: $viewAppear)
            }
            Spacer()
            nextButton
                .onTapGesture {
                    nextButtonPressedTimes += 1
                    withAnimation(.linear){
                        if nextButtonPressedTimes < 3 {
                            viewAppear[nextButtonPressedTimes] = true
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
        }
        .padding()
        .onAppear{
            withAnimation(.linear) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    viewAppear[0] = true
                }
            }
        }
    }
        
    private var nextButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .foregroundColor(viewAppear[2] ? .black : .green)
                .frame(width: UIScreen.main.bounds.width - 40, height: 60)
                .matchedGeometryEffect(id: "button2\(user.id)", in: namespace)
            
            Text(viewAppear[2] ? "Confirm" : "Next")
                .foregroundColor(.white)
                .font(.title2)
        }
    }
}

struct AfterPayButtonView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        PayButtonPressedView(namespace: namespace)
    }
}

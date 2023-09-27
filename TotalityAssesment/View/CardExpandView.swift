//
//  CardExpandView.swift
//  TotalityAssesment
//
//  Created by Varun Bagga on 27/09/23.
//

import SwiftUI

struct CardExpandView: View {
    var namespace: Namespace.ID
    
    @Binding var isShowingExpandedScreen: Bool
    
    var user: User = User.samples[0]
    
    // Timer for  downloanding animation
    let timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
    
    //  Variables to track of download button animation
    @State var isDownloadButtonPressed: Bool = false
    @State var isDownloaded: Bool = false
    @State var progress: CGFloat = 0
    
    @State var appear = [false, false, false]
    
    var body: some View {
        ZStack (alignment: .top){
            xMark
            VStack(alignment: .center) {
                profileImageAndName
                    .padding(.horizontal)
                description
                    .padding(.horizontal)
                moviesList
                if !isDownloaded {
                    downloadButton
                        .matchedGeometryEffect(id: "button\(user.id)", in: namespace)
                }
                if isDownloaded {
                    PayButtonView(namespace: namespace, isDownloaded: $isDownloaded, user: user)
                }
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.easeOut.delay(0.4)) {
                appear[0] = true
            }
            withAnimation(.easeOut.delay(0.5)) {
                appear[1] = true
            }
            withAnimation(.easeOut(duration: 1.4).delay(0.9)) {
                appear[2] = true
            }
        }
        .onChange(of: isShowingExpandedScreen) { _ in
            appear[0] = false
            appear[1] = false
            appear[2] = false
        }
    }

    
    private var xMark: some View {
        HStack {
            Spacer()
            ZStack {
                Rectangle()
                    .frame(width: 1, height: appear[1] ? 24 : 0)
                    .rotationEffect(.degrees(45))
                    .animation(.linear(duration: 0.6), value: appear[1])
                Rectangle()
                    .frame(width: 1, height: appear[1] ? 24 : 0)
                    .rotationEffect(.degrees(-45))
                    .animation(.linear(duration: 0.6).delay(0.6), value: appear[1])
                
            }
            .padding()
            .frame(width: 50, height: 50)
            .padding()
            .offset(y: appear[1] ? 0 : -10)
            .opacity(appear[1] ? 1 : 0.5)
            .animation(.linear(duration: 0.6).delay(1.2), value: appear[1])
            .onTapGesture {
                withAnimation(.spring()){
                    isShowingExpandedScreen.toggle()
                }
            }
            
        }
    }
    
    private var profileImageAndName: some View {
        HStack {
            RoundedRectangle(cornerRadius: 18)
                .foregroundColor(.yellow)
                .frame(width: 100, height: 100)
                .cornerRadius(32)
                .clipped()
                .matchedGeometryEffect(id: user.id, in: namespace)
            
            VStack (alignment: .leading){
                Text("CANDY")
                    .font(.title2)
                    .offset(x: appear[0] ? 0 : 30)
                    .opacity(appear[0] ? 1 : 0)
                Text("BUST")
                    .font(.title2)
                    .offset(x: appear[0] ? 0 : 30)
                    .opacity(appear[0] ? 1 : 0)
            }
            .padding()
            
            Spacer()
        }
    }
    
    private var description: some View {
        VStack {
            Text("What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting")
                .foregroundColor(.gray)
                .fontWeight(.semibold)
                .padding(.top)
                .opacity(appear[1] ? 1 : 0)
                .transition(.move(edge: .bottom))
            Text("READ MORE")
                .foregroundColor(.green)
                .padding(.top, 4)
                .opacity(appear[1] ? 1 : 0)
        }
    }
    
    private var moviesList: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<4) { i in
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.7))
                        .frame(width: UIScreen.main.bounds.width / 1.4)
                        .frame(maxHeight: 455)
                        .cornerRadius(8)
                        .opacity(appear[2] ? 1 : 0)
                        .offset(x: appear[2] ? 0 : 48)
                        .padding(appear[2] ? 4 : 32)
                }
            }
        }
    }
    
    private var downloadButton: some View {
        Button {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)){
                isDownloadButtonPressed = true
            }
        } label: {
            if !isDownloadButtonPressed {
                regularDownloadButton
            } else {
                downloadingButton
            }
        }
    }
    
    private var regularDownloadButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .frame(width: UIScreen.main.bounds.width - 40, height: 60)
                .matchedGeometryEffect(id: "download", in: namespace)
                .foregroundColor(.green)
            VStack {
                Text("DOWNLOAD")
                Text("30.00 MB")
            }
            .foregroundColor(.white)
        }
    }
    
    private var downloadingButton: some View {
        HStack {
            ZStack (alignment: .leading){
                RoundedRectangle(cornerRadius: 32)
                    .frame(width: UIScreen.main.bounds.width - 80, height: 60)
                    .matchedGeometryEffect(id: "download", in: namespace)
                    .foregroundColor(.gray.opacity(0.3))
                    .padding(.leading)
                
                RoundedRectangle(cornerRadius: 32)
                    .frame(width: progress < 100 ? ((progress / 100) * (UIScreen.main.bounds.width - 80)) : (UIScreen.main.bounds.width - 80), height: 60)
                    .foregroundColor(progress > 100 ? .green : .green.opacity(0.6))
                    .padding(.horizontal)
                    .animation(.linear.delay(0.2), value: progress)
                
                HStack {
                    Spacer()
                    if progress <= 100 {
                        Text("\(Int((progress / 100) * 30))MB / 30MB")
                            .foregroundColor(.white)
                            .font(.title3)
                    } else {
                        Text("30MB / 30MB")
                            .foregroundColor(.white)
                            .font(.title3)
                    }
                    Spacer()
                }
                
            }
            .onReceive(timer){ _ in
                if progress <= 100 {
                    progress += 25
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                        withAnimation(.spring(response: 0.8, dampingFraction: 0.6)){
                            isDownloaded = true
                        }
                        timer.upstream.connect().cancel()
                        // Stop the timer when progress reaches 100
                    }
                }
            }
            
            Image(systemName: progress > 100 ? "checkmark.circle.fill" : "x.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.yellow)
            
            Spacer()
            
        }
    }
    
}

struct ExpandedCardView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CardExpandView(namespace: namespace, isShowingExpandedScreen: .constant(true))
    }
}

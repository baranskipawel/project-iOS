//
//  ContentView.swift
//  Project-6-Animations
//
//  Created by Pawel Baranski on 14/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }.onTapGesture {
            withAnimation{
                isShowingRed.toggle()
            }
        }
    }
}

struct CornerRotateModifier : ViewModifier {
    let amount : Double
    let anchor : UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

//VStack {
//    Button("Tap me") {
//        withAnimation{
//            isShowingRed.toggle()
//        }
//    }
//
//    if isShowingRed {
//        Rectangle().fill(.red)
//            .frame(width: 200, height: 200)
//            .transition(.scale)
//    }
//}

//struct ContentView: View {
//    let letters = Array("Hello SwiftUI")
//    @State private var enabled = false
//    @State private var dragAmount = CGSize.zero
//
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count, id: \.self) { num in
//                Text(String(letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(enabled ? .blue : .red)
//                    .offset(dragAmount)
//                    .animation(.default.delay(Double(num) / 20), value: dragAmount)
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { dragAmount = $0.translation }
//                .onEnded { _ in
//                    dragAmount = .zero
//                    enabled.toggle()
//                }
//        )
//    }
//}

//Button("Tap Me") {
//    enabled.toggle()
//}
//.frame(width: 200, height: 200)
//.background(enabled ? .blue : .red)
//.animation(nil, value: enabled)
//.foregroundColor(.white)
//.clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//.animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)

//Button("Tap Me") {
//    withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//        animationAmount += 360
//    }
//}
//.padding(50)
//.background(.red)
//.foregroundColor(.white)
//.clipShape(Circle())
//.rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 0, z: 1))


//print(animationAmout)
//
//return VStack {
//    Stepper("Scale amount", value: $animationAmout.animation(
//        .easeInOut(duration: 1).repeatCount(3, autoreverses: true)
//    ), in: 1...10)
//
//    Spacer()
//
//    Button("Tap Me") {
//        animationAmout += 1
//    }
//    .padding(50)
//    .background(.red)
//    .foregroundColor(.white)
//    .clipShape(Circle())
//    .scaleEffect(animationAmout)
//}

//Button("Tap Me") {
//    //animationAmout += 1
//}
//.padding(50)
//.background(.red)
//.foregroundColor(.white)
//.clipShape(Circle())
//.overlay(
//    Circle()
//    .stroke(.red)
//    .scaleEffect(animationAmout)
//    .opacity(2 - animationAmout)
//    .animation(
//        .easeInOut(duration: 3).repeatCount(3, autoreverses: false),
//        value: animationAmout
//    )
//)
//.onAppear {
//    animationAmout = 2
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

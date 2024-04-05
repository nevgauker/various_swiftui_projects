import SwiftUI

struct AnimatedLoader: View {
//    @State private var angle: Double = 270.0
    @State private var rotation: Double = 0.0

    func calculateOffset(angle: Double) -> CGSize {
        let radians = angle * .pi / 180
        let x = 100 * cos(radians)
        let y = 100 * sin(radians)
        return CGSize(width: x, height: y)
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 200, height: 200)
                Image("earth")
                Image(systemName: "airplane")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .offset(calculateOffset(angle: 270.0))
                    .rotationEffect(.degrees(rotation))
            }
            Text("Looking for the best flights")
                .font(.title)
            .onAppear {
                let _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    withAnimation {
                      //  angle += 1 // You can adjust the speed by changing the angle increment
                       rotation+=2
//                        if rotation == 360 { rotation = 0 }
                    }
                }
            }
            Spacer()
        }
    }
}

struct AnimatedLoader_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedLoader()
    }
}


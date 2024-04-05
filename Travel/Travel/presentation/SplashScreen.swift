import SwiftUI

struct SplashScreen: View {
    
    var body: some View {
        ZStack{
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            HStack{
                Text("Fllights")
                    .font(.title)
                    .foregroundColor(.white)
                Image(systemName: "airplane")
                    .foregroundColor(.white)
            }
        }
    }
}

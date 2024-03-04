import SwiftUI

struct Bottone: View {
    @State private var isAnimating = false

    var body: some View {
        Button(action: {
            // Your action here
        }) {
            Text("Hold to Animate")
                .padding()
                .background(isAnimating ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .onLongPressGesture(minimumDuration: 1, maximumDistance: 10, perform: {
            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                self.isAnimating = true
            }
        }) {_ in 
            self.isAnimating = false
        }
    }
}

struct Bottone_Previews: PreviewProvider {
    static var previews: some View {
        Bottone()
    }
}

import SwiftUI
import MapKit

struct FullMapView: View {
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 31.334_900,longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    @Environment(\.dismiss) private var dismiss
    let locationManager = CLLocationManager()
    
    var body: some View {
        HStack{
            Button("Back") {
                dismiss()
            }
        }
            Map (
                coordinateRegion: $region,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow)
            )
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(false)
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
            }
            
        
    }
}

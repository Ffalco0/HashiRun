import SwiftUI
import MapKit

struct FullMapView: View {
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 31.334_900,longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var regionBinding: Binding<MKCoordinateRegion> {
        .init(
            get: { region },
            set: { newValue in DispatchQueue.main.async { region = newValue } }
        )
    }
    
    @Environment(\.dismiss) private var dismiss
    let locationManager = CLLocationManager()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(
                coordinateRegion: regionBinding,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow)
            )
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
            }
            
            Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "x.circle")
                                .foregroundStyle(.accent)
                                .font(.system(size: 40))
                                .fontWeight(.semibold)
                                .padding()
                                
                        }
        }
    }
}

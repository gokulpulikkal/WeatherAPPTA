//
//  LocationManager.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

import CoreLocation
import Foundation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject, NetworkServiceProtocol {

    var lastKnownLocation: CLLocationCoordinate2D?
    var manager = CLLocationManager()

    var locationServiceIsActive: Bool = false
    @Published var locationCity: City?

    func checkLocationAuthorization() {
        manager.delegate = self
        manager.startUpdatingLocation()

        switch manager.authorizationStatus {
        case .notDetermined: // The user choose allow or denny your app to get the location yet
            manager.requestWhenInUseAuthorization()

        case .restricted: // The user cannot change this app’s status, possibly due to active restrictions such as
            // parental controls being in place.
            print("Location restricted")

        case .denied: // The user dennied your app to get location or disabled the services location or the phone is in
            // airplane mode
            print("Location denied")

        case .authorizedAlways: // This authorization allows you to use all location services and receive location
            // events whether or not your app is in use.
            print("Location authorizedAlways")

        case .authorizedWhenInUse: // This authorization allows you to use all location services and receive location
            // events only when your app is in use
            print("Location authorized when in use")
            lastKnownLocation = manager.location?.coordinate

        @unknown default:
            print("Location service disabled")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Trigged every time authorization status changes
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        getCityFromLocation()
    }

    func getCityFromLocation() {
        guard locationServiceIsActive else { return }
        Task {
            do {
                guard let coordinates = lastKnownLocation,
                      let request = Endpoint.getCityListFromCoordinates(
                          lat: coordinates.latitude,
                          long: coordinates.longitude
                      ).request
                else {
                    throw RequestError.unknown
                }
                let cityList = try await networkManager.makeRequest(
                    with: request,
                    respModel: [City].self
                )
                if let city = cityList.first {
                    await MainActor.run {
                        locationCity = city
                    }
                    
                }
            } catch {
                print("Error while reverse decoding location data")
            }
        }
    }
}

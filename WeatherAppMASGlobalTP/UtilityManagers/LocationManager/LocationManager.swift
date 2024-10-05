//
//  LocationManager.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

import CoreLocation
import Foundation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {

    var geoLocationDataRepository: GeoLocationDataRepositoryProtocol
    var lastKnownLocation: CLLocationCoordinate2D?
    var manager = CLLocationManager()

    var locationServiceIsActive = false
    @Published var locationCity: City?

    init(geoLocationDataRepository: GeoLocationDataRepositoryProtocol = GeoLocationDataRepository()) {
        self.geoLocationDataRepository = geoLocationDataRepository
    }

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
        guard locationServiceIsActive, let lastKnownLocation else {
            return
        }
        Task {
            do {
                let cityList = try await geoLocationDataRepository.getCityFromCoordinates(
                    lat: lastKnownLocation.latitude,
                    long: lastKnownLocation.longitude
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

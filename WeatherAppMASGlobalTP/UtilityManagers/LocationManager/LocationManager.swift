//
//  LocationManager.swift
//  WeatherAppMASGlobalTP
//
//  Created by Gokul P on 05/10/24.
//

import CoreLocation
import Foundation

/// LocationManager class is responsible for managing location services and retrieving city information based on the
/// user's location.
final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {

    /// Protocol for accessing geo-location data repository.
    var geoLocationDataRepository: GeoLocationDataRepositoryProtocol

    /// Stores the last known geographical coordinates.
    var lastKnownLocation: CLLocationCoordinate2D?

    /// Instance of CLLocationManager to manage location updates.
    var manager = CLLocationManager()

    /// Flag to indicate if location services are active. If set false no geo-coding with coordinates will happen
    var locationServiceIsActive = false

    /// Published property to store the current city based on location.
    @Published var locationCity: City?

    /// Initializer that sets up the geoLocationDataRepository, using a default implementation if none is provided.
    init(geoLocationDataRepository: GeoLocationDataRepositoryProtocol = GeoLocationDataRepository()) {
        self.geoLocationDataRepository = geoLocationDataRepository
    }

    /// Checks the authorization status for location services and starts updating the location.
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

    /// Delegate method triggered whenever the authorization status changes.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Trigged every time authorization status changes
        checkLocationAuthorization()
    }

    /// Delegate method called when the location manager updates the user's location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        Task {
            await getCityFromLocation()
        }
    }

    /// Asynchronously retrieves the city name from the last known location's coordinates.
    @MainActor
    func getCityFromLocation() async {
        // Ensure that location services are active and a last known location exists.
        guard locationServiceIsActive, let lastKnownLocation else {
            return
        }
        do {
            let cityList = try await geoLocationDataRepository.getCityFromCoordinates(
                lat: lastKnownLocation.latitude,
                long: lastKnownLocation.longitude
            )
            if let city = cityList.first {
                locationCity = city
            }
        } catch {
            print("Error while reverse decoding location data")
        }
    }
}

//
//  MapComponents.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 18.05.2021.
//

import CoreLocation

struct AnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct Shops: Identifiable {
    var location: String
    var price: Int
    var km: Double
    var coordinates: CLLocationCoordinate2D
    let id = UUID()
}

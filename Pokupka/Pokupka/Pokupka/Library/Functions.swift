//
//  Functions.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 16.05.2021.
//

import SwiftUI
import UserNotifications
import CoreLocation

extension String {
    mutating func randomCode () {
        self = String(Int.random(in: 1000...9999))
    }
}
func roundTo (_ x: Double) -> Double {
    return Double(round(10*x)/10)
}
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
    
}
struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}
extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

//Notice
func pushNotice (title: String, message: String) {
    let sendContent = UNMutableNotificationContent()
    sendContent.title = title
    sendContent.body = message
    sendContent.sound = UNNotificationSound.default
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(3), repeats: false)
    let require = UNNotificationRequest(identifier: UUID().uuidString, content: sendContent, trigger: trigger)
    UNUserNotificationCenter.current().add(require) { errors in
        if let errors = errors {
            print(errors.localizedDescription)
        }
    }
}


func removePendingNotice () {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
}

func removeDeliveredNotice () {
    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
}

func nullifyCounterNotice () {
    DispatchQueue.main.async {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

func requestAuthorizationNotice () {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound]) { response, error in
        if error != nil {
            print(error!.localizedDescription)
        }
    }
}

// Location

func getCoordinate(addressString : String, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
        if error == nil {
            if let placemark = placemarks?[0] {
                let location = placemark.location!
                completionHandler(location.coordinate, nil)
                return
            }
        }
        completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
    }
}


// Demo Products

func getProducts (_ count: Int) -> [DemoProduct] {
    var mass = [DemoProduct]()
    let titles = ["Гречка Макфа", "Кофе Motti", "Бананы 1 кг", "Вода Русская"]
    let images = [Image("Makfa"), Image("Coffee"), Image("Banana"), Image("Water")]
    for _ in 1...count {
        let index = Int.random(in: 0...3)
        mass.append(DemoProduct(inTitle: titles[index], inImage: images[index]))
    }
    return mass
}

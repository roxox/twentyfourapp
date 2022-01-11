//
//  Extensions.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.03.21.
//

import Foundation
import CoreLocation
import UIKit
import SwiftUI

public extension CLLocationCoordinate2D {

    func boundingBox(radius: CLLocationDistance) -> (max: CLLocationCoordinate2D, min: CLLocationCoordinate2D) {
        // 0.0000089982311916 ~= 1m
        let offset = 0.0000089982311916 * radius
        let latMax = self.latitude + offset
        let latMin = self.latitude - offset
        
        // 1 degree of longitude = 111km only at equator
        // (gradually shrinks to zero at the poles)
        // So need to take into account latitude too
        let lngOffset = offset * cos(self.latitude * .pi / 180.0)
        let lngMax = self.longitude + lngOffset
        let lngMin = self.longitude - lngOffset
        
        
        let max = CLLocationCoordinate2D(latitude: latMax, longitude: lngMax)
        let min = CLLocationCoordinate2D(latitude: latMin, longitude: lngMin)
        
        return (max, min)
    }
}

extension CLLocation {
    
    /// Get distance between two points
    ///
    /// - Parameters:
    ///   - from: first point
    ///   - to: second point
    /// - Returns: the distance in meters
    class func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distance(from: to)
    }
}

extension CLLocationCoordinate2D: Codable {
    public enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }
}

// extension for keyboard to dismiss
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Image {

    public init?(data: Data?) {
        guard let data = data,
            let uiImage = UIImage(data: data) else {
                return nil
        }
        self = Image(uiImage: uiImage)
    }
}


// MARK: - API
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    public func foreground<Overlay: View>(_ overlay: Overlay) -> some View {
        self.overlay(overlay).mask(self)
    }
}

extension Font {
    static func flamingos(size: Int) -> Font {
        return Font.custom("Flamingos", size: CGFloat(size))
    }
    
    static func avenirNext(size: Int) -> Font {
        return Font.custom("Avenir Next", size: CGFloat(size))
    }
    
    
    static func cereal(size: Int) -> Font {
        return Font.custom("Airbnb Cereal App", size: CGFloat(size))
    }
    
    static func cerealBold(size: Int) -> Font {
        return Font.custom("Airbnb Cereal App Bold", size: CGFloat(size))
    }
    
    static func cerealMedium(size: Int) -> Font {
        return Font.custom("Airbnb Cereal App Medium", size: CGFloat(size)).weight(.medium)
    }
    
    static func cerealBook(size: Int) -> Font {
        return Font.custom("Airbnb Cereal App Book", size: CGFloat(size)).weight(.medium)
    }
    
    static func cerealLight(size: Int) -> Font {
        return Font.custom("Airbnb Cereal App Light", size: CGFloat(size))
    }
    
    static func sfpro(size: Int) -> Font {
        return Font.custom("SFProDisplay-Regular", size: CGFloat(size))
    }
}


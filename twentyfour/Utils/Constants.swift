//
//  Constants.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.03.21.
//

import Foundation
import UIKit
import SwiftUI

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

public let horizontalPadding: CGFloat = 15

public let buttonCornerRadius: CGFloat = 8
public let menuCornerRadius: CGFloat = 0

//public let

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

var gradient: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors: [Color.black.opacity(0.4), Color.black.opacity(0.1), Color.black.opacity(0.01)]),
        startPoint: .bottom,
        endPoint: .top)
}
var testgradientPinkViolet: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("violet"),
                    //  Color ("violet-1"),
                    //  Color ("pink-1"),
                    Color ("violet-1"),
                ]),
        startPoint: .bottomLeading,
        endPoint: .topTrailing)
}

var testgradientBlueblue: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("violet-1"),
                    //  Color ("violet-1"),
                    //  Color ("pink-1"),
                    Color ("violet"),
                ]),
        startPoint: .top,
        endPoint: .bottom)
}

var testgradientBlueblue2: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("violet-1"),
                    //  Color ("violet-1"),
                    //  Color ("pink-1"),
                    Color ("violet"),
                ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}


var testgradientClearBLack: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color.clear,
                    //  Color ("violet-1"),
                    //  Color ("pink-1"),
                    Color.black.opacity(0.3),
                ]),
        startPoint: .center,
        endPoint: .bottom)
}

var testgradientPinkRed: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("pink-1"),
                    //  Color ("violet-1"),
                    //  Color ("pink-1"),
                    Color.red,
                ]),
        startPoint: .top,
        endPoint: .bottom)
}

var testgradientBlueblue1: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("violet"),
                    //  Color ("violet-1"),
                    //  Color ("pink-1"),
                    Color ("turquoise"),
                ]),
        startPoint: .bottomLeading,
        endPoint: .topTrailing)
}

var testgradient: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("gradient3"),
                    Color ("gradient4")
                ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}

var testgradient2: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("gradient2"),
                    Color ("gradient3")
                ]),
        startPoint: .bottomLeading,
        endPoint: .topTrailing)
}

var testgradient3: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    Color ("violet-3"),
                    Color ("violet-2")
                ]),
        startPoint: .bottomLeading,
        endPoint: .topTrailing)
}

var testgradient4: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    //                    Color ("blue-2"),
                    Color ("gradient4"),
                    Color ("blue-2"),
                    //                    Color ("turquoise")
                ]),
        startPoint: .bottomLeading,
        endPoint: .topTrailing)
}

var gradientWhite: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
                [
                    //                    Color ("blue-2"),
                    .white.opacity(1.0),
                    .white.opacity(1.0),
                    .white.opacity(1.0),
                    .white.opacity(0.8),
                    .white.opacity(0.6),
                    .white.opacity(0.0),
                    //                    Color ("turquoise")
                ]),
        startPoint: .bottom,
        endPoint: .top)
}


class ViewFrame: ObservableObject {
    var startingRect: CGRect?
    
    @Published var frame: CGRect {
        willSet {
            if startingRect == nil {
                startingRect = newValue
            }
        }
    }
    
    init() {
        self.frame = .zero
    }
}

struct GeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            AnyView(Color.clear)
                .preference(key: RectanglePreferenceKey.self, value: geometry.frame(in: .global))
        }.onPreferenceChange(RectanglePreferenceKey.self) { (value) in
            self.rect = value
        }
    }
}

struct RectanglePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

var centerGradient: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors: [Color.black.opacity(0.01), Color.black.opacity(0.6), Color.black.opacity(0.01)]),
        startPoint: .bottom,
        endPoint: .top)
}

var centerGradientInverted: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors: [Color.black.opacity(0.44), Color.black.opacity(0.1), Color.black.opacity(0.44)]),
        startPoint: .bottom,
        endPoint: .top)
}

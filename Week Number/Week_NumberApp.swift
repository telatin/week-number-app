//
//  Week_NumberApp.swift
//  Week Number
//
//  Created by Andrea Telatin (QIB) on 31/07/2025.
//

import SwiftUI
import AppKit

@main
struct WeekNumberApp: App {
    @State private var weekOfYear = getCurrentWeekOfYear()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    updateDockIcon(with: weekOfYear)
                }
        }
    }
}

 



func updateDockIcon(with week: Int) {
    let imageSize = NSSize(width: 128, height: 128)
    let image = NSImage(size: imageSize)
    image.lockFocus()

    // Rounded rectangle path (corner radius 20)
    let rect = NSRect(origin: .zero, size: imageSize)
    let path = NSBezierPath(roundedRect: rect, xRadius: 20, yRadius: 20)
    path.addClip()  // Clip all drawing to rounded rect

    // Pine green background for the bottom part
    let bottomRect = NSRect(x: 0, y: 0, width: imageSize.width, height: 85)
    NSColor(calibratedRed: 0.035, green: 0.394, blue: 0.354, alpha: 1).set()
    bottomRect.fill()

    // Apple-green background for the top part
    let topRect = NSRect(x: 0, y: 85, width: imageSize.width, height: 43)
    NSColor(calibratedRed: 0.714, green: 0.745, blue: 0.0, alpha: 1).set()
    topRect.fill()

    // Centered text alignment
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center

    // "DOW DD" label (small top text)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E dd"
    let dayString = dateFormatter.string(from: Date())
    let labelAttributes: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 31, weight: .semibold),
        .foregroundColor: NSColor(calibratedRed: 0.13, green: 0.17, blue: 0.20, alpha: 1),// Charcoal
        .paragraphStyle: paragraphStyle
    ]
    let labelRect = NSRect(x: 0, y: 92, width: imageSize.width, height: 30)
    NSString(string: dayString).draw(in: labelRect, withAttributes: labelAttributes)

 
    
    let weekString = "\(week)" as NSString
    let numberFont = NSFont.systemFont(ofSize: 82, weight: .bold)
    let numberAttributes: [NSAttributedString.Key: Any] = [
        .font: numberFont,
        .foregroundColor: NSColor.white,
        .paragraphStyle: paragraphStyle
    ]

    // Measure the string's actual size
    let stringSize = weekString.size(withAttributes: numberAttributes)

    // Calculate centered Y
    let numberY = (85 - stringSize.height) / 2
    let numberRect = NSRect(x: 0, y: numberY, width: imageSize.width, height: stringSize.height)
    weekString.draw(in: numberRect, withAttributes: numberAttributes)
    image.unlockFocus()
    NSApp.applicationIconImage = image
}


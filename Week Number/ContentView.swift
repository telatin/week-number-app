//
//  ContentView.swift
//  Week Number
//
//  Created by Andrea Telatin (QIB) on 31/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    private var calendar: Calendar { Calendar.current }

    var weekOfYear: Int {
        calendar.component(.weekOfYear, from: selectedDate)
    }

    var weekDates: [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: selectedDate) else { return [] }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: weekInterval.start) }
    }

    var monthString: String {
        let months = Set(weekDates.map { calendar.component(.month, from: $0) })
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("MMMM")
        let monthNames = months.sorted().compactMap { month in
            formatter.monthSymbols[safe: month - 1]
        }
        return monthNames.joined(separator: "/")
    }

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 20) {
                HStack(spacing: 0) {
                    Button(action: { selectedDate = calendar.date(byAdding: .weekOfYear, value: -1, to: selectedDate)! }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 20, height: 40)
                    }
                    Spacer()
                    VStack(spacing: 8) {
                        Button(action: {
                            selectedDate = Date()
                        }) {
                            Text("Week of the Year")
                                .font(.system(size: geo.size.height * 0.05, weight: .bold))
                                .foregroundColor(.primary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(nsColor: NSColor.windowBackgroundColor))
                                .cornerRadius(8)
                        }
                        Text("\(weekOfYear)")
                            .font(.system(size: geo.size.height * 0.12, weight: .bold))
                            .foregroundColor(.accentColor)
                        Text(monthString)
                            .font(.system(size: geo.size.height * 0.045, weight: .semibold))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button(action: { selectedDate = calendar.date(byAdding: .weekOfYear, value: 1, to: selectedDate)! }) {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 20, height: 40)
                    }
                }
                .padding(.horizontal, geo.size.width * 0.04)

                if geo.size.height > 250 && geo.size.width > 400 {
                    HStack {
                        ForEach(weekDates, id: \Date.self) { date in
                            VStack {
                                Text(shortWeekday(date: date))
                                    .font(.system(size: geo.size.height * 0.035))
                                    .foregroundColor(calendar.isDateInToday(date) ? .accentColor : .secondary)
                                Text("\(calendar.component(.day, from: date))")
                                    .font(.system(size: geo.size.height * 0.045, weight: .medium))
                                    .foregroundColor(calendar.isDateInToday(date) ? .accentColor : .primary)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .transition(.opacity)
                    .padding(.horizontal, geo.size.width * 0.04)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }

    func shortWeekday(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
}

// Safe index accessor for arrays
extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

// Utility function for current week (for other files)
func getCurrentWeekOfYear() -> Int {
    let calendar = Calendar.current
    return calendar.component(.weekOfYear, from: Date())
}

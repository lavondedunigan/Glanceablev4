//
//  MetricCard.swift
//  GlancableFitness Watch
//
//  Created by Lavonde Dunigan on 11/22/25.
//
import SwiftUI

struct MetricCard: View {
    let title: String
    let value: String
    let unit: String?
    let accessibilityHint: String

    var body: some View {
        VStack(spacing: 2) {
            Text(title)
                .font(.system(.caption2, design: .rounded))
                .opacity(0.8)
            Text(value)
                .font(.system(.title2, design: .rounded).weight(.semibold))
                .minimumScaleFactor(0.7)
            if let unit {
                Text(unit)
                    .font(.system(.footnote, design: .rounded))
                    .opacity(0.8)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(title) \(value) \(unit ?? "")")
        .accessibilityHint(accessibilityHint)
    }
}

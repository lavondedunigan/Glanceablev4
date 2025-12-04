//
//  RingView.swift
//  GlancableFitness Watch
//
//  Created by Lavonde Dunigan on 11/22/25.
//
import SwiftUI

struct Ring: View {
    var value: Double   // 0 → 1
    var color: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6)
                .opacity(0.2)
            Circle()
                .trim(from: 0, to: value)
                .stroke(color, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
        .animation(.easeInOut(duration: 0.6), value: value)
    }
}



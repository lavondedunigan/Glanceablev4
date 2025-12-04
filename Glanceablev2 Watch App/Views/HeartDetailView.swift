//
//  HeartDetailView.swift
//  GlancableFitness Watch
//
//  Created by Lavonde Dunigan on 11/22/25.
//
import SwiftUI

struct HeartDetailView: View {
    let bpm: Int

    var body: some View {
        VStack(spacing: 8) {
            Text("Heart Rate")
                .font(.system(.headline, design: .rounded))
            Text("\(bpm) bpm")
                .font(.system(.largeTitle, design: .rounded).weight(.semibold))
        }
        .padding()
        .navigationTitle("Heart")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityElement(children: .combine)
    }
}

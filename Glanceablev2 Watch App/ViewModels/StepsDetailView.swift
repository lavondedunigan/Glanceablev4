//
//  StepsDetailView.swift
//  GlancableFitness Watch
//
//  Created by Lavonde Dunigan on 11/22/25.
//
import SwiftUI

struct StepsDetailView: View {
    let steps: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Steps Today")
                .font(.system(.headline, design: .rounded))
            Text("\(steps)")
                .font(.system(.largeTitle, design: .rounded).weight(.semibold))
        }
        .padding()
        .navigationTitle("Steps")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityElement(children: .combine)
    }
    
}

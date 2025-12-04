//
//  GlanceView.swift
//  GlancableFitness Watch
//
//  Created by Lavonde Dunigan on 11/22/25.
//
import SwiftUI

struct GlanceView: View {
    @ObservedObject var vm: GlanceVM
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                // Time (glance-first)
                Text(vm.snapshot.time, style: .time)
                    .font(.system(.title3, design: .rounded).weight(.medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .accessibilityLabel("Time")
                    .accessibilityValue(Text(vm.snapshot.time, style: .time))

                HStack(spacing: 8) {
                    NavigationLink {
                        HeartDetailView(bpm: vm.snapshot.heartBPM)
                    } label: {
                        MetricCard(
                            title: "Heart",
                            value: "\(vm.snapshot.heartBPM)",
                            unit: "bpm",
                            accessibilityHint: "Opens heart rate details"
                        )
                    }
                    .sensoryFeedback(.selection, trigger: vm.snapshot.heartBPM)

                    NavigationLink {
                        StepsDetailView(steps: vm.snapshot.steps)
                    } label: {
                        MetricCard(
                            title: "Steps",
                            value: "\(vm.snapshot.steps)",
                            unit: nil,
                            accessibilityHint: "Opens steps details"
                        )
                    }
                    .sensoryFeedback(.selection, trigger: vm.snapshot.steps)
                }

                Button("Refresh") { vm.refreshMock() }
                    .buttonStyle(.borderedProminent)
                    .font(.system(.footnote, design: .rounded))
                    .accessibilityHint("Simulates new sensor data")
            }
            .padding(.horizontal, 8)
            .containerBackground(for: .navigation) {
                // keeps a consistent background for watchOS
                scheme == .dark ? Color.black : Color.clear
            }
        }
    }
}

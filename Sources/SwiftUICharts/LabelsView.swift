//
//  LabelsView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

public struct LabelsView: View {
    let labels: [String]
    let labelColor: Color
    let labelCount: Int

    private var threshold: Int {
        let threshold = Double(labels.count) / Double(labelCount)
        return Int(threshold.rounded(.awayFromZero))
    }

    public init(labels: [String], axisColor: Color, labelCount: Int? = nil) {
        self.labels = labels
        self.labelColor = axisColor
        self.labelCount = labelCount ?? labels.count
    }

    public var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(labels.indexed(), id: \.1.self) { index, label in
                    if index % self.threshold == 0 {
                        Text(label)
                            .multilineTextAlignment(.center)
                            .foregroundColor(labelColor)
                            .font(.caption)
                            .frame(width: geometry.size.width / CGFloat(labelCount), alignment: .center)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct LabelsView_Previews: PreviewProvider {
    static var previews: some View {
        LabelsView(labels: DataPoint.mock.map { "\($0.label)" }, axisColor: .secondary)
    }
}
#endif

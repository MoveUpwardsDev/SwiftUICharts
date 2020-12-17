//
//  AxisView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

public struct AxisView: View {
    let dataPoints: [Double]
    let axisColor: Color
    let format: String

    public init(dataPoints: [Double], axisColor: Color, format: String = "%.0f") {
        self.dataPoints = dataPoints
        self.axisColor = axisColor
        self.format = format
    }

    public var body: some View {
        VStack {
            dataPoints.max().map {
                Text(String(format: format, locale: Locale.current, $0))
                    .foregroundColor(axisColor)
                    .font(.caption)
            }
            Spacer()
            dataPoints.max().map {
                Text(String(format: format, locale: Locale.current, $0 / 2))
                    .foregroundColor(axisColor)
                    .font(.caption)
            }
            Spacer()
        }
    }
}

#if DEBUG
struct AxisView_Previews: PreviewProvider {
    static var previews: some View {
        AxisView(dataPoints: DataPoint.mock.map { $0.value }, axisColor: .secondary)
    }
}
#endif

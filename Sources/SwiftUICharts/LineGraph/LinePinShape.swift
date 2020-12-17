//
//  SwiftUIView.swift
//  
//
//  Created by Majid Jabrayilov on 24.09.20.
//
import SwiftUI

public struct LinePinShape: Shape {
    let dataPoints: [Double]
    let pinSize: CGSize

    public init(dataPoints: [Double], pinSize: CGSize = .init(width: 8, height: 8)) {
        self.dataPoints = dataPoints
        self.pinSize = pinSize
    }

    public func path(in rect: CGRect) -> Path {
        guard !dataPoints.isEmpty, let max = dataPoints.max(), max > 0 else { return Path() }

        return Path { path in
            let startY = CGFloat(dataPoints.first ?? 0) / CGFloat(dataPoints.max() ?? 1)
            let stepX = rect.width / CGFloat(dataPoints.count)
            path.move(to: CGPoint(x: stepX * 0.5 - pinSize.width * 0.5, y: rect.height - rect.height * startY))
            var currentX: CGFloat = stepX * 0.5 - pinSize.width * 0.5

            if !dataPoints.isEmpty {
                let rect = CGRect(x: currentX,
                                  y: rect.height - rect.height * startY - pinSize.width / 2,
                                  width: pinSize.width,
                                  height: pinSize.height)
                path.addPath(Circle().path(in: rect))
            }

            dataPoints.dropFirst().forEach {
                currentX += stepX
                let y = CGFloat($0 / (dataPoints.max() ?? 1)) * rect.height
                let rect = CGRect(x: currentX,
                                  y: rect.height - y - pinSize.width / 2,
                                  width: pinSize.width,
                                  height: pinSize.height)
                path.addPath(Circle().path(in: rect))
            }
        }
    }
}

#if DEBUG
struct LinePinShape_Previews: PreviewProvider {
    static var previews: some View {
        LinePinShape(dataPoints: DataPoint.mock.map { $0.value })
    }
}
#endif

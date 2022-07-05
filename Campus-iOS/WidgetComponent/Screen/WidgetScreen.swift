//
//  WidgetScreen.swift
//  Campus-iOS
//
//  Created by Robyn Kölle on 24.06.22.
//

import SwiftUI

struct WidgetScreen: View {
    var body: some View {
        ScrollView {
            VStack {
                
                StudyRoomWidgetView(size: .bigSquare)
                    .padding(.bottom)
                
                TuitionWidgetView(size: .rectangle)
                    .padding(.bottom)
                
                CafeteriaWidgetView(size: .rectangle)
                    .padding(.bottom)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("My Widgets")
    }
}

struct WidgetScreen_Previews: PreviewProvider {
    static var previews: some View {
        WidgetScreen()
        WidgetScreen()
            .preferredColorScheme(.dark)
    }
}

//
//  CustomDivider.swift
//  Moonshot
//
//  Created by Manideep Gattamaneni on 1/25/26.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    CustomDivider()
}

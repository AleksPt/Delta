//
//  AddAccountOrGroupView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 10.12.24.
//

import SwiftUI

struct AddAccountOrGroupView: View {
    @Binding var isTargeted: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(isTargeted ? .appBlack.opacity(0.3) : .clear, lineWidth: 1)
                .frame(height: 50)
            
            Image(systemName: "plus")
                .foregroundColor(isTargeted ? .appBlack.opacity(0.3) : .clear)
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    AddAccountOrGroupView(isTargeted: .constant(true))
}

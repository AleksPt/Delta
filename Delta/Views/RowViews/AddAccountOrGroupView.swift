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
            Rectangle()
                .fill(.clear)
                .frame(height: isTargeted ? 64 : 16)
            
            RoundedRectangle(cornerRadius: 16)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: isTargeted ? 32 : 16
                )
                .foregroundColor(.clear)
            
            if isTargeted {
                Image(systemName: "plus")
                    .foregroundColor(.gray)
            }
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    AddAccountOrGroupView(isTargeted: .constant(true))
}

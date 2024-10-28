//
//  ChosingIconView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/12/24.
//

import SwiftUI
import UISystem

struct ColorPickerView: View {
    @Binding var selectedItem: AppGradient
    
    let items: [AppGradient]
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheading2())
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(items, id: \.self) { color in
                        Circle()
                            .fill(color.value)
                            .frame(width: 35)
                            //.shadow(color: selectedItem == color ? Color.gray.opacity(0.8) : Color.clear, radius: 3)
                            .overlay(
                                Circle()
                                    .stroke(selectedItem == color ? Color.appBlack : Color.clear, lineWidth: 2)
                            )
                            .simultaneousGesture(
                                TapGesture().onEnded {
                                    selectedItem = color
                                }
                            )
                    }
                    .frame(height: 40)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
            .scrollIndicators(.hidden)
        }
        .frame(height: 106)
        .background(AppGradient.appBackgroundMini.value)
        .cornerRadius(16)
    }
}

struct IconPickerView: View {
    @Binding var selectedItem: Icon
    
    let items: [Icon]
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheading2())
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(items, id: \.self) { icon in
                        ZStack {
                            Circle()
                                .fill(.appGray)
                                .frame(width: 35)
                                //.shadow(color: selectedItem == icon ? Color.gray.opacity(0.8) : Color.clear, radius: 3)
                                .overlay(
                                    Circle()
                                        .stroke(selectedItem == icon ? Color.appBlack : Color.clear, lineWidth: 2)
                                )
                            Image(systemName: icon.name)
                                .foregroundStyle(.appBlack)
                        }
                        .frame(height: 40)
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                selectedItem = icon
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
            .scrollIndicators(.hidden)
        }
        .frame(height: 106)
        .background(AppGradient.appBackgroundMini.value)
        .cornerRadius(16)
    }
}

#Preview {
    IconPickerView(selectedItem: .constant(Icon.creditcard), items: Icon.allCases, title: "Icons")
}

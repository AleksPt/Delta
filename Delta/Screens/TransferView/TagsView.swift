//
//  TagsView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 11/22/24.
//

import SwiftUI
import UISystem

struct TagsView: View {
    @Environment(CategoryService.self) private var categoryService
    @Environment(Router.self) private var router
    
    @Binding var selectedTags: [Tag]
    
    @State private var viewHeight = CGFloat.zero
    
    var body: some View {
        ZStack {
            VStack {
                Text("Choose tags")
                    .font(.heading1())
                    .foregroundStyle(AppGradient.appBlack.value)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                GeometryReader { geometry in
                    ScrollView(.vertical) {
                        self.generateHashtagViews(g: geometry)
                    }
                }
                
                RoundedButtonView(title: "Save tags") {
                    router.dismissModal()
                }
                .contentShape(Rectangle())
                .padding(20)
                .onTapGesture {
                    router.dismissModal()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(.appBackground)
    }
    
    private func generateHashtagViews(g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(categoryService.tags, id: \.id) { tag in
                TagCapsuleView(
                    tag: tag,
                    isSelected: selectedTags.contains(where: { $0.id == tag.id })
                    ) {
                        if selectedTags.contains(where: { $0.id == tag.id }) {
                            selectedTags.removeAll(where: { $0.id == tag.id })
                        } else {
                            selectedTags.append(tag)
                        }
                    }
                    .id(tag.id)
                
                    .padding(.vertical, 6)
                    .padding(.horizontal, 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if(abs(width - d.width) > g.size.width){
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == categoryService.tags.last! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if tag == categoryService.tags.last! {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(getViewHeight($viewHeight))
        .padding(.horizontal, 16)
    }
    
    private func getViewHeight(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geo -> Color in
            let rect = geo.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

#Preview {
    TagsView(selectedTags: .constant(CategoryService().tags))
    .environment(CategoryService())
    .environment(Router.shared)
}

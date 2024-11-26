//
//  ShoppingListView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import SwiftUI
import UISystem

//@Observable final class ShoppingListCategory: Hashable, Identifiable{
//    var id: UUID = UUID()
//    var name: String = ""
//    var items: [ShoppingListItem] = []
//    var amount: String = ""
//    
//    var activeItems: [ShoppingListItem] {
//        items.filter { !$0.isCompleted }
//    }
//    
//    var completedItems: [ShoppingListItem] {
//        items.filter { $0.isCompleted }
//    }
//    
//    init(id: UUID = UUID(), name: String, items: [ShoppingListItem] = [], amount: String = "") {
//        self.id = id
//        self.name = name
//        self.items = items
//        self.amount = amount
//    }
//    
//    static func == (lhs: ShoppingListCategory, rhs: ShoppingListCategory) -> Bool {
//        return lhs.id == rhs.id
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}

/*@Observable final class ShoppingListModel {
    
    // Tags
    
    var text = ""
    var tags = ["Bread", "Tomato", "Pasta", "Water", "Table", "T-Shirt"]
    
    var filteredTags: [String] {
        if text.isEmpty {
            return []
        } else {
            return tags.filter { $0.lowercased().contains(text.lowercased()) }
        }
    }
    
    func saveTags() {
        withAnimation {
            if !tags.contains(text) {
                tags.append(text)
            }
            
            text = ""
        }
    }
    
    // Categories
    //var activeCategory: ShoppingListCategory?
    
   /* var categories = [
        ShoppingListCategory(
            name: "products",
            items: [
                ShoppingListItem(name: "Bread"),
                ShoppingListItem(name: "Tomato"),
                ShoppingListItem(name: "Pasta"),
                ShoppingListItem(name: "Water")
            ]
        ),
        ShoppingListCategory(
            name: "home",
            items: [ShoppingListItem(name: "Table")]
        ),
        ShoppingListCategory(
            name: "wear",
            items: [ShoppingListItem(name: "T-Shirt")]
        ),
        ShoppingListCategory(
            name: "shoes",
            items: [ShoppingListItem(name: "Nike")]
        ),
        ShoppingListCategory(
            name: "alcohol",
            items: [ShoppingListItem(name: "Tekila")]
        ),
        ShoppingListCategory(
            name: "toys",
            items: [ShoppingListItem(name: "Lego")]
        )
    ]*/
    
    var completedItems: [ShoppingListItem] {
        categories.flatMap { $0.items.filter { $0.isCompleted } }
    }
    
    var categoriesWithCompletedItems: [ShoppingListCategory] {
        categories.filter { category in
            category.items.contains(where: { $0.isCompleted })
        }
    }
    
    func addItem(for category: ShoppingListCategory) {
        let newItem = ShoppingListItem(name: text)
        withAnimation {
            category.items.append(newItem)
        }
    }
    
    // TODO: - добавить функционал
    
    //    func moveItem(in category: ShoppingListCategory, from source: IndexSet, to destination: Int) {
    //        var activeItems = category.activeItems
    //        activeItems.move(fromOffsets: source, toOffset: destination)
    //    }
    
    func deleteItems(at indexSet: IndexSet, from category: ShoppingListCategory) {
        if let categoryIndex = categories.firstIndex(where: { $0.id == category.id }) {
            let activeItems = category.activeItems
            let itemsToDelete = indexSet.map { activeItems[$0].id }
            categories[categoryIndex].items.removeAll { item in
                itemsToDelete.contains(item.id)
            }
        }
    }
    
    // TODO: - добавить сохранение по индексу в базу
    
    func addCategory(withName name: String) {
        let newCategory = ShoppingListCategory(name: name, items: [])
        categories.append(newCategory)
    }
    
    func createTransactions(for account: Account?) -> [Transaction] {
        guard let account = account else { return [] }
        
        var transactions: [Transaction] = []
        
        for category in categoriesWithCompletedItems {
            
            let transaction: Transaction = Transaction(
                id: UUID(),
                amount: Double(category.amount) ?? 0,
                date: Date(),
                sourceID: category.id, // TODO: - Устанавливаем категорию как источник
                destinationID: account.id,
                tags: category.completedItems.map { $0.name },
                currency: account.currency,
                person: nil, // TODO: - Задать пользователя
                autoTransaction: nil
            )
            
            transactions.append(transaction)
        }
        
        return transactions
    }
    
    func deleteCompletedItems() {
        for category in categories {
            category.items.removeAll { $0.isCompleted == true}
            category.amount = ""
        }
    }
    
    // TODO: - доделать метод сохранения в базу
    
    func saveTransactions(_ transactions: [Transaction]) {
        for transaction in transactions {
            print("Сохранение транзакции на сумму \(transaction.amount) для категории \(transaction.sourceID)")
        }
        
        deleteCompletedItems()
    }
}*/

enum Field: Hashable {
    case addTextField
    case textField
    case amountField
}

struct ShoppingListView: View {
    @Environment(CategoryService.self) private var categoryService
    
    //@State private var shoppingListModel = ShoppingListModel()
    @State private var categoryName = ""
    @State private var selectedAccount: Account? = nil
    @State private var heightKeyboard: CGFloat = 0
    @State private var isPresentedSwapCategories: Bool = false
    
    @State private var categories: [Expense] = []
    @State private var text: String = ""
    @State private var activeCategory: Expense? = nil
    
    @FocusState private var textFieldFocus: Field?
    
    @Namespace var buyButtonID
    @Namespace var emptySpacerID

    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach($categories, id: \.id) { $category in
                    Section {
                        ForEach(category.activeItems) { item in
                            ShoppingListItemView(item: item)
                                .focused($textFieldFocus, equals: .textField)
                        }
                        .onDelete { indexSet in
                            categoryService.deleteItems(at: indexSet, from: category)
                        }
                        
                        ShoppingListAddView(text: $text) {
                            categoryService.addItem(for: category, text: text)
                            categoryService.saveTags(text: text)
                            text = ""
                        }
                        .focused($textFieldFocus, equals: .addTextField)
                    } header: {
                        Text(category.title)
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            activeCategory = category
                        }
                    )
                    .listRowBackground(Color.appBackgroundMini)
                }
                if !categoryService.getCompletedItems().isEmpty {
                    Section {
                        ForEach(categoryService.getCompletedItems()) { item in
                            ShoppingListItemView(item: item)
                        }
                        .focused($textFieldFocus, equals: .textField)
                        
                        ForEach(categoryService.getCategoriesWithCompletedItems()) { category in
                            ShoppingListAmountRowView(category: category)
                        }
                        .focused($textFieldFocus, equals: .amountField)
                        //#warning("что положить вместо accountsAndGroups?")
                        ShoppingListAccountsScrollView(
                            selectedAccount: $selectedAccount
                        )
                        .listRowInsets(EdgeInsets())
                        
                        RoundedButtonView(title: "Buy", action: {
                            if selectedAccount != nil {
                                let transactions = categoryService.createShoppingTransactions(for: selectedAccount)
                                categoryService.saveTransactions(transactions)
                                selectedAccount = nil
                            }
                            // TODO: - add alert if amount is empty
                        })
                        .id(buyButtonID)
                        .transition(.move(edge: .bottom))
                    } header: {
                        Text(LocalizedStringKey("Completed"))
                    }
                    .listRowBackground(Color.appBackgroundMini)
                    Spacer(minLength: heightKeyboard).listRowBackground(Color.clear).id(emptySpacerID)
                }
            }
            .scrollContentBackground(.hidden)
            .background(.appBackground)
            .foregroundStyle(.appBlack)
            .listSectionSpacing(.compact)
            .toolbar {
                Menu {
                    Button(action: {
                        categoryService.addCategory(withName: categoryName)
                    }) {
                        Label("Add category", systemImage: "plus")
                    }
                    Button(action: {
                        isPresentedSwapCategories = true
                    }) {
                        Label("Swap categories", systemImage: "filemenu.and.selection")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
            .onChange(of: selectedAccount) { _ , newValue in
                if newValue != nil {
                    withAnimation {
                        proxy.scrollTo(buyButtonID, anchor: .bottom)
                    }
                }
            }
            .onChange(of: textFieldFocus, { _, newValue in
                if newValue == .amountField {
                    withAnimation {
                        proxy.scrollTo(emptySpacerID)
                    }
                }
            })
            .onTapGesture {
                textFieldFocus = nil
                text = ""
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    if textFieldFocus == .addTextField {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                if text == "" {
                                    ScrollTagsView(tags: categoryService.tags, text: $text, activeCategory: $activeCategory)
                                } else {
                                    ScrollTagsView(tags: categoryService.getFilteredTags(text: text), text: $text, activeCategory: $activeCategory)
                                }
                            }
                        }
                    } else if textFieldFocus == .textField {
                        Spacer()
                        Button(action: {
                            hideKeyboard()
                            withAnimation {
                                proxy.scrollTo(buyButtonID, anchor: .bottom)
                            }
                        }) {
                            Text("Done")
                        }
                    }
                }
            }
        }
        .onAppear {
            categories = categoryService.expenses.filter { $0.isShoppingList == true }
            keyboardHeightObserver()
        }
        .sheet(isPresented: $isPresentedSwapCategories) {
            SwapCategoriesView(categories: $categories)
        }
    }
    
    private func keyboardHeightObserver() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main) { noti in
                
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                
                self.heightKeyboard = height
            }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main) { noti in
                self.heightKeyboard = 0
                textFieldFocus = nil
            }
    }
}

#Preview {
    ShoppingListView().environment(CategoryService())
}

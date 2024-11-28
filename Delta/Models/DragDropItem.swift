//
//  DragDropItem.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 21.11.24.
//

import CoreTransferable

enum DragDropItem: Codable, Transferable {
    case income(Income)
    case accountAndGroups(AccountsAndGroups)
//    case account(Account)

    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation { DragDropItem.income($0) }
        ProxyRepresentation { DragDropItem.accountAndGroups($0) }
//        ProxyRepresentation { DragDropItem.account($0) }
    }

    var income: Income? {
        if case .income(let value) = self { return value }
        return nil
    }
    
    var accountAndGroups: AccountsAndGroups? {
        if case .accountAndGroups(let value) = self { return value }
        return nil
    }
    
//    var account: Account? {
//        if case .account(let value) = self { return value }
//        return nil
//    }
}

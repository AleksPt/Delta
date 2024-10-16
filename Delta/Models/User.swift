//
//  User.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 24.07.24.
//

import SwiftUI

enum Currency: String, CaseIterable, Identifiable {
    case kes = "KES"
    case uah = "UAH"
    case bbd = "BBD"
    case tmt = "TMT"
    case dzd = "DZD"
    case xcd = "XCD"
    case mxn = "MXN"
    case jmd = "JMD"
    case eur = "EUR"
    case vuv = "VUV"
    case amd = "AMD"
    case btn = "BTN"
    case sdg = "SDG"
    case lrd = "LRD"
    case ars = "ARS"
    case cdf = "CDF"
    case mur = "MUR"
    case nzd = "NZD"
    case npr = "NPR"
    case gbp = "GBP"
    case ils = "ILS"
    case mkd = "MKD"
    case clp = "CLP"
    case gip = "GIP"
    case ang = "ANG"
    case wst = "WST"
    case kyd = "KYD"
    case mnt = "MNT"
    case fjd = "FJD"
    case kzt = "KZT"
    case jod = "JOD"
    case byn = "BYN"
    case qar = "QAR"
    case mga = "MGA"
    case syp = "SYP"
    case uzs = "UZS"
    case bmd = "BMD"
    case crc = "CRC"
    case lak = "LAK"
    case sar = "SAR"
    case gyd = "GYD"
    case aoa = "AOA"
    case htg = "HTG"
    case afn = "AFN"
    case sle = "SLE"
    case inr = "INR"
    case bhd = "BHD"
    case mzn = "MZN"
    case rub = "RUB"
    case isk = "ISK"
    case pgk = "PGK"
    case bnd = "BND"
    case kwd = "KWD"
    case cop = "COP"
    case mmk = "MMK"
    case kmf = "KMF"
    case kpw = "KPW"
    case thb = "THB"
    case dkk = "DKK"
    case lyd = "LYD"
    case mru = "MRU"
    case myr = "MYR"
    case rwf = "RWF"
    case ngn = "NGN"
    case cad = "CAD"
    case mop = "MOP"
    case bob = "BOB"
    case aed = "AED"
    case xpf = "XPF"
    case iqd = "IQD"
    case shp = "SHP"
    case jpy = "JPY"
    case irr = "IRR"
    case gmd = "GMD"
    case xof = "XOF"
    case lkr = "LKR"
    case nad = "NAD"
    case omr = "OMR"
    case uyu = "UYU"
    case cve = "CVE"
    case mwk = "MWK"
    case top = "TOP"
    case pab = "PAB"
    case yer = "YER"
    case sbd = "SBD"
    case usd = "USD"
    case khr = "KHR"
    case bzd = "BZD"
    case bam = "BAM"
    case huf = "HUF"
    case rsd = "RSD"
    case szl = "SZL"
    case ghs = "GHS"
    case sos = "SOS"
    case tzs = "TZS"
    case gtq = "GTQ"
    case bdt = "BDT"
    case ern = "ERN"
    case mdl = "MDL"
    case sek = "SEK"
    case pyg = "PYG"
    case bwp = "BWP"
    case pln = "PLN"
    case czk = "CZK"
    case TRY = "TRY"
    case mad = "MAD"
    case cny = "CNY"
    case ron = "RON"
    case tnd = "TND"
    case dop = "DOP"
    case nok = "NOK"
    case fkp = "FKP"
    case vnd = "VND"
    case gnf = "GNF"
    case aud = "AUD"
    case zmw = "ZMW"
    case ved = "VED"
    case php = "PHP"
    case egp = "EGP"
    case srd = "SRD"
    case krw = "KRW"
    case pen = "PEN"
    case ttd = "TTD"
    case bsd = "BSD"
    case awg = "AWG"
    case brl = "BRL"
    case sgd = "SGD"
    case bgn = "BGN"
    case zar = "ZAR"
    case hkd = "HKD"
    case bif = "BIF"
    case twd = "TWD"
    case all = "ALL"
    case pkr = "PKR"
    case stn = "STN"
    case ugx = "UGX"
    case scr = "SCR"
    case ssp = "SSP"
    case lbp = "LBP"
    case mvr = "MVR"
    case djf = "DJF"
    case idr = "IDR"
    case azn = "AZN"
    case cup = "CUP"
    case kgs = "KGS"
    case chf = "CHF"
    case etb = "ETB"
    case gel = "GEL"
    case hnl = "HNL"
    case nio = "NIO"
    case xaf = "XAF"
    case tjs = "TJS"
    
    var name: String {
        switch self {
        case .kes: "Kenyan Shilling"
        case .uah: "Ukrainian Hryvnia"
        case .bbd: "Barbadian Dollar"
        case .tmt: "Turkmenistani Manat"
        case .dzd: "Algerian Dinar"
        case .xcd: "East Caribbean Dollar"
        case .mxn: "Mexican Peso"
        case .jmd: "Jamaican Dollar"
        case .eur: "Euro"
        case .vuv: "Vanuatu Vatu"
        case .amd: "Armenian Dram"
        case .btn: "Bhutanese Ngultrum"
        case .sdg: "Sudanese Pound"
        case .lrd: "Liberian Dollar"
        case .ars: "Argentine Peso"
        case .cdf: "Congolese Franc"
        case .mur: "Mauritian Rupee"
        case .nzd: "New Zealand Dollar"
        case .npr: "Nepalese Rupee"
        case .gbp: "British Pound Sterling"
        case .ils: "Israeli New Shekel"
        case .mkd: "Macedonian Denar"
        case .clp: "Chilean Peso"
        case .gip: "Gibraltar Pound"
        case .ang: "Netherlands Antillean Guilder"
        case .wst: "Samoan Tala"
        case .kyd: "Cayman Islands Dollar"
        case .mnt: "Mongolian Tögrög"
        case .fjd: "Fijian Dollar"
        case .kzt: "Kazakhstani Tenge"
        case .jod: "Jordanian Dinar"
        case .byn: "Belarusian Ruble"
        case .qar: "Qatari Riyal"
        case .mga: "Malagasy Ariary"
        case .syp: "Syrian Pound"
        case .uzs: "Uzbekistani Som"
        case .bmd: "Bermudian Dollar"
        case .crc: "Costa Rican Colón"
        case .lak: "Lao Kip"
        case .sar: "Saudi Riyal"
        case .gyd: "Guyanese Dollar"
        case .aoa: "Angolan Kwanza"
        case .htg: "Haitian Gourde"
        case .afn: "Afghan Afghani"
        case .sle: "Sierra Leonean Leone"
        case .inr: "Indian Rupee"
        case .bhd: "Bahraini Dinar"
        case .mzn: "Mozambican Metical"
        case .rub: "Russian Ruble"
        case .isk: "Icelandic Króna"
        case .pgk: "Papua New Guinean Kina"
        case .bnd: "Brunei Dollar"
        case .kwd: "Kuwaiti Dinar"
        case .cop: "Colombian Peso"
        case .mmk: "Burmese Kyat"
        case .kmf: "Comorian Franc"
        case .kpw: "North Korean Won"
        case .thb: "Thai Baht"
        case .dkk: "Danish Krone"
        case .lyd: "Libyan Dinar"
        case .mru: "Mauritanian Ouguiya"
        case .myr: "Malaysian Ringgit"
        case .rwf: "Rwandan Franc"
        case .ngn: "Nigerian Naira"
        case .cad: "Canadian Dollar"
        case .mop: "Macanese Pataca"
        case .bob: "Bolivian Boliviano"
        case .aed: "United Arab Emirates Dirham"
        case .xpf: "CFP Franc"
        case .iqd: "Iraqi Dinar"
        case .shp: "Saint Helena Pound"
        case .jpy: "Japanese Yen"
        case .irr: "Iranian Rial"
        case .gmd: "Gambian Dalasi"
        case .xof: "West African CFA Franc"
        case .lkr: "Sri Lankan Rupee"
        case .nad: "Namibian Dollar"
        case .omr: "Omani Rial"
        case .uyu: "Uruguayan Peso"
        case .cve: "Cape Verdean Escudo"
        case .mwk: "Malawian Kwacha"
        case .top: "Tongan Paʻanga"
        case .pab: "Panamanian Balboa"
        case .yer: "Yemeni Rial"
        case .sbd: "Solomon Islands Dollar"
        case .usd: "United States Dollar"
        case .khr: "Cambodian Riel"
        case .bzd: "Belize Dollar"
        case .bam: "Bosnia-Herzegovina Convertible Mark"
        case .huf: "Hungarian Forint"
        case .rsd: "Serbian Dinar"
        case .szl: "Swazi Lilangeni"
        case .ghs: "Ghanaian Cedi"
        case .sos: "Somali Shilling"
        case .tzs: "Tanzanian Shilling"
        case .gtq: "Guatemalan Quetzal"
        case .bdt: "Bangladeshi Taka"
        case .ern: "Eritrean Nakfa"
        case .mdl: "Moldovan Leu"
        case .sek: "Swedish Krona"
        case .pyg: "Paraguayan Guarani"
        case .bwp: "Botswana Pula"
        case .pln: "Polish Złoty"
        case .czk: "Czech Koruna"
        case .TRY: "Turkish Lira"
        case .mad: "Moroccan Dirham"
        case .cny: "Chinese Yuan"
        case .ron: "Romanian Leu"
        case .tnd: "Tunisian Dinar"
        case .dop: "Dominican Peso"
        case .nok: "Norwegian Krone"
        case .fkp: "Falkland Islands Pound"
        case .vnd: "Vietnamese Đồng"
        case .gnf: "Guinean Franc"
        case .aud: "Australian Dollar"
        case .zmw: "Zambian Kwacha"
        case .ved: "Venezuelan Digital Bolívar"
        case .php: "Philippine Peso"
        case .egp: "Egyptian Pound"
        case .srd: "Surinamese Dollar"
        case .krw: "South Korean Won"
        case .pen: "Peruvian Sol"
        case .ttd: "Trinidad and Tobago Dollar"
        case .bsd: "Bahamian Dollar"
        case .awg: "Aruban Florin"
        case .brl: "Brazilian Real"
        case .sgd: "Singapore Dollar"
        case .bgn: "Bulgarian Lev"
        case .zar: "South African Rand"
        case .hkd: "Hong Kong Dollar"
        case .bif: "Burundian Franc"
        case .twd: "New Taiwan Dollar"
        case .all: "Albanian Lek"
        case .pkr: "Pakistani Rupee"
        case .stn: "São Tomé and Príncipe Dobra"
        case .ugx: "Ugandan Shilling"
        case .scr: "Seychellois Rupee"
        case .ssp: "South Sudanese Pound"
        case .lbp: "Lebanese Pound"
        case .mvr: "Maldivian Rufiyaa"
        case .djf: "Djiboutian Franc"
        case .idr: "Indonesian Rupiah"
        case .azn: "Azerbaijani Manat"
        case .cup: "Cuban Peso"
        case .kgs: "Kyrgyzstani Som"
        case .chf: "Swiss Franc"
        case .etb: "Ethiopian Birr"
        case .gel: "Georgian Lari"
        case .hnl: "Honduran Lempira"
        case .nio: "Nicaraguan Córdoba"
        case .xaf: "Central African CFA Franc"
        case .tjs: "Tajikistani Somoni"
        }
    }
    
    var symbol: String {
        switch self {
        case .kes: "Ksh"
        case .uah: "₴" // UAH
        case .bbd: "$"
        case .tmt: "m" // TMT
        case .dzd: "د.ج" //DA
        case .xcd: "$"
        case .mxn: "$"
        case .jmd: "$"
        case .eur: "€"
        case .vuv: "VT"
        case .amd: "֏"
        case .btn: "Nu."
        case .sdg: "ج.س." //SDG
        case .lrd: "$"
        case .ars: "$"
        case .cdf: "FC"
        case .mur: "₨" //Rs
        case .nzd: "$"
        case .npr: "नेरू"
        case .gbp: "£"
        case .ils: "₪"
        case .mkd: "den"
        case .clp: "$" //CLP
        case .gip: "£"
        case .ang: "ƒ" //NAf.
        case .wst: "T" //WS$
        case .kyd: "$"
        case .mnt: "₮"
        case .fjd: "$"
        case .kzt: "₸"
        case .jod: "د.أ.‏"
        case .byn: "Br"
        case .qar: "ر.ق.‏"
        case .mga: "Ar"
        case .syp: "ل.س.‏"
        case .uzs: "сўм"
        case .bmd: "BMD"
        case .crc: "₡"
        case .lak: "₭"
        case .sar: "ر.س.‏"
        case .gyd: "$" //GYD
        case .aoa: "Kz"
        case .htg: "G"
        case .afn: "؋"
        case .sle: "Le"
        case .inr: "₹"
        case .bhd: ".د.ب"
        case .mzn: "MTn"
        case .rub: "₽"
        case .isk: "kr."
        case .pgk: "K"
        case .bnd: "$"
        case .kwd: "د.ك.‏"
        case .cop: "$"
        case .mmk: "MMK"
        case .kmf: "CF"
        case .kpw: "₩" // KPW
        case .thb: "฿"
        case .dkk: "kr"
        case .lyd: "د.ل.‏"
        case .mru: "UM"
        case .myr: "RM"
        case .rwf: "FR"
        case .ngn: "₦"
        case .cad: "$" //CA$
        case .mop: "MOP$"
        case .bob: "Bs"
        case .aed: "د.إ.‏"
        case .xpf: "₣" //FCFP
        case .iqd: "د.ع.‏"
        case .shp: "£"
        case .jpy: "¥" //JP¥
        case .irr: "﷼"
        case .gmd: "D"
        case .xof: "F CFA"
        case .lkr: "Rs."
        case .nad: "N$" //$
        case .omr: "ر.ع.‏"
        case .uyu: "$U" //$
        case .cve: "$" //
        case .mwk: "MWK"
        case .top: "T$"
        case .pab: "B/."
        case .yer: "ر.ي.‏"
        case .sbd: "$"
        case .usd: "$"
        case .khr: "៛"
        case .bzd: "$"
        case .bam: "KM"
        case .huf: "Ft"
        case .rsd: "RSD"
        case .szl: "E"
        case .ghs: "₵" // GHS
        case .sos: "S"
        case .tzs: "TSh"
        case .gtq: "Q"
        case .bdt: "৳"
        case .ern: "Nfk"
        case .mdl: "L"
        case .sek: "kr"
        case .pyg: "₲" //Gs
        case .bwp: "P"
        case .pln: "zł"
        case .czk: "Kč" //CZK
        case .TRY: "₺"
        case .mad: "د.م." //MAD
        case .cny: "¥"
        case .ron: "RON"
        case .tnd: "د.ت.‏"
        case .dop: "$" //RD$
        case .nok: "kr"
        case .fkp: "£"
        case .vnd: "₫"
        case .gnf: "FG"
        case .aud: "$"
        case .zmw: "K"
        case .ved: "Bs.D"
        case .php: "₱"
        case .egp: "ج.م.‏"
        case .srd: "$"
        case .krw: "₩"
        case .pen: "S/"
        case .ttd: "$" //TTD
        case .bsd: "$" //BSD
        case .awg: "ƒ" //Afl.
        case .brl: "R$"
        case .sgd: "$"
        case .bgn: "лв."
        case .zar: "R"
        case .hkd: "$" //HK$
        case .bif: "FBu"
        case .twd: "NT$" //$
        case .all: "L" //Lekë
        case .pkr: "₨" //Rs
        case .stn: "Db"
        case .ugx: "USh"
        case .scr: "₨" //SR
        case .ssp: "£"
        case .lbp: "ل.ل."
        case .mvr: "Rf"
        case .djf: "Fdj"
        case .idr: "Rp"
        case .azn: "₼"
        case .cup: "$"
        case .kgs: "с" //com
        case .chf: "CHF"
        case .etb: "Br"
        case .gel: "₾"
        case .hnl: "L"
        case .nio: "C$"
        case .xaf: "XAF" //FCFA
        case .tjs: "ЅМ" //com.
        }
    }
    
    var id: String { self.rawValue }
}

enum CategoryType: String, CaseIterable {
    case account = "Account"
    case groupOfAccounts = "GroupOfAccounts"
    case income = "Income"
    case expense = "Expense"
//    case goal = "Goal"
//    case loan = "Loan"
//    case credit = "Credit"
//    case investment = "Investment"
    
    static func getCategoryTypes() -> [CategoryType] {
        CategoryType.allCases
            .filter { $0 != .account && $0 != .groupOfAccounts }
            .map { $0 }
    }
}

enum Period {
    case day
    case week
    case month
    case quarter
    case year

    var calendarComponent: Calendar.Component {
        switch self {
        case .day:
            .day
        case .week:
            .weekOfYear
        case .month:
            .month
        case .quarter:
            .quarter
        case .year:
            .year
        }
    }
}

enum RepeatingType: String, CaseIterable, Identifiable {
    case random = "Random"
    case certain = "Certain"
    
    var id: String { self.rawValue }
}

final class User {
    var mail: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    var passwordCode: String = ""
    var person: Person?
}

final class Person: Hashable, Identifiable {
    var id: UUID = UUID()
    var photo: String = ""
    var name: String = ""
    var age: Int = 0
    var accounts: [Account] = []
    
    var isAdult: Bool {
        age >= 18
    }
    
    var balance: Double {
        accounts.reduce(0) { $0 + $1.amount }
    }
    
    init(id: UUID, photo: String, name: String, age: Int, accounts: [Account] = []) {
        self.id = id
        self.photo = photo
        self.name = name
        self.age = age
        self.accounts = accounts
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class Transaction {
    var id: UUID = UUID()
    var amount: Double = 0.0
    var date: Date = Date()
    var sourceID: UUID = UUID()
    var destinationID: UUID = UUID()
    var tags: [String] = []
    var currency: Currency = .rub
    var person: Person?
}

//final class DebtTransaction: Transaction {
//    var isMyDebt = false
//    var interestRate: Double = 0.0
//}
@Observable
class Category: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String = ""
    var currency: Currency = .usd
    var categoryType: CategoryType = .account
    
    init(
        id: UUID,
        title: String,
        currency: Currency,
        categoryType: CategoryType
    ) {
        self.id = id
        self.title = title
        self.currency = currency
        self.categoryType = categoryType
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@Observable
final class SubCategory: Category {
    var amount: Double = 0
    var date: Date
    var notification: Bool
    var autoTransaction: Bool
    var transaction: Transaction?
    
    init(
        id: UUID,
        title: String,
        currency: Currency,
        categoryType: CategoryType,
        amount: Double,
        date: Date,
        notification: Bool,
        autoTransaction: Bool,
        transaction: Transaction? = nil
    ) {
        self.amount = amount
        self.date = date
        self.notification = notification
        self.autoTransaction = autoTransaction
        self.transaction = transaction
        super.init(id: id, title: title, currency: currency, categoryType: categoryType)
    }
}

@Observable
final class Income: Category {
    var amount: Double
    var image: String = ""
    var repeatingType: RepeatingType = .random
    var subCategories: [SubCategory] = []
    var transactions: [Transaction] = []
    
    var plannedAmount: Double {
        if subCategories.isEmpty {
            return amount
        } else {
            return subCategories.reduce(0) { $0 + $1.amount }
        }
    }
    
    // проверить обнуления amount при начале нового периода
    var totalAmount: Double {
        let filteredTransactions = DataManager.filterTransactions(transactions, for: .month, startDay: 1, fromMonthOffset: 0)
        return filteredTransactions.reduce(0) { $0 + $1.amount }
    }

    var isExceeded: Bool {
        amount >= plannedAmount
    }
    
    var amountsAndDates: [(amount: Double, date: Date)] {
        repeatingType == .random ? getAmountsByDate() : getAmountsByPeriod()
    }
    
    init(
        amount: Double,
        image: String,
        repeatingType: RepeatingType,
        subCategories: [SubCategory],
        transactions: [Transaction],
        id: UUID,
        title: String,
        currency: Currency,
        categoryType: CategoryType
    ) {
        self.amount = amount
        self.image = image
        self.repeatingType = repeatingType
        self.subCategories = subCategories
        self.transactions = transactions
        super.init(id: id, title: title, currency: currency, categoryType: categoryType)
    }
    
    // методы для построения графика "План"
    func getAmountsByPeriod() -> [(amount: Double, date: Date)] {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        let numberOfDaysInMonth = range.count
        
        let dailyAmount = plannedAmount / Double(numberOfDaysInMonth)
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        
        var result: [(amount: Double, date: Date)] = []
        for day in 0..<numberOfDaysInMonth {
            if let date = calendar.date(byAdding: .day, value: day, to: startOfMonth) {
                result.append((amount: dailyAmount, date: date))
            }
        }
        return result
    }
    
    func getAmountsByDate() -> [(amount: Double, date: Date)] {
        return subCategories.map { ($0.amount, $0.date) }
    }
}

@Observable
final class Expense: Category {
    var amount: Double
    var image: String = ""
    var repeatingType: RepeatingType = .random
    var subCategories: [SubCategory] = []
    var transactions: [Transaction] = []
    
    var plannedAmount: Double {
        subCategories.reduce(0) { $0 + $1.amount }
    }
    
    // проверить обнуления amount при начале нового периода
    var totalAmount: Double {
        let filteredTransactions = DataManager.filterTransactions(transactions, for: .month, startDay: 1, fromMonthOffset: 0)
        return filteredTransactions.reduce(0) { $0 + $1.amount }
    }

    var isExceeded: Bool {
        amount >= plannedAmount
    }
    
    var amountsAndDates: [(amount: Double, date: Date)] {
        repeatingType == .random ? getAmountsByDate() : getAmountsByPeriod()
    }
    
    init(
        amount: Double,
        image: String,
        repeatingType: RepeatingType,
        subCategories: [SubCategory],
        transactions: [Transaction],
        id: UUID,
        title: String,
        currency: Currency,
        categoryType: CategoryType
    ) {
        self.amount = amount
        self.image = image
        self.repeatingType = repeatingType
        self.subCategories = subCategories
        self.transactions = transactions
        super.init(id: id, title: title, currency: currency, categoryType: categoryType)
    }
    
    // методы для построения графика "План"
    func getAmountsByPeriod() -> [(amount: Double, date: Date)] {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        let numberOfDaysInMonth = range.count
        
        let dailyAmount = plannedAmount / Double(numberOfDaysInMonth)
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        
        var result: [(amount: Double, date: Date)] = []
        for day in 0..<numberOfDaysInMonth {
            if let date = calendar.date(byAdding: .day, value: day, to: startOfMonth) {
                result.append((amount: dailyAmount, date: date))
            }
        }
        return result
    }
    
    func getAmountsByDate() -> [(amount: Double, date: Date)] {
        return subCategories.map { ($0.amount, $0.date) }
    }
}

final class Account: Category {
    var image: String = ""
    var color: String = ""
    var users: [Person] = []
    var transactions: [Transaction] = []
    
    var incomingTransactions: [Transaction] {
        transactions.filter { $0.destinationID == self.id }
    }
    
    var outgoingTransactions: [Transaction] {
        transactions.filter { $0.sourceID == self.id }
    }

    var amount: Double {
        incomingTransactions.reduce(0) { $0 + $1.amount } - outgoingTransactions.reduce(0) { $0 + $1.amount }
    }
    // изменить balance можно добавив транзакцию (сервисную), в зависимости от знака либо в incomingAmount, либо в outgoingAmount
    
    init(
        id: UUID,
        title: String,
        currency: Currency,
        image: String,
        color: String,
        users: [Person],
        transactions: [Transaction],
        categoryType: CategoryType
    ) {
        self.image = image
        self.color = color
        self.users = users
        self.transactions = transactions
        super.init(id: id, title: title, currency: currency, categoryType: categoryType)
    }
}

final class GroupOfAccounts: Category {
    var image: String = ""
    var color: String = ""
    var accounts: [Account] = []
    
    var amount: Double {
        accounts.reduce(0) { $0 + $1.amount }
    }
    
    init(
        id: UUID,
        title: String,
        currency: Currency,
        image: String,
        color: String,
        accounts: [Account],
        categoryType: CategoryType
    ) {
        self.image = image
        self.color = color
        self.accounts = accounts
        super.init(id: id, title: title, currency: currency, categoryType: categoryType)
    }
}

final class Goal: Category {
    
}

final class Loan: Category {
    
}

final class Credit: Category {
    
}

final class Investment: Category {
    
}

import Foundation
import SwiftUI

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    /// A currency format style that uses the device's current locale currency code, defaulting to USD.
    public static var localCurrencyOrUSD: Self {
        let code = Locale.current.currency?.identifier ?? "USD"
        return .currency(code: code)
    }
}

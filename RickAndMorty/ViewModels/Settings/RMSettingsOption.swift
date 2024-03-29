//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode

    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://www.linkedin.com/in/marcelodearaujo47/")
        case .terms:
            return URL(string: "https://github.com/AIWASS23/RickAndMorty/blob/main/CODE_OF_CONDUCT.md")
        case .privacy:
            return URL(string: "https://github.com/AIWASS23/RickAndMorty/blob/main/LICENSE")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/documentation/#get-a-single-episode")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/@adultswim/playlists")
        case .viewCode:
            return URL(string: "https://github.com/AIWASS23/RickAndMorty")
        }
    }

    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Referenec"
        case .viewSeries:
            return "View VIdeo Series"
        case .viewCode:
            return "View App Code"
        }
    }

    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemGreen
        case .terms:
            return .systemRed
        case .privacy:
            return .systemYellow
        case .apiReference:
            return .systemOrange
        case .viewSeries:
            return .systemPurple
        case .viewCode:
            return .systemPink
        }
    }

    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewSeries:
            return UIImage(systemName: "tv.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
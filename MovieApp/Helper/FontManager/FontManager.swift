//
//  FontManager.swift
//  MovieApp
//
//  Created by mert polat on 3.02.2024.
//

import UIKit

// MARK: - FontManager
class FontManager {
    
    public static func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: "FONTNAME", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func semiBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "FONTNAME", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func boldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "FONTNAME", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
}

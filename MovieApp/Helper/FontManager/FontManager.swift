//
//  FontManager.swift
//  MovieApp
//
//  Created by mert polat on 3.02.2024.
//

import UIKit

// MARK: - FontManager
class FontManager {
    
    public static func headline1() -> UIFont {
        return   UIFont.boldSystemFont(ofSize: 28) }
    
    public static func headline2() -> UIFont {
        return  UIFont.boldSystemFont(ofSize: 24)    }
    
    public static func headline3() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 21)    }
    
    public static func subtitleAndMenu() -> UIFont {
        return UIFont.systemFont(ofSize: 18)    }
    
    public static func bodyAndForms() -> UIFont {
        return UIFont.systemFont(ofSize: 16)    }
    
    public static func paragraphAndButton() -> UIFont {
        return UIFont.systemFont(ofSize: 14)    }
    
    public static func caption() -> UIFont {
        return UIFont.systemFont(ofSize: 12)    }
    
    public static func overline() -> UIFont {
        return UIFont.systemFont(ofSize: 10)    }
    
}

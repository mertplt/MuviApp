//
//  FontManager.swift
//  MovieApp
//
//  Created by mert polat on 3.02.2024.
//

import UIKit

// MARK: - FontManager
class FontManager {
    
    public static func headline1(size: CGFloat) -> UIFont {
        return   UIFont.boldSystemFont(ofSize: 28) }
    
    public static func headline2(size: CGFloat) -> UIFont {
        return  UIFont.boldSystemFont(ofSize: 24)    }
    
    public static func headline3(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: 21)    }
    
    public static func subtitleAndMenu(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: 18)    }
    
    public static func bodyAndForms(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: 16)    }
    
    public static func paragraphAndButton(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: 14)    }
    
    public static func caption(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: 12)    }
    
    public static func overline(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: 10)    }
    
}

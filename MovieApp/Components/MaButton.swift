//
//  MaButton.swift
//  MovieApp
//
//  Created by mert polat on 4.02.2024.
//

import Foundation
import UIKit
import TinyConstraints

enum MaButtonStyle{
    case largeButtonYellow
    case largeButtonDark
    case smallButtonYellow
    case smallButtonDark
    case bigButtun
}

class MaButton: UIButton{
    
    var Icon: UIImage?{
        didSet{
            configureIcon()
        }
    }
    
    var buttonTitle: String?{
        didSet{
            setButtonTitle()
        }
    }
    
    var style: MaButtonStyle?{
        didSet{
            applyStyle()
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setButton()
    }
}

extension MaButton{
    private func applyStyle(){
        guard let style = style else {return}
        switch style {
        case .largeButtonYellow:
            configureLargeYellowStyle()
        case .largeButtonDark:
            configureLargeDarkStyle()
        case .smallButtonYellow:
            configureSmallYellowStyle()
        case .smallButtonDark:
            configureSmallDarkStyle()
        case .bigButtun:
            configureBigStyle()
        }
    }
    
    private func configureLargeYellowStyle(){
        self.backgroundColor = ColorManager.primary
        titleLabel?.font = FontManager.paragraphAndButton()
        setTitleColor(ColorManager.surfaceDark, for: .normal)
        self.height(36)
        self.width(335)
    }
    
    private func configureLargeDarkStyle(){
        self.backgroundColor = ColorManager.surfaceDark
        titleLabel?.font = FontManager.paragraphAndButton()
        setTitleColor(ColorManager.surfaceLight, for: .normal)
        self.height(36)
        self.width(335)
    }
    
    private func configureSmallYellowStyle(){
        self.backgroundColor = ColorManager.primary
        titleLabel?.font = FontManager.paragraphAndButton()
        setTitleColor(ColorManager.surfaceDark, for: .normal)
        self.height(36)
        self.width(160)

    }
    
    private func configureSmallDarkStyle(){
        self.backgroundColor = ColorManager.surfaceDark
        titleLabel?.font = FontManager.paragraphAndButton()
        setTitleColor(ColorManager.surfaceLight, for: .normal)
        self.height(36)
        self.width(160 )
    }
    private func configureBigStyle(){
        self.backgroundColor = ColorManager.primary
        titleLabel?.font = FontManager.paragraphAndButton()
        setTitleColor(ColorManager.surfaceDark, for: .normal)
        self.height(46)
        self.width(335)
    }
    
    private func setButton(){
        self.layer.cornerRadius = 4
    }
    
    private func configureIcon(){
        if let image = self.Icon{
            self.setImage(image, for: .normal)
            let edgeInset = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
            imageEdgeInsets = edgeInset
        }
    }
    
    private func setButtonTitle(){
        if let buttonTitle = self.buttonTitle{
            self.setTitle(buttonTitle, for: .normal)
        }
    }
}




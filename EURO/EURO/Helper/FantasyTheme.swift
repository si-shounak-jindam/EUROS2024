//
//  FantasyTheme.swift
//  sifantasysdk
//
//  Created by Milind Trivedi on 02/04/24.
//

import Foundation
import UIKit
import SwiftUI


class FANTASYTheme {
    
    static var currentnavigation: UINavigationController?
    static var restore_old_navigation : Bool = true
    static var gaming_pushed_navigation : UINavigationController = UINavigationController()
    static var embeded_In_NavigationController : Bool = true
    static var originalNavBarAppearance: UINavigationBarAppearance?
    static var originalNavBarStoredStyle: UINavigationController.NavigationBarStyle?
    static var originalNavBarprefersLargeTitles: Bool? = false
    static var currentBundle: Bundle? = Bundle(identifier: "com.nasportz.sifantasysdk.t20wc")
    static var currentChildViewController: UIViewController?
    static let CFSDKScreenShotKey = "CFSDKTakeScreenShotofCurrentScreen"
    static var selectedMenuItem: String?
    
    static var isLandscape: Bool {
        return UIDevice.current.orientation.isValidInterfaceOrientation
        ? UIDevice.current.orientation.isLandscape
        : UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
    }
    
    static func getColor(named colorName: CFSDKColorName) -> Color {
        return Color(colorName.name, bundle: currentBundle)
    }
    
    static func getImage(named imageName: CFSDKImageName) -> Image? {
        return Image(imageName.name, bundle: currentBundle)
    }
    
    static func getImage(named imageName: String) -> UIImage? {
        return UIImage(named: imageName, in: currentBundle, compatibleWith: nil)
    }
    
    static func registerFonts() {
        do {
            //try UIFont.register()
        } catch let err {
            
            // GameLogger.print(err.localizedDescription)
        }
    }
    
    static var currentKeyWindow: UIWindow? {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
}


//MARK: - Navigation bar appearance and styling extenstion
extension UINavigationController {
    func style(style: NavigationBarStyle) {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        if let font = style.font, let textColor = style.textColor {
            appearance.titleTextAttributes = [.foregroundColor: textColor,
                                              .font: font]
            appearance.largeTitleTextAttributes = [.foregroundColor: textColor,
                                                   .font:  font ]
        }
        
        if let tintColor = style.tintColor {
            let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
            buttonAppearance.normal.titleTextAttributes = [.foregroundColor: tintColor]
            appearance.buttonAppearance = buttonAppearance
            navigationBar.tintColor = tintColor
        }
        
        if let backgroundColor = style.backgroundColor {
            appearance.backgroundColor = backgroundColor
        } else{
            appearance.backgroundColor = UIColor.init(patternImage: UIImage())
        }
        
        if let backgroundImage = style.backgroundImage {
            appearance.backgroundColor = style.backgroundColor
            appearance.backgroundImage = backgroundImage
            appearance.backgroundImageContentMode = .bottomRight
        }else{
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true
        }
        navigationBar.prefersLargeTitles =  true
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance =  appearance
    }
    
    func onExitQuizzerGame_restore_old_style(style: NavigationBarStyle, appearance: UINavigationBarAppearance? = nil) {
        var restoreappearance : UINavigationBarAppearance?
        
        if appearance == nil {
            restoreappearance = UINavigationBarAppearance()
        } else {
            restoreappearance = appearance
        }
        
        guard let app = restoreappearance else { return }
        
        app.configureWithTransparentBackground()
        
        if let font = style.font, let textColor = style.textColor {
            app.titleTextAttributes = [.foregroundColor: textColor, .font: UIFont.systemFont(ofSize: 17, weight: .bold)]
            app.largeTitleTextAttributes = [.foregroundColor: textColor, .font:  UIFont.systemFont(ofSize: 32, weight: .bold) ]
        }
        
        if let tintColor = style.tintColor {
            let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
            buttonAppearance.normal.titleTextAttributes = [.foregroundColor: tintColor]
            app.buttonAppearance = buttonAppearance
            navigationBar.tintColor = tintColor
        }
        
        if let backgroundColor = style.backgroundColor {
            app.backgroundColor = backgroundColor
        } else{
            app.backgroundColor = UIColor.init(patternImage: UIImage())
        }
        
        if let backgroundImage = style.backgroundImage {
            app.backgroundColor = style.backgroundColor
            app.backgroundImage = backgroundImage
            app.backgroundImageContentMode = .bottomRight
        }else{
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true
        }
        
        navigationBar.prefersLargeTitles = FANTASYTheme.originalNavBarprefersLargeTitles ?? false
        navigationBar.standardAppearance = app
        navigationBar.scrollEdgeAppearance = app
        navigationBar.compactAppearance =  app
    }
    
    struct NavigationBarStyle {
        
        var font: UIFont?//
        var textColor: UIColor?
        var tintColor: UIColor?
        var backgroundImage: UIImage?
        var shadowImage: UIImage?
        var isTranslucent: Bool?
        var backgroundColor: UIColor?
        
        static func clear() -> NavigationBarStyle {
            var style = NavigationBarStyle()
            // style.font = UIFont.customFont(customFont: .SF_UI_Bold, size: 18)
            style.textColor = UIColor(FANTASYTheme.getColor(named: .CFSDKPrimary))
            style.tintColor = UIColor(FANTASYTheme.getColor(named: .CFSDKPrimary))
            //            style.backgroundImage = UIImage()
            style.shadowImage = UIImage()
            style.isTranslucent = false
            style.backgroundColor = UIColor.init(patternImage: UIImage())
            return style
        }
        
        static func blue() -> NavigationBarStyle {
            var style = NavigationBarStyle()
            style.font =  UIFont.systemFont(ofSize: 14.0, weight: .regular)
            style.textColor = UIColor.red
            style.tintColor = UIColor.red
            //style.backgroundImage = UIImage()
            //style.shadowImage = UIImage()
            style.isTranslucent = false
            style.backgroundColor = UIColor.black
            return style
        }
        
        static func customColor(color: UIColor) -> NavigationBarStyle {
            var style = NavigationBarStyle()
            style.font =  UIFont.systemFont(ofSize: 14.0, weight: .regular)
            style.textColor = UIColor(FANTASYTheme.getColor(named: .CFSDKWhite))
            style.tintColor = UIColor(FANTASYTheme.getColor(named: .CFSDKWhite))
            //style.shadowImage = UIImage()
            style.isTranslucent = false
            style.backgroundColor = color
            return style
        }
        
        static func darkColor(color: UIColor) -> NavigationBarStyle {
            var style = NavigationBarStyle()
            //style.font = UIFont.customFont(customFont: .SF_UI_Bold, size: 18)
            style.textColor = UIColor(FANTASYTheme.getColor(named: .CFSDKPrimary))
            style.tintColor = UIColor(FANTASYTheme.getColor(named: .CFSDKPrimary))
            //style.backgroundImage = UIImage()
            //style.shadowImage = UIImage()
            style.isTranslucent = false
            style.backgroundColor = color
            return style
        }
        
        static func withBgImage(image: UIImage,color: UIColor) -> NavigationBarStyle {
            var style = NavigationBarStyle()
            style.font =  UIFont.systemFont(ofSize: 24.0, weight: .regular)
            style.textColor = UIColor(FANTASYTheme.getColor(named: .CFSDKPrimary))
            style.tintColor = UIColor(FANTASYTheme.getColor(named: .CFSDKPrimary))
            style.backgroundImage = image
            style.shadowImage = UIImage()
            style.isTranslucent = false
            style.backgroundColor = color
            return style
        }
        
        static func withBgImageEuro(image: UIImage) -> NavigationBarStyle {
            var style = NavigationBarStyle()
            style.font = UIFont.systemFont(ofSize: 24.0, weight: .regular)
            style.textColor = UIColor.white
            style.tintColor = UIColor.white
            style.backgroundImage = image
            //style.shadowImage = UIImage()
            style.isTranslucent = false
            style.backgroundColor = UIColor(FANTASYTheme.getColor(named: .CFSDKPrimary))
            return style
        }
        
        static func eraseallstyles() -> NavigationBarStyle {
            let style = NavigationBarStyle()
            return style
        }
        
    }
}

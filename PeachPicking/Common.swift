import UIKit


let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height


let isiPhoneX = screenHeight >= 812.0


let safeAreaTopHeight:CGFloat = (screenHeight >= 812) ? 44:24
let safeAreaBottomHeight:CGFloat = (screenHeight >= 812.0 && UIDevice.current.model == "iPhone"  ? 30 : 0)

let navigationBarAddTopSafeAreaHeight : CGFloat = (screenHeight >= 812.0) ? 88 : 64


let contentWidth = screenWidth - 37 - 37
let contentHeight = (contentWidth * 25) / 32




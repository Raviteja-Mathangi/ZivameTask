//
//  Extension+UIView.swift
//  iOSAssignment
//
//  Created by Raviteja Mathangi on 17/12/21.
//

import Foundation
import UIKit
import SkeletonView

extension UIView{
    //MARK: Show skeleton view in view
    func showLoading() {
                let gradient = SkeletonGradient(baseColor: UIColor.lightGray)
        self.showAnimatedGradientSkeleton(usingGradient: gradient, animation: .none, transition: .crossDissolve(1.0))
    }
    //MARK: Remove skeleton view from view
    func hideLoading() {
        self.hideSkeleton(transition: .crossDissolve(1.0))
    }
}

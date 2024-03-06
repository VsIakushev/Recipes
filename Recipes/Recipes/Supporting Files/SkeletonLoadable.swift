//
//  SkeletonLoadable.swift
//  Recipes
//
//  Created by Vitaliy Iakushev on 05.03.2024.
//

import UIKit

protocol SkeletonLoadable { }

extension SkeletonLoadable {
    
    func makeAnimationGroup() -> CAAnimationGroup {
        let animationDuration: CFTimeInterval = 1.5
        let animationOne = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        animationOne.fromValue = UIColor.gradientLightGrey.cgColor
        animationOne.toValue = UIColor.gradientDarkGrey.cgColor
        animationOne.duration = animationDuration
        animationOne.beginTime = 0
        
        let animationTwo = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        animationTwo.fromValue = UIColor.gradientDarkGrey.cgColor
        animationTwo.toValue = UIColor.gradientLightGrey.cgColor
        animationTwo.duration = animationDuration
        animationTwo.beginTime = animationOne.beginTime + animationOne.duration
        
        let group = CAAnimationGroup()
        group.animations = [animationOne, animationTwo]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = animationTwo.beginTime + animationTwo.duration
        group.isRemovedOnCompletion = false
        
       
        return group
        
    }
    
}

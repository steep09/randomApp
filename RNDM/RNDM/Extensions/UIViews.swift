//
//  Views.swift
//  RNDM
//
//  Created by Stephenson Ang on 11/23/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

extension UIView {
    
    func showToastMessage(label: UILabel, message: String) {
        
        label.text = message
        
        self.isHidden = false
        self.layer.opacity = 1.0
        closeToastMessageAnimation()
    }
    
    func closeToastMessageAnimation() {
        
        UIView.animate(withDuration: 0.8,
                       delay: 2.0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
                        
                        guard let this = self else { return }
                        
                        this.layer.opacity = 0.0
                        
        }) { [weak self] _ in
            
            guard let this = self else { return }
            
//            this.removeFromSuperview()
            this.isHidden = true
        }
        
    }
}


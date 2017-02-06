//
//  ChatViewController.swift
//  Geist
//
//  Created by Jose Eduardo Quintero Gutiérrez on 05/02/17.
//  Copyright © 2017 Jose Eduardo Quintero Gutiérrez. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var content_view: UIView!
    @IBOutlet var scroll_view: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll_view.delegate = self
        scroll_view.contentOffset = CGPoint(x: 0, y: scroll_view.frame.size.height)

        let mask_path = UIBezierPath(roundedRect: content_view.bounds, byRoundingCorners:[UIRectCorner.topLeft , UIRectCorner.topRight], cornerRadii: CGSize(width: 10, height: 10))
        

        let mask_layer = CAShapeLayer()
        mask_layer.frame = content_view.bounds
        mask_layer.path = mask_path.cgPath
        
        content_view.layer.mask = mask_layer
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.y / scrollView.frame.size.height
        if page == 0 {
            self.dismiss(animated: false, completion: nil)
        }

    }

    

}

extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)+1
    }
}

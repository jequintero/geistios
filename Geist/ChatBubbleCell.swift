//
//  ChatBubbleCell.swift
//  Geist
//
//  Created by Jose Eduardo Quintero Gutiérrez on 06/02/17.
//  Copyright © 2017 Jose Eduardo Quintero Gutiérrez. All rights reserved.
//

import UIKit

public enum BubbleType: String{
   case MyMessage, UserMessage
}

class ChatBubbleCell: UICollectionViewCell {
    public var type: BubbleType = .MyMessage
    public var bubble_width: CGFloat!
    public var bubble_height: CGFloat!
    
    override func draw(_ rect: CGRect) {
        //setupViews()
    }
    func setupViews() {
        switch type {
        case .MyMessage:
            drawMyMessage()
            break
        case .UserMessage:
            drawUserMessage()
            break
        }
    }
    
    func drawUserMessage(){
        let bubbleSpace = CGRect(x: 5.0, y: self.bounds.origin.y, width: bubble_width + 10, height: self.bounds.height)
        let bubblePath = UIBezierPath(roundedRect: bubbleSpace, byRoundingCorners: [ UIRectCorner.bottomLeft, UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
        
        
        //let bubblePath = UIBezierPath(roundedRect: bubbleSpace, cornerRadius: 20.0)
        
        /*UIColor.green.setStroke()
        UIColor.red.setFill()
        bubblePath.stroke()
        bubblePath.fill()
        */
        
        let trianglePath = UIBezierPath()
        let startPoint = CGPoint(x: 5.0, y: 0)
        let tipPoint = CGPoint(x: 0.0, y: 0)
        let endPoint = CGPoint(x: 5.0, y: 5)
        
        trianglePath.move(to: startPoint)
        trianglePath.addLine(to: tipPoint)
        trianglePath.addLine(to: endPoint)
        trianglePath.close()
        
        /*UIColor.orange.setStroke()
         UIColor.red.setFill()
         trianglePath.stroke()
         trianglePath.fill()*/
        
        
        //design path in layer
        let tailLayer = CAShapeLayer()
        tailLayer.path = trianglePath.cgPath
        tailLayer.strokeColor = UIColor.orange.cgColor
        tailLayer.lineWidth = 1.0
        
        self.layer.addSublayer(tailLayer)
        
        let bubbleLayer = CAShapeLayer()
        bubbleLayer.path = bubblePath.cgPath
        bubbleLayer.strokeColor = UIColor.clear.cgColor
        bubbleLayer.lineWidth = 1.0
        
        self.layer.addSublayer(bubbleLayer)
        
        messageTextView.frame = CGRect(x: 8, y: 0, width: bubble_width + 16, height: bubble_height + 20)
        self.addSubview(messageTextView)

    }
    
    func drawMyMessage(){
        let view_width = self.frame.size.width
        
        
        let bubbleSpace = CGRect(x: view_width-bubble_width - 25, y: self.bounds.origin.y, width: bubble_width + 10, height: self.bounds.height)
        let bubblePath = UIBezierPath(roundedRect: bubbleSpace, byRoundingCorners: [ UIRectCorner.topLeft, UIRectCorner.bottomLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
        
        
        let bubbleLayer = CAShapeLayer()
        bubbleLayer.path = bubblePath.cgPath
        bubbleLayer.strokeColor = UIColor.clear.cgColor
        bubbleLayer.lineWidth = 1.0
        
        //self.layer.addSublayer(bubbleLayer)
        self.layer.insertSublayer(bubbleLayer, at: 0)
        
        
        messageTextView.frame = CGRect(x: (view_width - bubble_width) - 20 , y: 0, width: bubble_width + 16, height: bubble_height + 20)
        
        self.addSubview(messageTextView)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
 
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Sample message"
        textView.textColor = .white
        textView.isEditable = false
        textView.backgroundColor = .clear
        return textView
    }()
    
}

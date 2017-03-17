//
//  ChatViewController.swift
//  Geist
//
//  Created by Jose Eduardo Quintero Gutiérrez on 05/02/17.
//  Copyright © 2017 Jose Eduardo Quintero Gutiérrez. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    

    @IBOutlet var chat_collection_view: UICollectionView!
    @IBOutlet var content_view: UIView!
    @IBOutlet var scroll_view: UIScrollView!
    
    private let cell_id = "chatBubbleCell"
    
    let text:String = "QUE PASO AMIGUITO???????  ???????"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scroll_view.delegate = self
        scroll_view.contentOffset = CGPoint(x: 0, y: scroll_view.frame.size.height)
        
        self.chat_collection_view.register(ChatBubbleCell.self, forCellWithReuseIdentifier: cell_id)


        let mask_path = UIBezierPath(roundedRect: content_view.bounds, byRoundingCorners:[UIRectCorner.topLeft , UIRectCorner.topRight], cornerRadii: CGSize(width: 10, height: 10))
        

        let mask_layer = CAShapeLayer()
        mask_layer.frame = content_view.bounds
        mask_layer.path = mask_path.cgPath
        
        content_view.layer.mask = mask_layer
        
    

        
        print(chat_collection_view.frame.size.width)
        
        /*Database.insertMessage(message_object: Message(id:1, from: 1, to: 1, sent_date: Date(timeIntervalSinceReferenceDate: -123456789.0), delivered_date: Date(timeIntervalSinceReferenceDate: -123456789.0), read_date: Date(timeIntervalSinceReferenceDate: -123456789.0),text: "Como estas?",type: ""))*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        chat_collection_view.reloadData()
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(chat_collection_view.frame.size.width)

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView != chat_collection_view{
            let page = scrollView.contentOffset.y / scrollView.frame.size.height
            if page == 0 {
                self.dismiss(animated: false, completion: nil)
            }
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let messageText = self.text
        
        let size = CGSize(width:250, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
        
        //return CGSize(width: view.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id, for: indexPath) as! ChatBubbleCell
        
        
        cell.messageTextView.text = self.text
        
        let size = CGSize(width: 250, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let estimatedFrame = NSString(string: self.text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
        
        cell.bubble_width = estimatedFrame.width + 8
        cell.bubble_height = estimatedFrame.height
        cell.setupViews()

        
    
            
        
        return cell
    }
    
}



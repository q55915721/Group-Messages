//
//  MessageCell.swift
//  Swift Grouped Messages
//
//  Created by 洪森達 on 2019/1/28.
//  Copyright © 2019 洪森達. All rights reserved.
//

import UIKit

class MessageCell:UITableViewCell{
    
    
    
    var message:Message! {
        
        didSet{
            
            messageLabel.text = message.text
            bubbleMessage.backgroundColor = message.isIncoming ? .white : .darkGray
            messageLabel.textColor = message.isIncoming ? .black:.white
            
            if message.isIncoming {
                trailing.isActive = false
                leading.isActive = true
            }else {
                leading.isActive = false
                trailing.isActive = true
            }
        }

    }
    let messageLabel:UILabel = {
        let lb = UILabel()
            lb.numberOfLines = 0
            lb.font = UIFont.systemFont(ofSize: 15)
        return lb
    }()
    
    let bubbleMessage:UIView = {
        let v = UIView()
            v.backgroundColor = .lightGray
            v.layer.cornerRadius = 10
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    var leading:NSLayoutConstraint!
    var trailing:NSLayoutConstraint!
    fileprivate func setupUI(){
        
        addSubview(bubbleMessage)
        addSubview(messageLabel)
        backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        
        
        messageLabel.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0))
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        leading = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
        leading.isActive = true
        
        trailing = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant:-24)
        trailing.isActive = false
        
        
        
//
        bubbleMessage.anchor(top: messageLabel.topAnchor, leading: messageLabel.leadingAnchor, bottom: messageLabel.bottomAnchor, trailing: messageLabel.trailingAnchor, padding: UIEdgeInsets(top: -16, left: -16, bottom: -16, right: -16))
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

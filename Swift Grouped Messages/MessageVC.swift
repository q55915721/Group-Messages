//
//  ViewController.swift
//  Swift Grouped Messages
//
//  Created by 洪森達 on 2019/1/28.
//  Copyright © 2019 洪森達. All rights reserved.
//

import UIKit

struct Message {
    let text: String
    let isIncoming:Bool
    let date: Date
}


extension Date {
    
    static func dateFromCustomString(customString:String) -> Date {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.date(from: customString) ?? Date()
        
    }
    
}


class DateLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        textColor = .white
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 14)
        
    }
    
    override var intrinsicContentSize: CGSize{
        let originalSize = super.intrinsicContentSize
        let height = originalSize.height + 12
            layer.cornerRadius = height / 2
        clipsToBounds = true
        return CGSize(width: originalSize.width + 20, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

class MessageVC: UITableViewController {

    
    var messagesFromServer = [
        Message(text: "How are you doing ?", isIncoming: true, date: Date.dateFromCustomString(customString: "01/27/2019")),
        Message(text: "only know you have been hard to losing road", isIncoming: true, date: Date.dateFromCustomString(customString: "01/22/2019")),
        Message(text: "It's my life", isIncoming: true, date: Date.dateFromCustomString(customString: "01/29/2019")),
        Message(text: "How have you been?", isIncoming: true, date: Date.dateFromCustomString(customString: "01/31/2019")),
        Message(text: "Swift Grouped Message_TtC22Swift_Grouped_Messages14ViewController in Interface Builder file.", isIncoming: false, date: Date.dateFromCustomString(customString: "01/23/2019")),
        Message(text: "How are you doing ?", isIncoming: true, date: Date.dateFromCustomString(customString: "01/23/2019")),

         Message(text: "How are you doing ?", isIncoming: true, date: Date.dateFromCustomString(customString: "01/25/2019")),
         Message(text: "How are you doing ?", isIncoming: false, date: Date.dateFromCustomString(customString: "01/24/2019")),
         Message(text: "How are you doing ?", isIncoming: true, date: Date.dateFromCustomString(customString: "01/24/2019"))
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Message"
        tableView.separatorStyle = .none
        tableView.register(MessageCell.self, forCellReuseIdentifier: "cellid")
        tableView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        
        gropingMessage()
    }
    
    fileprivate let cellid = "cellid"
    
    fileprivate func gropingMessage(){
        
        let dic = Dictionary(grouping: messagesFromServer) { (elemnt) -> Date in // [date:[Message]]
            return elemnt.date
        }
        
        let sortedKey = dic.keys.sorted()//[date]
        
        sortedKey.forEach { (key) in
            
            let values = dic[key] // [message]
            groupedMessages.append(values ?? [])  // [[meesage]]
        }
        
    }
    
    var groupedMessages = [[Message]]()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupedMessages.count
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if  let date = groupedMessages[section].first?.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
         
            let label = DateLabel()
            label.text = dateFormatter.string(from: date )
            
            let containerView = UIView()
                containerView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
            
        }
        
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! MessageCell
        
        let message = groupedMessages[indexPath.section][indexPath.row]
        
        cell.message = message
        
        return cell


    }


}


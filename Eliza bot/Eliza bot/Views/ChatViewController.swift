//
//  ChatViewController.swift
//  Eliza bot
//
//  Created by Тимур Чеберда on 10.03.2023.
//

import UIKit

final class ChatViewController: UITableViewController {
    @IBOutlet var messageInputView: UIView!
    @IBOutlet var textField: UITextField!
    
    private var messages: [String] = ["Hello, I'm Eliza. What is bothering you today?"]
    private let eliza = Eliza()
    
    override var inputAccessoryView: UIView? {
        messageInputView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    private func setupAppearance() {
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    override var canBecomeFirstResponder: Bool {
        true
    }
    
    @IBAction func send(_ sender: Any) {
        guard let message = textField.text, !message.isEmpty else {
            return
        }
        
        push(message)
        textField.text = nil
        push(eliza.reply(to: message))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let identifier = row.isMultiple(of: 2) ? "ElizaCell" : "UserCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MessageCell else {
            return UITableViewCell()
        }
        
        cell.message = messages[row]
        
        return cell
    }
}

private extension ChatViewController {
    func push(_ message: String) {
        messages.append(message)
        
        let newMessageIndexPath = IndexPath(row: messages.count - 1, section: 0)
        
        tableView.insertRows(at: [newMessageIndexPath], with: .fade)
        tableView.scrollToRow(at: newMessageIndexPath, at: .bottom, animated: true)
    }
}

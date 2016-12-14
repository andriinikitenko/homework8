//
//  TaskDetailsViewController.swift
//  Todo-List
//
//  Created by Andrii Nikitenko on 11.12.16.
//  Copyright © 2016 Andrii Nikitenko. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func saveTouched(_ sender: Any) {
        var savedText = textView.text!
        if savedText.characters.count > 0 {
            let task =  Tusk()
            task.taskText = savedText
            let vc = navigationController?.viewControllers.first as! TodoListViewController
            vc.tuskArr.append(task)
            _ = navigationController?.popViewController(animated: true)
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }


}

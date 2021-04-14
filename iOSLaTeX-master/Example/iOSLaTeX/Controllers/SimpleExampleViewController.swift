//
//  ViewController.swift
//  iOSLaTeX
//
//  Created by shujew on 07/23/2018.
//  Copyright (c) 2018 shujew. All rights reserved.
//

import UIKit
import iOSLaTeX

class SimpleExampleViewController: UIViewController {

    @IBOutlet weak var laTeXImageView: LaTeXImageView!
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var laTexImageViewHeightConstraint: NSLayoutConstraint!
    
    private var laTeXRenderer: LaTeXRenderer?
    
    var exampleLaTeXArray: [String] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         * You don't have to inject a LaTeX renderer but it is useful
         * for cases where you have to render multiple LaTeX images but
         * don't want 1 LaTeXRenderer per imageView
         */
        self.laTeXRenderer = LaTeXRenderer(parentView: self.view)
        
        self.laTeXImageView.inject(laTeXRenderer: self.laTeXRenderer!)
        self.laTeXImageView.heightConstraint = laTexImageViewHeightConstraint
        
        self.loadExampleLaTeX()
        
        self.generateLaTeXButtonTapped(self)
    }
    
    func loadExampleLaTeX() {
        guard let path = Bundle.main.path(forResource: "example_latex", ofType: "txt"),
            let data = try? String(contentsOfFile: path, encoding: .utf8) else {
                
            print("Error loading example LaTeX")
            return
        }
        
        self.exampleLaTeXArray = data.components(separatedBy: .newlines).filter { !$0.isEmpty }
    }
    
    func renderLaTeX(_ laTeX: String){
        self.view.endEditing(true)
        laTeXImageView.backgroundColorWhileRenderingLaTeX = self.view.backgroundColor
        
        /*
        * You can use  `laTeXImageView.laTeX = laTeX` if you don't need the completion handler
        */
        laTeXImageView.render(laTeX, shouldResize: true) { (error) in
            if let error = error {
                print("\(error)")
                return
            }
            
            print("Successfully rendered LaTeX")
        }
    }
    
    @IBAction func generateLaTeXButtonTapped(_ sender: Any) {
        let textfieldText = textfield.text
        
        if let laTeX = textfieldText?.trimmingCharacters(in: .whitespaces), !laTeX.isEmpty, !exampleLaTeXArray.contains(laTeX) {
            renderLaTeX(laTeX)
        } else {
            let randomNum:UInt32 = arc4random_uniform(UInt32(exampleLaTeXArray.count))
            let defaultLaTeXText = exampleLaTeXArray[Int(randomNum)]
            
            textfield.text = defaultLaTeXText
            renderLaTeX(defaultLaTeXText)
        }
    }
}


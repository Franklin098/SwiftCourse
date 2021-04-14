//
//  TableExampleViewController.swift
//  iOSLaTeX_Example
//
//  Created by Shuaib Jewon on 3/25/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import iOSLaTeX

class TableExampleViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var laTeXRenderer: LaTeXRenderer?
    private var exampleLaTeXArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.laTeXRenderer = LaTeXRenderer(parentView: self.view)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.loadExampleLaTeX()
    }
    
    func loadExampleLaTeX() {
        guard let path = Bundle.main.path(forResource: "example_latex", ofType: "txt"),
            let data = try? String(contentsOfFile: path, encoding: .utf8) else {
                
                print("Error loading example LaTeX")
                return
        }
        
        self.exampleLaTeXArray = data.components(separatedBy: .newlines).filter { !$0.isEmpty }
    }
}

extension TableExampleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageTableViewCell", for: indexPath) as! ImageTableViewCell
        
        let index = indexPath.row % (exampleLaTeXArray.count - 1)
        let laTeX = exampleLaTeXArray[index]
        
        cell.laTeX = laTeX
        cell.laTeXRenderer = self.laTeXRenderer
        
        cell.renderLaTeX()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

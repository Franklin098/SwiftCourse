//
//  ImageTableViewCell.swift
//  iOSLaTeX_Example
//
//  Created by Shuaib Jewon on 3/25/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import iOSLaTeX

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var latexImageView: UIImageView!
    
    weak var laTeXRenderer: LaTeXRenderer?
    var laTeX: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.latexImageView.image = nil
    }
    
    func renderLaTeX() {
        if let laTeX = laTeX, let laTeXRenderer = laTeXRenderer {
            laTeXRenderer.render(laTeX) { [weak self] (renderedLaTeX, error)  in
                if error == nil, let renderedLaTeX = renderedLaTeX, laTeX == self?.laTeX {
                    self?.latexImageView.image = renderedLaTeX
                }
            }
        }
    }
}

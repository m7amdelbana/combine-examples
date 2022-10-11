//
//  PostCell.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 04/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    func configure(with post: Post) {
        lblTitle.text = post.title
        lblDesc.text = post.body
    }
}

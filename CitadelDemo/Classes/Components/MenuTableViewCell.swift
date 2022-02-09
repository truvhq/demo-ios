//
//  MenuTableViewCell.swift
//  CitadelDemo
//
//  Created by Sergey Butorin on 08.02.2022.
//

import UIKit

final class MenuTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

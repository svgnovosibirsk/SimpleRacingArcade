//
//  RecordTableViewCell.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 14.12.2023.
//

import UIKit

final class RecordTableViewCell: UITableViewCell {
    static var identifier: String { "\(Self.self)" }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .systemGreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with record: Record) {
        self.textLabel?.text = "\(record.name): \(record.score)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel?.text = nil
    }
}

//
//  AdTableCell.swift
//  ios-adapters
//
//  Created by Charis Kyriakidis on 15/06/16.
//  Copyright © 2016 Avocarrot. All rights reserved.
//

import UIKit

class SampleTableCell: UITableViewCell {
	@IBOutlet weak var adTitle: UILabel!
	@IBOutlet weak var adText: UILabel!
	@IBOutlet weak var adImage: UIImageView!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	func loadWithSampleModel(sampleModel: SampleModel) {
		adTitle.text = sampleModel.getTitle()
		adText.text = sampleModel.getText()
		adImage.loadImage(sampleModel.getImageUrl())
	}
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}

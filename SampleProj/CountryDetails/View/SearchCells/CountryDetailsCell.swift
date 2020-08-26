//
//  CountryDetailsCell.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 26/08/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import UIKit

class CountryDetailsCell: UITableViewCell {
    
    @IBOutlet weak var countryImgView : UIImageView!
    @IBOutlet weak var countryTitleLbl : UILabel!
    @IBOutlet weak var countryDescLbl : UILabel!
    
    var index : Int? = nil
    var countryData : CountryDetails? {
        didSet{
            refresh()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        refresh()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.countryImgView.image = UIImage.init(named: "no image")
    }
    
    
    func refresh(){
        
        if let data = self.countryData, let dataTag = self.index {
            
            self.countryTitleLbl.text = data.title ?? ""
            self.countryDescLbl.text = data.description
            
            if let url = data.imageHref {
                self.countryImgView.loadImage(for: url) { (image, error) in
                    
                    DispatchQueue.main.async {
                        if error != nil {
                             self.countryImgView.image = UIImage.init(named: "no image")
                        }else if self.tag == dataTag, let img = image {
                                self.countryImgView.image = img
                        }else{
                            self.countryImgView.image = UIImage.init(named: "no image")
                        }
                    }
                }
            }else {
                self.countryImgView.image = UIImage.init(named: "no image")
            }
            
        }
    }
}

//
//  detailViewController.swift
//  SlideshowApp
//
//  Created by PC-SYSKAI553 on 2021/03/19.
//

import UIKit

class detailViewController: UIViewController {
    @IBOutlet weak var ImageView: UIImageView!
    
    var imageSource: [String]?
    var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ImageView.image = UIImage(named: (imageSource![index]) )
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  MainProfile(extention).swift
//  Insta.Gram
//
//  Created by Kok Yong on 17/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation
import UIKit

extension MainProfileViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 56 //postDetails.count
        
    }
    
    //what is the content in cell
    //dequeueReusableCell is to reque a cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let singlePostDetails = postDetails[indexPath.row]
        
        let postcell = postColectionView.dequeueReusableCell(withReuseIdentifier: "PostPictureCollectionViewCell", for: indexPath) as!PostPictureCollectionViewCell
        
        
        
//        if let url = NSURL(string: self.displayPostImage) {
//            if let data = NSData(contentsOf: url as URL) {
//                postcell.postImageView.image = UIImage(data: data as Data)
//            }
//        }
        
//        if let url = singlePostDetails.pathToImage {
//            
//            if let data = try? Data(contentsOf: url) {
//                postcell.postImageView?.image = UIImage(data: data)
//            }
//        }
        
        return postcell
    }
}

extension MainProfileViewController : UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 3
        
        
        return CGSize(width: width, height: width)
    }
}



//extension MainProfileViewController : UICollectionViewDelegate {
//
//    // var for selectedIndex
//    var selectedIndex : IndexPath = IndexPath()
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let storyboard = UIStoryboard(name: "MainProfile", bundle: Bundle.main)
//        guard let controller = storyboard.instantiateViewController(withIdentifier: "SingleViewPostViewController") as? SingleViewPostViewController else {return}
//
//        present(controller, animated: true, completion: nil)
//
//        //save index path
//        selectedIndex = indexPath
//
//        print(indexPath)
//        //Bundle.main.loadNibNamed("Slider View", owner: self, options: nil)?[0]
//    }
//
//
//}


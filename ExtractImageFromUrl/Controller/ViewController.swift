//
//  ViewController.swift
//  ExtractImageFromUrl
//
//  Created by Shahzaib Mumtaz on 31/03/2022.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    // Mark:- Creating IBOutlets.
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSinger: UILabel!
    
    // Mark:- View Life Cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetImageThumbnail()
    }
    
    // Mark:- Function to get Url thumbnail Image, title & Singer.
    
    func GetImageThumbnail() {
        
        //  Getting the path of the mp3 file.
        
        let filePath = Bundle.main.path(forResource: "Song", ofType: "mp3")
        
        // Transforming it to url
        
        let fileUrl = NSURL(fileURLWithPath: filePath!)
        
        // Instanciating asset with url associated file.
        
        let asset = AVAsset(url: fileUrl as URL) as AVAsset
        
        // Using the asset property to get the metadata of file.
        
        for metaDataItems in asset.commonMetadata {
            
            // Getting the title of the song
            
            if metaDataItems.commonKey == .commonKeyTitle {
                
                let titleData = metaDataItems.value as! NSString
                let title = titleData.substring(to: 9)
                let singerData = titleData.substring(from: 12)
                let singer = (singerData as NSString).substring(to: 13)
                labelTitle.text = title
                labelSinger.text = singer
            }
            
            // Getting the "Artist of the mp3 file.
            
            if metaDataItems.commonKey == .commonKeyArtist {
                
                let artistData = metaDataItems.value as! NSString
                print("artist ---> \(artistData)")
            }
            
            // Getting the thumbnail image associated with file
            
            if metaDataItems.commonKey == .commonKeyArtwork {
                
                let imageData = metaDataItems.value as! NSData
                let image2: UIImage = UIImage(data: imageData as Data)!
                thumbnailImage.image = image2
            }
        }
    }
}

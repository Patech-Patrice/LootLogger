//
//  ImageStore.swift
//  LootLogger
//
//  Created by Patrice Drayton on 3/4/22.
//

import UIKit

//Create an ImageStore class to store the images seperate from the data. The image store will fetch and cache the images as need and will flush the cache if the memory runs low.
class ImageStore {
    
    //Due to the way NSCache is implemented with an objective c class it requires using NSString instead of String.
    let cache = NSCache<NSString, UIImage>()
    
    //methods for adding, retrieving, and deleting an image from the dictionary
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        //To save and load an image, copy the JPEG representation of the image into a Data buffer which gets the URL and saves the image
        //Create full URL for image
        let url = imageURL(forKey: key)
        //Turn image into JPEG data. jpegData(compressionQuality:) method takes a single parameter that determines the compression quality when converting the image to JPEG data format. The compression quality is a float from 0 to 1, where 1 is the highest quality.
        if let data = image.jpegData(compressionQuality: 0.5) {
            //Write it to full URL.The function returns an instance of Data if the compression succeeds and nil if it does not. Call write(to:) to write the image data to the filesystem.
            try? data.write(to: url)
        }
    }
    
    //Now that the image is stored in the file system, the ImageStore will need to load that image when it is requested. The UIImage initializer init(contentsOffFile:) will read in an image from a file, given a URL.  Update image(forKey:) so that the ImageStore will load the image from the filesystem if it does not already have it.
    func image(forKey key: String) -> UIImage? {
        //return cache.object(forKey: key as NSString)
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        let url = imageURL(forKey: key)
        //Guard statement: a conditional that must have an else block that exits scope. Use this statement when some condition must be met in order for the code after it to be executed.  If that condition is met, program executions continues past the guard statement, and any variables bound in the guard statement are available for use.  The condition here is whether or not the UIImage initialization is successful.  If it succeeds, imageFromDisk is available to use.  If it fails, the else block is executed, returning nil.
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        //Remove the image from the filesystem and the store
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error removing the image from disk: \(error)")
        }
    }
    
    //Implement imageURL(forKey:) to create a URL in the documents directory using a given key.  The images for Item instances should also be stored in the Documents directory.  Use the image key genereatede when the user takes a picture to name the image in the file system.
    //Method to get a URL for a given image
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
    
}

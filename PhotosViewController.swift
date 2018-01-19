import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    @IBAction func nextImage(_ sender: UIButton) {
        fetchRandomPhoto()
    }
    
    func updateImageView(for photo: Photo) {
        store.fetchImage(for: photo) { (imageResult) -> Void in
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }
    
    private func fetchRandomPhoto() {
        store.fetchInterestingPhotos { (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                let randomIndex = Int(arc4random_uniform(UInt32(photos.count)))
                
                self.updateImageView(for: photos[randomIndex])
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRandomPhoto()
    }
    
}

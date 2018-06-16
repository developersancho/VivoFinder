//
//  BottomDetailViewController.swift
//  VivoFinder
//
//  Created by developersancho on 13.06.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit
import AppBottomActionSheet
import MapKit
import CoreLocation

class BottomDetailViewController: UIViewController, HalfSheetPresentableProtocol, HalfSheetTopVCProviderProtocol {
    
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            bottomView.layer.cornerRadius = 15
            bottomView.clipsToBounds = true
        }
    }
    
    var managedScrollView: UIScrollView? {
        return nil
    }
    
    var dismissMethod: [DismissMethod] {
        return [.tap, .swipe]
    }
    
    var sheetHeight: CGFloat? = 400
    
    var topVC: UIViewController = {
        DismissView.canShow = false
        //DismissView.indicatorWidth = 25
        //DismissView.indicatorColor = UIColor.black.withAlphaComponent(0.3)
        //DismissView.indicatorSpacing = 8
        //DismissView.indicatorColor = .clear
        return DismissBarViewController.instance()!
    }()
    
    var topVCTransitionStyle: HalfSheetTopVCTransitionStyle{
        return .slide
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var imageType: UIImageView!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelAddress: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelAddress.isEditable = false
        labelName.text = Common.myVivo?.name
        labelAddress.text = Common.myVivo?.address
        labelDistance.text = (Common.myVivo?.distance?.toString())! + " km"
        
        if Common.myVivo?.type == TYPE.TRANSPORT {
            imageType.image = UIImage(named: "icons8_subway")
            labelType.text = Common.TRANSPORT
        } else if Common.myVivo?.type == TYPE.OTOPARK {
            imageType.image = UIImage(named: "icons8_parking")
            labelType.text = Common.OTOPARK
        } else if Common.myVivo?.type == TYPE.AKBIL {
            imageType.image = UIImage(named: "icons8_akbil")
            labelType.text = Common.AKBIL
        } else if Common.myVivo?.type == TYPE.AVM {
            imageType.image = UIImage(named: "icons8_avm")
            labelType.text = Common.AVM
        } else if Common.myVivo?.type == TYPE.ATM {
            imageType.image = UIImage(named: "icons8_atm")
            labelType.text = Common.ATM
        } else if Common.myVivo?.type == TYPE.BANK {
            imageType.image = UIImage(named: "icons8_bank")
            labelType.text = Common.BANK
        } else if Common.myVivo?.type == TYPE.BENZIN {
            imageType.image = UIImage(named: "icons8_gas_station")
            labelType.text = Common.BENZIN
        } else if Common.myVivo?.type == TYPE.CHARGEVEHICLE {
            imageType.image = UIImage(named: "icons8_park_and_charge")
            labelType.text = Common.CHARGEVEHICLE
        } else if Common.myVivo?.type == TYPE.CINEMA {
            imageType.image = UIImage(named: "icons8_movie")
            labelType.text = Common.CINEMA
        } else if Common.myVivo?.type == TYPE.INSPECTION {
            imageType.image = UIImage(named: "icons8_service")
            labelType.text = Common.INSPECTION
        } else if Common.myVivo?.type == TYPE.ISBIKE {
            imageType.image = UIImage(named: "icons8_isbike")
            labelType.text = Common.ISBIKE
        } else if Common.myVivo?.type == TYPE.MARKET {
            imageType.image = UIImage(named: "icons8_market")
            labelType.text = Common.MARKET
        }
    }
    
    
    @IBAction func showOnMap(_ sender: Any) {
        // Navigate from one coordinate to another
//        let url = "http://maps.apple.com/maps?saddr=\(Common.vivoLocation.coordinate.latitude),\(Common.vivoLocation.coordinate.longitude)&daddr=\(Common.myVivo?.xCoor),\(Common.myVivo?.yCoor)"
//        UIApplication.shared.openURL(URL(string:url)!)
        
        let coordinate = CLLocationCoordinate2DMake((Common.myVivo?.xCoor)!, (Common.myVivo?.yCoor)!)
        let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.01, 0.02))
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
        mapItem.name = Common.myVivo?.name
        mapItem.openInMaps(launchOptions: options)
    }
    
    
}

extension BottomDetailViewController : HalfSheetAppearanceProtocol {
    var presentAnimationDuration: TimeInterval {
        return 0.35
    }
    
    var dismissAnimationDuration: TimeInterval {
        return 0.25
    }
}

extension UIView {
    func rounded(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

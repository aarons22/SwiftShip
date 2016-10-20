//
//  SwiftShip.swift
//  Pods
//
//  Created by Aaron Sapp on 10/7/16.
//
//

import Foundation
import Alamofire

public enum USPSServiceType: String {
    case priority = "Priority"
    case priorityCommercial = "Priority Commercial"
    case priorityCpp = "Priority Cpp"
    case priorityHFPCommercial = "Priority HFP Commercial"
    case priorityHFPCPP = "Priority HFP CPP"
    case priorityMailExpress = "Priority Mail Express"
    case priorityMailExpressCommercial = "Priority Mail Express Commercial"
    case priorityMailExpressCPP = "Priority Mail Express CPP"
    case priorityMailExpressSh = "Priority Mail Express Sh"
    case priorityMailExpressShCommercial = "Priority Mail Express Sh Commercial"
    case priorityMailExpressHFP = "Priority Mail Express HFP"
    case priorityMailExpressHFPCommercial = "Priority Mail Express HFP Commercial"
    case priorityMailExpressHFPCPP = "Priority Mail Express HFP CPP"
    case retailGround = "Retail Ground"
    case media = "Media"
    case library = "Library"
    case all = "All"
    case online = "Online"
    case plus = "Plus"
}

public enum USPSContainerType: String {
    case variable = "VARIABLE"
    case flatRateEnvelope = "FLAT RATE ENVELOPE"
    case paddedFlatRateEnvelope = "PADDED FLAT RATE ENVELOPE"
    case legalFlatRateEnvelope = "LEGAL FLAT RATE ENVELOPE"
    case smFlatRateEnvelope = "SM FLAT RATE ENVELOPE"
    case windowFlatRateEnvelope = "WINDOW FLAT RATE ENVELOPE"
    case iftCardFlatRateEnvelope = "IFT CARD FLAT RATE ENVELOPE"
    case smFlatRateBox = "SM FLAT RATE BOX"
    case mdFlatRateBox = "MD FLAT RATE BOX"
    case lgFlatRateBox = "LG FLAT RATE BOX"
    case regionalRateBoxA = "REGIONALRATEBOXA"
    case regionalRateBoxB = "REGIONALRATEBOXB"
    case rectangular = "RECTANGULAR"
    case nonRectangular = "NONRECTANGULAR"
}

public enum USPSSize: String {
    /// Package dimensions are 12" or less
    case regular = "REGULAR"
    /// Any package dimension is larger than 12"
    case large = "LARGE"
}

open class SwiftShip: NSObject {
    var userIdUSPS: String!
    
    var eName: String = String()
    var mailService: String = String()
    var rate: String = String()
    
    var APIError: Bool = false
    var APIErrorDescription: String = String()
    
    public init(userIdUSPS: String="") {
        self.userIdUSPS = userIdUSPS
    }
    
    open func getUSPSRate(fromZip: Int,
                          toZip: Int,
                          service: USPSServiceType = .priority,
                          pounds: Double,
                          ounces: Double,
                          container: USPSContainerType?,
                          size: USPSSize,
                          completionHandler: (@escaping (_ rate: String, _ error: String) -> Void)){
        let parameters: Parameters = [
            "API": "RateV4",
            "XML": "<RateV4Request USERID='\(self.userIdUSPS!)'><Package ID='0'><Service>\(service.rawValue)</Service><FirstClassMailType></FirstClassMailType><ZipOrigination>\(fromZip)</ZipOrigination><ZipDestination>\(toZip)</ZipDestination><Pounds>\(pounds)</Pounds><Ounces>\(ounces)</Ounces><Container>\(container!.rawValue)</Container><Size>\(size.rawValue)</Size></Package></RateV4Request>"
        ]
        
        Alamofire.request("http://production.shippingapis.com/ShippingAPI.dll", parameters: parameters).response { response in
            let parser = XMLParser(data: response.data!)
            parser.delegate = self
            
            if parser.parse() {
                completionHandler(self.rate, self.APIErrorDescription)
            } else {
                completionHandler("", "SwiftShip: XML parsing error.")
            }
            
        }
    }
}

extension SwiftShip: XMLParserDelegate {
    // MARK: XMLParser Delegate
    public func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string
        
        if (!data.isEmpty) {
            if APIError {
                if eName == "Description" {
                    APIErrorDescription += data
                }
            } else {
                if eName == "Rate" {
                    rate += data
                } else if eName == "MailService" {
                    mailService += data
                }
            }
        }
        
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        if elementName == "Error" {
            APIError = true
        }
        /* if elementName == "MailService" {
         if let mailService = attributeDict["MailService"] {
         print("MailService: \(mailService)")
         }
         }
         if elementName == "Rate" {
         if let rate = attributeDict["Rate"] {
         print("Rate: \(rate)")
         }
         } */
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
}

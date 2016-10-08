//
//  SwiftShip.swift
//  Pods
//
//  Created by Aaron Sapp on 10/7/16.
//
//

import Foundation
import Alamofire

public enum SerivceType {
    case usps
    case ups
}
enum USPSServiceType {
    case priority
    case priorityCommercial
    case priorityCpp
    case priorityHFPCommercial
    case priorityHFPCPP
    case priorityMailExpress
    case priorityMailExpressCommercial
    case priorityMailExpressCPP
    case priorityMailExpressSh
    case priorityMailExpressShCommercial
    case priorityMailExpressHFP
    case priorityMailExpressHFPCommercial
    case priorityMailExpressHFPCPP
    case retailGround
    case media
    case library
    case all
    case online
    case plus
}

enum USPSContainerType {
    case variable
    case flatRateEnvelope
    case paddedFlatRateEnvelope
    case legalFlatRateEnvelope
    case smFlatRateEnvelope
    case windowFlatRateEnvelope
    case iftCardFlatRateEnvelope
    case smFlatRateBox
    case md
    case lgFlatRateBox
    case regionalrateboxa
    case regionalrateboxb
    case rectangular
    case nonrectangular
}

open class SwiftShip: NSObject, XMLParserDelegate {
    var userId: String!
    var serviceType: SerivceType!
    
    var eName: String = String()
    var mailService: String = String()
    var rate: String = String()
    
    public init(_ userId: String, serviceType: SerivceType) {
        self.userId = userId
        self.serviceType = serviceType
    }
    
    open func getRate(_ from: String!, to: String!) -> Double {
        let parameters: Parameters = [
            "API": "RateV4",
            "XML": "<RateV4Request USERID='\(self.userId!)'><Package ID='0'><Service>Priority</Service><FirstClassMailType></FirstClassMailType><ZipOrigination>45208</ZipOrigination> <ZipDestination>43551</ZipDestination><Pounds>12.12345678</Pounds><Ounces>0.12345678</Ounces><Container>SM FLAT RATE BOX</Container><Size>REGULAR</Size></Package></RateV4Request>"
        ]
        
        Alamofire.request("http://production.shippingapis.com/ShippingAPI.dll", parameters: parameters).response { response in
            var parser = XMLParser(data: response.data!)
            parser.delegate = self

            if parser.parse() {
                //print("JSON: \(JSON)")
                print("Rate: \(self.rate)")
                print("MailService: \(self.mailService)")
            }
        }
        return 12.0
    }
    
    // MARK: XMLParser Delegate
    public func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string
        
        if (!data.isEmpty) {
            if eName == "Rate" {
                rate += data
            } else if eName == "MailService" {
                mailService += data
            }
        }
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
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

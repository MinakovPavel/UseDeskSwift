//
//  UseDeskSDKHelp.swift

import Foundation

class UseDeskSDKHelp {
    class func config_CompanyID(_ companyID: String?, email: String?, url: String?, token: String?) -> [Any]? {
        let payload = [
            "sdk" : "iOS"
        ]
        
        var dic = [
            "type" : "@@server/chat/INIT",
            "payload" : payload,
            "company_id" : companyID ?? "",
            "url" : url ?? ""
            ] as [String : Any]
        if token != nil {
            dic["token"] = token
        }
        
        return [dic]
    }
    
    class func dataEmail(_ email: String?) -> [Any]? {
        let dic = [
            "type" : "@@server/chat/SET_EMAIL",
            "email" : email ?? ""
        ]
        return [dic]
    }
    
    class func messageText(_ text: String?) -> [Any]? {
        
        let message = [
            "text" : text ?? ""
        ]
        
        let dic = [
            "type" : "@@server/chat/SEND_MESSAGE",
            "message" : message
            ] as [String : Any]
        return [dic]
    }
    
    class func feedback(_ fb: Bool) -> [Any]? {
        var data: String
        
        if fb {
            data = "LIKE"
        } else {
            data = "DISLIKE"
        }

        let payload = [
            "data" : data,
            "type" : "action"
        ]
        
        let dic = [
            "type" : "@@server/chat/CALLBACK",
            "payload" : payload
            ] as [String : Any]
        return [dic]
    }
    
    class func message(_ text: String?, withFileName fileName: String?, fileType: String?, contentBase64: String?) -> [Any]? {
        let file = [
            "name" : fileName ?? "",
            "type" : fileType ?? "",
            "content" : contentBase64 ?? ""
        ]
        
        let message = [
            "text" : text ?? "",
            "file" : file
            ] as [String : Any]
        
        let dic = [
            "type" : "@@server/chat/SEND_MESSAGE",
            "message" : message
            ] as [String : Any]
        return [dic]
    }
    
    class func dict(toJson dict: [AnyHashable : Any]?) -> String? {
        var jsonData: Data? = nil
        if let aDict = dict {
            jsonData = try? JSONSerialization.data(withJSONObject: aDict, options: [])
        }
        if jsonData == nil {
            return "{}"
        } else {
            if let aData = jsonData {
                return String(data: aData, encoding: .utf8)
            }
            return nil
        }
    }
    
    class func image(toNSString image: UIImage) -> String {
        let imageData: Data = UIImagePNGRepresentation(image)!
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
}

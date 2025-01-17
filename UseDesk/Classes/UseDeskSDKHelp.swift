//
//  UseDeskSDKHelp.swift

import Foundation

class UseDeskSDKHelp {
    class func config_CompanyID(_ companyID: String?, email: String, phone: String?, name: String?, url: String?, token: String?) -> [Any]? {
        let payload = [
            "sdk" : "iOS",
            "type" : "sdk"
        ]
        var dic = [
            "type" : "@@server/chat/INIT",
            "payload" : payload,
            "company_id" : companyID ?? "",
            "url" : url ?? ""
            ] as [String : Any]
        if token != nil {
            if token != "" {
                dic["token"] = token
            }
        }
        
        return [dic]
    }
    
    class func dataClient(_ email: String = "", phone: String = "", name: String = "", note: String = "", signature: String = "", additional_id: String? = nil) -> [Any]? {
        var dic: [String : Any] = [
            "type"  : "@@server/chat/SET_CLIENT"
        ]
        var payload: [String : Any] = [
            "email"    : email,
            "username" : name,
            "phone"    : phone,
            "note"     : note
        ]
//        if additional_id != nil {
//            if additional_id != "" {
//                payload["additional_id"] = additional_id
//            }
//        }
        if signature != "" {
            payload["signature"] = signature
        }
        dic["payload"] = payload
        return [dic]
    }
    
    class func messageText(_ text: String, messageId: String? = nil) -> [Any]? {
        
        var message: [String : Any] = [
            "text" : text
        ]
        
        if messageId != nil {
            let payload = [
                "message_id" : messageId!
            ]
            message["payload"] = payload
        }
        
        let dic = [
            "type" : "@@server/chat/SEND_MESSAGE",
            "message" : message
            ] as [String : Any]
        return [dic]
    }
    
    class func feedback(_ fb: Bool, message_id: Int) -> [Any]? {
        var data: String
        
        if fb {
            data = "LIKE"
        } else {
            data = "DISLIKE"
        }

        var payload: [String : Any] = [
            "data" : data,
            "type" : "action"
        ]
        if message_id != 0 {
            payload["messageId"] = String(message_id)
        }
        
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
        
        let message: [String : Any] = [
            "text" : text ?? "",
            "file" : file
            ]
        
        let dic: [String : Any] = [
            "type" : "@@server/chat/SEND_MESSAGE",
            "message" : message
            ]
        
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
        let imageData: Data = image.pngData()!
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
}

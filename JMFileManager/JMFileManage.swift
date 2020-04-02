//
//  JMFileManage.swift
//  JMFileManager
//
//  Created by Juuman on 2020/4/1.
//  Copyright © 2020 Juuman. All rights reserved.
//

import Foundation
import UIKit

public class JMFileManage: NSObject {
    
    public enum JMFileDataType: Int {
        case data
        case string
        case array
        case directory
        case image
        case object
    }
    
    //单列
    public static let shared : JMFileManage = {
        let instance = JMFileManage.init()
        return instance
    }()
    
    public static let fileMgr = FileManager.default
    
    //沙盒根路径
    public static let rootPath:String = {
        return NSHomeDirectory()
    }()
    
    //Document目录路径
    public static let documentPath:String = {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).last! as String
    }()
    
    //缓存目录路径cache
    public static let library_cachePath:String = {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
    }()
    
    //临时目录路径temp
    public static let tempPath:String = {
        return NSTemporaryDirectory() as String
    }()
    
}

extension JMFileManage {
    //写入文件
    @discardableResult
    public static func save(obj:Any?,path:String,type:JMFileDataType? = .data) -> Bool{
        if path.count < 2 || obj == nil{
            return false
        } else {
            let d_type = type ?? .data
            let data:NSData? = toData(obj: obj, type: d_type, path: path)
            if data != nil {
                //先创建文件夹
                if !(JMFileManage.fileMgr.fileExists(atPath: path)) {
                    var folderPath = ""
                    let folderArr = path.components(separatedBy: "/")
                    for ide in 0...folderArr.count-2{
                        let idx = folderArr[ide]
                        if folderPath == ""{
                            folderPath = idx
                        } else {
                            folderPath = folderPath + "/" + idx
                        }
                        if !(JMFileManage.fileMgr.fileExists(atPath: folderPath)) {
                            try? JMFileManage.fileMgr.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
                        }
                    }
                }
                return data!.write(to: URL(fileURLWithPath: path), atomically: true)
            } else {
                return false
            }
        }
    }
    
    //读取文件
    public static func load(path:String, type:JMFileDataType? = .data) -> Any? {
        if JMFileManage.fileMgr.fileExists(atPath: path){
            let data = NSData.init(contentsOf: URL(fileURLWithPath: path))
            let d_type = type ?? .data
            return toObject(data: data, type: d_type, path: path)
        } else {
            return nil
        }
    }
    
    //删除文件
    public static func delete(path:String){
        try? JMFileManage.fileMgr.removeItem(atPath: path)
    }
    
    
    
    
    //基本对象转nsdata
    private static func toData(obj:Any?,type:JMFileDataType,path:String?) -> NSData? {
        if obj == nil {
            return nil
        } else {
            switch type {
            case .data:
                return obj as? NSData
            case .string:
                return (obj as! String).data(using: .utf8) as NSData?
            case .array:
                return try!JSONSerialization.data(withJSONObject: obj!, options: .prettyPrinted) as NSData?
            case .directory:
                return try!JSONSerialization.data(withJSONObject: obj!, options: .prettyPrinted) as NSData?
            case .image:
                if path != nil && (path!.contains("png") || path!.contains("PNG")) {
                    return (obj as! UIImage).pngData() as NSData?
                } else {
                    return (obj as! UIImage).jpegData(compressionQuality: 0) as NSData?
                }
            case .object:
                if #available(iOS 11.0, *) {
                    return try!NSKeyedArchiver.archivedData(withRootObject: obj!, requiringSecureCoding: false) as NSData?
                } else {
                    return NSKeyedArchiver.archivedData(withRootObject: obj!) as NSData?
                }
            }
        }
    }
    
    //nsdata转基本对象
    private static func toObject(data:NSData?,type:JMFileDataType,path:String?) -> Any? {
        if data == nil {
            return nil
        } else {
            switch type {
            case .data:
                return data
            case .string:
                return String.init(data: data! as Data, encoding: .utf8)
            case .array:
                return try?JSONSerialization.jsonObject(with: data! as Data, options: .mutableContainers)
            case .directory:
                return try?JSONSerialization.jsonObject(with: data! as Data, options: .mutableContainers)
            case .image:
                return UIImage(data: data! as Data)
            case .object:
                return try?NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data! as Data)
            }
        }
    }
    
}

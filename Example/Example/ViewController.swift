//
//  ViewController.swift
//  Example
//
//  Created by Juuman on 2020/4/2.
//  Copyright © 2020 Juuman. All rights reserved.
//

import UIKit
import JMFileManager

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "JMFileManager"
    }
    
    var cells : [String] =  ["data","string","array","directory","image","object","DeleteAll"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "JSONCell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "JSONCell")
        }
        let str = cells[indexPath.row]
        cell?.textLabel?.text = str
        if str == "DeleteAll"{
            cell?.textLabel?.textColor = UIColor.blue
        } else {
            cell?.textLabel?.textColor = UIColor.black
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = cells[indexPath.row]
        switch str {
        case "data":
            let path = JMFileManage.documentPath + "/test/data";
            let obj = Data.init()
            JMFileManage.save(obj: obj, path: path)
        case "string":
            let path = JMFileManage.documentPath + "/test/string";
            let obj = "12345"
            JMFileManage.save(obj: obj, path: path, type: .string)
        case "array":
            let path = JMFileManage.documentPath + "/test/array";
            let obj = ["asas",["key":"value"]] as [Any]
            JMFileManage.save(obj: obj, path: path, type: .array)
        case "directory":
            let path = JMFileManage.documentPath + "/test/directory";
            let obj = ["key1":"value1","key2":100,"key3":["item1"]] as [String : Any]
            JMFileManage.save(obj: obj, path: path, type: .directory)
        case "image":
            let path = JMFileManage.documentPath + "/test/setting.png";
            let obj = UIImage.init(named: "setting.png")
            JMFileManage.save(obj: obj, path: path, type: .image)
        case "object":
            let path = JMFileManage.documentPath + "/test/object";
            let obj = TestModel.init()
            obj.testStr = "XXYYZZ"
            JMFileManage.save(obj: obj, path: path, type: .object)
        case "DeleteAll":
            let path = JMFileManage.documentPath + "/test";
            JMFileManage.delete(path: path)
        default:
            break
        }
    }
}




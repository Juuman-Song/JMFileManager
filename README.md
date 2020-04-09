# JMFileManager
1. [为何使用JMFileManager](#为何使用JMFileManager)
2. [如何使用JMFileManager](#如何使用JMFileManager)

## 为何使用JMFileManager
JMFileManager是对系统文件服务的封装，可以更方便得操作及管理沙盒内存储的文件。
将原先需要判断路径，生成文件夹，保存文件，判断异常等一系列操作使用简单的方法一步调用。


## 如何使用JMFileManager
```swift
import JMFileManager
 核心方法：
JMFileManage.save(obj: Any?, path: String, type: JMFileManage.JMFileDataType?)
JMFileManage.load(path: String, type: JMFileManage.JMFileDataType?)
JMFileManage.delete(path: String)
```

#### JMFileManage.data
```
let path = JMFileManage.documentPath + "/test/data";
let obj = Data.init()
JMFileManage.save(obj: obj, path: path)
let lObj = JMFileManage.load(path: path)
```

#### JMFileManage.string
```
let path = JMFileManage.documentPath + "/test/string";
let obj = "12345"
JMFileManage.save(obj: obj, path: path, type: .string)
```

#### JMFileManage.array
```
let path = JMFileManage.documentPath + "/test/array";
let obj = ["asas",["key":"value"]] as [Any]
JMFileManage.save(obj: obj, path: path, type: .array)
```

#### JMFileManage.directory
```
let path = JMFileManage.documentPath + "/test/directory";
let obj = ["key1":"value1","key2":100,"key3":["item1"]] as [String : Any]
JMFileManage.save(obj: obj, path: path, type: .directory)
```

#### JMFileManage.image
```
let path = JMFileManage.documentPath + "/test/setting.png";
let obj = UIImage.init(named: "setting.png")
JMFileManage.save(obj: obj, path: path, type: .image)
```

#### JMFileManage.object
NSObject对象必须实现NSCoding协议
```
class TestModel: NSObject , NSCoding{
    var isLogin : Bool = false
    var testStr : String? = nil
    
    override init() {
        super.init()
    }
    
    //decode
    required init?(coder aDeCoder: NSCoder){
        self.isLogin = aDeCoder.decodeBool(forKey: "isLogin")
        self.testStr = aDeCoder.decodeObject(forKey: "testStr") as? String
    }
    
    //encode
    func encode(with aCoder: NSCoder) {
        aCoder.encode(isLogin, forKey: "isLogin")
        aCoder.encode(testStr, forKey: "testStr")
    }
}
```

```
let path = JMFileManage.documentPath + "/test/object";
let obj = TestModel.init()
obj.testStr = "XXYYZZ"
JMFileManage.save(obj: obj, path: path, type: .object)
```

#### DeleteAll
```
let path = JMFileManage.documentPath + "/test";
JMFileManage.delete(path: path)
```

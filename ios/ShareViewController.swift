//
//  ShareViewController.swift
//  RNShareMenu
//
//  DO NOT EDIT THIS FILE. IT WILL BE OVERRIDEN BY NPM OR YARN.
//
//  Created by Gustavo Parreira on 26/07/2020.
//

import MobileCoreServices
import UIKit
import Social
import RNShareMenu

internal let DEFAULT_MIME_TYPE = "application/octet-stream"

internal let mimeTypes = [
    "md": "text/markdown",
    "html": "text/html",
    "htm": "text/html",
    "shtml": "text/html",
    "css": "text/css",
    "xml": "text/xml",
    "gif": "image/gif",
    "jpeg": "image/jpeg",
    "jpg": "image/jpeg",
    "js": "application/javascript",
    "atom": "application/atom+xml",
    "rss": "application/rss+xml",
    "mml": "text/mathml",
    "txt": "text/plain",
    "jad": "text/vnd.sun.j2me.app-descriptor",
    "wml": "text/vnd.wap.wml",
    "htc": "text/x-component",
    "png": "image/png",
    "tif": "image/tiff",
    "tiff": "image/tiff",
    "wbmp": "image/vnd.wap.wbmp",
    "ico": "image/x-icon",
    "jng": "image/x-jng",
    "bmp": "image/x-ms-bmp",
    "svg": "image/svg+xml",
    "svgz": "image/svg+xml",
    "webp": "image/webp",
    "woff": "application/font-woff",
    "jar": "application/java-archive",
    "war": "application/java-archive",
    "ear": "application/java-archive",
    "json": "application/json",
    "hqx": "application/mac-binhex40",
    "doc": "application/msword",
    "pdf": "application/pdf",
    "ps": "application/postscript",
    "eps": "application/postscript",
    "ai": "application/postscript",
    "rtf": "application/rtf",
    "m3u8": "application/vnd.apple.mpegurl",
    "xls": "application/vnd.ms-excel",
    "eot": "application/vnd.ms-fontobject",
    "ppt": "application/vnd.ms-powerpoint",
    "wmlc": "application/vnd.wap.wmlc",
    "kml": "application/vnd.google-earth.kml+xml",
    "kmz": "application/vnd.google-earth.kmz",
    "7z": "application/x-7z-compressed",
    "cco": "application/x-cocoa",
    "jardiff": "application/x-java-archive-diff",
    "jnlp": "application/x-java-jnlp-file",
    "run": "application/x-makeself",
    "pl": "application/x-perl",
    "pm": "application/x-perl",
    "prc": "application/x-pilot",
    "pdb": "application/x-pilot",
    "rar": "application/x-rar-compressed",
    "rpm": "application/x-redhat-package-manager",
    "sea": "application/x-sea",
    "swf": "application/x-shockwave-flash",
    "sit": "application/x-stuffit",
    "tcl": "application/x-tcl",
    "tk": "application/x-tcl",
    "der": "application/x-x509-ca-cert",
    "pem": "application/x-x509-ca-cert",
    "crt": "application/x-x509-ca-cert",
    "xpi": "application/x-xpinstall",
    "xhtml": "application/xhtml+xml",
    "xspf": "application/xspf+xml",
    "zip": "application/zip",
    "bin": "application/octet-stream",
    "exe": "application/octet-stream",
    "dll": "application/octet-stream",
    "deb": "application/octet-stream",
    "dmg": "application/octet-stream",
    "iso": "application/octet-stream",
    "img": "application/octet-stream",
    "msi": "application/octet-stream",
    "msp": "application/octet-stream",
    "msm": "application/octet-stream",
    "docx": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    "pptx": "application/vnd.openxmlformats-officedocument.presentationml.presentation",
    "mid": "audio/midi",
    "midi": "audio/midi",
    "kar": "audio/midi",
    "mp3": "audio/mpeg",
    "ogg": "audio/ogg",
    "m4a": "audio/x-m4a",
    "ra": "audio/x-realaudio",
    "3gpp": "video/3gpp",
    "3gp": "video/3gpp",
    "ts": "video/mp2t",
    "mp4": "video/mp4",
    "mpeg": "video/mpeg",
    "mpg": "video/mpeg",
    "mov": "video/quicktime",
    "webm": "video/webm",
    "flv": "video/x-flv",
    "m4v": "video/x-m4v",
    "mng": "video/x-mng",
    "asx": "video/x-ms-asf",
    "asf": "video/x-ms-asf",
    "wmv": "video/x-ms-wmv",
    "avi": "video/x-msvideo",
    "keynote": "application/x-iwork-keynote-sffkey",
    "pages": "application/x-iwork-pages-sffpages",
    "numbers": "application/x-iwork-numbers-sffnumbers"
]

internal func MimeType(ext: String?) -> String {
    let lowercase_ext: String = ext!.lowercased()
    if ext != nil && mimeTypes.contains(where: { $0.0 == lowercase_ext }) {
        return mimeTypes[lowercase_ext]!
    }
    return DEFAULT_MIME_TYPE
}

class ShareViewController: SLComposeServiceViewController {
  var hostAppId: String?
  var hostAppUrlScheme: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let hostAppId = Bundle.main.object(forInfoDictionaryKey: HOST_APP_IDENTIFIER_INFO_PLIST_KEY) as? String {
      self.hostAppId = hostAppId
    } else {
      print("Error: \(NO_INFO_PLIST_INDENTIFIER_ERROR)")
    }
    
    if let hostAppUrlScheme = Bundle.main.object(forInfoDictionaryKey: HOST_URL_SCHEME_INFO_PLIST_KEY) as? String {
      self.hostAppUrlScheme = hostAppUrlScheme
//      self.didSelectPost()
    } else {
      print("Error: \(NO_INFO_PLIST_URL_SCHEME_ERROR)")
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.didSelectPost()
  }

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
      guard let item = extensionContext?.inputItems.first as? NSExtensionItem else {
        cancelRequest()
        return
      }

      handlePost(item)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

  func handlePost(_ item: NSExtensionItem, extraData: [String:Any]? = nil) {
    guard let provider = item.attachments?.first else {
      cancelRequest()
      return
    }

    if let data = extraData {
      storeExtraData(data)
    } else {
      removeExtraData()
    }

    if provider.isFileURL {
      storeFile(withProvider: provider)
    } else if provider.isText {
      storeText(withProvider: provider)
    } else if provider.isURL {
      storeUrl(withProvider: provider)
    } else {
      storeFile(withProvider: provider)
    }
  }

  func storeExtraData(_ data: [String:Any]) {
    guard let hostAppId = self.hostAppId else {
      print("Error: \(NO_INFO_PLIST_INDENTIFIER_ERROR)")
      return
    }
    guard let userDefaults = UserDefaults(suiteName: "group.\(hostAppId)") else {
      print("Error: \(NO_APP_GROUP_ERROR)")
      return
    }
    userDefaults.set(data, forKey: USER_DEFAULTS_EXTRA_DATA_KEY)
    userDefaults.synchronize()
  }

  func removeExtraData() {
    guard let hostAppId = self.hostAppId else {
      print("Error: \(NO_INFO_PLIST_INDENTIFIER_ERROR)")
      return
    }
    guard let userDefaults = UserDefaults(suiteName: "group.\(hostAppId)") else {
      print("Error: \(NO_APP_GROUP_ERROR)")
      return
    }
    userDefaults.removeObject(forKey: USER_DEFAULTS_EXTRA_DATA_KEY)
    userDefaults.synchronize()
  }
  
  func storeText(withProvider provider: NSItemProvider) {
    provider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil) { (data, error) in
      guard (error == nil) else {
        self.exit(withError: error.debugDescription)
        return
      }
      guard let text = data as? String else {
        self.exit(withError: COULD_NOT_FIND_STRING_ERROR)
        return
      }
      guard let hostAppId = self.hostAppId else {
        self.exit(withError: NO_INFO_PLIST_INDENTIFIER_ERROR)
        return
      }
      guard let userDefaults = UserDefaults(suiteName: "group.\(hostAppId)") else {
        self.exit(withError: NO_APP_GROUP_ERROR)
        return
      }
      
      userDefaults.set([DATA_KEY: text, MIME_TYPE_KEY: "text/plain"],
                       forKey: USER_DEFAULTS_KEY)
      userDefaults.synchronize()
      
      self.openHostApp()
    }
  }
  
  func storeUrl(withProvider provider: NSItemProvider) {
    provider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil) { (data, error) in
      guard (error == nil) else {
        self.exit(withError: error.debugDescription)
        return
      }
      guard let url = data as? URL else {
        self.exit(withError: COULD_NOT_FIND_URL_ERROR)
        return
      }
      guard let hostAppId = self.hostAppId else {
        self.exit(withError: NO_INFO_PLIST_INDENTIFIER_ERROR)
        return
      }
      guard let userDefaults = UserDefaults(suiteName: "group.\(hostAppId)") else {
        self.exit(withError: NO_APP_GROUP_ERROR)
        return
      }
      
      userDefaults.set([DATA_KEY: url.absoluteString, MIME_TYPE_KEY: "text/plain"],
                       forKey: USER_DEFAULTS_KEY)
      userDefaults.set(["isLink": true],
                       forKey: USER_DEFAULTS_EXTRA_DATA_KEY)
      userDefaults.synchronize()
      
      self.openHostApp()
    }
  }
  
  func storeImage(withProvider provider: NSItemProvider) {
    provider.loadItem(forTypeIdentifier: kUTTypeData as String, options: nil) { (data, error) in
      guard (error == nil) else {
        self.exit(withError: error.debugDescription)
        return
      }
      guard let url = data as? URL else {
        self.exit(withError: COULD_NOT_FIND_IMG_ERROR)
        return
      }
      guard let hostAppId = self.hostAppId else {
        self.exit(withError: NO_INFO_PLIST_INDENTIFIER_ERROR)
        return
      }
      guard let userDefaults = UserDefaults(suiteName: "group.\(hostAppId)") else {
        self.exit(withError: NO_APP_GROUP_ERROR)
        return
      }
      guard let groupFileManagerContainer = FileManager.default
              .containerURL(forSecurityApplicationGroupIdentifier: "group.\(hostAppId)")
      else {
        self.exit(withError: NO_APP_GROUP_ERROR)
        return
      }
      
      var mimeType = url.extractMimeType()
      let fileExtension = url.pathExtension
      let fileName = UUID().uuidString
      let filePath = groupFileManagerContainer
        .appendingPathComponent("\(fileName).\(fileExtension)")
      
      guard self.moveFileToDisk(from: url, to: filePath) else {
        self.exit(withError: COULD_NOT_SAVE_FILE_ERROR)
        return
      }
      
      if (mimeType == "") {
        mimeType = MimeType(ext: fileExtension)
      }
      
      userDefaults.set([DATA_KEY: filePath.absoluteString,  MIME_TYPE_KEY: mimeType],
                       forKey: USER_DEFAULTS_KEY)
      userDefaults.set(["fileName": url.lastPathComponent],
                       forKey: USER_DEFAULTS_EXTRA_DATA_KEY)
      userDefaults.synchronize()
      
      self.openHostApp()
    }
  }
  
  func storeFile(withProvider provider: NSItemProvider) {
    if provider.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
      self.storeImage(withProvider: provider)
      return
    }
    provider.loadItem(forTypeIdentifier: kUTTypeFileURL as String, options: nil) { (data, error) in
      guard (error == nil) else {
        self.exit(withError: error.debugDescription)
        return
      }
      guard let url = data as? URL else {
        self.exit(withError: COULD_NOT_FIND_IMG_ERROR)
        return
      }
      guard let hostAppId = self.hostAppId else {
        self.exit(withError: NO_INFO_PLIST_INDENTIFIER_ERROR)
        return
      }
      guard let userDefaults = UserDefaults(suiteName: "group.\(hostAppId)") else {
        self.exit(withError: NO_APP_GROUP_ERROR)
        return
      }
      guard let groupFileManagerContainer = FileManager.default
              .containerURL(forSecurityApplicationGroupIdentifier: "group.\(hostAppId)")
      else {
        self.exit(withError: NO_APP_GROUP_ERROR)
        return
      }
      
      var mimeType = url.extractMimeType()
      let fileExtension = url.pathExtension
      let fileName = UUID().uuidString
      let filePath = groupFileManagerContainer
        .appendingPathComponent("\(fileName).\(fileExtension)")
      
      guard self.moveFileToDisk(from: url, to: filePath) else {
        self.exit(withError: COULD_NOT_SAVE_FILE_ERROR)
        return
      }
      
      if (mimeType == "") {
        mimeType = MimeType(ext: fileExtension)
      }
      
      userDefaults.set([DATA_KEY: filePath.absoluteString,  MIME_TYPE_KEY: mimeType],
                       forKey: USER_DEFAULTS_KEY)
      userDefaults.set(["fileName": url.lastPathComponent],
                       forKey: USER_DEFAULTS_EXTRA_DATA_KEY)
      userDefaults.synchronize()
      
      self.openHostApp()
    }
  }

  func moveFileToDisk(from srcUrl: URL, to destUrl: URL) -> Bool {
    do {
      if FileManager.default.fileExists(atPath: destUrl.path) {
        try FileManager.default.removeItem(at: destUrl)
      }
      try FileManager.default.copyItem(at: srcUrl, to: destUrl)
    } catch (let error) {
      print("Could not save file from \(srcUrl) to \(destUrl): \(error)")
      return false
    }
    
    return true
  }
  
  func exit(withError error: String) {
    print("Error: \(error)")
    cancelRequest()
  }
  
  internal func openHostApp() {
    guard let urlScheme = self.hostAppUrlScheme else {
      exit(withError: NO_INFO_PLIST_URL_SCHEME_ERROR)
      return
    }
    
    let url = URL(string: urlScheme)
    let selectorOpenURL = sel_registerName("openURL:")
    var responder: UIResponder? = self
    
    while responder != nil {
      if responder?.responds(to: selectorOpenURL) == true {
        responder?.perform(selectorOpenURL, with: url)
      }
      responder = responder!.next
    }
    
    completeRequest()
  }
  
  func completeRequest() {
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
  }
  
  func cancelRequest() {
    extensionContext!.cancelRequest(withError: NSError(domain: "onmail", code: 1, userInfo: nil))
  }

}

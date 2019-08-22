# DDLoganLog


## Explain

自动采集app所有事件信息和网络情况，以logan存储，提供了上传函数block方便用户自主上传<br>
***自动采集app所有事件信息，2货pm们再不用担心埋点或追踪***


上传函数：

```objective-c
/**
上传本地所有日志目录

@param uploadBlock 上传日志block,此处调用http上传即可，filePath会遍历返回所有文件路径,最好用nsurlsession异步上传
*/
+ (void)uploadLogan:(void(^)(NSString *filePath))uploadBlock;
```

***举个栗子：***

```objective-c
[NSObject uploadLogan:^(NSString * _Nonnull filePath) {
        //请求ReqestAuth
        NSString* urltoUpload = @"www.baidu.com";
        NSURL *urlOSS = [NSURL URLWithString:urltoUpload];
        NSMutableURLRequest *mutableRequestOSS = [[NSMutableURLRequest alloc] initWithURL:urlOSS];
        mutableRequestOSS.HTTPMethod = @"PUT";
        [mutableRequestOSS setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        NSURLSessionUploadTask *task = [[NSURLSession sharedSession] uploadTaskWithRequest:mutableRequestOSS fromFile:fileUrl completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
            if (error == nil) {
                NSLog(@"upload success");
                [NSObject deleteLoganFile:filePath];
            } else {
                NSLog(@"upload failed. error:%@", error);
            }
        }];
        [task resume];
    }];
```



## Requirements

日志依赖于Logan，部分swizzle依赖于Aspects，上传json格式依赖于mjextension

## Installation

DDLoganLog is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DDLoganLog'
```

## Author

DDStrongman, lishengshu232@gmail.com

## License

DDLogan is available under the MIT license. See the LICENSE file for more info.

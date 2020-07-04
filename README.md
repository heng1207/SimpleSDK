framework打包：
1、complie：手动编译，即项目中Com+B，需要在Run Script中指定脚本文件路径。
2、archive：终端命令编译，不需要在Run Script中指定脚本文件路径。终端执行到项目目录下，执行命令./archive.sh SimpleSDK，SimpleSDK为framework项目名。
3、使用shell脚本进行framework打包时，出现如下错误：
accessing build database "/Users/gensee/Library/Developer/Xcode/DerivedData/RtSDK-degtdyfrubivpfeqblicsrkrntyt/Build/Intermediates.noindex/XCBuildData/build.db": database is locked Possibly there are two concurrent builds running in the same filesystem location.
解决：发现workspace file的build system没有改为legacy，修改为legacy build system即可。


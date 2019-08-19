# 使用 VSCode debug CocoaPods 源码和插件

![Debug cocoapods](img/1.png)

![Debug plugin](img/2.png)

- [使用 VSCode debug CocoaPods 源码和插件](#%e4%bd%bf%e7%94%a8-vscode-debug-cocoapods-%e6%ba%90%e7%a0%81%e5%92%8c%e6%8f%92%e4%bb%b6)
  - [需要安装的工具](#%e9%9c%80%e8%a6%81%e5%ae%89%e8%a3%85%e7%9a%84%e5%b7%a5%e5%85%b7)
    - [Debug Ruby 用的 gem](#debug-ruby-%e7%94%a8%e7%9a%84-gem)
    - [VSCode Ruby 插件](#vscode-ruby-%e6%8f%92%e4%bb%b6)
  - [Debug](#debug)
    - [Debug CocoaPods 源码](#debug-cocoapods-%e6%ba%90%e7%a0%81)
    - [🔌 同时 debug CocoaPods 和插件源码](#%f0%9f%94%8c-%e5%90%8c%e6%97%b6-debug-cocoapods-%e5%92%8c%e6%8f%92%e4%bb%b6%e6%ba%90%e7%a0%81)
    - [🌰 一个 debug CocoaPods 源码及插件的例子](#%f0%9f%8c%b0-%e4%b8%80%e4%b8%aa-debug-cocoapods-%e6%ba%90%e7%a0%81%e5%8f%8a%e6%8f%92%e4%bb%b6%e7%9a%84%e4%be%8b%e5%ad%90)

## 需要安装的工具

### Debug Ruby 用的 gem

```sh
gem install ruby-debug-ide
gem install debase
```

### VSCode Ruby 插件

[Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby)

## Debug

### Debug CocoaPods 源码

- Clone [CocoaPods](https://github.com/CocoaPods/CocoaPods)
```sh
git clone https://github.com/CocoaPods/CocoaPods.git
```

- 把 clone 的仓库切换到和本地 pod 版本相同的 tag 上

```sh
git checkout `pod --version`
```

- 在根目录创建 `.vscode/launch.json` 并填入以下内容（注意，有几个字段需要按实际填写

```json
{
  "configurations": [{
    "name": "Debug CocoaPods Plugin",
    "showDebuggerOutput": true,
    "type": "Ruby",
    "request": "launch",
    "cwd": "path/to/podfile/dir", // pod 命令执行的路径
    "program": "${workspaceRoot}/bin/pod",
    "args": ["install"] // `pod` 命令的参数
  }]
}
```

- 注释 `bin/pod:L27 (# require 'bundler/setup')` 
- 在 VSCode 中对源码下断点
- 按 F5 或点击菜单 `Debug - Start Debugging`

### 🔌 同时 debug CocoaPods 和插件源码

- 创建一个新的文件夹，下面所有的操作都在这个文件夹中
- Clone & checkout CocoaPods 的源码
- Clone 或者创建一个 CocoaPods 插件
- 把本仓库中的 `.vscode` 目录拷贝到创建的文件夹中
- 对 `.vscode/launch.json` 进行一些修改
  - `cwd`: `pod` 命令执行的路径
  - `pluginPath`: plugin 的路径
  - `args`: `pod` 命令的参数
- 修改 `cocoapods/bin/pod:L27` 
  - 把 `require 'bundler/setup` 换成 `require_relative '../../.vscode/plugin_patch'`, [参考这里](https://github.com/X140Yu/debug_cocoapods_plugins_in_vscode/blob/1a79aa6db45b67218e84044d8c3dce665cf92658/cocoapods/bin/pod#L27:L28)
- 在 VSCode 中对源码下断点
- 按 F5 或点击菜单 `Debug - Start Debugging`

### 🌰 一个 debug CocoaPods 源码及插件的例子 

> 本仓库中 CocoaPods 源码的版本为 `1.8.0.beta.1`，因为 CocoaPods 依赖的 gem 如 CocoaPods-Core 使用的还是系统内的版本，所以为了防止兼容性问题，本地安装版本也需要安装这个版本的 pod

- Clone 这个仓库
- 在 VSCode 中下断点
  - eg. `cocoapods/lib/cocoapods/command/install.rb:L46`
  - eg. `cocoapods-binary/lib/cocoapods-binary/Main.rb:L101`
- 按 F5 或点击菜单 `Debug - Start Debugging`
- Have fun 🌸


---

如果有任何问题，欢迎提交 issue 😉

喜欢就点个 🌟 吧

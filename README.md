# Debug CocoaPods & Plugins in VSCode

![Debug cocoapods](img/1.png)

![Debug plugin](img/2.png)

## Pre-requirements

### Install Debug Gems

```sh
gem install ruby-debug-ide
gem install debase
```

### Install VSCode Ruby Plugin

[Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby)

## Debug

### Debug CocoaPods

- Clone [CocoaPods](https://github.com/CocoaPods/CocoaPods)
```sh
git clone https://github.com/CocoaPods/CocoaPods.git
```

- Checkout cloned repo to match the version you have installed on your laptop

```sh
git checkout `pod --version`
```

- Create `.vscode/launch.json` in CocoaPods' root folder

```json
{
  "configurations": [{
    "name": "Debug CocoaPods Plugin",
    "showDebuggerOutput": true,
    "type": "Ruby",
    "request": "launch",
    "cwd": "path/to/podfile/dir", // where the `pod` command execute (the folder should contain a `Podfile`)
    "program": "${workspaceRoot}/bin/pod",
    "args": ["install"] // `pod` command arguments
  }]
}
```
- Comment `bin/pod:L27 (# require 'bundler/setup')` 
- Add some breakpoint within VSCode
- Press F5 or hit menu `Debug - Start Debugging`

### Example of debugging CocoaPods & plugin

> The CocoaPods version in this repository is `1.8.0.beta.1`, incase some version incompatible issue with CocoaPods-Core or other gems, you should install this version's CocoaPods in your Mac too

- Clone this repository
- Open it with VSCode
- Add a breakpoint somewhere you like to explore
  - eg. `cocoapods/lib/cocoapods/command/install.rb:L46`
  - eg. `cocoapods-binary/lib/cocoapods-binary/Main.rb:L101`
- Press F5 or hit menu `Debug - Start Debugging`
- All set 🌸

## Debug your own plugins

TBD

---

Appreciate a 🌟 if you like it. 

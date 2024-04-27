UseJavaScriptPackages
==

iOS アプリ内で、JavaScript のライブラリ (npm) を実行するサンプルです。

## JavaScript のライブラリ

### ライブラリの追加

追加したいライブラリを追加する（たとえば hogehoge とする）。

```shell
cd js-packages
yarn add hogehoge
```

### Webpack

追加したライブラリを `index.js` で定義された Bridge クラスで関数を定義する。

```javascript
import hogehoge from "hogehoge"

export class Bridge {
    static hogehoge(arguments) {
        return hogehoge(arguments)
    }
}
```

その `index.js` から次のコマンドを実行する。

```shell
yarn build
```

生成されたファイル `dist/Module.bundle.js` を iOS アプリのプロジェクトに追加する（追加済みなら更新されているのを確認する）。

## iOS アプリのブリッジ

###  バンドルされた JS ファイルの読み込み

フレームワーク `JavaScriptCore` を import して、JSContext

```swift
guard
	let path = Bundle.main.path(forResource: "Module.bundle.js", ofType: nil),
	let contents = try? String(contentsOfFile: path)
else {
	throw JavaScriptBridgeError.bundleNotFound
}
        
let context: JSContext = JSContext(virtualMachine: JSVirtualMachine())
context.evaluateScript(contents)
```

### 関数を読み込み実行する

context に対して、Webpack で設定したモジュール名や関数名を頼りに取得する。

```swift
let module = context.objectForKeyedSubscript("Module")
let bridge = module?.objectForKeyedSubscript("Bridge")
let function = bridge?.objectForKeyedSubscript("mean")

 let result =  function?.call(withArguments: [[1, 2, 3])
```






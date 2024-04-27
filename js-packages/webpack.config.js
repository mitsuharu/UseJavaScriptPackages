const path = require("path")

// https://ics.media/entry/16329/

module.exports = {
    // モード値を production に設定すると最適化された状態で、
    // development に設定するとソースマップ有効でJSファイルが出力される
    mode: 'production',
    
    // メインとなるJavaScriptファイル（エントリーポイント）
    entry: { Bridge: './index.js' },

    output: {
        path: path.resolve(__dirname, "dist"),
        filename: "[name].bundle.js",
        library: "[name]",
        libraryTarget: "var",
    },
}

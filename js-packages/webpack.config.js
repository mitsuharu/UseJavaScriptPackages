const path = require("path")
const webpack = require('webpack')

module.exports = {
    mode: 'production',
    entry: './src/index.ts', // エントリーポイント
    output: {
        path: path.resolve(__dirname, "dist"),
        filename: "Module.bundle.js",
        library: "Module",
        libraryTarget: "var",
    },
    module: {
        rules: [{
            test:  /\.tsx?$/, // .ts または .tsx ファイルを対象
            use: 'ts-loader',
            exclude: /node_modules/,
        }]
    },
    plugins: [
        new webpack.ProvidePlugin({
            Buffer: ['buffer', 'Buffer'],
        })
    ],
    resolve: {
        fallback: {
            "string_decoder": false,
            "util": false,
            "stream": false,
            "zlib": false,
            "assert": false,
            "buffer": require.resolve('buffer/'),
            "process": false,
        }
    },
    target: 'web'
}

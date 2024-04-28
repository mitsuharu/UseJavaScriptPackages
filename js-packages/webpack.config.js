const path = require("path")
const webpack = require('webpack')

module.exports = {
    mode: 'production',
    entry: './index.js',
    output: {
        path: path.resolve(__dirname, "dist"),
        filename: "Module.bundle.js",
        library: "Module",
        libraryTarget: "var",
    },
    module: {
        rules: [{
            test: /\.js$/,
            exclude: /node_modules(?!(\/|\\)(PACKAGE_NAME))/,  
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

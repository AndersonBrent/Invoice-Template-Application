
const path = require('path');

module.exports = {
  mode: 'production', // change based on 'development' or 'production' needs.
  entry: './src/index.js',
  performance: {
    hints: false,
    maxEntrypointSize: 512000,
    maxAssetSize: 512000
  },
  output: {
    filename: './public/bundle.js',
    path: __dirname
  },
  devServer: {
    contentBase: './public',
    host: 'localhost',
    port: '3000',
    open: true,
    hot: true,
    proxy: {
      '/data': {
        target: 'http://localhost:3000',
        router: () => 'http://localhost:5001'
      }
    }
  },
  module: {
    rules: [
      { test: /\.html$/i, loader: 'html-loader' },
      { test: /\.(jpg|jpeg|png|woff|woff2|eot|ttf|svg)$/, loader: 'url-loader' },
      { test: /\.jsx?$/, loader: 'babel-loader' },
      {
        test: /\.s[ac]ss$/i,
        use: [
          'style-loader',
          'css-loader',
          'sass-loader'
        ]
      },
      {
        test: /\.css$/i,
        use: ["style-loader", "css-loader", "sass-loader"],
      }
    ]
  }
};

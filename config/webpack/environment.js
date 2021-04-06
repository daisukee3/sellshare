const { environment } = require('@rails/webpacker')

module.exports = environment

environment.config.merge({
  performance: {
    hints: false
  }
})

// const webpack = require('webpack')
// environment.plugins.append(
//   'Provide',
//   new webpack.ProvidePlugin({
//     $: 'jquery/src/jquery',
//     jQuery: 'jquery/src/jquery',
//     Popper: ['popper.js', 'default']
//   })
// )
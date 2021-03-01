import 'bootstrap';
import '../stylesheets/application';
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("trix")
require("@rails/actiontext")

import $ from 'jquery'
import axios from 'modules/axios'

// フォロー機能
const handleFollowDisplay = (hasFollow) => {
  if (hasFollow) {
      $('.following').removeClass('hidden')
  } else {
      $('.follow').removeClass('hidden')
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#account-show').data()
  const accountId = dataset.accountId
  const userId = dataset.userId

  axios.get(`/accounts/${accountId}/follows/${userId}`)
    .then((response) => {
        const hasFollow = response.data.hasFollow
        handleFollowDisplay(hasFollow)
    })

  $(function(){
    $('.follow').on('click', function() {
      axios.post(`/accounts/${accountId}/follows`)
        .then((response) => {
          if (response.data.status === 'ok') {
            $('.follow').addClass('hidden')
            $('.following').removeClass('hidden')
            // const followerCount = $(`#follower_count`).text()
            // const numFollowerCount = parseInt(followerCount)
            // $(`#follower_count`).text(numFollowerCount + 1)
          }
        })
        .catch((e) => {
          window.alert('Error')
          console.log(e)
        })
    })
  })

  $(function(){
    $('.following').on('click', function() {
      axios.post(`/accounts/${accountId}/unfollows`)
        .then((response) => {
          if (response.data.status === 'ok') {
            $('.follow').removeClass('hidden')
            $('.following').addClass('hidden')
            // const followerCount = $(`#follower_count`).text()
            // const numFollowerCount = parseInt(followerCount)
            // $(`#follower_count`).text(numFollowerCount - 1)
          }
        })
        .catch((e) => {
          window.alert('Error')
          console.log(e)
        })
    })
  })

})

import $ from 'jquery'
import axios from 'modules/axios'
import {
  listenInactiveHeartEvent,
  listenActiveHeartEvent
} from 'modules/handle_heart'

// いいねされたときの挙動
const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    $('.active-heart').removeClass('hidden')
  } else {
    $('.inactive-heart').removeClass('hidden')
  }
}

// いいね機能
document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#tweet-show').data()
  const tweetId = dataset.tweetId
  
  axios.get(`/api/tweets/${tweetId}/like`)
    .then((response) => {
      const hasLiked = response.data.hasLiked
      handleHeartDisplay(hasLiked)
    })
    listenInactiveHeartEvent(tweetId)
    listenActiveHeartEvent(tweetId)
})
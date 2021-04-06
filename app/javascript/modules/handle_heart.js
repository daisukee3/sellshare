import $ from 'jquery'
import axios from 'modules/axios'

// いいねの処理による挙動変更
const listenInactiveHeartEvent = (tweetId) => {

  $('.inactive-heart').on('click', () => {
    axios.post(`/api/tweets/${tweetId}/like`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $('.active-heart').removeClass('hidden')
        $('.inactive-heart').addClass('hidden')
        const heartCount = $(`#hearts_count`).text()
        const numHeartCount = parseInt(heartCount)
        $(`#hearts_count`).text(numHeartCount + 1)
  }
    })
    .catch((e) => {
      window.alert('Error')
      console.log(e)
    })
  })
}

const listenActiveHeartEvent = (tweetId) => {
  $('.active-heart').on('click', () => {
    axios.delete(`/api/tweets/${tweetId}/like`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $('.active-heart').addClass('hidden')
        $('.inactive-heart').removeClass('hidden')
        const heartCount = $(`#hearts_count`).text()
        const numHeartCount = parseInt(heartCount)
        $(`#hearts_count`).text(numHeartCount - 1)
      }
    })
    .catch((e) => {
      window.alert('Error')
      console.log(e)
    })
  })
}

export {
  listenInactiveHeartEvent,
  listenActiveHeartEvent
}

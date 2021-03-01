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

// コメントフォームの挙動
const handleCommentForm = () => {
  $('.show-comment-form').on('click', () => {
    $('.show-comment-form').addClass('hidden')
    $('.comment-text-area.hidden').removeClass('hidden')
  })
}

// コメント追加
const appendNewComment = (comment) => {
  $('.comments-container').append(
    `<div class="tweet_comment"><p>${comment.content}</p></div>`
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#tweet-show').data()
  const tweetId = dataset.tweetId

  // コメント機能
  axios.get(`/api/tweets/${tweetId}/comments`)
    .then((response) => {
      const comments = response.data
      comments.forEach((comment) => {
        appendNewComment(comment)
      })
    })
    .catch((error) => {
      window.alert('失敗')
    })

    handleCommentForm()

  $('.add-comment-button').on('click', () => {
    const content = $('#comment_content').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/api/tweets/${tweetId}/comments`, {
        comment: {content: content}
      })
        .then((res) => {
          const comment = res.data
          appendNewComment(comment)
          $('#comment_content').val('')
        })
    }
    
  })

  // いいね機能
  axios.get(`/api/tweets/${tweetId}/like`)
    .then((response) => {
      const hasLiked = response.data.hasLiked
      handleHeartDisplay(hasLiked)
    })
    listenInactiveHeartEvent(tweetId)
    listenActiveHeartEvent(tweetId)
})
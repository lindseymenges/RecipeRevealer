$(document).ready(function() {
  $('.container').on('click', '.login_link', getLoginPartial)
  $('.container').on('click', '.signup_link', getSignupPartial)
  $('.container').on('click', '.upload_link', getUploadPartial)
});

var getLoginPartial = function(event) {
  event.preventDefault()
  var retrievingLoginPartial = $.ajax({
    url: '/login',
    type: 'GET'
  })
  retrievingLoginPartial.done(replacingHomeWithLogin)
}

var replacingHomeWithLogin = function(loginForm) {
  $('.container').empty()
  $('.container').append(loginForm)
}

var getSignupPartial = function(event) {
  event.preventDefault()
  var retrievingSignupPartial = $.ajax({
    url: '/signup',
    type: 'GET'
  })
  retrievingSignupPartial.done(replacingHomeWithSignup)
}

var replacingHomeWithSignup = function(signupForm) {
  $('.container').empty()
  $('.container').append(signupForm)
}

var getUploadPartial = function(event) {
  event.preventDefault()
  var retrievingUploadPartial = $.ajax({
    url: '/uploadrecipe',
    type: 'GET'
  })
  retrievingUploadPartial.done(appendUploadPartial)
}

var appendUploadPartial = function(uploadForm) {
  $('.upload').empty()
  $('.upload').append(uploadForm) 
}


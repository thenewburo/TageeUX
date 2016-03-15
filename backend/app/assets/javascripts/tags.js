angular.module('tagee', ['ngSanitize', 'emojiApp']);

angular.module('tagee').run(['$http', function ($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

angular.module('tagee').service('ChatService', ['$http', function ($http) {

  var messageUrl = $('[data-messages-url]').attr('data-messages-url');

  return {

    createPost: function (body) {
      return $http.post(messageUrl, { message: { body: body } });
    },

    fetchPostsAfter: function (id) {
      return $http.get(messageUrl + '?after=' + id);
    }

  };

}]);

angular.module('tagee').controller('ChatCtrl', ['$scope', '$interval', '$timeout', 'ChatService', function ($scope, $interval, $timeout, ChatService) {

  var last = 0;
  var loading = false;

  $scope.users = []
  $scope.messages = [];
  $scope.maxChars = 350
  $scope.loggedIn = window.loggedIn
  $scope.emojiMessage = {
    // angular-emoji-popup swallows and cancels the "enter" event.
    // it will only trigger this method instead.
    replyToUser: function() {
      $scope.submitMessage()
    }
  }

  $scope.currentCharacters = function() {
    if($scope.emojiMessage.messagetext) {
      return $scope.emojiMessage.messagetext.length;
    }
    return 0;
  }

  $scope.charsLeft = function() {
    return $scope.maxChars - $scope.currentCharacters();
  }

  $scope.tooManyChars = function() {
    return $scope.currentCharacters() >= $scope.maxChars;
  }

  $scope.loadNewMessages = function () {
    if (loading) return;
    var newMessages = false;
    ChatService.fetchPostsAfter(last).then(function (response) {
      newMessages = response.data.messages.length > 0;
      response.data.messages.forEach(function (message) {
        if ($scope.users.indexOf(message.login) == -1)
          $scope.users.push(message.login)
        $scope.messages.push(message);
        last = message.id;
      });
    }).finally(function () {
      loading = false;
      if (newMessages) {
        $timeout(function() {
          var messages = $('.chatroom .messages').get(0);
          messages.scrollTop = messages.scrollHeight;
          // Also hide page h1, if necessary
          $('h1').slideUp()
        });
      }
    });
  };

  $scope.keyDown = function(event) {
  }

  $scope.submitMessage = function () {
    if ($scope.emojiMessage && $scope.emojiMessage.messagetext) {
      if ($scope.tooManyChars()) return
      ChatService.createPost($scope.emojiMessage.messagetext).then(function () {
        $scope.chatProblem = '';
        $scope.emojiMessage.rawhtml = '';
        $scope.loadNewMessages();
      });
    }
  };

  $scope.loadNewMessages();
  $interval(function () { $scope.loadNewMessages(); }, 1000);
}]);

angular.module('locApp.modules.profile.controllers')
    .directive('sssLoading', function() {
        return {
            link: function(scope) {
                scope.finishedLoading = false;

                scope.$watch('finishedLoading', function() {
                    if(scope.finishedLoading) {
                        $('#spinner').hide();

                    }
                    else {
                        $('#spinner').show();
                    }
                });
            }
        };
});

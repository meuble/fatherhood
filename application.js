
$(function() {
  var questions = $('.question');
  var currentStep = 0;

  questions.hide();

  questions.each(function(index) {
    $(this).append('<p><a class="previous" href="#">Précédent</a> <a class="next" href="#">Suivant</a></p>');
  });

  var showCurrentStep = function() {
    $(questions[currentStep]).show();
  };

  var hideCurrentStep = function() {
    $(questions[currentStep]).hide();
  };

  $('.previous').on('click', function(event) {
    event.preventDefault();
    if (currentStep > 0) {
      hideCurrentStep();
      currentStep -= 1;
      showCurrentStep();
    }
  })

  $('.next').on('click', function(event) {
    event.preventDefault();
    if (currentStep < questions.length - 1) {
      hideCurrentStep();
      currentStep += 1;
      showCurrentStep();
    }
  })

  showCurrentStep();
})
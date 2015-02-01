
$(function() {
  var questions = $('.question');
  var currentStep = 0;

  questions.hide();

  questions.each(function(index) {
    $(this).append('<p class="commands"><a class="previous" href="#">Précédent</a> <a class="next" href="#">Suivant</a></p>');
  });

  var showCurrentStep = function() {
    $(questions[currentStep]).show();
  };

  var hideCurrentStep = function() {
    $(questions[currentStep]).hide();
  };

  var validatesStep = function(step) {
    if (step == 0) {
      return $('#grant_permissions').is(':checked');
    }
    return $('input:checked', questions[step]).length > 0;
  }

  var nextStep = function(event) {
    event.preventDefault();
    if (!validatesStep(currentStep)) {
      return false;
    }
    if (currentStep < questions.length - 1) {
      hideCurrentStep();
      currentStep += 1;
      showCurrentStep();
    }
  };

  var previousStep = function(event) {
    event.preventDefault();
    if (currentStep > 0) {
      hideCurrentStep();
      currentStep -= 1;
      showCurrentStep();
    }
  };

  $('.previous').on('click', previousStep);
  $('.next').on('click', nextStep);
  $('.question input[type=radio]').on('change', nextStep);

  showCurrentStep();
})

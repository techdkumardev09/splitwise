// app/javascript/expense_form.js

function populateParticipants() {
  // Fetch users from backend
  $.ajax({
    url: '/users',
    method: 'GET',
    dataType: 'json',
    success: function (users) {
      $('#participants').empty()

      users.forEach(function (user) {
        $('#participants').append(
          $('<option>', {
            value: user.id,
            text: user.name,
          })
        )
      })
    },
    error: function (xhr, status, error) {
      console.error('Failed to fetch users:', error)
    },
  })
}

// Function to submit the expense form via AJAX
function addExpense(formData) {
  $.ajax({
    url: '/expenses',
    method: 'POST',
    data: formData,
    dataType: 'json',
    success: function (response) {
      console.log('Expense added successfully:', response)
      window.location.reload()
    },
    error: function (xhr, status, error) {
      console.error('Failed to add expense:', error)
      const errors = xhr.responseJSON
      if (errors.length) {
        $('#expenseErrorMessages').show();
        $('#expenseErrorMessages').html(errors.join('<br>'))
      } else {
        $('#expenseErrorMessages').hide();
      }
    },
  })
}

function prepareExpenseParticipantData() {
  var split_by = $('#split_by').val();
  var participantIds = $('#participants').val();
  var currentUserId = $('#paid_by').data('current_user_id');
  var total_amount = parseInt($('#total_amount').val())

  participantIds.push(currentUserId);

  var expenseParticipants = [];
  if (split_by === 'unequally') {
    participantIds.forEach(function(participantId) {
      var amount_owed = parseInt($('#participant_' + participantId + '_amount').val());

      var participant = {
        user_id: participantId,
        amount_owed: amount_owed
      };
      expenseParticipants.push(participant);
    });

  } else {

    var amount_owed = total_amount / participantIds.length;
    participantIds.forEach(function(participantId) {
      var participant = {
        user_id: participantId,
        amount_owed: amount_owed
      };
      expenseParticipants.push(participant);
    });
  }
  return expenseParticipants
}

// Function to handle the form submission
function handleFormSubmission() {
  $('.add-expense').click(function (event) {
    event.preventDefault()


    var total_amount = parseInt($('#total_amount').val())
    var expenseParticipants = prepareExpenseParticipantData();
    var formData = {
      expense: {
        total_amount: total_amount,
        description: $('#description').val(),
        date: $('#date').val(),
        split_by: $('#split_by').val(),
        expense_participants_attributes : expenseParticipants,
        paid_by_id: $('#paid_by').val(),
      },
    }

    addExpense(formData)
  })
}

function updatePaidBy() {
  var selectedParticipants = $('#participants').val();
  var currentUserId = $('#paid_by').data('current_user_id');

  $('#paid_by').empty();

  $('#paid_by').append($('<option>', {
    value: currentUserId,
    text: 'You'
  }));

  selectedParticipants.forEach(function(participantId) {
    var participantName = $('#participants option[value="' + participantId + '"]').text();
    $('#paid_by').append($('<option>', {
      value: participantId,
      text: participantName
    }));

    $('#paid_by').val('')
  });
}

function updateparticipantsDetails() {
  $('#unequallySplitSection').empty();

  var currentUserID = $('#paid_by').data('current_user_id');
  var currentUserName = $('#paid_by').data('current_user_name');

  var currentUserSplitInputField = $('<div class="mb-3">' +
                                    '<label class="form-label">Amount for <b>' + currentUserName + '</b></label>' +
                                    '<input class="form-control" type="number" placeholder="Enter amount" id="participant_' + currentUserID + '_amount">' +
                                  '</div>');
$('#unequallySplitSection').append(currentUserSplitInputField);

  var selectedParticipants = $('#participants').val();
  selectedParticipants.forEach(function(participantId) {
    var participantName = $('#participants option[value="' + participantId + '"]').text();

    var participantInputField = $('<div class="mb-3">' +
                                    '<label class="form-label">Amount for <b>' + participantName + '</b></label>' +
                                    '<input class="form-control" type="number" placeholder="Enter amount" id="participant_' + participantId + '_amount">' +
                                  '</div>');
    $('#unequallySplitSection').append(participantInputField);

  });
}

function toggleSplitBySection() {
  $('#split_by').change(function() {
    var selectedOption = $(this).val();
    if (selectedOption === 'unequally') {
      $('#unequallySplitSection').removeClass('d-none');
    } else {
      $('#unequallySplitSection').addClass('d-none');
    }
  });
}

$(document).ready(function () {
  populateParticipants()
  handleFormSubmission()
  updatePaidBy();
  $('#participants').change(function() {
    updatePaidBy();
    updateparticipantsDetails();
  });
  toggleSplitBySection();
})

$(document).ready(function(){
    // Client listener
    window.addEventListener('message', function(event) {
        if (event.data.action == 'open') {
          var data = event.data.array;
          $('#lastname').text(data.lastname);
          $('#firstname').text(data.firstname);
          $('#sex').text(data.sex.toUpperCase());
          $('#personnummer').text(data.dateofbirth);
          $('#height').text(data.height + ' CM');
          $('body').show();
        } else if (event.data.action == 'close') {
          $('body').hide();
        }
    });
  });
$(document).ready(function() {
  $("#results").hide();
  if ($("body").hasClass("artists")) {
    renderArtistShow();
  }
  $("#artist-search").onSubmit(function(event) {
    event.preventDefault();
    // Fill in the data
    $("#results").show();
  });
});

var renderArtistShow = function() {
  artist = $("#artist-container").data("artist")
  $.getJSON("/artists/" + artist + "/shows", function(data) {
    $.each(data, function(key, show) {
      renderShowRow(show);
    });
  });
};

var renderShowRow = function(show) {
  date = new Date(show.datetime);
  month = parseInt(date.getMonth()) + 1
  html = "<tr class=\"shows\">";
  html += "<td class=\"artist_date shows\">" + month + "/" + date.getDate() + "/" + date.getFullYear() + "</td>";
  html += "<td class=\"artist_venue shows\">" + show.venue_name + "</td>";
  html += "<td class=\"artist_location shows\">" + show.formatted_location + "</td>";
  html += "<td class=\"artist_tickets shows\"><a href='" + show.ticket_url + "'>Ticekts</a></td>";
  html += "<td class=\"artist_rsvp shows\"><a href='" + show.facebook_rsvp_url + "'>RSVP</a></td>";
  html += "</tr>";
  $(".shows-body").append(html)
}

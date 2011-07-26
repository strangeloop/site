describe('Schedule', function() {
  beforeEach(function() {
    loadFixtures('schedule.html');
  });

  it("adds .shaded to all .column2 elements of a different track", function() {
    $('span:last').click();
    var fooey = $('#class-receiver').hasClass('column2');
    expect($("#class-receiver")).toHaveClass("shaded");
    expect($("#no-class-added")).not.toHaveClass("shaded");
  });

});



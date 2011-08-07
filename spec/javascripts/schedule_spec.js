describe('Schedule', function() {
  beforeEach(function() {
    loadFixtures('schedule.html');
  });

  it("adds .shaded to all .column3 elements of a different track", function() {
    $('span:last').trigger('click');
    expect($('span:last').text()).toEqual('Ruby');
    expect($("#no-class-added")).not.toHaveClass("shaded");
    expect($("#class-receiver")).toHaveClass("shaded");
  });

});



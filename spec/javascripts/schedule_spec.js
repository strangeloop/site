describe('Schedule', function() {
  beforeEach(function() {
    loadFixtures('spec/javascripts/fixtures/schedule.html');
  });
  
  it("adds .shaded to all .column2 elements of a different track", function() {
    $('span[data-track="Ruby"]').click();
    expect($("#class-receiver")).toHaveClass("shaded");
    expect($("#no-class-added")).not.toHaveClass("shaded");
  });
  
});

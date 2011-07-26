describe("Nav bar re-writing", function() {
  beforeEach(function() {
    loadFixtures('nav_bar.html');
  });
  
  it("adds name link to the beginning of the nav list", function() {
    SL.prependNav('foo', '/bar');
    expect($('nav > ul li:first-child').html()).toEqual('<a href="/bar">foo</a>');
  });

  it("adds log-out to the end of the nav list", function() {
    SL.appendNav('Log Out', '/logout');
    expect($('nav > ul li:last').html()).toEqual('<a href="/logout">Log Out</a>');
  });  
  
});  


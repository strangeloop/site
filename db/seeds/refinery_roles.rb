def create(title)
  Role.create(:title => title) if Role.where("title = ?", title).empty?
end

create("Submission Admin")
create("Reviewer")
create("Organizer")

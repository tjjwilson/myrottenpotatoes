class AddMyMovies < ActiveRecord::Migration
  MY_MOVIES = [
    {:title => 'Secondhand Lions', :rating => 'PG', :release_date => '19-Sep-2003'},
    {:title => 'The Gnome Mobile', :rating => 'G', :release_date => '09-Jun-1967'}
  ]
  def up
    MY_MOVIES.each do |movie|
      Movie.create!(movie)
    end
  end

  def down
    MY_MOVIES.each do |movie|
      Movie.find_by_title_and_rating(movie[:title], movie[:rating]).destroy
    end
  end
end

require "test_helper"

describe MoviesController do
  let(:move) { movies(:one) }

  it "should get index" do
    get movies_path
    value(response).must_be :success?
  end

  it "returns json" do
    get movies_path
    expect(response.header["Content-Type"]).must_include "json"
  end

  it "returns an Array" do
    get movies_path

    body = JSON.parse(response.body)
    body.must_be_kind_of Array
  end

  it "returns all of the movies" do
    get movies_path

    body = JSON.parse(response.body)
    body.length.must_equal Movie.count
  end

  it "returns movies with exactly the required fields" do
    keys = %w(id release_date title)
    get movies_path
    body = JSON.parse(response.body)
    body.each do |movie|
      movie.keys.sort.must_equal keys
    end
  end
end

describe "show" do
  # let(:movie2) { movies(:two) }
  # This bit is up to you!
  # it "can get a movie" do
  #   get movie_path(movies(:two).id)
  #   must_respond_with :success
  # end
  it "redirects if movie not found" do
    get "/movies/:id(-7)"

    must_respond_with :not_found
  end
end

describe "create" do
  let(:movie_data) {
    {
      title: "Friday",
      release_date: "1995-04-26",
      inventory: 7,
    }
  }

  it "creates a new movie given valid data" do
    expect {
      post movies_path, params: {movie: movie_data}
    }.must_change "Movie.count", 1

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of Hash
    expect(body).must_include "id"

    movie = Movie.find(body["id"].to_i)

    expect(movie.title).must_equal movie_data[:title]
    must_respond_with :success
  end

  it "returns an error for invalid movie data" do
    # arrange
    movie_data["title"] = nil

    expect {
      post movies_path, params: {movie: movie_data}
    }.wont_change "Movie.count"
    body = JSON.parse(response.body)

    expect(body).must_be_kind_of Hash
    expect(body).must_include "errors"
    expect(body["errors"]).must_include "name"
    must_respond_with :bad_request
  end
end

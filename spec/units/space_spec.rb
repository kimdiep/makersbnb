require 'space'
require 'database_connection'
require 'pg'
require 'user'

describe Space do

  before(:each) do
    @owner = User.create(fullname: 'Riya Dattani', email: 'test@example.com', password: 'password123')
  end

  describe '#all' do
    it 'returns all spaces from the spaces database table' do
      connection = PG.connect(dbname: 'makersbnb_test')
      Space.create(user_id: @owner.id, title: "Beautiful Home", description: "Beautiful home in Yorkshire", price_per_night: 50, date_from: "2019-05-01", date_to: "2019-05-31")

      spaces = Space.all

      expect(spaces.first.title).to eq 'Beautiful Home'
    end
  end

  describe '#create' do
    it 'makes a new space and inputs it to database' do
      space = Space.create(user_id: @owner.id, title: "Beautiful Home", description: "Beautiful home in Yorkshire", price_per_night: 50, date_from: "2019-05-01", date_to: "2019-05-31")
      connection = PG.connect(dbname: 'makersbnb_test')
      connection.query("SELECT * FROM spaces WHERE title = 'Beautiful Home';")

      expect(space).to be_a Space
      expect(space.title).to eq "Beautiful Home"
    end
  end

  describe '#find' do
    it 'finds a space by id' do
      space = Space.create(user_id: @owner.id, title: "Beautiful Home", description: "Beautiful home in Yorkshire", price_per_night: 50, date_from: "2019-05-01", date_to: "2019-05-31")
      result = Space.find(id: space.id)

      expect(result.id).to eq space.id
    end
  end
end

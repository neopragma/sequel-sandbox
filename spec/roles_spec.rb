require_relative "../app/db_helpers"

class Db
  include DbHelpers
end

context 'sequel gem:' do

  before do
    @dbtest = Db.new
  end

  describe 'roles table:' do

    before do
      @dbtest.clear_table :roles
    end

    it 'deletes all rows from the roles table' do
      expect(@dbtest.roles.count).to eq 0
    end

    it 'inserts one row into a simple table' do
      @dbtest.add_role("Soloist")
      expect(@dbtest.roles.count).to eq 1
    end

    it 'inserts the expected values into a single row in a simple table' do
      @dbtest.add_role("Soloist")
      expect(@dbtest.roles.first[:role_name]).to eq 'Soloist'
    end

    it 'inserts multiple rows into a simple table' do
      @dbtest.add_roles([ "Arranger", "Composer" ])
      expect(@dbtest.roles.count).to eq 2
    end

    it 'returns the data for the specified role' do
      @dbtest.add_role('Composer')
      expect(@dbtest.role('Composer')[:role_name]).to eq 'Composer'
    end

    it 'returns all role data in ascending order by role_name' do
      @dbtest.add_roles([ "Soloist", "Arranger", "Engineer", "Conductor" ])
      result = @dbtest.roles.all
      expect(result[0][:role_name]).to eq 'Arranger'
      expect(result[1][:role_name]).to eq 'Conductor'
      expect(result[2][:role_name]).to eq 'Engineer'
      expect(result[3][:role_name]).to eq 'Soloist'
    end

  end # describe roles table

end # context sequel gem

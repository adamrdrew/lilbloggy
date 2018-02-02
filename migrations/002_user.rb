Sequel.migration do
  change do
    create_table :user do
      primary_key :pk
      String :uuid, unique: true, null: false
      String :name, unique: true, null: false
      String :picture, text: true 
      String :bio, text: true
      String :email
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP, :index=>true
      index [:uuid, :name]
    end
  end
end
  
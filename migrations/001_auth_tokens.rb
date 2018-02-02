Sequel.migration do
  change do
    create_table :auth_tokens do
      primary_key :pk
      String :uuid, unique: true, null: false
      String :name, unique: true, null: false
      String :hash
      String :salt
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP, :index=>true
      index [:uuid, :name]
    end
  end
end

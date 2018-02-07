Sequel.migration do
    change do
      create_table :posts do
        primary_key :id
        String      :title, unique: true, null: false
        String      :picture, text: true 
        String      :body
        DateTime    :created_at, default: Sequel::CURRENT_TIMESTAMP, :index=>true
        index [:id, :created_at]
      end
    end
  end
    
namespace :install do
  desc "change admin user"
  task :change_admin_pwd => :environment do
    email = 'admin@example.com'
    row = Optimacms::CmsAdminUser.where(email: email).first || Optimacms::CmsAdminUser.new

    row.email = email
    row.password = ENV['pwd']
    row.password_confirmation = row.password
    #row.skip_confirmation!

    row.save!
  end


  desc 'init db. Import DB'
  task :init_db => :environment do
    #ActiveRecord::Base.connection.execute(IO.read("db-init/gex.sql"))

    # gex.sql
    script = Rails.root.join("db-init").join("gex.sql.gz").read

    # this needs to match the delimiter of your queries
    statements = script.split /;$/

    ActiveRecord::Base.transaction do
      statements.each do |stmt|
        s = stmt.strip
        #puts "s='#{s}'"

        next if stmt.blank?
        ActiveRecord::Base.connection.execute(stmt)
      end
    end



  end


end

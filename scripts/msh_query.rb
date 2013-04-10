require 'yaml'
require 'csv'

module MshQuery
  MSH = 'RUBYOPT="" msh'

  def self.fetch_user
    begin
      YAML.load(`#{MSH} show user -v`)["results"]
    rescue
      return []
    end
  end

  def self.fetch_sa(user_code=nil)
    if user_code
      ret = `#{MSH} show sa user_code #{user_code} -v`
    else
      ret = `#{MSH} show sa -v`
    end
    begin
      YAML.load(ret)["results"]
    rescue
      return []
    end
  end

  def self.fetch_all_sa
    all_sa = []
    fetch_user.each do |user|
      fetch_sa(user["code"]).each do |sa|
        all_sa << sa
#        next unless sa["up"]
#        all_sa << {
#                   "user_code" => user["code"],
#                   "code" => sa["code"],
#                   "name" => sa["name"],
#                   "distributionId" => sa["distributionId"],
#                   "up" => sa["up"]
#                   }
      end
    end

    all_sa
  end

  def self.fetch_log(sa, module_id=0)
    if sa["user_code"]
      ret = `#{MSH} md-command #{sa} #{module_id} show log user_code sa["user_code"]`
    else
      ret = `#{MSH} md-command #{sa} #{module_id} show log `
    end

    if ret =~ /\A[\.]+\n/
      ret = ret.split("\n")[2..-1].join("\n")
    end
  end

  def self.fetch_log_all_sa
    ret = { }
    fetch_all_sa.each do |sa|
      ret[sa["code"]] = self.fetch_log(sa["code"])
    end

    ret
  end

  def self.bulk_set_sa(params)
    command = []
    params.each do |param|
      command = ["msh", "set", "sa", param.delete("code")]

      param.each do |k, v|
        next if v.nil? || v.empty?
        command << "#{k} #{v}"
      end

      puts command.join(" ")
      print "execute? y/n:"
      input = gets.chomp
      puts `#{command.join(" ")}` if input == "y"
    end

  end

  def self.load_csv(path)
    ret = []
    CSV.open(path) do |row|
      sa_params = row.take(1)[0]

      row.each do |params|
        ret << Hash[*sa_params.zip(params).flatten]
      end

    end

    ret
  end

  def self.write_csv(path, header, lines)
    CSV.open(path, "w") do |writer|
      writer << header
      lines.each do |line|
        row = []
        header.each {|key| row << line[key] }
        writer << row
      end
    end
  end

end


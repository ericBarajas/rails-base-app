class Admin::DeployController < Admin::MyAdminBaseController

  def index

  end


  def server_save
    @res = run_rake_task("rake appdata:save  2>&1")


    respond_to do |format|
      format.html {      }
      format.json{        render :json=>@res}
    end
  end

  def server_update
    @res = run_rake_task("rake appdata:update  2>&1")


    respond_to do |format|
      format.html {      }
      format.json{        render :json=>@res}
    end
  end


  def run_rake_task(cmd)
    cmd = %Q(#{cmd})
    res_output = %x[#{cmd}]
    exit_code = $?.exitstatus

    #output = "exit_code = #{exit_code}; message: #{res_output}"

    # res
    {res: (exit_code==0), output: res_output, exit_code: exit_code}
  end



end

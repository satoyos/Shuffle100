require 'open3'
require 'json'

class Recorder
  attr_reader :udid, :pid, :file_path

  def initialize(driver)
    @udid = _get_udid(driver)
    # puts "UDID: #{@udid}"
  end

  def _get_udid(driver)
    device_name = driver.caps[:deviceName]
    platform_version = driver.caps[:platformVersion]

    # appiumが実行しているシミュレータのUDIDを取得
    stdout, _stderr, _status = Open3.capture3('xcrun simctl list --json devices')
    json = JSON.parse(stdout)
    booted_device = json.dig('devices', "iOS #{platform_version}").find do |device|
      device['state'] == 'Booted' && device['name'].match(device_name)
    end

    booted_device['udid']
  end

  def start(file_path)
    raise 'UDID is null' unless @udid
    raise 'Already started recording' if @pid

    file_path_converted = replace_chars_for_path(file_path)
    # バックグラウンドで録画を開始
    @pid = spawn("xcrun simctl io #{@udid} recordVideo #{file_path_converted}", out: '/dev/null', err: '/dev/null')
    # @pid = spawn("xcrun simctl io #{@udid} recordVideo #{file_path_converted}")
    @file_path = file_path_converted
    Process.detach(@pid)
  end

  def stop
    raise 'Any recording process started' unless @pid

    # 録画終了
    # たまに"No such process"で失敗するので、そのエラーはrescueで無視する。
    begin
      killed_process_num = Process.kill('SIGINT', @pid)
      raise "Kill pid: #{@pid} did not end correctly" unless killed_process_num.positive?
    rescue Errno::ESRCH
    end

    # たまに終了に時間がかかる場合があるので待つ。既に終了している場合はエラーになるのでrescueで無視する
    begin
      Process.waitpid(@pid)
    rescue Errno::ECHILD
    end

    @pid = nil
  end

  def remove_video
    raise 'file_path is null' unless @file_path

    if File.exist? @file_path
      File.delete(@file_path)
      # puts "--- 録画ファイルを消したよ！ #{@file_path}"
    end

    @file_path = nil
  end

  def replace_chars_for_path(path)
    path.gsub(/\s|,/, '_')
  end
end
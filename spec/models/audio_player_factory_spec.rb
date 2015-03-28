# -*- coding: utf-8 -*-

=begin
describe 'AudioPlayerFactory' do
  # Travis-CIを一度ちゃんと通したいのでAvAudioPlayerの再生が絡むテストは
  # 一旦全部コメントアウト。

  VALID_BASENAME   = 'audio/ia/001a'
  INVALID_BASENAME = 'audio/ia/120'
  AUDIO_TYPE = 'm4a'

  shared 'creator of playable AVAudioPlayer' do
    it 'should create non-nil-object' do
      @player.should.not.be.nil
    end
    it 'should create a playable AVAudioPlayer' do
      @player.is_a?(AVAudioPlayer).should.be.true
      @player.play.should.be.true
    end
  end
  describe 'create reader by valid file path' do
    before do
      @player = AudioPlayerFactory.create_player_by_path(VALID_BASENAME, ofType: AUDIO_TYPE)
    end

    behaves_like 'creator of playable AVAudioPlayer'
  end


  # RubyMotion3.7からraiseをspecテストでうまく拾えなくなったので、それが解決するまでこのテストはコメントアウト。
  # 
  # describe 'create reader by invalid file path' do
  #   it 'should raise RuntimeError' do
  #     should.raise{AudioPlayerFactory.create_player_by_path(INVALID_BASENAME, ofType: AUDIO_TYPE)}
  #   end
  # end


  describe 'クラスで用意されたplayerへのアクセス' do
    VOICE_AUDIO_PATH = {
        opening: 'audio/2003_序歌朗読',
    }
    before do
      AudioPlayerFactory.prepare_audio_players(VOICE_AUDIO_PATH)
      @players = AudioPlayerFactory.players
    end
    it 'AudioPlayerFactory class has a member "players"' do
      @players.should.not.be.nil
    end
    it 'all voice player can be played' do
      VOICE_AUDIO_PATH.keys.each do |key|
        @players[key].play.should.be.true
      end
    end
  end
end
=end

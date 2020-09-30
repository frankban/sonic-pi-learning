# The Departure by Max Richter
# An exercise for learning Sonic Pi.

duration = 0.5

in_thread(name: :base) do

  use_synth :saw

  arp1 = [:C, :Ds, :G, :Ds, :G, :Ds, :G, :Ds]
  arp2 = [:C, :Ds, :Gs, :Ds, :Gs, :Ds, :Gs, :Ds]
  arp3 = [:As3, :Ds, :G, :Ds, :G, :Ds, :G, :Ds]
  arp4 = [:B3, :D, :G, :D, :G, :D, :G, :D]
  base = [arp1, arp2, arp3, arp4].ring

  puts "intro"

  4.times do
    arp arp1
  end

  4.times do
    arp [:C, :F, :Gs, :F, :Gs, :F, :Gs, :F]
  end

  4.times do
    arp [:C, :D, :F, :D, :F, :D, :F, :D]
  end

  4.times do
    arp [:C, :Ds, :G, :Ds, :G, :Ds, :G, :Ds]
  end

  2.times do
    arp arp3
  end

  arp arp4
  cue :solo
  arp arp4

  puts "main"

  loop do

    i = tick
    2.times do
      arp base[i]
    end

  end

end


in_thread(name: :solo) do

  use_synth :supersaw
  sync :solo
  puts "solo"

  with_fx :reverb, room: 1, mix: 1 do
    with_fx :ixi_techno, phase: rand do
      sleep duration

      play2 :D5, :C5
      sleep duration*7
      play2 :Ds5, :D5
      sleep duration*7
      play2 :D5, :C5
      sleep duration*7
      3.times do
        play2 :F5, :Ds5
        sleep duration*7
      end

      puts "loop"
      loop do
        play2 :Ds5, :D5
        sleep duration*3.9
        play :C5
        sleep duration*3.1
        play2 :F5, :Ds5
        sleep duration*3.9
        play :D5
        sleep duration*3.1
      end
    end
  end

end

define :arp do |notes|
for note in notes do
    play note
    sleep duration/4
  end
end

define :play2 do |note1, note2|
  play note1
  sleep duration
  play note2
end

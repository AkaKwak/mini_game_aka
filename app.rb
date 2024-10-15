require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Josianne BALASCO")
player2 = HumanPlayer.new("José BEAUVAIS")

while player1.life_points > 0 && player2.life_points > 0
  puts "=" * 50
  puts "Voici l'état de chaque joueur :"
  puts
  player1.show_state
  player2.show_state
  puts "=" * 50
  puts "PHASE D'ATTAQUE :"
  puts "=" * 50
  puts
  player1.attacks(player2)
  if player2.life_points  <= 0
    break
  end
  puts
  puts "=" * 50
  puts "ETAT DES PARTICIPANTS"
  puts "=" * 50
  player1.show_state
  player2.show_state
  player2.search_weapon
  puts "=" * 50
  puts
  player2.attacks(player1)
  if player1.life_points  <= 0
    break
  end
end
puts "=" * 50

# binding.pry
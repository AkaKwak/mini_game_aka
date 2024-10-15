require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "|Bienvenue sur 'KI CASSE DU CODE' !             |"
puts "|Le but du jeu est d'être un gros costaud !     |"
puts "-------------------------------------------------"
puts "Quel est ton blaze ?"

player_name = gets.chomp
# binding.pry
user = HumanPlayer.new(player_name)
puts"=" * 75

puts "Quelle choix de merde ! #{player_name} !"
gets.chomp
puts "=" * 75
puts "Voici quand même tes caractéristiques :"
user.show_state
puts"=" * 75

player1 = Player.new("Josiane")
player2 = Player.new("José")

enemies = [player1, player2]

puts "Les deux gobelins ont été créés c'est #{enemies.map(&:name).join(' et ')}"

gets.chomp

while user.life_points >0 && (player1.life_points >0 || player2.life_points >0)

  gets.chomp
  user.show_state
  gets.chomp

  # Afficher le menu
  puts "=" * 75
  puts "Quelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts "attaquer un joueur en vue :"
  puts "0 - #{player1.name} a #{player1.life_points} points de vie"
  puts "1 - #{player2.name} a #{player2.life_points} points de vie"
  puts "=" * 75
  
  # Saisie de l'utilisateur
  print "> "
  action = gets.chomp
  
  # Exécution en fonction de la saisie
  case action
  when 'a'
    # Chercher une meilleure arme
    user.search_weapon
  when 's'
    # Chercher un pack de soins
    user.search_health_pack
  when '0'
    # Attaquer Josiane
    if player1.life_points > 0
      user.attacks(player1)
      gets.chomp
    else
      puts "#{player1.name} est déjà mort."
      gets.chomp
    end
  when '1'
    # Attaquer José
    if player2.life_points > 0
      user.attacks(player2)
      gets.chomp
    else
      puts "#{player2.name} est déjà mort."
      gets.chomp
    end
  else
    puts "Action non reconnue. Prends ça dans ta gueule."
  end

  # Vérifier si un ennemi est mort après l'attaque
  if player1.life_points <= 0
    puts "#{player1.name} a été vaincu !"
    gets.chomp
  end
  
  if player2.life_points <= 0
    puts "#{player2.name} a été vaincu !"
    gets.chomp
  end

  # Les ennemis ripostent
  puts "Les autres joueurs t'attaquent !"
  gets.chomp
  enemies.each do |enemy|
    if enemy.life_points > 0
      enemy.attacks(user)
    else
      puts "#{enemy.name} est déjà mort, il ne peut pas attaquer."
    end
  end
end


puts "La partie est finie"

# Vérifier si le joueur humain est toujours en vie
if user.life_points > 0
  puts "BRAVO loser, l'inverse aurait été humiliant"
else
  puts "Loser ! Tu as perdu !"
end

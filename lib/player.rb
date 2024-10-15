class Player

  attr_accessor :name, :life_points
  @@players = []

  @life_points=10
  def initialize(name="", life_points=10) 
    @name = name
    @life_points = life_points
    @@players << self
  end

  def show_state
    puts "#{name} a #{life_points} points de vie"
  end

  def gets_damage(damage_received)
    @life_points = @life_points - damage_received
    
    if @life_points <= 0
      puts "Le joueur #{name} a été tué !"
    end
  end

  def attacks(player)
    puts "Le joueur #{name} attaque le joueur #{player.name}"

    damage = compute_damage
    
    puts "Il lui inflige #{damage} points de dommages"

    player.gets_damage(damage)
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    # Appelle le constructeur de la classe parente Player
    super(name)
    
    # Définit les valeurs spécifiques pour HumanPlayer
    @life_points = 100
    @weapon_level = 1
  end

  # Personnalisation de show_state pour HumanPlayer
  def show_state
    puts "#{name} a #{life_points} points de vie et une arme de niveau #{weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts"=" * 75
    puts "Tu a trouvé une arme de niveau #{new_weapon_level}"
    puts"=" * 75

    if new_weapon_level > @weapon_level
      # puts "#{new_weapon_level} #{@weapon_level}"
      @weapon_level = new_weapon_level
      puts "J'adore quand ça tape fort"
      puts "=" * 75
    else
      puts"=" * 75
      puts "Bordel de merde... C'est de la daube cette arme !"
      puts"=" * 75
    end
  end

  def search_health_pack
    dice_roll = rand(1..6)
  
    if dice_roll == 1
      puts "Tu n'as rien trouvé..."
    elsif dice_roll >= 2 && dice_roll <= 5
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      @life_points += 50
      @life_points = 100 if @life_points > 100  # On s'assure que la vie ne dépasse pas 100
    elsif dice_roll == 6
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
      @life_points += 80
      @life_points = 100 if @life_points > 100  # Limitation à 100 points de vie
    end
  end
end
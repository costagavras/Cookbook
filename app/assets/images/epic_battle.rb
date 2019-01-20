attacker_lost_armies = 0
defender_lost_armies = 0

puts <<~ooo

Attack | Def
------------
ooo

(1..6).each do |attack_die_1|
  (1..6).each do |attack_die_2|
    (1..6).each do |attack_die_3|
      (1..6).each do |defend_die_1|
        (1..6).each do |defend_die_2|

          attacker_dice = [attack_die_1, attack_die_2, attack_die_3].sort.reverse
          defender_dice = [defend_die_1, defend_die_2].sort.reverse

          attacker_dice[0] > defender_dice[0] ? defender_lost_armies += 1 : attacker_lost_armies += 1
          attacker_dice[1] > defender_dice[1] ? defender_lost_armies += 1 : attacker_lost_armies += 1

          print "#{attacker_dice[0]} #{attacker_dice[1]} #{attacker_dice[2]}"
          print " vs "
          puts  "#{defender_dice[0]} #{defender_dice[1]}"

        end
      end
    end
  end
end

defender_loses_per_100_attacker_loses = (defender_lost_armies.to_f / attacker_lost_armies * 100).round

puts <<~ooo

Final Outcome
=============

Attacker lost #{attacker_lost_armies} armies.
Defender lost #{defender_lost_armies} armies.

For every 100 armies the attacker loses, the defender loses #{defender_loses_per_100_attacker_loses} armies.

ooo

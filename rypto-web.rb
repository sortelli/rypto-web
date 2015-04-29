require 'sinatra'
require 'rypto'
require 'json'
require 'haml'

get '/' do
  redirect to('/game')
end

get '/game' do
  @hand         = Rypto::Hand.new
  @new_game_url = '/game'
  @solve_url    = '/game/solve/%s,%s' % [@hand.krypto_cards.join(','), @hand.target_card]

  haml :game, :layout => :'layouts/game'
end

get '/game/solve/:c1,:c2,:c3,:c4,:c5,:c6' do
  @hand         = Rypto::Hand.new((1..5).map {|i| params["c#{i}".to_sym].to_i}, params[:c6].to_i)
  @new_game_url = '/game'
  @solutions    = @hand.solve.infix

  haml :game, :layout => :'layouts/game'
end


get '/solve/postfix/:card1/:card2/:card3/:card4/:card5/:target.:format' do |*args|
  solve args, :postfix
end

get '/solve/infix/:card1/:card2/:card3/:card4/:card5/:target.:format' do |*args|
  solve args, :infix
end

def solve(args, expr_type)
  cards = args[0, 6].map {|c| c.to_i}
  solns = Rypto::Hand.new(cards[0, 5], cards[5]).solve
  exprs = solns.send expr_type

  mime_type = case args[6]
    when 'txt', 'text' then 'text/plain'
    else                    'application/json'
  end

  output = case mime_type
    when 'text/plain' then exprs.join("\n")
    else                   JSON.pretty_generate({:solutions => exprs})
  end

  [200, {'Content-Type' => mime_type}, output]
end

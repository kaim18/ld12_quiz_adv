require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'

before do
  if Result.all.length == 0
    Result.create(score:0)
  end

  @questions = Array.new
  @questions.push(["Webサービスプログラミングコースで学んでいる、赤色の宝石の名前を使っている言語は？", "Garnet", "Ruby", "Amethyst", "Opal", "2"])
  @questions.push(["Life is Tech!でプログラミングを教えてくれるのは誰？", "メンバー", "センセー", "メンター", "センサー", "3"])
end

get '/' do
  result = Result.first
  result.score = 0
  result.save
  redirect '/question/0'
end

get '/question/:id' do
  @number = params[:id].to_i
  erb :question
end

post '/question/check/:id' do
  number = params[:id].to_i
  answer = @questions[number][5]
  select_answer = params[:select_answer]
  if answer == select_answer
    result = Result.first
    result.score = result.score + 1
    result.save
  end
  if number + 1 < @questions.length
    number = number + 1
    redirect "/question/#{number}"
  else
    redirect "/result"
  end
end

get '/result' do
  @score = Result.first.score
  erb :result
end
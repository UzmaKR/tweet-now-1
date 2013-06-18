get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/tweet' do

 Twitter.update(params[:tweet])
 
end

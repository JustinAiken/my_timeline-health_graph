MyTimeline::Engine.routes.draw do
  get 'health_graph/scrape' => 'health_graph#scrape', as: "health_graph_scrape"
  resources :health_graph
end

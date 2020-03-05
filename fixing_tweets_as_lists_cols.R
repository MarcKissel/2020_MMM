tidy_tweets <- all_tweets %>% 
  select(screen_name, mentions_screen_name) %>% 
  mutate(
    hashtags = gsub("\\[|\\]|'", "", mentions_screen_name)
  ) %>% 
  tidyr::separate_rows(hashtags, sep = ", ") %>% 
  tidyr::nest(hashtags = c(hashtags))




tidy_tweets <- all_tweets %>% 
  select(screen_name, mentions_screen_name) %>% 
  tidyr::separate_rows(mentions_screen_name, sep = " ") %>% 
  tidyr::nest(mentions_screen_name = c(mentions_screen_name))

tidy_tweets$mentions_screen_name <- tidy_tweets$mentions_screen_name %>%  
  purrr::map(unlist) %>% 
  purrr::map(unname)


tidy_tweets %>% 
  gt_edges(screen_name, mentions_screen_name) %>% 
  gt_nodes() %>% 
  gt_collect() -> gt

nodes <- gt$nodes %>% 
  mutate(
    id = nodes,
    label = nodes,
    size = n,
    color = "#1967be"
  ) 

edges <- gt$edges %>% 
  mutate(
    id = 1:n()
  )

sigmajs() %>% 
  sg_force_start() %>% 
  sg_nodes(nodes, id, label, size, color) %>% 
  sg_edges(edges, id, source, target) %>% 
  sg_force_stop(10000)

``


g %>% 
  gt_edges(screen_name, mentions_screen_name) %>% 
  gt_nodes(meta = TRUE) %>% 
  gt_collect() -> graph

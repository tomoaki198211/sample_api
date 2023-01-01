json.array! @posts, partial: "posts/post", as: :post
json.images do
  ison.array! @images
end

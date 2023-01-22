1.upto(13) do |i|
  Book.create(
    book_id: "book#{i}",
    title: "title#{i}",
    image_url: "https://2.bp.blogspot.com/-CWoHjphCbNQ/Wj4IYnGuK-I/AAAAAAABJKw/V7xQ7KauTx8S5w0JcEazgmvbS7DOhiQiQCLcBGAs/s800/entertainment_novel.png", description: "description#{i}", author: "author#{i}", user_id: 5
  )
end

podcast_list = File.open('podcast_links').readlines
first_item = podcast_list.first

podcast_list[0..2].each do |list_item|
  html = URI.open(list_item.strip)
  doc = Nokogiri::HTML(html)

  title = doc.css('.subtitle-text').text
  published_on = doc.css('.right-side p:nth-child(1)').text.gsub("\n", " ")
  description = doc.css('.right-side p:nth-child(3)').text.gsub("\n", " ")
  libsyn_id = doc.css(".row.libsyn-item.libsyn.libsyn-item-free")[0]["data-id"]

  Podcast.create(
    title: title, 
    published_on: published_on,
    description: description,
    libsyn_id: libsyn_id
  )

  Article.create(
    title: title,
    description: description,
    published: true
  )

  sleep(2)
end


anthology = [
  { sort: 1, youtube_link: "https://youtu.be/lXbeeHPS7Jg", title: "What Women Are Attracted to" },
  { sort: 2, youtube_link: "https://youtu.be/WXD5VDegplg", title: "What Women Are Not Attracted to" },
  { sort: 3, youtube_link: "https://youtu.be/HfluVPUOsOY", title: "Your Beliefs" },
  { sort: 4, youtube_link: "https://youtu.be/ihvrZ-ZosHc", title: "Your Standards" },
  { sort: 5, youtube_link: "https://youtu.be/h8GnpsaC-ak", title: "Body Language Secrets" },
  { sort: 6, youtube_link: "https://youtu.be/wotHT1YwBro", title: "Female Psychology 101" },
  { sort: 7, youtube_link: "https://youtu.be/_p3OQFRhbiU", title: "Bringing a Good Dynamic to the Nightclub" },
  { sort: 8, youtube_link: "https://youtu.be/V4ByWnSvZX4", title: "What to Wear" },
  { sort: 9, youtube_link: "https://youtu.be/bWTOD9hyt6Q", title: "How to Read Her Interest & Attraction" },
  { sort: 10, youtube_link: "https://youtu.be/Y1IsOZ8Xvn4", title: "Approaching & Opening" },
  { sort: 11, youtube_link: "https://youtu.be/lHp1ALWUiXM", title: "Day Game" },
  { sort: 12, youtube_link: "https://youtu.be/XVcuqd2ujTo", title: "Dealing With Rejection" },
  { sort: 13, youtube_link: "https://youtu.be/E_tU2yaf62k", title: "Foundation to The Initial Conversation" },
  { sort: 14, youtube_link: "https://youtu.be/eMPf8puy3v4", title: "What to Talk About" },
  { sort: 15, youtube_link: "https://youtu.be/LLalEoI8yps", title: "How to Tell Stories" },
  { sort: 16, youtube_link: "https://youtu.be/BTSmy9LJ3-I", title: "Cold Reading" },
  { sort: 17, youtube_link: "https://youtu.be/2OqBfmpEias", title: "Roleplaying" },
  { sort: 18, youtube_link: "https://youtu.be/lNZAA7hlouA", title: "Gambits Part 1" },
  { sort: 19, youtube_link: "https://youtu.be/X4hkoAlkEM8", title: "Gambits Part 2" },
  { sort: 20, youtube_link: "https://youtu.be/WbQoM9yFDSE", title: "Alliances, Misinterpretation, and Building Intrigue" },
  { sort: 21, youtube_link: "https://youtu.be/aAcR9pauXgg", title: "Push/Pull" },
  { sort: 22, youtube_link: "https://youtu.be/tcaF_sUfsRQ", title: "How to be a Challenge" },
  { sort: 23, youtube_link: "https://youtu.be/w0xmD9CEz_s", title: "Frame Control" },
  { sort: 24, youtube_link: "https://youtu.be/Ao-M7xU3MvU", title: "Requests" },
  { sort: 25, youtube_link: "https://youtu.be/4Di9jP5X7fA", title: "Advanced Body Language Techniques" },
  { sort: 26, youtube_link: "https://youtu.be/sQT1PawbgY8", title: "Dealing with Distractions and Cock Blocks" },
  { sort: 27, youtube_link: "https://youtu.be/GnWWD9gZBbU", title: "Approaching Groups" },
  { sort: 28, youtube_link: "https://youtu.be/Gv-QMiIM_JQ", title: "Winging" },
  { sort: 29, youtube_link: "https://youtu.be/cjcKRgpwF8U", title: "Making Her Work For You" },
  { sort: 30, youtube_link: "https://youtu.be/SRW6V8UD1Yc", title: "Physical Escalations for Building Attraction" },
  { sort: 31, youtube_link: "https://youtu.be/9Vs9rLkyFF8", title: "How to Get Her Phone Number" },
  { sort: 32, youtube_link: "https://youtu.be/NH0KkTBhayg", title: "How to Make a First Phone Call" },
  { sort: 33, youtube_link: "https://youtu.be/dfR0SS9kH1A", title: "Texting Game Masterclass" },
  { sort: 34, youtube_link: "https://youtu.be/NAVbBgiGQcY", title: "First Hang Out Part 1" },
  { sort: 35, youtube_link: "https://youtu.be/ajKOxmyrkeg", title: "First Hang Out Part 2" },
  { sort: 36, youtube_link: "https://youtu.be/UAS6sroym3Q", title: "Building Rapport" },
  { sort: 37, youtube_link: "https://youtu.be/sfd29AMI6nU", title: "First Kiss" },
  { sort: 38, youtube_link: "https://youtu.be/vTWVIjCbvjE", title: "Relationship Dynamic" },
  { sort: 39, youtube_link: "https://youtu.be/SQzf_jm87PE", title: "Internet Gaming" },
  { sort: 40, youtube_link: "https://youtu.be/AF7jrB7GyZs", title: "The tao of Inner Game" },
  { sort: 41, youtube_link: "https://youtu.be/wirBODLYC5w", title: "Defining the Ego" },
  { sort: 42, youtube_link: "https://youtu.be/5gkozVE2Bx4", title: "Dissolving Negativity" },
  { sort: 43, youtube_link: "https://youtu.be/C8lXct-oTjs", title: "Facing the Shadow" },
  { sort: 44, youtube_link: "https://youtu.be/6fed-RhFjXE", title: "Being in the Now" }
]


ActiveRecord::Base.transaction do
  anthology_course = Course.create(title: "Video Anthology", published: true)

  anthology.each do |anthology_course_module|
    CourseModule.create(
      course_id: anthology_course.id,
      youtube_link: anthology_course_module[:youtube_link],
      sort: anthology_course_module[:sort],
      title: anthology_course_module[:title]
    )
  end
end

puts "Seeds run! :+1:"
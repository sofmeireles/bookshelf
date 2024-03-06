# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Book.find_or_create_by(
    title: 'Kubernetes Up & Running',
    description: """
    In just five years, Kubernetes has radically changed the way developers and ops personnel build, deploy, and maintain applications in the cloud.With this book's updated third edition, you'll learn how this popular container orchestrator can help your company achieve new levels of velocity, agility, reliability, and efficiency whether you're new to distributed systems or have been deploying cloud native apps for some time.
    """,
    cover_url: 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ffaghatketab.ir%2Fwp-content%2Fuploads%2F2020%2F01%2FKubernetes-Up-Running-cover-768x971.jpg&f=1&nofb=1&ipt=af1a49617e06b9d284552eb17bc39f10b6ba06e9f717d05f92b577917bc821a3&ipo=images'
  )
  
Book.find_or_create_by(
    title: 'Creating Software with Modern Diagramming Techniques',
    description: """
    Diagrams communicate relationships more directly and clearly than words ever can. Using only text-based markup, create meaningful and attractive diagrams to document your domain, visualize user flows, reveal system architecture at any desired level, or refactor your code. With the tools and techniques this book will give you, you'll create a wide variety of diagrams in minutes, share them with others, and revise and update them immediately on the basis of feedback.
    """,
    cover_url: 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fprodimage.images-bn.com%2Fpimages%2F9781680509830_p0_v5_s600x595.jpg&f=1&nofb=1&ipt=3482b2941a6b48cc56d6bd74867581993749b23c6b16e3589ff616f503b9295a&ipo=images'
)

Book.find_or_create_by(
    title: 'Programming Phoenix Liveview',
    description: """
    The days of the traditional request-response web application are long gone, but you don't have to wade through oceans of JavaScript to build the interactive applications today's users crave. The innovative Phoenix LiveView library empowers you to build applications that are fast and highly interactive, without sacrificing reliability.
    This definitive guide to LiveView isn't a reference manual.
    Learn to think in LiveView. Write your code layer by layer, the way the experts do. Explore techniques with experienced teachers to get the best possible performance.
    """,
    cover_url: 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fforum.devtalk.com%2Fuploads%2Fdefault%2Foptimized%2F1X%2F5f78c0a689145a610e7fa721d077a07c8056237c_2_853x1024.jpeg&f=1&nofb=1&ipt=a35c518b37f863c2321a0acea657a024b7d869b366b60efa0367252cd6f18dd9&ipo=images'
)

Book.find_or_create_by(
    title: 'Programação em Python',
    description: """
    Este é um livro que apresenta os fundamentos da programação em Python, linguagem de programação de alto nível, estruturado em duas partes.
    Numa primeira parte, aprofunda-se a programação procedimental, fazendo-se, numa segunda parte, uma breve introdução à programação orientada aos objetos (POO).
    Assim, o livro apresenta não só uma panorâmica do essencial da programação, como também aprofunda os conceitos básicos da programação e os aspetos complementares, mais avançados, da linguagem Python, discutindo- -se vários aspetos do desenvolvimento de programas.
    """,
    cover_url: 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fstatic.fnac-static.com%2Fmultimedia%2FImages%2FPT%2FNR%2Fd1%2F24%2F0e%2F926929%2F1507-1%2Ftsp20151127200551%2FProgramacao-em-Python.jpg&f=1&nofb=1&ipt=462082fa1538935781316fb2b2a13ba5cc6a89817b8e7185fa62c22db1e31b9f&ipo=images'
)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 产生两个admin 和一个新手用户
create_account = User.create([email: "123@123", password: "123123", password_confirmation: "123123", is_admin: "true", balance: 0, name: "admin"])
puts "Admin account created."

create_account = User.create([email: "liumiao2023@gmail.com", password: "123456", password_confirmation: "123456", is_admin: "true", balance: 0, name: "玛丽"])
puts "Admin account created."

create_xiaobai = User.create(email:"1@1", password: "123123", password_confirmation: "123123", is_admin: "false", name: "新用户")
# 产生30个用户
name = ["刘思宁","杜娟","张冕","刘苗","陈云莉","Sandy", "Cury", "Sherly", "Christina", "Austin", "Ethon", "Frank", "Newton", "Edison", "Eva"]
i = 0
15.times do
  i += 1
  create_replyer = User.create(email: "#{i}@gmail.com", password: "123123", password_confirmation: "123123", is_admin: "false", role: "replyer", description: "学霸#{i} is studing in Havard Business School", gender: "male", school: "Havard", name:"学霸"+name[i-1] , major: "IT")
  create_asker = User.create(email:"#{i}@163.com", password: "123123", password_confirmation: "123123", is_admin: "false", role: "asker", description: "小白#{i} is living in China", gender: "female", school: "清华", name:"小白"+name[i-1], major:"EE")
end

Question.create(title: "在美国谈恋爱，你要怎么过七夕？",
description: "身在美国，谈恋爱会遇到哪些问题？", user_id: 29, downpayment:500, is_hidden:false, status: "closed", tag_list: "美国")
Answer.create(content: "来美国之后认识现在的女票，她23但是还是初恋，特别害羞。所以跟我谈了7个月我也没亲一口，主要是她不让。7个月只有一次不愉快还是关于默克尔收留难民的态度我们产生了分歧。我坚决不支持，她是坚决支持，我跟她说我希望我们可以求同存异，但是她始终要说服我。今年下半年要毕业了，暑假我们在两地实习，一周开一次视频，可是在七夕这天加开的一次，谈论到了好多以后的问题，发现分歧越来越多，我喜欢住郊区安静，她喜欢热闹，我想去东海岸，她希望我去硅谷。等等等等。。以前没有聊过这种有关未来，关于价值观的话题，我们感情也一直不错，可是这次视频之后仿佛我们重新开始认识彼此。她两天没有回我信息了，我也开始重新审视我们的关系。我打算回屯里之后再好好跟她聊一下，毕竟只有一个学期就毕业了。如果这种问题不能达成共识，可能早散对谁都好吧。
被教练Matt Artisan push到处搭讪。。。比较害羞，一下午搭了五六个，收了一个jewish girl的facebook 晚上去夜店，找不认识的妹子玩游戏。。。 虽然没有啪啪啪，也是不错的人生体验。 3天1000刀，个人觉得不算贵，国内浪迹啥的也不止这价。 妹子和有妹子的不要吐槽啊，我觉得工科男比较腼腆，就需要被这种教练训练一下，push你去搭讪，找陌生女孩聊天 ",
user_id: 6, answer_status: "best_answer", question_id: 1, is_hidden: false)
Answer.create(content:"先自我介绍一下，女生，21岁，172cm, 北京人，16岁来美国读高中11年级，两年之后上美国一所不错的公立大学。今年五月份毕业，明年开始在美国读phd（phd是理科的，已有offer，尚未决定去那个学校）.我性格外向，开朗，很喜欢运动。 对男生的标准，175以上，22岁以上，PhD在读或已拿到master，phd学位在美国工作。喜欢运动（篮球，游泳，羽毛球，etc)。在美国哪里都行，最好是北京人(不要喷我，我没有帝都主义，我只是觉得以后照顾父母比较方便）。 就这些啦，请有意者联系，也求广大网友推荐，谢谢啦",
user_id: 10, question_id: 1, answer_status: "unchosen", is_hidden: false)

Question.create([title: "请问美国有哪些特别好的野鸡大学呢？", description: "哪些野鸡大学好申请，但是教学好不错？", user_id: 30, downpayment: 900, is_hidden: false, status: "closed", tag_list: "美国"])
Answer.create([content: "我感觉还是有必要稍微讲下几个重点 以免后人踩坑。 1.2015年UCI的EE转CE需要修两门CE核心课 并且同时达到A-以上才能申请转专业。 所以难度比以往的一门A-更难，并且其中一门神坑computer architecture请千万注意。 如果想要转专业请千万先预习好这些东西。 2.EE还是一如既往分circuit和system方向。 然后circuit以往实习大靠山broadcom 由于收购合并，今年已经听说基本是不招实习生了。所以抱着进博通实习的人需要慎重。以后情况不知道。 3. UCI的EE虽然有VLSI但是非常非常非常的硬，请千万不要以为是USC那种偏数字编程的。基本是 cadence画MOS管的‘硬’。 4. career fair和JOB board上是CS的天下，所以抱着找工作来UCI的EE的童鞋们要受苦了。 5.以上是个人入学半年经历，如有问题和不妥可以指正谢谢。 为后人留点参考。",
  question_id: 2, user_id: 8, is_hidden: false, answer_status: "best_answer"])
Answer.create([content: "首先、确定专业方向。每个国家的大学专业分类并不完全一致，但大体上分为以下几类：文科、商科、理科、工程、建筑、艺术、医学、法学、传媒。对专业选择迷茫是可以由大类到细分，逐步进行精准定位。先确定专业方向，再具体到每一个专业。比如选商科，要先问自己是不是真的喜欢商科，对其有多深的了解，具体课程内容自己是否感兴趣。当然也可以参考自己选择的文理科方向，也需要考虑就读专业将来在社会上的应用，了解课程设置、相关专业。",
  question_id: 2, user_id: 5, is_hidden: false, answer_status: "unchosen"])
Answer.create([content: "US NEWS排名榜作为美国“官方唯一指定排名”，常常被拿来申请者作为选校参考，作为可信度、权威性相当高的美国学校排名，2016年USNEWS全美综合大学排名正式也有很多的改变。",
  question_id: 2, user_id: 9, is_hidden: false, answer_status: "unchosen"])

Question.create(title: "德州米饭大学怎么样？", description: "好不好，差不差，香不香？", user_id: 28, downpayment: 700, is_hidden: false, status: "closed", tag_list: "美国")
Answer.create([content: "我觉得Rice是一个非常注重本科生教育的学校。
而且德州人比较保守，感觉学校里非常安全。Houston除了夏天热，非常适合生活居住。巨大的橡树，可爱的松树，充足的阳光，低廉的物价，各种石油科技公司蓬勃发展。同时我们也有很大的mall各种小牌大牌，不远处有美国最大的outlet。物价很低廉，中国超市有很多家，各种小吃生活用品应有尽有。

学习上，比如碳60的发现人在rice，比如我们有为航天局Nasa工作的教授，同时又有石油公司给的奖学金。因为是很有钱的私立学校，所以对教授坐班答疑有很多要求。小班教学对学生很有帮助，不会一个班上最多100人，一般情况都是40-50人。平时还有TA答疑，我觉得真的是不错的选择。而且rice学费在私立里面算是最低廉的，大家都来报名吧！！

lz感觉国内对Rice的了解不是特别多，所以希望大家可以关注一下我的母校。

补充内容 (2016-8-23 03:34):
关于Houston的交通：Uber和Uber eats，各种搭车APP，叫外面APP都有。而且rice给本科生和研究生都提供周末去超市的校车，非常方便！外带学长学姐都有车呐，不怕哈。没有地铁，但是其他跟纽约芝加哥没区别哈。",
  question_id: 3, user_id: 11, is_hidden: false, answer_status: "best_answer"])
Answer.create([content: "首先、确定专业方向。每个国家的大学专业分类并不完全一致，但大体上分为以下几类：文科、商科、理科、工程、建筑、艺术、医学、法学、传媒。对专业选择迷茫是可以由大类到细分，逐步进行精准定位。先确定专业方向，再具体到每一个专业。比如选商科，要先问自己是不是真的喜欢商科，对其有多深的了解，具体课程内容自己是否感兴趣。当然也可以参考自己选择的文理科方向，也需要考虑就读专业将来在社会上的应用，了解课程设置、相关专业。",
  question_id: 3, user_id: 4, is_hidden: false, answer_status: "unchosen"])
Answer.create([content: "US NEWS排名榜作为美国“官方唯一指定排名”，常常被拿来申请者作为选校参考，作为可信度、权威性相当高的美国学校排名，2016年USNEWS全美综合大学排名正式也有很多的改变。",
  question_id: 3, user_id: 10, is_hidden: false, answer_status: "unchosen"])

Question.create(title: "宾大的MCIT项目如何？", description: "想去宾大，但是不知道去什么项目比较好，也想转CS，所以问问MCIT怎么样", user_id: 32, downpayment: 600, is_hidden: false, status: "closed", tag_list: "美国")
Answer.create(content: "恩，总之在美国也有十几天了，也上了两天课。既然去年申请的时候是在地里知道有这个项目的，那么我也汇报一下，尽量帮一帮后来的申请人吧 我们的Director说MCIT 2016Fall有500+的申请，录取了70+，最后来了能有60左右，听说是多年来人数最多的一次。中国学生有个23成的样子，比我想的少。有小道消息说Director今年刻意压低了中国学生的数量 当然每年的录取情况都不大一样，数据也好八卦也好都没啥指导意义。 这个项目是一个面向非CS背景的人开设的项目，大家的背景五湖四海。我感觉大部分人都是数学&经济出身，也可能使我的英语听力水平只能捕捉到这两个单词也说不定 我记的一月份MCIT放录取的时候，地好多大神贴出自己的NB背景和UPENN的拒信，论坛上下都在讨论MCIT到底收怎样的学生，那叫一个热闹 总之哪怕对CS一无所知也没关系，这个项目就是为这样我们准备的 这个项目有不少外国人是读过其他的硕士学位或者有过几年的工作经验的，再不就是UPENN转专业的。即使是美国人看来也在削尖了脑袋往CS里挤嘛 新生基本上都是忧心忡忡的，不过整个项从上到下都洋溢着相当正能量，上到Director下到刚受过一年教育的MCIT前辈，都在传达出这样一种信息 跟着MCIT的培养方案走，从零开始学CS，找工作好说 作为CIT的新生我当然希望这是真的，不过我感觉其他系的Director应该也会说类似的话吧。。 暂时就这些咯，才来几天，也没有太多干货。尽量更新吧。 祝各位能找到自己理想的项目。",
  question_id: 4, user_id: 7, is_hidden: false, answer_status: "best_answer")
Answer.create(content: "首先、确定专业方向。每个国家的大学专业分类并不完全一致，但大体上分为以下几类：文科、商科、理科、工程、建筑、艺术、医学、法学、传媒。对专业选择迷茫是可以由大类到细分，逐步进行精准定位。先确定专业方向，再具体到每一个专业。比如选商科，要先问自己是不是真的喜欢商科，对其有多深的了解，具体课程内容自己是否感兴趣。当然也可以参考自己选择的文理科方向，也需要考虑就读专业将来在社会上的应用，了解课程设置、相关专业。",
  question_id: 4, user_id: 15, is_hidden: false, answer_status: "unchosen")
Answer.create(content: "US NEWS排名榜作为美国“官方唯一指定排名”，常常被拿来申请者作为选校参考，作为可信度、权威性相当高的美国学校排名，2016年USNEWS全美综合大学排名正式也有很多的改变。",
  question_id: 4, user_id: 13, is_hidden: false, answer_status: "unchosen")


i = 0
15.times do
  i += 1
  Question.create([title: "请问如何申请U#{i.to_words}大学", description: "如何申请，马上就要申请季了，急求", user_id: 18+i, downpayment: 300, is_hidden: false, status: "open", tag_list: "美国"])
  Answer.create([content: "A#{i},首先、确定专业方向。每个国家的大学专业分类并不完全一致，但大体上分为以下几类：文科、商科、理科、工程、建筑、艺术、医学、法学、传媒。对专业选择迷茫是可以由大类到细分，逐步进行精准定位。先确定专业方向，再具体到每一个专业。", question_id: 4+i, user_id: 3+i, is_hidden: false])
  Answer.create([content: "A#{i}比如选商科，要先问自己是不是真的喜欢商科，对其有多深的了解，具体课程内容自己是否感兴趣。当然也可以参考自己选择的文理科方向，也需要考虑就读专业将来在社会上的应用，了解课程设置、相关专业。", question_id: 4+i, user_id: 3+i, is_hidden: false])
  Answer.create([content: "A#{i}US NEWS排名榜作为美国“官方唯一指定排名”，常常被拿来申请者作为选校参考，作为可信度、权威性相当高的美国学校排名，2016年USNEWS全美综合大学排名正式也有很多的改变。", question_id: 4+i, user_id: 3+i, is_hidden: false])
  QuestionInvitation.create(question_id: 1, user_id: i)
  QuestionInvitation.create(question_id: i+4, user_id: i)
  AnswerSubscription.create(answer_id: 1, user_id: i)
  AnswerSubscription.create(answer_id: 1, user_id: i+18)
  AnswerSubscription.create(answer_id: 1+i, user_id: i)
  Blog.create(title:"Blog#{i}，这是我的文章", description:"我喜欢写文章，大家也喜欢看我的文章，我的文章特别好", user_id: i)
  FollowRelationship.create(user_id: 18+i, follower_id: 3+i)
  u = User.find(3+i)
  u.fans_num += 1
  u.save
  FollowRelationship.create(user_id: i+4, follower_id: 4)
  u = User.find(4)
  u.fans_num += 1
  u.save
  LikeAnswer.crearte(answer_id: 1, user_id: i, like_answer: i)
  LikeAnswer.create(answer_id: 11+i, user_id: 18+i, like_answer: i)
  QuestionLike.create(question_id: 1, user_id: i+18)
  QuestionLike.create(question_id:i+4, user_id: i+18)
end

# "title"
# "description"
# "vote"
# "is_hidden"
# "user_id"
# "created_at",  null: false
# "updated_at"

# t.text     "content"
# t.boolean  "is_hidden"
# t.integer  "user_id"
# t.integer  "question_id"
# t.datetime "created_at",  null: false
# t.datetime "updated_at",  null: false

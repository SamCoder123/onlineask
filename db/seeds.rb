# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

create_account = User.create([email: "123@123", password: "123123", password_confirmation: "123123", is_admin: "true", balance: 0, name: "admin"])
puts "Admin account created."

create_account = User.create([email: "liumiao2023@gmail.com", password: "123456", password_confirmation: "123456", is_admin: "true", balance: 0, name: "玛丽"])
puts "Admin account created."

create_replyer = User.create([email: "1@1", password: "123123", password_confirmation: "123123", is_admin: "false", role: "replyer", description: "I am studing in Havard currently", gender: "male", school: "Havard", major: "IT", name: "Havard boy", balance: 0])

create_asker = User.create([email: "2@2", password: "123123", password_confirmation: "123123", is_admin: "false", role: "asker", description: "I want to study in Havard", gender: "female", major: "IT", name: "Shoot", balance: 0])

# "title"
# "description"
# "vote"
# "is_hidden"
# "user_id"
# "created_at",  null: false
# "updated_at"


create_question = Question.create([title: "请问如何申请斯坦福大学呢？", description: "明年9月份想去斯坦福，不知道有没有大神可以给些意见？", user_id: 1, downpayment: 200, is_hidden: false, status: "open",tag_list:'美国'])
create_question = Question.create([title: "想了解一下日本的留学政策？", description: "近年来，又迎来了一股赴日留学的新潮流，留学日本提前了解留学新政策是必须的，这样可以帮助留学生更好的准备留学规划，做好留学准备。", user_id: 1, downpayment: 200, is_hidden: false, status: "open",tag_list:'美国'])
create_question = Question.create([title: "如何申请日本研究生？", description: "很多同学想要赴日本留学读研，但是日本语中国的研究生是不一样的，日本的研究生分为修士研究生和博士研究生两种。", user_id: 1, downpayment: 200, is_hidden: false, status: "open",tag_list:'美国'])

create_question = Question.create([title: "谁呢那个给讲讲美国大学的排名？", description: "作为权威性相当高的美国学校排名，2016年USNEWS全美综合大学排名正式也有很多的改变。综合大学前100中有81所学校出现了排名变化，可谓是最近几年最大变动。", user_id: 2, downpayment: 200, is_hidden: false, status: "open",tag_list:'日本'])
create_question = Question.create([title: "香港留学计算机专业，谁能讲讲？", description: "目前去香港读计算机专业的学生逐年递增，以前因为香港是有名的金融商业中心，给绝大多数的学生留下的印象都是香港的商科很强，计算机和信息技术等理工科专业与商科相差甚远。", user_id: 2, downpayment: 200, is_hidden: false, status: "open",tag_list:'新加坡'])
create_question = Question.create([title: "香港有什么好大学吗？", description: "不知道去香港，还是日本？大家能给些意见吗？", user_id: 2, downpayment: 200, is_hidden: false, status: "open",tag_list:'美国'])

create_question = Question.create([title: "谁呢那个给讲讲美国大学的排名？", description: "作为权威性相当高的美国学校排名，2016年USNEWS全美综合大学排名正式也有很多的改变。综合大学前100中有81所学校出现了排名变化，可谓是最近几年最大变动。", user_id: 3, downpayment: 200, is_hidden: false, status: "open",tag_list:'日本'])
create_question = Question.create([title: "香港留学计算机专业，谁能讲讲？", description: "目前去香港读计算机专业的学生逐年递增，以前因为香港是有名的金融商业中心，给绝大多数的学生留下的印象都是香港的商科很强，计算机和信息技术等理工科专业与商科相差甚远。", user_id: 3, downpayment: 200, is_hidden: false, status: "open",tag_list:'新加坡'])
create_question = Question.create([title: "香港有什么好大学吗？", description: "不知道去香港，还是日本？大家能给些意见吗？", user_id: 3, downpayment: 200, is_hidden: false, status: "open",tag_list:'美国'])

# t.text     "content"
# t.boolean  "is_hidden"
# t.integer  "user_id"
# t.integer  "question_id"
# t.datetime "created_at",  null: false
# t.datetime "updated_at",  null: false

create_answer = Answer.create([content: "首先、确定专业方向。每个国家的大学专业分类并不完全一致，但大体上分为以下几类：文科、商科、理科、工程、建筑、艺术、医学、法学、传媒。在每一个大的分类下又有很多细分的专业，以传媒为例，可以分为新闻学、广告学、公共关系、大众传媒、多媒体、媒体管理、影视类等等，对专业选择迷茫是可以由大类到细分，逐步进行精准定位。先确定专业方向，再具体到每一个专业。", question_id: 1, user_id: 2, is_hidden: false])
create_answer = Answer.create([content: "比如选商科，要先问自己是不是真的喜欢商科，对其有多深的了解，具体课程内容自己是否感兴趣。当然也可以参考自己选择的文理科方向，也需要考虑就读专业将来在社会上的应用，了解课程设置、相关专业。再结合自己的综合成绩(包括英语和数学)考虑申请难度和就读的难易程度再做选择。", question_id: 1, user_id: 3, is_hidden: false])
create_answer = Answer.create([content: "US NEWS排名榜作为美国“官方唯一指定排名”，常常被拿来申请者作为选校参考，作为可信度、权威性相当高的美国学校排名，2016年USNEWS全美综合大学排名正式也有很多的改变。总体来看，综合大学前100中有81所学校出现了排名变化，这可谓是最近几年中最大的一次变动了，其中39所学校降底了名次，而同时42所学校名次有所上升。", question_id: 4, user_id: 3, is_hidden: false])
create_answer = Answer.create([content: "首先、确定专业方向。每个国家的大学专业分类并不完全一致，但大体上分为以下几类：文科、商科、理科、工程、建筑、艺术、医学、法学、传媒。在每一个大的分类下又有很多细分的专业，以传媒为例，可以分为新闻学、广告学、公共关系、大众传媒、多媒体、媒体管理、影视类等等，对专业选择迷茫是可以由大类到细分，逐步进行精准定位。先确定专业方向，再具体到每一个专业。", question_id: 6, user_id: 3, is_hidden: false])
create_answer = Answer.create([content: "首先、确定专业方向。每个国家的大学专业分类并不完全一致，但大体上分为以下几类：文科、商科、理科、工程、建筑、艺术、医学、法学、传媒。在每一个大的分类下又有很多细分的专业，以传媒为例，可以分为新闻学、广告学、公共关系、大众传媒、多媒体、媒体管理、影视类等等，对专业选择迷茫是可以由大类到细分，逐步进行精准定位。先确定专业方向，再具体到每一个专业。", question_id: 6, user_id: 4, is_hidden: false])
create_answer = Answer.create([content: "首先、确定专业方向。每个国家的大学专业分类并不完全一致，但大体上分为以下几类：文科、商科、理科、工程、建筑、艺术、医学、法学、传媒。在每一个大的分类下又有很多细分的专业，以传媒为例，可以分为新闻学、广告学、公共关系、大众传媒、多媒体、媒体管理、影视类等等，对专业选择迷茫是可以由大类到细分，逐步进行精准定位。先确定专业方向，再具体到每一个专业。", question_id: 6, user_id: 2, is_hidden: false])
create_answer = Answer.create([content: "比如选商科，要先问自己是不是真的喜欢商科，对其有多深的了解，具体课程内容自己是否感兴趣。当然也可以参考自己选择的文理科方向，也需要考虑就读专业将来在社会上的应用，了解课程设置、相关专业。再结合自己的综合成绩(包括英语和数学)考虑申请难度和就读的难易程度再做选择。", question_id: 1, user_id: 3, is_hidden: false])
create_answer = Answer.create([content: "US NEWS排名榜作为美国“官方唯一指定排名”，常常被拿来申请者作为选校参考，作为可信度、权威性相当高的美国学校排名，2016年USNEWS全美综合大学排名正式也有很多的改变。总体来看，综合大学前100中有81所学校出现了排名变化，这可谓是最近几年中最大的一次变动了，其中39所学校降底了名次，而同时42所学校名次有所上升。", question_id: 7, user_id: 3, is_hidden: false])
create_answer = Answer.create([content: "首先、确定专业方向。每个国家的大学专业分类并不完全一致，但大体上分为以下几类：文科、商科、理科、工程、建筑、艺术、医学、法学、传媒。在每一个大的分类下又有很多细分的专业，以传媒为例，可以分为新闻学、广告学、公共关系、大众传媒、多媒体、媒体管理、影视类等等，对专业选择迷茫是可以由大类到细分，逐步进行精准定位。先确定专业方向，再具体到每一个专业。", question_id: 7, user_id: 3, is_hidden: false])
create_answer = Answer.create([content: "首先、确定专业方向。每个国家的大学专业分类并不完全一致，但大体上分为以下几类：文科、商科、理科、工程、建筑、艺术、医学、法学、传媒。在每一个大的分类下又有很多细分的专业，以传媒为例，可以分为新闻学、广告学、公共关系、大众传媒、多媒体、媒体管理、影视类等等，对专业选择迷茫是可以由大类到细分，逐步进行精准定位。先确定专业方向，再具体到每一个专业。", question_id: 7, user_id: 4, is_hidden: false])

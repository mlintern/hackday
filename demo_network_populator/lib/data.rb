# encoding: utf-8
# frozen_string_literal: true

def default_data
  {
    all_done: false,
    auth_user: nil,
    business_units: { count: 0, items: [], max: 50 },
    categories: { count: 0, items: [], max: 50 },
    content: { count: 0, items: [], max: 1000 },
    content_types: { count: 0, items: [], max: 5 },
    end_pub_date: nil,
    end_time: nil,
    errors: [],
    languages: { count: 0, items: [], max: 10 },
    network_id: nil,
    projects: { count: 0, items: [], max: 20 },
    pub_date_range: nil,
    publishers: { count: 0, items: [], max: 10 },
    root_user: nil,
    start_pub_date: nil,
    start_time: Time.now,
    template_id: nil,
    users: { count: 0, items: [], max: 100 }
  }
end

def title_wizard(topic)
  titles = [
    "How to Do #{topic} in Just 3 Steps",
    "What You Didn't Learn in College About #{topic}",
    "#{topic}: The Wrong Way and The Right Way",
    "10 Ways to Do #{topic}",
    "Get Rid Of #{topic} Trouble Once and For All",
    "See How Easily You Can Do #{topic}",
    "The Lazy Man's Way to Do #{topic}",
    "Five Common Problems With #{topic}",
    "Little Known Ways to Do #{topic}",
    "10 Sure Fire Ways to Do #{topic}",
    "How to Achieve Amazing #{topic}",
    "What Everybody Ought to Know About #{topic}",
    "Who Else Wants Awesome #{topic}?",
    "Give Me 45 Minutes -- And I'll Show Unbelievable #{topic}",
    "Let Me Tell You How I conquered #{topic}",
    "#{topic} You Can Be Proud Of",
    "#{topic} Looks Hard, But it isn't",
    "#{topic} Build to Last",
    "#{topic}: Quickly and Easily",
    "How #{topic} Will Help You Perform Better",
    "Thousands Now Do #{topic} Who Never Thought They Could",
    "Now, Have The #{topic} Of a Famous Person",
    "The Best #{topic} You've Ever Seen or Your Money Back",
    "If You Don't Try #{topic}, You'll Hate Yourself Later",
    "You Don't Need to Be Rich to Do #{topic}",
    "#{topic} Like A Pro",
    "Do You Make These Horrible #{topic} Mistakes?",
    "Learn How to Be the Best at #{topic}",
    "Master #{topic} In Just 2 Days",
    "9 Surefire Methods to Succeed at #{topic}",
    "21 Secrets to #{topic}",
    "New Concepts in #{topic}",
    "Do You Recognize the 7 Early Warning Signs of #{topic} Failure?",
    "Can You Spot These 5 Common #{topic} Mistakes?",
    "If You Struggle With #{topic}, Then Read This",
    "Three Reasons #{topic} Should Be On Your Radar",
    "Five ways you will benefit from #{topic}",
    "What is #{topic} and why is it important?",
    "What the heck is #{topic} and why would I want it?",
    "A Simple Guide to #{topic}",
    "Eight Quick #{topic} Tips",
    "The Power of #{topic}",
    "3 Reasons I Succeed at #{topic}",
    "#{topic} Like a Boss!"
  ]
  titles[rand(titles.length)]
end

def images
  [
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/Image/ecf7f3ef41bcf4e4764ca8e019a33c90/analytics.jpg',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/Image/95b52d7e0a9f3b4f89c717f87fcbb281/big_lever.jpg',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/Image/2d88c7b5477d5a20d0532504aea0f27e/blog.jpg',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/Image/65ef481e432b0524eb3b949b72fd9669/brand.jpg',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/Image/461681bc622019832d7d4658da4ba94a/bullseye.jpg',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/Image/cb66aacd10df69a93a03a6d505115401/business_to_business.jpg',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/Image/a9ccd4a231748c06d83e47274253d904/charts_3.jpg',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/Image/b41f62229c12462e87cdd6eccaf144a8/charts_5.jpg',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/Image/e09ca768ea63b8a5e180b390881cf496/chat_bubbles.jpg',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/Image/c884fec0b33888edba0ed2afbc2d6a27/content.jpg'
  ]
end

def videos
  [
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/kO7RDEnCAgk" frameborder="0" allowfullscreen></iframe>',
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/mjZFGugwkyc?list=PLo0PbWmWAecGwwFZQC8s-7Pzxd01l1p1Z" frameborder="0" allowfullscreen></iframe>',
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/dFOyVFimkXw?list=PL7NYXEutUrvKfTOMPRQPcQNwwTPiSa0yX" frameborder="0" allowfullscreen></iframe>',
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/TUEvClDvaTo?list=PL7NYXEutUrvKfTOMPRQPcQNwwTPiSa0yX" frameborder="0" allowfullscreen></iframe>',
    '<iframe width="560" height="315" src="https://www.youtube.com/embed/bb9Xr7DAw6s?list=PL7NYXEutUrvKjQ7KMJZeg_orEoH9tA9-u" frameborder="0" allowfullscreen></iframe>'
  ]
end

def paragraphs
  [
    "Promote content across your social scenes. You can also promote content to any social channel including Facebook, Twitter, and LinkedIn through our social relationship management platform or built-in social publishing feature. Not only can content be promoted to any channel, but it can also be easily scheduled so your created content is not forgotten. At any given time, you can quickly find content you'd like to distribute and promote to relevant channels again. With advanced scheduling options, you can choose social messages to be promoted in the future—thus keeping a consistent flow of content.",
    "The right content across multiple personas and channels. Organizations must create the right content for the right person at the right time delivered through the right channel. Oracle Content Marketing makes it easy for everyone in your organization—and even your customers-to create and distribute compelling content across multiple channels to the people you want to reach. Now you can plan, produce, and deliver engaging content across multiple personas and channels throughout the customer lifecycle. Content marketing is driving how marketing organizations engage their audiences. But in our consumer-empowered world, it's become more difficult for marketers to cut through clutter.",
    "Manage content across calenders, personas, and stages. Content isn't always viewed as a strategic asset inside most marketing shops. Some marketers scramble to create content with the spray-and-pray approach for one campaign at a time, versus having an overall strategy that includes repurposing and not wasting content. Without a tool, you end up with a bunch of point solutions and not one central view of content. You get overlapping workflows and a hodgepodge of tools that are fragmented and often redundant. Get a single view. With the Oracle Content Marketing platform, content planning is put into one intuitive calendar-based tool.",
    'Create specifc workflows for your processes. Creating workflows for content asset creation, review, and distribution is crucial to ensure that efforts are not being duplicated, enough content is being produced and content is not being wasted. Oracle Content Marketing has built-in workflow capability offerings like no other content marketing platform. You are able to create specific workflows for each process. For example, there can be a separate workflow for Legal Approval Content Templates, Corporate Blog Post Workflows, and Social Promotion Workflows among many more.',
    "Personalized Content At Scale. Few marketers have content tools integrated into their marketing process resulting in overlapping workflows and redundant content production. With Oracle's Content Marketing Platform, it is possible to effectively manage the large volume of content necessary to provide 1:1 customer messaging. Each workflow can include various steps in the process including creation, approval, and promotion while also associating each individual step with a task that will map to one or more people. Email notifications and in-app indicators help to keep teams aligned and working efficiently.",
    'See how your content machine is running. Oracle Content Marketing has built-in content marketing metrics. These analytics are essential in your overall content marketing strategy and compliment your general analytics packages. The main features of these analytics help the marketer understand how content is performing and how to speed up content production. They provide insight into who the key content contributors are within an organization and where there may be bottlenecks in the content workflow.',
    "Metrics To Measure Strategy, Production, And Workflow. Metrics are the currency of the new economy and without them your efforts are hard to defend. Prove your content's success with reporting and tracking features to show ROI. Visualize progress on dashboards. The main dashboard gives the marketer a quick look at content production and workflow while also providing traffic and conversion statistics. Marketers are also able to drill down and analyze on personalized content delivery.",
    "Despite all the hype about 1:1 customer relationships, marketing teams struggle to deliver on the promise. The main challenge: Static email segments and journey builders don't adapt fast enough to keep pace with real customers and the unpredictable ways in which they move about the world. According to research from eConsultancy, only 12% of marketers believe their marketing is real-time enough to drive adequate business results.",
    "Oracle's Push Cloud Service extends cross-channel marketing strategies to the world of apps. Delivered standalone or integrated as part of Oracle Cross-Channel Marketing, Oracle Push Cloud Service helps the world's best marketers deliver relevant push notifications that stimulate engagement and drive users back to their applications. Deliver push notifications across devices to enhance your customer experience.",
    "Part of Oracle's Cross-Channel Marketing solution, Oracle Responsys, Mobile SMS enables marketers to create rich SMS campaigns and orchestrate them as part of a larger cross-channel marketing program, helping drive new revenue, improve loyalty, and build stronger customer relationships. Mobile marketing engages customers and prospects when they're online away from the traditional home/office desktop environment. You've put together a successful content marketing program. Now you need to show that. Metrics are the currency of the new economy and without them your efforts are hard to defend."
  ]
end

def files
  [
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/File/c8b98f7b07935d9331de9025031b611e/content_marketing_essentials_gd_oracle.pdf',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/File/82a0a5919878f63fa16449e96d816c88/cvent_customer_success_oracle.pdf',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/File/84f0eb49592673a3a6fe1a15c029b7b0/forrester_why_modern_marketer_us_emea_wp_oracle.pdf',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/File/196a5b5be196c063564fc733af903aac/look_book_2015_gd_oracle.pdf',
    '//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/File/b3505dd693ee0fbac7460c7307a1d0fd/readytalk_customer_success_oracle.pdf'
  ]
end

def categories
  [
    '24/7', '24/365', 'accelerated', 'accurate', 'adaptive', 'alternative', 'an expanded array of', 'B2B', 'B2C', 'backend', 'backward-compatible', 'best-of-breed', 'bleeding-edge', 'bricks-and-clicks', 'business', 'clicks-and-mortar', 'client-based', 'client-centered', 'client-centric', 'client-focused', 'collaborative', 'compelling', 'competitive', 'cooperative', 'corporate', 'cost effective', 'covalent', 'cross functional', 'cross-media', 'cross-platform', 'cross-unit', 'customer directed', 'customized', 'cutting-edge', 'distinctive', 'distributed', 'diverse', 'dynamic', 'e-business', 'economically sound', 'effective', 'efficient', 'emerging', 'empowered', 'enabled', 'end-to-end', 'enterprise', 'enterprise-wide', 'equity invested', 'error-free', 'ethical', 'excellent', 'exceptional', 'extensible', 'extensive', 'flexible', 'focused', 'frictionless', 'front-end', 'fully researched', 'fully tested', 'functional', 'functionalized', 'future-proof', 'global', 'go forward', 'goal-oriented', 'granular', 'high standards in', 'high-payoff', 'high-quality', 'highly efficient', 'holistic', 'impactful', 'inexpensive', 'innovative', 'installed base', 'integrated', 'interactive', 'interdependent', 'intermandated', 'interoperable', 'intuitive', 'just in time', 'leading-edge', 'leveraged', 'long-term high-impact', 'low-risk high-yield', 'magnetic', 'maintainable', 'market positioning', 'market-driven', 'mission-critical', 'multidisciplinary', 'multifunctional', 'multimedia based', 'next-generation', 'one-to-one', 'open-source', 'optimal', 'orthogonal', 'out-of-the-box', 'pandemic', 'parallel', 'performance based', 'plug-and-play', 'premier', 'premium', 'principle-centered', 'proactive', 'process-centric', 'professional', 'progressive', 'prospective', 'quality', 'real-time', 'reliable', 'resource sucking', 'resource maximizing', 'resource-leveling', 'revolutionary', 'robust', 'scalable', 'seamless', 'stand-alone', 'standardized', 'standards compliant', 'state of the art', 'sticky', 'strategic', 'superior', 'sustainable', 'synergistic', 'tactical', 'team building', 'team driven', 'technically sound', 'timely', 'top-line', 'transparent', 'turnkey', 'ubiquitous', 'unique', 'user-centric', 'user friendly', 'value-added', 'vertical', 'viral', 'virtual', 'visionary', 'web-enabled', 'wireless', 'world-class', 'worldwide', 'action items', 'alignments', 'applications', 'architectures', 'bandwidth', 'benefits', 'best practices', 'blamestorming', 'catalysts for change', 'channels', 'collaboration and idea-sharing', 'communities', 'content', 'convergence', 'core', 'competencies', 'creative', 'customer service', 'data deliverables', 'e-business', 'e-commerce', 'e-markets', 'e-tailers', 'e-services', 'experiences', 'expertise', 'functionalities', 'growth', 'strategies', 'human', 'capital', 'ideas', 'imperatives', 'infomediaries', 'information', 'infrastructures', 'initiatives', 'innovation', 'intellectual', 'capital interfaces', 'internal or organic sources', 'leadership', 'leadership skills', 'manufactured products', 'markets', 'materials', 'meta-services', 'methodologies', 'methods of empowerment', 'metrics', 'mindshare models', 'networks', 'niches', 'niche markets', 'offline opportunities', 'outsidethebox thinking', 'outsourcing', 'paradigms', 'partnerships', 'platforms', 'portals', 'potentialities', 'process', 'improvements', 'processes', 'products', 'quality', 'vectors', 'relationships', 'resources', 'results', 'ROI', 'scenarios', 'schemas', 'services', 'solutions', 'sources', 'strategic theme', 'areas', 'supply chains', 'synergy', 'systems', 'technologies', 'technology testing procedures', 'linkage', 'upshot', 'users value', 'vortals', 'web-readiness', 'web services', 'win-win'
  ]
end

def languages
  [
    { name: 'English', code: 'EN' },
    { name: 'Spanish', code: 'ES' },
    { name: 'French', code: 'FR' },
    { name: 'German', code: 'DE' },
    { name: 'Greek', code: 'EL' },
    { name: 'Russian', code: 'RU' },
    { name: 'Portuguese', code: 'PT' },
    { name: 'Arabic', code: 'AR' },
    { name: 'Swedish', code: 'SV' },
    { name: 'Dutch', code: 'NL' },
    { name: 'Italian', code: 'IT' },
    { name: 'Japanese', code: 'JA' },
    { name: 'Tamil', code: 'TA' },
    { name: 'Latin', code: 'LA' }
  ]
end

def all_categories
  '{% for Category in Categories %}
  {% if Category.PostCount > 0 %}
      <li><a href="{{ Category.Url }}" name="{{ Category.Name }}">{{ Category.Name }} [{{Category.PostCount}}]</a></li>
  {% endif %}
{% endfor %}'
end

def last_couple
  '<h5>Recent Posts:</h5>
  {% for Post in Posts %}
  <div class="panel panel-danger">
      <div class="panel-heading">
          <h5>{{Post.PostTitle}}</h5>
      </div>
      <div class="panel-body">
          <p>{{Post.PostBody|striptags|truncate(100)|raw}}</p>
          <a href="{{ Post.PostUrl }}">Read More &rarr;</a>
      </div>
  </div>
  {% endfor %}

  {# <div>{{ Vars.ExtraText }}</div> #}'
end

def default_template
  '<!DOCTYPE html>
<html lang="en">
<head>
  <title>{{PageTitle}}</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="google-site-verification" content="XXXXXXXXX">
  <link rel="alternate" type="application/rss+xml" title="{{ BlogTitle }}" href="{{ RssFeedUrl }}">
  {% if MetaDescription %}<meta name="description" content="{{ MetaDescription|raw }}">{% endif %}
  {% if Posts|length == 0 %}<meta name="robots" content="noindex"/>{% endif %}
  <meta name="host_name" content="{{ HostName|raw }}">
  <meta name="title" content="{{ PageTitle|raw }}">
  <meta name="page_type" content="{{ PageType|raw }}">
  <meta name="page_content_count" content="{{ Posts|length }}">
  <meta name="long_page_type" content="{{ LongPageType|raw }}">
  <meta name="c_blog_type" content="{{ BlogType|raw }}">
  <meta name="blog_name" content="{{ BlogTitle|raw }}">
  {% if PageType == "item" %}
  <meta name="author" content="{{ Posts[0].Author.AuthorName|raw }}">
  <meta name="publish_date" content="{{ Posts[0].PostDate|raw }}">
  <meta property="og:type" content="article">
  <meta property="og:title" content="{{ PageTitle|raw }}">
  <meta property="og:image" content="{% if "http" in FeaturedImageUrl %}{{ FeaturedImageUrl|raw }}{%else%}http:{{ FeaturedImageUrl|raw }}{%endif%}">
  <meta property="og:url" content="{{ Posts[0].PostUrl|raw }}">
  <meta name="category" content="{% for Category in Posts[0].CategoryBlogs %}{{Category.Name}} {% endfor %}">
  {%elseif PageType == "list" %}
  <meta name="category" content="{{ BlogTitle|raw }}">
  {%else%}{% endif %}
  <meta name="cpdm_tracker" content="UA-2883046-6">
  <meta name="network_tracker" content="">
  <meta name="extra_trackers" content="">
  <meta name="target_hostname" content="">
  <link rel="shortcut icon" href="//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/File/6c316e2867852537fe8f8e33eb6224c7/fav_oracle.ico">

  <!-- Latest compiled and minified CSS -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <!-- Optional theme -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
  <!-- FontAwesome -->
  <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

  <!-- Custom styles for this template -->
  <style>
      .main-container {margin-top: 80px;}
      ul {list-style:none;padding:0;}

      /* Colors */
      a { color: #ff0000; }
      a:hover, a:focus { color: #8b0000; text-decoration:none; }
      .side-nav li a:not(.button) { color: #ff0000; padding: 0.2188rem 0.4375rem; }
      .side-nav li a:not(.button):hover, .side-nav li a:not(.button):focus { color: #8b0000; }
      img { max-width: 100%; height: auto; }

      /* Nav */
      .nav-menu li a{ padding: 1rem; }
      .navbar-brand {font-size: 15px; line-height: 14px; font-weight: bold; padding: 5px 0 5px 141px; margin-top: 15px; background: url("//cdn.app.compendium.com/uploads/user/12a67f85-8b31-465a-93a1-99f578338c75/7b68ecaf-94ec-4ea6-b549-2a99e9c6123f/Image/a6184697feb472396f8837c15256adb8/oracle_logo_sm.png") no-repeat top left; float: left; height: auto;}

      @media only screen and (max-width: 40em) {
          .menu-toggle { clear both; }
          .nav-menu{ display: none; position: absolute; z-index: 1000; width: 100% }
          .nav-menu li { margin: 0; display: block; }
          .nav-menu li a{ margin: 0; display: block; }
      } /* max-width 640px, mobile-only styles, use when QAing mobile issues */

      /* Sidebar */

      .side-nav li { margin: 0; }

      /* Comment */
      .comment-submit { margin-top: 1rem; }

      @media only screen and (min-width: 40.063em) {
          .comment-submit { margin-top:8rem; }
      } /* min-width 641px, medium screens */

      /* RESPONSE MESSAGES */
      .response { border: 1px solid #005725; background-color: #d6f7e4; color: #005725; font-weight: bold; margin: 1em auto; padding: 12px; font-size: 14px; text-align: center; border-radius: 5px; margin-top: 40px; }
      .response.Error { border: 1px solid #700000; color: #700000; background-color: #f7dcdc; }

      /* FOOTER */
      .inline-list li {display:inline-block;padding:0 5px;}
  </style>

</head>

<body>

  {% if Response %}
      <div class="row response {{Response.Status}}">{{Response.Message }}</div>
  {% endif %}

  <!-- Nav Bar -->
  <div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="/"><i class="icon-home icon-white"></i> Network Populator</a>
          </div>
          <div class="collapse navbar-collapse navbar-ex1-collapse">
              <ul class="nav navbar-nav">

              </ul>
              <ul class="nav navbar-nav navbar-right">
                  <li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-link"></i></span></a>
                      <ul class="dropdown-menu" role="menu">
                          <li><a href="/">Home</a></li>
                          <li class="divider"></li>
                          <li><a href="https://app.compendium.com" target="_blank">Compendium</a></li>
                          <li class="divider"></li>
                          <li><a href="http://www.oracle.com" target="_blank">Oracle</a></li>
                      </ul>
                  </li>
              </ul>
          </div>
      </div>
  </div>
  <!-- End Nav -->

  <!-- Main Page Content and Sidebar -->
  <div class="container main-container">
      <div class="row">
          <!-- Main Blog Content -->
          <div class="col-sm-9" role="content">

              {% for Post in Posts %}

              <article>

                  <h3><a href="{{Post.PostUrl}}">{{ Post.PostTitle }}</a></h3>
                  <h6>Written by <a href="{{Post.Author.Url}}">{{Post.Author.Name}}</a> on {{Post.PostDate | date("F j, Y")}}.</h6>

                  <div class="post-content">
                      {% if Post.ContentType == "image" %}
                          <img src="{{Post.ContentAttachmentUrl}}" />
                          {{Post.PostBody|raw}}
                      {% elseif Post.ContentType == "video" %}
                          {{Post.ContentAttachmentUrl|raw }}
                          {{Post.PostBody|raw}}
                      {% elseif Post.ContentType == "file" %}
                          <a href="{{Post.ContentAttachmentUrl}}"> Download Me </a>
                          {{Post.PostBody|raw}}
                      {% else %}
                          {% if PageType == "list" %}
                              {{Post.PostBody|truncate(500)|raw}}
                          {% else %}
                              {{Post.PostBody|raw}}
                          {% endif %}
                      {% endif %}
                  </div>

              </article>
              <hr />

              {% endfor %}

              <div class="row"style="margin-top: 1rem;">
                  <div class="col-sm-12">
                      {% if PreviousPostUrl %}<a class="button alert right" href="{{PreviousPostUrl}}">Older &rarr;</a>{% endif %}
                      {% if NextPostUrl %}<a class="button alert" href="{{NextPostUrl}}">&larr; Newer</a>{% endif %}
                      {% if PreviousPage %}<a class="button alert" href="{{PreviousPage}}">&larr; Newer</a>{% endif %}
                      {% if NextPage %}<a class="button alert right" href="{{NextPage}}">Older &rarr;</a>{% endif %}
                  </div>
              </div>

             {% if LongPageType == "Item Page" %}
              {# Compendium Comments #}
              <div class="comments">
                  <h3>Comments for <span><a href="{{Post.PostUrl}}">{{Posts[0].PostTitle|raw}}</a></span></h3>
                      <dl class="comment-list">
                          {% for Comment in Posts[0].Comments %}
                              <dd>
                                  <div class="panel panel-danger" data-alert>
                                      <div class="panel-heading">
                                          <h4>{{ Comment.Author }}</h4>
                                          <h5>{{ Comment.Timestamp }}</h5>
                                      </div>
                                      <div class="panel-body">
                                          <p>{{ Comment.Body |raw }}</p>
                                      </div>
                                  </div>
                              </dd>
                          {% endfor %}
                      </dl>

                  <form class="comment-form" class="rounded" method="post" action="post.comment">
                      <input type="hidden" value="{{ Posts[0].PostId }}" name="post_id">
                      <input type="hidden" value="{{ BlogId }}" name="blog_id">
                      <h3>Leave a comment</h3>
                      <div class="row">
                          <div class="col-sm-6">
                              <div class="form-group">
                                  <input class="form-control" type="text" name="commentAuthorName" value="" placeholder="Name"/>
                              </div>
                          </div>
                          <div class="col-sm-6">
                              <div class="form-group">
                                  <input class="form-control" type="email" value="" name="commentAuthorEmail" placeholder="Email Address"/>
                              </div>
                          </div>
                      </div>
                      <div class="form-group">
                          <textarea class="form-control" rows="4" cols="60" name="commentText" placeholder="Your comment (No HTML)"></textarea>
                      </div>
                      <div class="row">
                          <div class="col-sm-6">
                              <div class="form-group">
                                  <input type="text" size="10" class="spam-prevent form-control" name="spamPrevent" placeholder="Type the text from the image below"/>
                              </div>
                              <div class="form-group">
                                  <img id="captcha" width="200" height="80" src="captcha.php?phrase=spamPrevent" alt="Captcha" style="border: solid 1px #444;"/>
                              </div>
                          </div>
                          <div class="col-sm-6">
                              <input class="btn btn-danger btn-lg pull-right comment-submit" name="submitComment" type="submit" value="Submit"/>
                          </div>
                      </div>
                  </form>
              </div> {##}
              {% endif %}

          </div>
          <!-- End Main Content -->

          <!-- Sidebar -->
          <aside class="col-sm-3">
              <h5>Categories:</h5>
              <ul class="side-nav">
                  {% AllCategoriesWidget "Categories" %}
              </ul>

              {% PostListWidget "Last Couple" { "Vars":{ "ExtraText":"Text From Variable" } } %}
          </aside>
          <!-- End Sidebar -->
      </div>
  </div>
  <!-- End Main Content and Sidebar -->

  <!-- Footer -->
  <div class="container">
      <footer>
          <hr />
          <div class="row">
              <div class="col-sm-4">
                  <p>&copy; Copyright Oracle Network Populator</p>
              </div>
              <div class="col-sm-8">
                  <ul class="inline-list text-right">
                      <li><a href="/">Home</a></li>
                      <li><a href="https://app.compendium.com" target="_blank">Compendium</a></li>
                      <li><a href="http://www.oracle.com" target="_blank">Oracle</a></li>
                  </ul>
              </div>
          </div>
      </footer>
  </div>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
  <script src="http://app.compendium.com/js/stats.js"></script>
  <!-- Latest compiled and minified Bootstrap JavaScript -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

</body>
</html>'
end

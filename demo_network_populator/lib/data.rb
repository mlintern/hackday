def default_data
  return {
    :auth_user => nil,
    :business_units => { :count => 0, :items => [], :max => 5 },
    :categories => { :count => 0, :items => [], :max => 20 },
    :content => { :count => 0, :items => [], :max => 100 },
    :content_types => { :count => 0, :items => [], :max => 5 },
    :languages => { :count => 0, :items => [], :max => 10 },
    :network_id => nil,
    :projects => { :count => 0, :items => [], :max => 10 },
    :publishers => { :count => 0, :items => [], :max => 10 },
    :users => { :count => 0, :items => [], :max => 15 }
  }
end

def images
  return [
    "path to image",
    "path to image"
  ]
end

def languages
  return [
    { :name => "English", :code => "EN"},
    { :name => "Spanish", :code => "ES"},
    { :name => "French", :code => "FR"},
    { :name => "German", :code => "DE"},
    { :name => "Greek", :code => "EL"},
    { :name => "Tamil", :code => "TA"},
    { :name => "Russian", :code => "RU"},
    { :name => "Portuguese", :code => "PT"},
    { :name => "Arabic", :code => "AR"},
    { :name => "Swedish", :code => "SV"},
    { :name => "Dutch", :code => "NL"},
    { :name => "Italian", :code => "IT"},
    { :name => "Japanese", :code => "JA"}
  ]
end

def all_categories
    return '{% for Category in Categories %}
    {% if Category.PostCount > 0 %}
        <li><a href="{{ Category.Url }}" name="{{ Category.Name }}">{{ Category.Name }} [{{Category.PostCount}}]</a></li>
    {% endif %}
{% endfor %}'
end

def last_couple
    return '<h5>Recent Posts:</h5>
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
    return '<!DOCTYPE html>
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
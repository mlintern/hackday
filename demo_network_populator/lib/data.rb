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
    reutrn '{% for Category in Categories %}
    {% if Category.PostCount > 0 %}
        <li><a href="{{ Category.Url }}" name="{{ Category.Name }}">{{ Category.Name }} [{{Category.PostCount}}]</a></li>
    {% endif %}
{% endfor %}'
end

def last_couple
    reutrn '<h5>Recent Posts:</h5>
{% for Post in Posts %}
<div class="alert-panel alert" data-alert>
    <div class="alert-panel-title">
        <h5>{{Post.PostTitle}}</h5>
    </div>
    <div class="alert-panel-message">
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
    <link rel="shortcut icon" href="http://placehold.it/20/ff0000/ffffff&text=Red">
    
    <!-- Foundation core CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/foundation/5.5.1/css/normalize.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/foundation/5.5.1/css/foundation.min.css" rel="stylesheet">
    
    <!-- FontAwesome -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

    <!-- Custom styles for this template -->
    <style>
        /* Colors */
        a { color: #ff0000; }
        a:hover, a:focus { color: #8b0000; }
        .side-nav li a:not(.button) { color: #ff0000; padding: 0.2188rem 0.4375rem; }
        .side-nav li a:not(.button):hover, .side-nav li a:not(.button):focus { color: #8b0000; }
        img { max-width: 100%; height: auto; }

        /* Nav */
        .nav-menu li a{ padding: 1rem; }

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
            .comment-submit { position: absolute; bottom: 0; right: 1rem; }   
        } /* min-width 641px, medium screens */
        
        
        /* Alert panel container */
        .alert-panel { margin-bottom: 1.5em; line-height: 1.3em; }
        .alert-panel p, .alert-panel a, .alert-panel h1, .alert-panel h2, .alert-panel h3, .alert-panel h4, .alert-panel h5, .alert-panel h6 { margin-bottom: 0; margin-top: 0; }
        .alert-panel .button.secondary { background: #fff; }
        
        /* Alert panel title */
        .alert-panel-title { background-color: #2ba6cb;border: solid 1px #2284a1; -moz-border-radius-topleft: 3px;-webkit-border-top-left-radius: 3px; border-top-left-radius: 3px; -moz-border-radius-topright: 3px; -webkit-border-top-right-radius: 3px; border-top-right-radius: 3px; font-size: 1.5em; color: #0c2e38; font-weight: bold; line-height: 1.3em; position: relative; padding: 10px 34px 10px 10px; display: block; }
        .alert-panel.alert .alert-panel-title { background-color: #c60f13; border: solid 1px #970b0e; }
        .alert-panel.alert .alert-panel-title h3,.alert-panel.alert .alert-panel-title h4, .alert-panel.alert .alert-panel-title h5{ color: #fff; }
        
        /* Alert panel message area */
        .alert-panel-message { background: white; border-left: solid 1px #2ba6cb; border-right: solid 1px #2ba6cb; border-bottom: solid 1px #2ba6cb; padding: 20px; line-height: 1.3; border-radius: 0 0 3px 3px; }
        .alert-panel.alert .alert-panel-message { border-left: solid 1px #c60f13; border-right: solid 1px #c60f13; border-bottom: solid 1px #c60f13; }
        button.pink, .button.pink { background-color: #FFC0CB; border-color: #ff69b4; color: #fff; }
        button.pink:hover, button.pink:focus, .button.pink:hover, .button.pink:focus { background-color: #ff69b4; }
        button.silver, .button.silver { background-color: #cccccc; border-color: #bbbbbb; }
        button.silver:hover, button.silver:focus, .button.silver:hover, .button.silver:focus { background-color: #aaaaaa; }
        
        /* RESPONSE MESSAGES */
        .response { border: 1px solid #005725; background-color: #d6f7e4; color: #005725; font-weight: bold; margin: 1em auto; padding: 12px; font-size: 14px; text-align: center; border-radius: 5px; }
        .response.Error { border: 1px solid #700000; color: #700000; background-color: #f7dcdc; }
    </style>

  </head>

  <body>
  
    {% if Response %}
        <div class="row response {{Response.Status}}">{{Response.Message }}</div>
    {% endif %}

    <!-- Nav Bar -->
    <div class="row">
        <div class="large-12 columns">
        <div class="nav-bar right">
        <div class="show-for-small-only"><a class="menu-toggle" href="javascript:void(0)" onclick="$(".nav-menu").toggle();"><i class="fa fa-2x fa-bars"></i></a></div>
        <ul class="button-group nav-menu">
            <li><a target="_blank" href="#" class="button alert"><i class="fa fa-link"></i>&nbsp;link</a></li>
            <li><a target="_blank" href="#" class="button alert"><i class="fa fa-link"></i>&nbsp;link</a></li>
            <li><a target="_blank" href="#" class="button alert"><i class="fa fa-link"></i>&nbsp;link</a></li>
            <li><a target="_blank" href="#" class="button alert"><i class="fa fa-link"></i>&nbsp;link</a></li>
            <li><a target="_blank" href="#" class="button alert"><i class="fa fa-link"></i>&nbsp;link</a></li>
        </ul>
        </div>
        <div class="show-for-small-only clearfix"></div>
        <h1><a href="{{BaseUrl}}">Hello World</a> <small>Let me tell you</small></h1>
        <hr />
        </div>
    </div>
    <!-- End Nav -->
     
    <!-- Main Page Content and Sidebar -->
    <div class="row">
        <!-- Main Blog Content -->
        <div class="large-9 columns" role="content">
            
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
                <div class="columns small-12">
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
                                <div class="alert-panel alert" data-alert>
                                    <div class="alert-panel-title">
                                        <h4>{{ Comment.Author }}</h4>
                                        <h5>{{ Comment.Timestamp }}</h5>
                                    </div>
                                    <div class="alert-panel-message">
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
                        <div class="medium-6 columns">
                            <input type="text" name="commentAuthorName" value="" placeholder="Name"/>
                        </div>
                        <div class="medium-6 columns">
                            <input type="email" value="" name="commentAuthorEmail" placeholder="Email Address"/>
                        </div>
                    </div>
                    <div>
                        <textarea class="form-control" rows="4" cols="60" name="commentText" placeholder="Your comment (No HTML)"></textarea>
                    </div>
                    <div class="row" data-equalizer>
                        <div class="medium-6 columns" data-equalizer-watch>
                            <div class="form-group">
                                <input type="text" size="10" class="spam-prevent form-control" name="spamPrevent" placeholder="Type the text from the image below"/>
                            </div>
                            <div class="form-group">
                                <img id="captcha" width="200" height="80" src="captcha.php?phrase=spamPrevent" alt="Captcha" style="border: solid 1px #444;"/>
                            </div>
                        </div>
                        <div class="columns medium-6" data-equalizer-watch>
                            <input class="button comment-submit alert" name="submitComment" type="submit" value="Submit"/>
                        </div>
                    </div>
                </form>
            </div> {##}
            {% endif %}
          
        </div>
        <!-- End Main Content -->
     
        <!-- Sidebar -->
        <aside class="large-3 columns">
          <h5>Categories:</h5>
          <ul class="side-nav">
            {% AllCategoriesWidget "Categories" %}
          </ul>
          
          {% PostListWidget "Last Couple" { "Vars":{ "ExtraText":"Text From Variable" } } %}
        </aside>
        <!-- End Sidebar -->
    </div>
    <!-- End Main Content and Sidebar -->
     
      <!-- Footer -->
    <footer class="row">
        <div class="large-12 columns">
            <hr />
            <div class="row">
                <div class="large-4 columns">
                    <p>&copy; Copyright Hello World.</p>
                </div>
                <div class="large-8 columns">
                    <ul class="inline-list right">
                        <li><a target="_blank" href="#">link</a></li>
                        <li><a target="_blank" href="#">link</a></li>
                        <li><a target="_blank" href="#">link</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>    

    <!-- Foundation core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="http://app.compendium.com/js/stats.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/foundation/5.5.1/js/foundation.min.js"></script>
    <script type="text/javascript">
        $(document).foundation();
    </script>
  </body>
</html>'
end
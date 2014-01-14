<%@tag description="layout" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
  	<head>
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta name="description" content="">
	    <meta name="author" content="">
		<title>School Management System</title>
		<!-- Fragments --> 
		<%@attribute name="css" fragment="true" %>
		<%@attribute name="script" fragment="true" %>
		
		<jsp:invoke fragment="css" />
		<jsp:invoke fragment="script" />
	</head>
	<body>
		<nav class="navbar navbar-fixed-top navbar-inverse" role="navigation">
			      <div class="container">
			        <div class="navbar-header">
			          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
			            <span class="sr-only">Toggle navigation</span>
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			          </button>
			          <a class="navbar-brand" href="index.html">School Management System</a>
			        </div>
			
			        <!-- Collect the nav links, forms, and other content for toggling -->
			        <div class="collapse navbar-collapse navbar-ex1-collapse">
			          <ul class="nav navbar-nav">
			            <li><a href="#about">Schools</a></li>
			            <li><a href="#services">Teachers</a></li>
			            <li><a href="#contact">Students</a></li>
			          </ul>
			        </div><!-- /.navbar-collapse -->
			      </div><!-- /.container -->
			    </nav>
			    
			    <div id="myCarousel" class="carousel slide">
			      <!-- Indicators -->
			        <ol class="carousel-indicators">
			          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			          <li data-target="#myCarousel" data-slide-to="1"></li>
			          <li data-target="#myCarousel" data-slide-to="2"></li>
			        </ol>
			
			        <!-- Wrapper for slides -->
			        <div class="carousel-inner">
			          <div class="item active">
			            <div class="fill"><img src="<c:url value='/assets/images/slider.jpg'/>" /></div>
			            <div class="carousel-caption">
			              <h1>A comprehensive school management system</h1>
			            </div>
			          </div>
			          <div class="item">
			            <div class="fill"><img src="<c:url value='/assets/images/slider2.jpg'/>" /></div>
			            <div class="carousel-caption">
			              <h1>Rebranding the educational sector</h1>
			            </div>
			          </div>
			          <div class="item">
			            <div class="fill"><img src="<c:url value='/assets/images/slider3.jpg'/>" /></div>
			            <div class="carousel-caption">
			              <h1>Full Database integration</h1>
			            </div>
			          </div>
			        </div>

			        <!-- Controls -->
			        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
			          <span class="icon-prev"></span>
			        </a>
			        <a class="right carousel-control" href="#myCarousel" data-slide="next">
			          <span class="icon-next"></span>
			        </a>
			    </div>

               <div class="container">
					<div class="row section">
        				<div class="col-lg-12">
          					<jsp:doBody/>
        				</div>
      				</div>
      				<hr>
      <footer>
        <div class="row">
          <div class="col-lg-12">
            <p>Copyright &copy; Foresythe 2013 &middot; Facebook &middot; Twitter &middot; Google+</p>
          </div>
        </div>
      </footer>

    </div>
    <!-- /.container -->
   </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	
	
	<link rel="stylesheet" href="css/screen.css">
	
	<script src="script/jquery.js"></script>
	<script src="script/jquery.validate.js"></script>
	<script src="script/localization/messages_tr.js"></script>
	
	
	
	<script>

	
	
	$.validator.setDefaults({
		submitHandler: function() {
			alert("submitted!");
		}
	});

	$().ready(function() {
		// validate the comment form when it is submitted
		$("#commentForm").validate();

	}
		
	
	
	</script>
	<style>
	#commentForm {
		width: 500px;
	}
	#commentForm label {
		width: 250px;
	} 
	#commentForm label.error, #commentForm input.submit {
		margin-left: 253px;
	}
	#signupForm {
		width: 670px;
	}
	#signupForm label.error {
		margin-left: 10px;
		width: auto;
		display: inline;
	}
	#newsletter_topics label.error {
		display: none;
		margin-left: 103px;
	}
	</style>
</head>
</head>
<body>


<h1 id="banner"><a href="http://jqueryvalidation.org/">jQuery Validation Plugin</a> Demo</h1>
<div id="main">
	<p>Default submitHandler is set to display an alert into of submitting the form</p>
	<form class="cmxform" id="commentForm" method="get" action="">
		<fieldset>
			<legend>Please provide your name, email address (won't be published) and a comment</legend>
			<p>
				<label for="cname">Name (required, at least 2 characters)</label>
				<input id="cname" name="name" minlength="2" type="text" required>
			</p>
			<p>
				<label for="cemail">E-Mail (required)</label>
				<input id="cemail" type="email" name="email" required>
			</p>
			<p>
				<label for="curl">URL (optional)</label>
				<input id="curl" type="url" name="url">
			</p>
			<p>
				<label for="ccomment">Your comment (required)</label>
				<textarea id="ccomment" name="comment" required></textarea>
			</p>
			<p>
				<input class="submit" type="submit" value="Submit">
			</p>
		</fieldset>
	</form>
	
</body>
</html>
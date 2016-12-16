// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require bootstrap-sprockets
//= require fancybox
//= require ahoy
//= require chosen/chosen.jquery.js
//= require_tree .

function get_amazon_details() {
	var url = $("#product_url").val();
	var split_url;
	var product_id;

	if(url){

		if(url.indexOf("product") > -1 ){
  		split_url = url.split("product/");
  		product_id = split_url[1];
		}

		else if (url.indexOf("dp") > -1){
			split_url = url.split("dp/");
			product_id = split_url[1];
		}

		else {
			console.log("URL is invalid");
		}

	$.ajax({
		url: "/products/populate",
		type: 'POST',
		dataType: 'xml',
		data: {'product_id' : product_id },
		success: function (response){
			put_amazon_details(response);
		},
	}).done(function() {
		console.log("success");
	}).fail(function() {
		console.log("error");
	}).always(function() {
		console.log("complete");
	});
}

	else{
		console.log("Error: You need to supply a valid URL");
	}
}

	function go(key){
		img = key.src;
		$("#product_image").val(img);
		$("#image_field").html("<img src='"+img+"' />");
	}

	function put_amazon_details(response){
		console.log(response);
		var item_price;
	 	var vendor =  response.getElementsByTagName("Brand")[0].childNodes[0].nodeValue;
	 	var name =  response.getElementsByTagName("Title")[0].childNodes[0].nodeValue;
	 	var imgGallery = response.getElementsByTagName("ImageSets")[0].childNodes;
	 	var offers_as_s = response.getElementsByTagName("TotalOffers")[0].childNodes[0].nodeValue;
 		var offers = parseInt(offers_as_s);

	 	if (offers >= 1){
	 	var first_offer = response.getElementsByTagName("OfferListing")[0];
	 	var prime = first_offer.getElementsByTagName("IsEligibleForPrime")[0].childNodes[0].nodeValue;
	 	item_price = first_offer.getElementsByTagName("Price")[0].getElementsByTagName("Amount")[0].childNodes[0].nodeValue;
	 	console.log(item_price);
	 	console.log(prime);
	 	}

	 	else {
	 	item_price = response.getElementsByTagName("Amount")[0].childNodes[0].nodeValue;

	 	}


	 	for (var i = 0; i < imgGallery.length; i++) {
	 		if (i===0){
	 			active_status = 'active';
	 		}
	 		else{
	 			active_status = '';
	 		}

	 		var img_url = imgGallery[i].getElementsByTagName("LargeImage")[0].childNodes[0].textContent;
	 		var plain_text = '<div class="item '+active_status+'"><img onclick="go(this);" alt="image" class="img-responsive" src="'+img_url+'"></div>';
 			$('#carousel-drop').append(plain_text);
	 	}

	 	item_price = parseInt(item_price)/100;

	  $("#product_name").val(name);
	  $("#product_price").val(item_price);
	  $("#product_vendor").val(vendor);
	  $("#product_prime").val(prime);

	}

	function like_product(product_id, user_id){

		var el = "#card-" + product_id;
		var like_status = $(el).attr('data-like');

		if (user_id == false){
			$.fancybox({
    		href : '/users/sign_in',
    		type : 'ajax',
  		});
		}

		else{

		if(like_status == "false"){
			$.ajax({
				url: "/likes",
				type: 'POST',
				dataType: 'html',
				data: {'like': {'product_id' : product_id, 'user_id' : user_id} },
				success: function (response){
					console.log(response);
					$(el).addClass("is-liked");

					//Find ID in response
					var like_id_object =  $($.parseHTML(response)).filter("#like-id"); 
					var like_id = like_id_object[0].innerHTML;
					console.log(like_id); // div#like_id
					$(el).attr("data-like",like_id);
				},
			}).done(function() {
			}).fail(function() {
				console.log("error");
			}).always(function() {
				console.log("complete");
			});
		}

		else {
			$.ajax({
				url: "/likes/"+like_status,
				type: 'DELETE',
				dataType: 'html',
				data: {'like': {'product_id' : product_id, 'user_id' : user_id} },
				success: function (response){
					$(el).removeClass("is-liked");
					$(el).attr("data-like","false");
				},
			}).done(function() {
			}).fail(function() {
				console.log("error");
			}).always(function() {
				console.log("complete");
			});
		}
	}
	}

	function scout(){
		$('.cardlike[data-like!="false"]').addClass("is-liked");
	}
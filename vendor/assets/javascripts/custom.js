/*
//Se ejecuta solo al terminar de cargar la pagina

$(document).ready(function(){
	var x = $(".navbar"); 
	//lo oculto con visibility hidden y opacity 0 porque el display hidden no voy a poder meterle la transicion. Se ve feo sin la transicion
	$(x).css({"visibility":"hidden","opacity": "0"});

	$(window).scroll(function(){
		var actualPosition = $(window).scrollTop();
		if (actualPosition>=50){
			$(x).css({"visibility":"visible","opacity": "1", "transition":"all 400ms ease"});
		}	
		else{
			$(x).css({"visibility":"hidden","opacity": "0", "transition":"all 400ms ease" });
		}
	});
});

*/
/*
function myMap() {
    var mapOptions = {
        center: new google.maps.LatLng(33.036612, -96.704803),
        zoom: 9,
        mapTypeId: google.maps.MapTypeId.HYBRID
    }
var map = new google.maps.Map(document.getElementById("map"), mapOptions);
}*/

$(document).ready(function(){

    //ScrollProcessor.process

	$('.owl-carousel').owlCarousel({
    loop:true,
    margin:5,
    nav:true,
    responsive:{
        0:{
            items:1
        },
        600:{
            items:3
        },
        1000:{
            items:5
        }
    }
    })
});



// @ScrollProcessor =
//   process: ->
//     return unless Modernizr.localstorage
//     @restore() if location.hash == '#scroll'
//     $(window).on 'scroll', => @onscroll()

//   onscroll: (event) ->
//     localStorage.setItem @key, $(window).scrollTop()

//   restore: ->
//     $(window).scrollTop localStorage.getItem(@key)

//   key: "scroll#{location.pathname}"


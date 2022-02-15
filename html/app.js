window.addEventListener("message", function(event) {
    var v = event.data  
    
    switch (v.action) {
        case 'showCarHud': 
            $('.carhud h1').text(Math.round(v.speed))
            $('.progressbarvel').css({'width': `${v.speed}%`})
            $('.progressfuel').css({'width': `${v.fuel}%`})
            $('.compass h1').text(v.streetName)
            $('.container').show()
            if (v.sirena == true) {
                $('.colortext').css({'animation': 'changecolor 1s step-end infinite'})
            } else if(v.sirena == false) {
                $('.colortext').css({'animation': 'none'})
            }

            // Limit

            if (v.limitador == true) {
                $('#maxspeed').fadeIn(500)
            } else if(v.limitador == false) {
                $('#maxspeed').fadeOut(500)
            }

            // seat belt 

            if (v.cinturon == true) {
                $('.container img').css('animation', 'none')
                $('.container img').hide()
            } else if(v.cinturon == false) {
                $('.container img').show()
                $('.container img').css('opacity', '0.5')
                $('.container img').css('animation', 'parpadea 2s infinite')
            }

        break;

        case 'hideCarHud':
            $('.container').hide()
        break;
    }        
});  

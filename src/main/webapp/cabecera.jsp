	<meta charset="UTF-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
	<meta name="description" content=""></meta>
	<meta name="viewport" content="width=device-width"></meta>
	<link rel="icon" type="img/x-icon" href="favicon.ico"></meta>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"></link>
	<script src="js/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script
		src="js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
	     </script>
	<script>
		function cambioTema(){
		    if (document.documentElement.getAttribute('data-bs-theme') == 'dark') {
		        document.documentElement.setAttribute('data-bs-theme','light');
		    }
		    else {
		        document.documentElement.setAttribute('data-bs-theme','dark');
		    }
		    
			$.ajax({
				url: 'HolaDiplo?bstheme=' + document.documentElement.getAttribute('data-bs-theme'),
        		type: "GET",
        		success: function (data) {
        			console.log(data);
        		}
	    });
		    
		}
	</script>
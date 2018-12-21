var pos = {
    lat: -34.397,
    lng: 150.644
};


$(document).ready(function(){
    $('#filter_date_start').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
    });
    $('#filter_date_end').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
    });
});


function initMapNewScream() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: pos,
        zoom: 16,
        zoomControl: false,
        mapTypeControl: false,
        scaleControl: false,
        streetViewControl: false,
        rotateControl: false,
        fullscreenControl: false
    });

    updateLocation();
   
    marker = new google.maps.Marker({
        position: pos,
        map: map,
        title: 'Your position',
        animation: google.maps.Animation.DROP,
    });
}

function initMapShowScream()
{
    map = new google.maps.Map(document.getElementById('map'), {
        center: pos,
        zoom: 16,
        zoomControl: true,
        mapTypeControl: true,
        scaleControl: true,
        streetViewControl: true,
        rotateControl: true,
        fullscreenControl: true
    });

    $.get(Routes.scream_path(screamId, {format: 'json'}), function(scream) {
        pos = {lat: scream.latitude, lng: scream.longitude}
        marker = new google.maps.Marker({
            position: pos,
            map: map,
            animation: google.maps.Animation.DROP,
            icon: getMarkerIconUrl(scream.status),
        });
        map.setCenter(pos);
    });
}

function getMarkerIconUrl(status)
{
    var icon = "";
    switch(status) {
        case 1:
            icon = "http://maps.google.com/mapfiles/ms/icons/red-dot.png";
            break;
        case 2:
            icon = "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png";
            break;
        default:
            icon = "http://maps.google.com/mapfiles/ms/icons/green-dot.png";
            break;
    }
    return icon;
}

function initMapShowScreams()
{
    map = new google.maps.Map(document.getElementById('map'), {
        center: pos,
        zoom: 10,
        zoomControl: true,
        mapTypeControl: true,
        scaleControl: true,
        streetViewControl: true,
        rotateControl: true,
        fullscreenControl: true
    });


    $.get(Routes.screams_path({format: 'json'}), function(data) {
        if (data.length == 0) {
            map.setCenter(pos);
            return;
        }
        $.each(data, function(i, scream) {
            pos = {lat: scream.latitude, lng: scream.longitude}
            new google.maps.Marker({
                position: pos,
                map: map,
                title: scream.description,
                animation: google.maps.Animation.DROP,
                icon: getMarkerIconUrl(scream.status),
            }).addListener('click', function() {
                var description = '<h5>' + scream.address + '</h5>' + 
                                    scream.description + 
                                    '<br><br>' +
                                    '<a class="btn btn-sm btn-secondary" href="' + Routes.scream_path(scream.id) + '">Show details</a>';
                new google.maps.InfoWindow({
                  content:  description,
                }).open(map, this);
            });

            if (i == 0) {
                map.setCenter(pos);
            }
        });
    });
}


function updateForm(pos)
{
    $('input[name="scream[longitude]"]').val(pos.lng);
    $('input[name="scream[latitude]"]').val(pos.lat);
    getReverseGeocodingData(pos);
}

function getReverseGeocodingData(pos) {
    var latlng = new google.maps.LatLng(pos.lat, pos.lng);    
    var geocoder = new google.maps.Geocoder();
    var result;

    geocoder.geocode({ 'latLng': latlng }, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            result = results[0].formatted_address;
        } else {
            result = "Can't find any address";
        }
        $('input[name="scream[address]"]').val(result);
    });
}

function updateLocation()
{
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };
            
            updateForm(pos);
            map.setCenter(pos);
            marker.setPosition(pos);

        }, function(error) {
            // handle error
            switch(error.code) {
                case error.PERMISSION_DENIED:
                    showError("User denied the request for Geolocation. Form submit will fail!");
                    break;
                case error.POSITION_UNAVAILABLE:
                    showError("Location information is unavailable. Form submit will fail!");
                    break;
                case error.TIMEOUT:
                    showError("The request to get user location timed out. Form submit will fail!");
                    break;
                case error.UNKNOWN_ERROR:
                    showError("An unknown error occurred. Form submit will fail!");
                    break;
            }
        }, { enableHighAccuracy:true });
    } else {
        // Browser doesn't support Geolocation
        showError("Browser doesn't support Geolocation. Form submit will fail!");
    }
}

function showError(message) {
    $('#errorMessage').text(message);
    $('#locationAlertModal').modal('show');
}

$('updateLocationButton').click(function () {
    updateLocation();
});
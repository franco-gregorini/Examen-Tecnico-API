Feature: Escenarios de Pruebas API Booking - GetBooking

    @Api_Test
    Scenario: Obtener informacion de una reserva HP status 200 flujo correcto
        * def bookingId = 7
        Given url "https://restful-booker.herokuapp.com"
        And header Accept = "application/json"
        And path "booking", bookingId
        When method GET
        Then status 200
        And match response.firstname == '#string'
        And match response.lastname == '#string'
        And match response.totalprice == '#number'
        And match response.depositpaid == '#boolean'
        And match response.bookingdates.checkin == '#regex ^\\d{4}-\\d{2}-\\d{2}$'
        And match response.bookingdates.checkout == '#regex ^\\d{4}-\\d{2}-\\d{2}$'
        And print 'Response:', response


    @Api_Test
    Scenario: Validacion de informacion de una reserva UNHP status 404 Url Incorrecta
        * def bookingId = 8
        Given url "https://restful-booker.herokuapp.com"
        And path "book", bookingId
        And header Accept = "application/json"
        When method GET
        Then status 404
        And match response == '#notnull'
        And print 'Response:', response


    @Api_Test
    Scenario: Validacion de informacion de una reserva UNHP status 418 - I'm a Teapot
        * def bookingId = 9
        Given url "https://restful-booker.herokuapp.com"
        And path "booking", bookingId
        When method GET
        Then status 418
        And match response == '#notnull'
        And print 'Response:', response


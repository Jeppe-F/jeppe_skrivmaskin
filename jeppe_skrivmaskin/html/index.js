$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://jeppe_skrivmaskin/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://jeppe_skrivmaskin/exit', JSON.stringify({}));
        return
    })
    $("#submit").click(function () {
        let inputValue = $("#input").val()
        if (inputValue.length >= 100) {
            $.post("http://jeppe_skrivmaskin/error", JSON.stringify({
                error: "Du kan inte skriva in mer än 100 bokstäver"
            }))
            return
        } else if (!inputValue) {
            $.post("http://jeppe_skrivmaskin/error", JSON.stringify({
                error: "Du skrev inte in något värde"
            }))
            return
        }
        $.post('http://jeppe_skrivmaskin/main', JSON.stringify({
            text: inputValue,
        }));
        return;
    })
})
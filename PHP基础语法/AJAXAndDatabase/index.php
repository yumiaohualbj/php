<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
        <script src="./selectuser.js">
        </script>
    </head>
    <body>
        <form>
            Select a User:
            <select name="users" onchange="showUser(this.value)">
                <option value="1">Peter Griffin</option>
                <option value="2">Lois Griffin</option>
                <option value="3">Glenn Quagmire</option>
                <option value="4">Joseph Swanson</option>
            </select>
        </form>
        <p> 
        <div id="txthint"><b>User info will be listed here.</b> </div>
        </p>
    </body>
</html>

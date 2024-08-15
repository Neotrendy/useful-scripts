<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>htaccess and htpasswd generator</title>
</head>
<body>
<h1>htaccess and htpasswd generator</h1>

<h2>1. Enter credentials</h2>
<form method="post">
    <p>
        <label>
            Username:
            <input type="text" name="username" value="<?php if (isset($_POST['username'])) {echo $_POST['username'];} ?>">
        </label>
    </p>
    <p>
        <label>
            Password:
            <input type="text" name="password" value="<?php if (isset($_POST['password'])) {echo $_POST['password'];} ?>">
        </label>
    </p>
    <p>
        <input type="submit">
    </p>
</form>

<?php if (isset($_POST['username']) && isset($_POST['password'])) : ?>
<h2>2. Create <code style="background-color: aliceblue">.htaccess</code> file</h2>
<code>
<pre style="background-color: aliceblue">
AuthName Login
AuthUserFile <?= __DIR__; ?>/.htpasswd
AuthType Basic
Require valid-user
</pre>
</code>

<h2>3a. Create <code style="background-color: aliceblue">.htpasswd</code> file by SSH command <code> htpasswd</code></h2>
<code>
<pre style="background-color: aliceblue">
cd <?= __DIR__ . PHP_EOL; ?>
htpasswd -cb <?= __DIR__; ?>/.htpasswd <?= $_POST['username'] ?> "<?= $_POST['password'] ?>"
</pre>
</code>

<h2>3b. Create <code style="background-color: aliceblue">.htpasswd</code> file by PHP function <code>crypt()</code> - not recommended</h2>
<code>
<pre style="background-color: aliceblue">
<?= $_POST['username'] ?>:<?= crypt($_POST['password'], base64_encode(random_bytes(10))); ?>
</pre>
</code>
<?php endif; ?>

</body>
</html>
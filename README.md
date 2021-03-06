# Email

[![license](https://img.shields.io/github/license/vphantom/php-email.svg?style=plastic)]() [![GitHub release](https://img.shields.io/github/release/vphantom/php-email.svg?style=plastic)]() [![Build Status](https://travis-ci.org/vphantom/php-email.svg?branch=v1.0.2)](https://travis-ci.org/vphantom/php-email) [![Coverage Status](https://coveralls.io/repos/github/vphantom/php-email/badge.svg?branch=v1.0.2)](https://coveralls.io/github/vphantom/php-email?branch=v1.0.2)

Create/send multipart MIME messages

Facilitates the creation of MIME compatible messages. It has useful features like easy creation of alternative bodies (i.e. plain+html) and multiple file attachments. It is _not_ a complete implementation, but it is very small which suits my needs.


## Installation

```sh
$ composer require vphantom/email
```


## Usage

Basically, you instantiate the `Email` class, set a few headers, add some content parts (at least one) and either build to a string using `$msg->build()` or send by piping through `sendmail` with `$msg->send()`.


<!-- BEGIN DOC-COMMENT H2 Email.php -->
## `class Email`

Create/send multipart MIME messages. 

Example: 

    require_once 'email.php';
    mb_internal_encoding('UTF-8');
    $msg = new Email();
    $msg->charset = 'UTF-8';
    $msg->to = "Someone <foo@example.com>";
    $msg->from = "Myself <bar@example.com>";
    $msg->subject = "Friendly reminder service";
    $msg->addText("Hello Someone,\n\nThis is your friendly reminder.\n");
    $msg->addFile('image/png', '/tmp/test-file.png', 'reminder.png');
    $msg->send();



### `public function __set($name, $value)`

Property overloading. 

To define any header, set a property of the same name.  If the header name contains dashes, use underscores instead and they will be converted to dashes.  For example: 

    $msg = new Email();
    $msg->X_Mailer_Info = "My Custom Mailer v0.15";



**Parameters:**

* `$name` — string — Name which will have underscores changed to dashes
* `$value` — string — Contents of the header

**Returns:** null

### `public function __construct()`

Constructor 


**Returns:** `object` — Email instance

### `public function addData($type, $displayname, $data)`

Add a raw data part to message. 

Netiquette: you should add text and HTML parts before any binary file attachments. 


**Parameters:**

* `$type` — string — MIME type of the attachment (i.e. "text/plain")
* `$displayname` — string — File name to suggest to user
* `$data` — mixed — Actual raw data to attach

**Returns:** null

### `public function addFile($filepath, $displayname, $mimetype = null)`

Attach a file part to message. 

Netiquette: you should add binary files after inline text and HTML parts. 

Note that the MIME type is automatically detected from the file itself if not specified. 


**Parameters:**

* `$filepath` — string — Path on local file system
* `$displayname` — string — File name to suggest to user
* `$mimetype` — string|null — (Optional) MIME Type

**Returns:** null

### `public function addText($text)`

Attach plain text part to message. 


**Parameters:**

* `$text` — string — Content to attach

**Returns:** null

### `public function addHTML($html)`

Attach HTML part to message. 


**Parameters:**

* `$html` — string — Content to attach

**Returns:** null

### `public function addTextHTML($text, $html)`

Attach a pair of text and HTML equivalents to message. 

This implements the "multipart/alternative" type so viewers can expect the text and HTML to represent the same content. 


**Parameters:**

* `$text` — string — The plain text content
* `$html` — string — The HTML equivalent content

**Returns:** null

### `public function build($skipTS = false)`

Build message to a string. 

**Caveat:** If you intend to use PHP's `mail()`, you will need to split headers from the body yourself since PHP needs headers separately, and use the `$skipTS` argument to extract "To" and "Subject" from the headers.  Something like this: 

    $parts = preg_split('/\r?\n\r?\n/', $msg->build(true), 2);
    mail($msg->getTo(), $msg->getSubject(), $parts[1], $parts[0]);



**Parameters:**

* `$skipTS` — bool — Skip "To" and "Subject" headers.

**Returns:** `string` — The entire message ready to send (i.e. via `sendmail`)

### `public function send()`

Build and immediately send message. 

Note that you can modify some headers and call `build()` or `send()` again on the current message.  This can be handy for mailing lists where only the destination changes (and where using the "Bcc" field isn't appropriate, that is.) 

Internally, this uses PHP's `popen()` to invoke your PHP configuration's "sendmail_path" directly. This avoids the extra overhead and formatting limitations of PHP's built-in `mail()`. 


**Returns:** `mixed` — False if the pipe couldn't be opened, the termination status of the sendmail process otherwise.

<!-- END DOC-COMMENT -->


## MIT License

Copyright (c) 2008-2017 Stéphane Lavergne https://github.com/vphantom

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

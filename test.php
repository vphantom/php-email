<?php
use PHPUnit\Framework\TestCase;

require_once 'vendor/autoload.php';
require_once 'Email.php';

class EmailTest extends TestCase
{
    public function testUndressEmail()
    {
        $this->assertEquals(
            1,
            '1',
            'Integer and string one are the same'
        );
    }
}

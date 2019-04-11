jQuery(function () {
    function addslashes(str) {

        return ( str + '' )
            .replace(/[\\"']/g, '\\$&')
            .replace(/\u0000/g, '\\0')
    }

    function gohead() {
        var $data = jQuery('body form :input').serializeJSON();
        var $headers = {};

        for ( var $k in $data.headers ) {
            if ( $data.headers[$k] !== '' ) {
                $headers[$k] = $data.headers[$k];
            }
        }

        var $output = 'workflow "Deploy" {';
        $output = $output + '\n   resolves = ["' + $data.workflow_name + '"]';
        $output = $output + '\n   on = "' + $data.workflow_on + '"';
        $output = $output + '\n }';
        $output = $output + '\n';
        $output = $output + 'action "' + $data.workflow_name + '" {';
        $output = $output + '\n   uses = "varunsridharan/wordpress-pot-generator@master"';

        $output = $output + '\n   env = {';
        $output = $output + '\n      SAVE_PATH = "' + $data.SAVE_PATH + '" ';
        $output = $output + '\n      ITEM_SLUG = "' + $data.ITEM_SLUG + '" ';
        $output = $output + '\n      DOMAIN = "' + $data.DOMAIN + '" ';
        $output = $output + '\n      PACKAGE_NAME = "' + $data.PACKAGE_NAME + '" ';
        $output = $output + '\n      HEADERS = "' + addslashes(JSON.stringify($headers)) + '" ';
        $output = $output + '\n   }';

        $output = $output + '\n   secrets = ["GITHUB_TOKEN"]';
        $output = $output + '\n}';
        jQuery('body pre').html($output);
    }

    jQuery('body form :input').on('change, blur', function () {
        gohead();
    }).keypress(function () {
        gohead();
    }).keyup(function () {
        gohead();
    }).keydown(function () {
        gohead();
    })
});
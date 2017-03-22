# Curl

With fields:

    curl --data "param1=value1&param2=value2" http://example.com/resource.cgi

Multipart:

    curl --form "fileupload=@filename.txt" http://example.com/resource.cgi

Without data:

    curl --data '' http://example.com/resource.cgi
    curl -X POST http://example.com/resource.cgi
    curl --request POST http://example.com/resource.cgi

For more information see the cURL manual. The cURL tutorial on emulating a web
browser is helpful. With libcurl, use the curl_formadd() function to build your
form before submitting it in the usual way. See the libcurl documentation for
more information.

For large files, consider adding parameters to show upload progress:

    curl --tr-encoding -X POST -v -# -o output -T filename.dat \
    http://example.com/resource.cgi

The -o output is required, otherwise no progress bar will appear.

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <curl/curl.h>

int
main(int argc, char *argv[])
{
	if (argc != 2)
		return 1;

	char *url = curl_easy_escape(NULL, argv[1], strlen(argv[1]));
	if (!url)
		return 1;

	puts(url);

	free(url);
	return 0;
}

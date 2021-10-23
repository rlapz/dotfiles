/* moewallpaper - Feh wallpaper slideshow
 *
 * MIT License
 * rLapz 2021
 *
 * -----------------------------------------------
 * How to compile:
 *   cc -Wall -Wextra moewallpaper.c -o moewallpaper -Os
 *
 * Don't forget to install Feh
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <sys/stat.h>


/* macros */
#define FEH "/usr/bin/feh"
#define FEH_ARGS "--randomize --bg-fill"
#define MAX_DIR_LEN 255
#define SIZE_CMD ((sizeof(FEH) + sizeof(FEH_ARGS)) + MAX_DIR_LEN +1)

#define HELP(X)\
	fprintf(X, "moewallpaper - Feh wallpaper slideshow\n\n"  \
		"Usage: %s [-d/-h] [DELAY] [DIR]\n"              \
		"       -d     delay (greater than 4 seconds)\n" \
		"       -h     Show this help\n\n"               \
		"Example: %s -d 30 ~/Pictures/Wallpapers/\n",    \
		arg0, arg0);


/* global vars */
static const char *arg0;


int
main(int argc, char *argv[])
{
	unsigned int delay = 0;
	struct stat s_file;
	char cmd[SIZE_CMD]; /* this is not VLA */
	const char *dir;
	arg0 = argv[0];

	/* argument parser */
	if (argc == 2 && (strcmp(argv[1], "-h") == 0)) {
		HELP(stdout);
		return EXIT_SUCCESS;
	}

	if (argc != 4 || (strcmp(argv[1], "-d") != 0)) {
		HELP(stderr);
		return EXIT_FAILURE;
	}

	delay = (unsigned int)strtol(argv[2], NULL, 10);
	if (errno != 0)
		return EXIT_FAILURE;

	if (delay < 5) {
		HELP(stderr);

		return EXIT_FAILURE;
	}


	dir = argv[3];

	if (strlen(dir) >= MAX_DIR_LEN) {
		fprintf(stderr,
			"Directory/path too long! Max Length: %d\n",
			MAX_DIR_LEN
		);

		return EXIT_FAILURE;
	}

	/* check directory exist or not */
	if (stat(dir, &s_file) != 0) {
		perror(dir);
		return EXIT_FAILURE;
	}

	/* check if the last argument is directory or not */
	if (S_ISREG(s_file.st_mode)) {
		fprintf(stderr, "\"%s\" is not a directory\n", dir);
		return EXIT_FAILURE;
	}

	if (snprintf(cmd, SIZE_CMD, "%s %s %s", FEH, FEH_ARGS, dir) < 0)
		return EXIT_FAILURE;

	printf("Wallpaper dir\t: %s\n"
		"CMD\t\t: %s\n"
		"Delay\t\t: %d seconds\n",
		dir, cmd, delay
	);

	/* feh */
	while (1) {
		if (system(cmd) != 0) {
			perror(NULL);

			return EXIT_FAILURE;
		}
		sleep(delay);
	}

	return EXIT_SUCCESS;
}

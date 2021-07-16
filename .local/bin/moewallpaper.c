/* moewallpaper - Feh wallpaper slideshow
 *
 * MIT License
 * rLapz 2021
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


/* global vars */
static const char *arg0;


void
help(FILE *f)
{
	fprintf(f, "moewallpaper - Feh wallpaper slide show\n\n"
		"Usage: %s [-d/-h] [DELAY] [DIR]\n"
		"       -d     delay\n"
		"       -h     Show this help\n\n"
		"Example: %s -d 30 ~/Pictures/Wallpapers/\n",
		arg0, arg0);
}


int
main(int argc, char **argv)
{
	unsigned int delay = 0;
	struct stat s_file;
	char cmd[SIZE_CMD]; /* this is not VLA */
	const char *dir;
	arg0 = argv[0];

	/* argument parser */
	if (argc == 2 && (strcmp(argv[1], "-h") == 0)) {
		help(stdout);
		return EXIT_SUCCESS;
	} else if (argc == 4 && (strcmp(argv[1], "-d") == 0) && 
			((delay = (unsigned int)atoi(argv[2])) > 0)) {
		/* okay, let's go! */
		goto okay;
	} else {
		errno = EINVAL;
		perror(NULL);
		help(stderr);
		return EXIT_FAILURE;
	}

okay:
	dir = argv[3];

	if (strlen(dir) >= MAX_DIR_LEN) {
		errno = EINVAL; /* I'm not sure if this is right */
		fprintf(stderr, "%s - Directory/path too long! Max Length: %d\n",
				strerror(errno), MAX_DIR_LEN);

		return EXIT_FAILURE;
	}

	/* check directory exist or not */
	if (stat(dir, &s_file) != 0) {
		perror(dir);
		return EXIT_FAILURE;
	}

	/* check if the last argument is directory or not */
	if (S_ISREG(s_file.st_mode)) {
		errno = ENOTDIR;
		perror(dir);
		return EXIT_FAILURE;
	}

	int ret	= snprintf(cmd, SIZE_CMD, "%s %s %s", FEH, FEH_ARGS, dir);
	if (ret < 0)
		/* UNREACHABLE */
		return EXIT_FAILURE;

	printf("Wallpaper dir\t: %s\nCMD\t\t: %s\n", dir, cmd);

	/* feh */
	while (1) {
		if (system(cmd) != 0)
			/* UNREACHABLE */
			break;
		sleep(delay);
	}

	return EXIT_FAILURE;
}

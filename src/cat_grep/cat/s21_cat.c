#include "s21_cat.h"

int main(int argc, char **argv) {
  int error;

  s21_flags_t flag = {
      .b = 0,
      .e = 0,
      .n = 0,
      .s = 0,
      .t = 0,
      .v = 0,
  };

  error = parsing_stdin(argc, argv, &flag);

  if (error != 1) {
    if (flag.b) flag.n = 0;

    while (optind < argc) {
      if ((error = read_file(argv, &flag)) == 2)
        printf("%s: %s: %s\n", argv[0], argv[optind], strerror(error));
      optind++;
    }
  }
  return error;
}

int read_file(char **argv, s21_flags_t *flag) {
  int error = 0;
  FILE *file = fopen(argv[optind], "r");

  if (file != NULL) {
    int emp_str_cnt = 0;
    int str_cnt = 1;
    int next_sym = '\n';

    while (true) {
      int current_sym = fgetc(file);

      if (current_sym == EOF) break;

      if (flag->s && current_sym == '\n' && next_sym == '\n') {
        emp_str_cnt++;
        if (emp_str_cnt > 1) continue;
      } else {
        emp_str_cnt = 0;
      }

      if (next_sym == '\n' && ((flag->b && current_sym != '\n') || flag->n)) {
        printf("%6d\t", str_cnt++);
      }

      if (flag->e && current_sym == '\n') printf("$");
      if (flag->t && current_sym == '\t') {
        printf("^");
        current_sym = 'I';
      }

      if (flag->v) {
        if ((current_sym >= 0 && current_sym < 9) ||
            (current_sym > 10 && current_sym < 32)) {
          printf("^");
          current_sym += 64;
        }
        if (current_sym >= 128 && current_sym < 256) {
          printf("M-");
          current_sym -= 64;
        }
        if (current_sym == 127) {
          printf("^");
          current_sym = '?';
        }
      }

      printf("%c", current_sym);
      next_sym = current_sym;
    }
    fclose(file);
  } else {
    error = 2;
  }
  return error;
}

int parsing_stdin(int argc, char **argv, s21_flags_t *flag) {
  const char *short_option = "bvEnsTet";
  int opt;
  int error = 0;
  int option_index = 0;

  const struct option long_option[] = {
      {"number-nonblank", no_argument, NULL, 'b'},
      {"number", no_argument, NULL, 'n'},
      {"squeeze-blank", no_argument, NULL, 's'},
      {NULL, 0, NULL, 0}};

  while ((opt = getopt_long(argc, argv, short_option, long_option,
                            &option_index)) != -1) {
    switch (opt) {
      case 'E':
        flag->e = 1;
        break;
      case 'T':
        flag->t = 1;
        break;
      case 'b':
        flag->b = 1;
        break;
      case 'e':
        flag->e = 1;
        flag->v = 1;
        break;
      case 'n':
        flag->n = 1;
        break;
      case 's':
        flag->s = 1;
        break;
      case 't':
        flag->v = 1;
        flag->t = 1;
        break;
      case 'v':
        flag->v = 1;
        break;
      default:
        error = 1;
        break;
    }
  }
  return error;
}

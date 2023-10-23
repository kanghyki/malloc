ifeq ($(HOSTTYPE),)
	HOSTTYPE := $(shell uname -m)_$(shell uname -s)
endif

NAME = libft_malloc.so
SYM_NAME = libft_malloc_$(HOSTTYPE).so

INC_DIR = ./inc/

SRC_DIR = ./src/
SRC = main.c

SRCS = $(addprefix $(SRC_DIR), $(SRC))
OBJS = $(SRCS:.c=.o)

CC = gcc
CFLAGS = -Wall -Wextra -Werror
CPPFLAGS = -I $(INC_DIR)

all: $(NAME)

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(NAME)
	ln -sf $(NAME) $(SYM_NAME)

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)
	unlink $(SYM_NAME)

re:
	make fclean
	make all

.PHONY: all clean fclean re

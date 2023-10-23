# **************************************************
# * TARGET NAME                                    *
# **************************************************
ifeq ($(HOSTTYPE),)
	HOSTTYPE := $(shell uname -m)_$(shell uname -s)
endif
NAME = libft_malloc.so
SYM_NAME = libft_malloc_$(HOSTTYPE).so

# **************************************************
# * SOURCE/INCLUDE                                 *
# **************************************************
INC_PATH = ./inc/
SRC_PATH = ./src/
SRC = main.c
SRCS = $(addprefix $(SRC_PATH), $(SRC))
OBJS = $(SRCS:.c=.o)

# **************************************************
# * LIBRARY                                        *
# **************************************************
LIBRARY_PATH = ./lib

# [ LIBFT ]
LIBFT_PATH = $(LIBRARY_PATH)/libft
LIBFT_NAME = $(LIBFT_PATH)/libft.a
LIBFT_INC		=	$(LIBFT_PATH)/inc

# **************************************************
# * FLAG                                           *
# **************************************************
CC = gcc
CFLAGS = -Wall -Wextra -Werror
CPPFLAGS = -I $(INC_PATH)
LDFLAGS = -lft -L$(LIBFT_PATH)

# **************************************************
# * RULE                                           *
# **************************************************
all: $(NAME)

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(NAME): $(OBJS) $(LIBFT_NAME)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $(NAME)
	ln -sf $(NAME) $(SYM_NAME)

clean:
	rm -f $(OBJS)
	make -C $(LIBFT_PATH) clean

fclean: clean
	rm -f $(NAME)
	unlink $(SYM_NAME)
	make -C $(LIBFT_PATH) fclean

re:
	make fclean
	make all

$(LIBFT_NAME):
	make -C $(LIBFT_PATH)


# **************************************************
# * PHONY                                          *
# **************************************************
.PHONY: all clean fclean re

# **************************************************
# * TARGET NAME                                    *
# **************************************************
ifeq ($(HOSTTYPE),)
	HOSTTYPE := $(shell uname -m)_$(shell uname -s)
endif
NAME = libft_malloc.so
SYM_NAME = libft_malloc_$(HOSTTYPE).so

# **************************************************
# * TEST                                           *
# **************************************************
TEST_NAME = run_test
TEST_SRC_PATH = ./test
TEST_SRC = main.c
TEST_SRCS = $(addprefix $(TEST_SRC_PATH)/, $(TEST_SRC))
TEST_OBJS = $(TEST_SRCS:.c=.o)

# **************************************************
# * SOURCE/INCLUDE                                 *
# **************************************************
INC_PATH = ./inc
SRC_PATH = ./src
SRC = malloc.c\
			realloc.c\
			free.c\
			debug.c
SRCS = $(addprefix $(SRC_PATH)/, $(SRC))
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
# * VARIABLE                                       *
# **************************************************
CC = gcc

CFLAGS = -Wall -Wextra -Werror
$(NAME): CFLAGS := -shared -fPIC
$(SRC_PATH)/%.o: CFLAGS := -Wall -Wextra -Werror
$(TEST_SRC_PATH)/%.o: CFLAGS := -Wall -Wextra -Werror

CPPFLAGS = -I $(INC_PATH)

LDFLAGS = -lft -L$(LIBFT_PATH)
test: LDFLAGS := -lft_malloc -L./

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
	rm -f $(NAME) $(SYM_NAME)
	make -C $(LIBFT_PATH) fclean

re:
	make fclean
	make all

$(LIBFT_NAME):
	make bonus -C $(LIBFT_PATH)

test: $(NAME) $(TEST_OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(TEST_OBJS) -o $(TEST_NAME)
	@echo "+--------------------------------------------------+\n\
| RUN TEST                                         |\n\
+--------------------------------------------------+"
	@./$(TEST_NAME)
	@echo "+--------------------------------------------------+"
	rm -f $(TEST_OBJS)
	rm -f $(TEST_NAME)


# **************************************************
# * PHONY                                          *
# **************************************************
.PHONY: all clean fclean re test

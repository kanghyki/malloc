# **************************************************
# * TARGET NAME                                    *
# **************************************************
LIB_NAME := ft_malloc
ifeq ($(HOSTTYPE),)
	HOSTTYPE := $(shell uname -m)_$(shell uname -s)
endif
NAME := lib$(LIB_NAME).so
SYM_NAME := lib$(LIB_NAME)_$(HOSTTYPE).so

# **************************************************
# * SOURCE/INCLUDE                                 *
# **************************************************
INC_PATH := ./inc
SRC_PATH := ./src
SRC := malloc.c\
			realloc.c\
			free.c\
			debug.c
SRCS := $(addprefix $(SRC_PATH)/, $(SRC))
OBJS := $(SRCS:.c=.o)

# **************************************************
# * TEST                                           *
# **************************************************
TEST_NAME := run_test
TEST_SRC_PATH := ./test
TEST_SRC := main.c
TEST_SRCS := $(addprefix $(TEST_SRC_PATH)/, $(TEST_SRC))
TEST_OBJS := $(TEST_SRCS:.c=.o)

# **************************************************
# * LIBRARY                                        *
# **************************************************
LIBRARY_PATH := ./lib

# [ LIBFT ]
LIBFT_LIB_NAME := ft
LIBFT_PATH := $(LIBRARY_PATH)/libft
LIBFT_NAME := $(LIBFT_PATH)/lib$(LIBFT_LIB_NAME).a
LIBFT_INC := $(LIBFT_PATH)/inc

# **************************************************
# * VARIABLE                                       *
# **************************************************
CC := gcc
CFLAGS := -Wall -Wextra -Werror
%.o: CFLAGS := -Wall -Wextra -Werror
%.so: CFLAGS := -shared -fPIC
CPPFLAGS := -I $(INC_PATH)
LDFLAGS := -l$(LIBFT_LIB_NAME) -L$(LIBFT_PATH)
$(TEST_NAME): LDFLAGS := -l$(LIB_NAME) -L./

# **************************************************
# * RULE                                           *
# **************************************************
all: $(NAME)
.PHONY: all

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(NAME): $(OBJS) $(LIBFT_NAME)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $(NAME)
	ln -sf $(NAME) $(SYM_NAME)

clean:
	rm -f $(OBJS)
	@make -C $(LIBFT_PATH) clean
.PHONY: clean

fclean: clean
	rm -f $(NAME) $(SYM_NAME)
	@make -C $(LIBFT_PATH) fclean
.PHONY: fclean

re:
	@make fclean
	@make all
.PHONY: re

$(LIBFT_NAME):
	@make -C $(LIBFT_PATH)

test:
	@make $(NAME)
	@make $(TEST_NAME)
.PHONY: test

$(TEST_NAME): $(TEST_OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(TEST_OBJS) -o $(TEST_NAME)

test/clean:
	rm -f $(TEST_OBJS)
.PHONY: test/clean

test/fclean: test/clean
	rm -f $(TEST_NAME)
.PHONY: test/fclean

test/re:
	@make test/fclean
	@make test
.PHONY: test/re

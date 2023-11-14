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
INC_PATHS := ./inc \
						 ./inc/implementation
SRC_PATH := ./src
SRC := malloc.c
SRCS := $(addprefix $(SRC_PATH)/, $(SRC))
OBJS := $(SRCS:.c=.o)

# **************************************************
# * LIBRARY                                        *
# **************************************************
LIBRARY_PATH := ./lib

# [ LIBFT ]
LIBFT_LIB_NAME := ft
LIBFT_PATH := $(LIBRARY_PATH)/libft
LIBFT_NAME := $(LIBFT_PATH)/lib$(LIBFT_LIB_NAME).a
LIBFT_INC_PATH := $(LIBFT_PATH)/inc

# [ FT_PRINTF ]
FT_PRINTF_LIB_NAME := ftprintf
FT_PRINTF_PATH := $(LIBRARY_PATH)/ft_printf
FT_PRINTF_NAME := $(FT_PRINTF_PATH)/lib$(FT_PRINTF_LIB_NAME).a
FT_PRINTF_INC_PATH := $(FT_PRINTF_PATH)/inc

LIBRARY_NAMES := $(LIBFT_LIB_NAME) \
								 $(FT_PRINTF_LIB_NAME)
LIBRARY_PATHS := $(LIBFT_PATH) \
								 $(FT_PRINTF_PATH)
LIBRARY_INC_PATHS := $(LIBFT_INC_PATH) \
										 $(FT_PRINTF_INC_PATH)

# **************************************************
# * VARIABLE                                       *
# **************************************************
CC := gcc
%.o: CFLAGS := -Wall -Wextra -Werror
%.so: CFLAGS := -shared -fPIC
CPPFLAGS := $(addprefix -I, $(LIBRARY_INC_PATHS)) \
						$(addprefix -I, $(INC_PATHS))
LDFLAGS := $(addprefix -l, $(LIBRARY_NAMES)) \
					 $(addprefix -L, $(LIBRARY_PATHS))

# **************************************************
# * RULE                                           *
# **************************************************
all: $(NAME)

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(NAME): $(OBJS) $(LIBFT_NAME) $(FT_PRINTF_NAME)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $(NAME)
	ln -sf $(NAME) $(SYM_NAME)

clean:
	rm -f $(OBJS)
	@make -C $(LIBFT_PATH) clean
	@make -C $(FT_PRINTF_PATH) clean

fclean: clean
	rm -f $(NAME) $(SYM_NAME)
	@make -C $(LIBFT_PATH) fclean
	@make -C $(FT_PRINTF_PATH) fclean

re:
	@make fclean
	@make all

$(LIBFT_NAME):
	@make -C $(LIBFT_PATH)

$(FT_PRINTF_NAME):
	@make -C $(FT_PRINTF_PATH)

# **************************************************
# * PHONY                                          *
# **************************************************
.PHONY: all clean fclean re

# **************************************************
# * TEST SOURCE/INCLUDE                            *
# **************************************************
TEST_NAME := run_test
TEST_SRC_PATH := ./test
TEST_SRC := main.c
TEST_SRCS := $(addprefix $(TEST_SRC_PATH)/, $(TEST_SRC))
TEST_OBJS := $(TEST_SRCS:.c=.o)

# **************************************************
# * TEST RULE                                      *
# **************************************************
test: $(TEST_NAME)

$(TEST_NAME): $(TEST_OBJS) $(NAME)
	$(CC) -l$(LIB_NAME) -L./ $(TEST_OBJS) -o $(TEST_NAME)

test/clean:
	rm -f $(TEST_OBJS)

test/fclean: test/clean
	rm -f $(TEST_NAME)

test/re:
	@make test/fclean
	@make test

# **************************************************
# * TEST PHONY                                     *
# **************************************************
.PHONY: test test/clean test/fclean test/re

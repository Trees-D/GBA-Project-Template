#========================================
.SUFFIXES:
#========================================

#========================================
ifeq ($(strip $(DEVKITARM)),)
    $(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

include $(DEVKITARM)/gba_rules
#========================================

#========================================
TARGET			:= GBA
BUILD			:= build
SRC_DIR			:= src
INC_DIR			:= include ext ext/gba ext/tonc
LIB_DIR			:= lib
DATA_DIR		:=
MUSIC_DIR		:=
GRAPHICS_DIR	:=
#========================================

#========================================
ARCH		:= -mthumb -mthumb-interwork

CFLAGS		:= -g -Wall -O3 \
         	-mcpu=arm7tdmi -mtune=arm7tdmi \
         	$(ARCH)
CFLAGS		+= $(INCLUDE)

CXXFLAGS	:= $(CFLAGS) -fno-rtti -fno-exceptions

ASFLAGS 	:= -g $(ARCH)

LDFLAGS		:= -g $(ARCH) -Wl,-Map,$(notdir $*.map)
#========================================

#========================================
LIBS		:= -lmm -lgba
#========================================

#========================================
ifneq ($(BUILD),$(notdir $(CURDIR)))

export OUTPUT	:= $(CURDIR)/$(BUILD)/$(TARGET)

export VPATH	:= $(foreach dir,$(SRC_DIR),$(CURDIR)/$(dir)) \

export DEPSDIR	:= $(CURDIR)/$(BUILD)

CFILES			:= $(foreach dir,$(SRC_DIR),$(notdir $(wildcard $(dir)/*.c)))

CPPFILES		:= $(foreach dir,$(SRC_DIR),$(notdir $(wildcard $(dir)/*.cpp)))

SFILES			:= $(foreach dir,$(SRC_DIR),$(notdir $(wildcard $(dir)/*.s)))

BINFILES		:= $(foreach dir,$(DATA_DIR),$(notdir $(wildcard $(dir)/*.*)))

AUDIOFILES		:= $(foreach dir,$(MUSIC_DIR),$(notdir $(wildcard $(dir)/*.*)))

GRAPHICSFILES	:= $(foreach dir,$(GRAPHICS_DIR),$(notdir $(wildcard $(dir)/*.bmp)))
#========================================

#========================================
ifeq ($(strip $(CPPFILES)),)
	export LD := $(CC)
else
	export LD := $(CXX)
endif
#========================================

export OFILES_BIN		:= $(addsuffix .o,$(BINFILES))

export OFILES_SOURCES	:= $(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(SFILES:.s=.o)

export OFILES			:= $(OFILES_BIN) $(OFILES_SOURCES)

export HFILES			:= $(addsuffix .h,$(subst .,_,$(BINFILES)))

export INCLUDE			:= $(foreach dir,$(INC_DIR),-I$(CURDIR)/$(dir)) \
						-I$(CURDIR)/$(BUILD)

export LIBPATHS			:= -L$(CURDIR)/$(LIB_DIR)

.PHONY: $(BUILD) clean

$(BUILD):
	@[ -d $(BUILD) ] || mkdir -p $(BUILD)
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile

clean:
	@echo clean ...
	@rm -rf $(BUILD)

else

$(OUTPUT).gba		: $(OUTPUT).elf

$(OUTPUT).elf		: $(OFILES)

$(OFILES_SOURCES)	: $(HFILES)

soundbank.bin soundbank.h : $(AUDIOFILES)
	@mmutil $^ -osoundbank.bin -hsoundbank.h

%.bin.o %_bin.h : %.bin
	@echo $(notdir $<)
	@$(bin2o)

-include $(DEPSDIR)/*.d

endif
# Определение переменных
CC = gcc
LEX = flex
YACC = bison

# Исходные файлы
LEX_SOURCE = L.l
YACC_SOURCE = Y.y
EXECUTABLE = translator

# Цель по умолчанию
all: run format

# Компиляция и сборка программы
$(EXECUTABLE): lex.yy.c y.tab.c
	$(CC) $^ -o $@


# Генерация программы на языке ST
# generate: 

# Генерация файла lex.yy.c
lex.yy.c: $(LEX_SOURCE)
	$(LEX) $<

# Генерация файлов y.tab.c и y.tab.h
y.tab.c: $(YACC_SOURCE)
	$(YACC) -d $<

# Цель для запуска программы
run: $(EXECUTABLE) 
	./$(EXECUTABLE)

# Чистка (удаление сгенерированных файлов)
clean:
	rm -f lex.yy.c y.tab.c y.tab.h output.txt $(EXECUTABLE)

# Форматирование текста программы
format:
	clang-format -i output.txt

# Правило .PHONY для указания фиктивных целей
.PHONY: all clean
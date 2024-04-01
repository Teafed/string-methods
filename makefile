OBJS = driver.o String_equals.o String_length.o ../obj/putstring.o ../obj/int64asc.o


%.o: %.s
	as -g $< -o $@

rasm-3: $(OBJS)
	ld -o driver $(OBJS)

clean:
	rm -f *.o run *~

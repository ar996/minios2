#ifndef LIBC_STRING_INCLUDED
#define LIBC_STRING_INCLUDED


void*	memchr(const void * m, int c, int n);
int		memcmp(const void * s1, const void * s2, int n);
void*	memcpy(void *dest, const void *src, int count);
void*	memset(void *dest, int c, int count);
char*	strcpy(char * s1, const char * s2);
int		strcmp(const char * s1, const char * s2);
char*	strcat(char* destination, const char* append);
int		strlen(const char * s);
char*	strchr(const char* s, int c);
int		strcspn(const char * s1, const char * s2);
char*	strncat(char* dst, const char* src, int n);
int		strncmp(const char * s1, const char * s2, int n);
char*	strncpy(char * s1, const char *s2, int n);
char*	strpbrk(const char * s1, const char * s2);
int		strspn(const char * s,const char * sep);
char*	strstr(const char * s, const char * find);
char*	strrchr(const char * s, int c);
char*	strtok(char * string,const char * separator);

int		isalpha(int c);
int		isalnum(int c);
int		isdigit(int c);
int		isxdigit(int c);
int		toupper(int c);
int		tolower(int c);

char*	strupr(char *s);
char*	strlwr(char *s);

int strnicmp( const char *string1, const char *string2, unsigned int count );
int memicmp( const void *buf1, const void *buf2, unsigned int count );


#endif

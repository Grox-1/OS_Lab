
user/_bigfile：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fcntl.h"
#include "kernel/fs.h"

int
main()
{
   0:	bd010113          	addi	sp,sp,-1072
   4:	42113423          	sd	ra,1064(sp)
   8:	42813023          	sd	s0,1056(sp)
   c:	40913c23          	sd	s1,1048(sp)
  10:	41213823          	sd	s2,1040(sp)
  14:	41313423          	sd	s3,1032(sp)
  18:	41413023          	sd	s4,1024(sp)
  1c:	43010413          	addi	s0,sp,1072
  char buf[BSIZE];
  int fd, i, blocks;

  fd = open("big.file", O_CREATE | O_WRONLY);
  20:	20100593          	li	a1,513
  24:	00001517          	auipc	a0,0x1
  28:	91c50513          	addi	a0,a0,-1764 # 940 <malloc+0xea>
  2c:	00000097          	auipc	ra,0x0
  30:	42c080e7          	jalr	1068(ra) # 458 <open>
  if(fd < 0){
  34:	00054b63          	bltz	a0,4a <main+0x4a>
  38:	892a                	mv	s2,a0
  3a:	4481                	li	s1,0
    *(int*)buf = blocks;
    int cc = write(fd, buf, sizeof(buf));
    if(cc <= 0)
      break;
    blocks++;
    if (blocks % 100 == 0)
  3c:	06400993          	li	s3,100
      printf(".");
  40:	00001a17          	auipc	s4,0x1
  44:	940a0a13          	addi	s4,s4,-1728 # 980 <malloc+0x12a>
  48:	a01d                	j	6e <main+0x6e>
    printf("bigfile: cannot open big.file for writing\n");
  4a:	00001517          	auipc	a0,0x1
  4e:	90650513          	addi	a0,a0,-1786 # 950 <malloc+0xfa>
  52:	00000097          	auipc	ra,0x0
  56:	746080e7          	jalr	1862(ra) # 798 <printf>
    exit(-1);
  5a:	557d                	li	a0,-1
  5c:	00000097          	auipc	ra,0x0
  60:	3bc080e7          	jalr	956(ra) # 418 <exit>
      printf(".");
  64:	8552                	mv	a0,s4
  66:	00000097          	auipc	ra,0x0
  6a:	732080e7          	jalr	1842(ra) # 798 <printf>
    *(int*)buf = blocks;
  6e:	bc942823          	sw	s1,-1072(s0)
    int cc = write(fd, buf, sizeof(buf));
  72:	40000613          	li	a2,1024
  76:	bd040593          	addi	a1,s0,-1072
  7a:	854a                	mv	a0,s2
  7c:	00000097          	auipc	ra,0x0
  80:	3bc080e7          	jalr	956(ra) # 438 <write>
    if(cc <= 0)
  84:	00a05a63          	blez	a0,98 <main+0x98>
    blocks++;
  88:	0014879b          	addiw	a5,s1,1
  8c:	0007849b          	sext.w	s1,a5
    if (blocks % 100 == 0)
  90:	0337e7bb          	remw	a5,a5,s3
  94:	ffe9                	bnez	a5,6e <main+0x6e>
  96:	b7f9                	j	64 <main+0x64>
  }

  printf("\nwrote %d blocks\n", blocks);
  98:	85a6                	mv	a1,s1
  9a:	00001517          	auipc	a0,0x1
  9e:	8ee50513          	addi	a0,a0,-1810 # 988 <malloc+0x132>
  a2:	00000097          	auipc	ra,0x0
  a6:	6f6080e7          	jalr	1782(ra) # 798 <printf>
  if(blocks != 65803) {
  aa:	67c1                	lui	a5,0x10
  ac:	10b78793          	addi	a5,a5,267 # 1010b <base+0xf0fb>
  b0:	00f48f63          	beq	s1,a5,ce <main+0xce>
    printf("bigfile: file is too small\n");
  b4:	00001517          	auipc	a0,0x1
  b8:	8ec50513          	addi	a0,a0,-1812 # 9a0 <malloc+0x14a>
  bc:	00000097          	auipc	ra,0x0
  c0:	6dc080e7          	jalr	1756(ra) # 798 <printf>
    exit(-1);
  c4:	557d                	li	a0,-1
  c6:	00000097          	auipc	ra,0x0
  ca:	352080e7          	jalr	850(ra) # 418 <exit>
  }
  
  close(fd);
  ce:	854a                	mv	a0,s2
  d0:	00000097          	auipc	ra,0x0
  d4:	370080e7          	jalr	880(ra) # 440 <close>
  fd = open("big.file", O_RDONLY);
  d8:	4581                	li	a1,0
  da:	00001517          	auipc	a0,0x1
  de:	86650513          	addi	a0,a0,-1946 # 940 <malloc+0xea>
  e2:	00000097          	auipc	ra,0x0
  e6:	376080e7          	jalr	886(ra) # 458 <open>
  ea:	892a                	mv	s2,a0
  if(fd < 0){
    printf("bigfile: cannot re-open big.file for reading\n");
    exit(-1);
  }
  for(i = 0; i < blocks; i++){
  ec:	4481                	li	s1,0
  if(fd < 0){
  ee:	04054463          	bltz	a0,136 <main+0x136>
  for(i = 0; i < blocks; i++){
  f2:	69c1                	lui	s3,0x10
  f4:	10b98993          	addi	s3,s3,267 # 1010b <base+0xf0fb>
    int cc = read(fd, buf, sizeof(buf));
  f8:	40000613          	li	a2,1024
  fc:	bd040593          	addi	a1,s0,-1072
 100:	854a                	mv	a0,s2
 102:	00000097          	auipc	ra,0x0
 106:	32e080e7          	jalr	814(ra) # 430 <read>
    if(cc <= 0){
 10a:	04a05363          	blez	a0,150 <main+0x150>
      printf("bigfile: read error at block %d\n", i);
      exit(-1);
    }
    if(*(int*)buf != i){
 10e:	bd042583          	lw	a1,-1072(s0)
 112:	04959d63          	bne	a1,s1,16c <main+0x16c>
  for(i = 0; i < blocks; i++){
 116:	2485                	addiw	s1,s1,1
 118:	ff3490e3          	bne	s1,s3,f8 <main+0xf8>
             *(int*)buf, i);
      exit(-1);
    }
  }

  printf("bigfile done; ok\n"); 
 11c:	00001517          	auipc	a0,0x1
 120:	92c50513          	addi	a0,a0,-1748 # a48 <malloc+0x1f2>
 124:	00000097          	auipc	ra,0x0
 128:	674080e7          	jalr	1652(ra) # 798 <printf>

  exit(0);
 12c:	4501                	li	a0,0
 12e:	00000097          	auipc	ra,0x0
 132:	2ea080e7          	jalr	746(ra) # 418 <exit>
    printf("bigfile: cannot re-open big.file for reading\n");
 136:	00001517          	auipc	a0,0x1
 13a:	88a50513          	addi	a0,a0,-1910 # 9c0 <malloc+0x16a>
 13e:	00000097          	auipc	ra,0x0
 142:	65a080e7          	jalr	1626(ra) # 798 <printf>
    exit(-1);
 146:	557d                	li	a0,-1
 148:	00000097          	auipc	ra,0x0
 14c:	2d0080e7          	jalr	720(ra) # 418 <exit>
      printf("bigfile: read error at block %d\n", i);
 150:	85a6                	mv	a1,s1
 152:	00001517          	auipc	a0,0x1
 156:	89e50513          	addi	a0,a0,-1890 # 9f0 <malloc+0x19a>
 15a:	00000097          	auipc	ra,0x0
 15e:	63e080e7          	jalr	1598(ra) # 798 <printf>
      exit(-1);
 162:	557d                	li	a0,-1
 164:	00000097          	auipc	ra,0x0
 168:	2b4080e7          	jalr	692(ra) # 418 <exit>
      printf("bigfile: read the wrong data (%d) for block %d\n",
 16c:	8626                	mv	a2,s1
 16e:	00001517          	auipc	a0,0x1
 172:	8aa50513          	addi	a0,a0,-1878 # a18 <malloc+0x1c2>
 176:	00000097          	auipc	ra,0x0
 17a:	622080e7          	jalr	1570(ra) # 798 <printf>
      exit(-1);
 17e:	557d                	li	a0,-1
 180:	00000097          	auipc	ra,0x0
 184:	298080e7          	jalr	664(ra) # 418 <exit>

0000000000000188 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 188:	1141                	addi	sp,sp,-16
 18a:	e406                	sd	ra,8(sp)
 18c:	e022                	sd	s0,0(sp)
 18e:	0800                	addi	s0,sp,16
  extern int main();
  main();
 190:	00000097          	auipc	ra,0x0
 194:	e70080e7          	jalr	-400(ra) # 0 <main>
  exit(0);
 198:	4501                	li	a0,0
 19a:	00000097          	auipc	ra,0x0
 19e:	27e080e7          	jalr	638(ra) # 418 <exit>

00000000000001a2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1a2:	1141                	addi	sp,sp,-16
 1a4:	e422                	sd	s0,8(sp)
 1a6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a8:	87aa                	mv	a5,a0
 1aa:	0585                	addi	a1,a1,1
 1ac:	0785                	addi	a5,a5,1
 1ae:	fff5c703          	lbu	a4,-1(a1)
 1b2:	fee78fa3          	sb	a4,-1(a5)
 1b6:	fb75                	bnez	a4,1aa <strcpy+0x8>
    ;
  return os;
}
 1b8:	6422                	ld	s0,8(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret

00000000000001be <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e422                	sd	s0,8(sp)
 1c2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1c4:	00054783          	lbu	a5,0(a0)
 1c8:	cb91                	beqz	a5,1dc <strcmp+0x1e>
 1ca:	0005c703          	lbu	a4,0(a1)
 1ce:	00f71763          	bne	a4,a5,1dc <strcmp+0x1e>
    p++, q++;
 1d2:	0505                	addi	a0,a0,1
 1d4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1d6:	00054783          	lbu	a5,0(a0)
 1da:	fbe5                	bnez	a5,1ca <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1dc:	0005c503          	lbu	a0,0(a1)
}
 1e0:	40a7853b          	subw	a0,a5,a0
 1e4:	6422                	ld	s0,8(sp)
 1e6:	0141                	addi	sp,sp,16
 1e8:	8082                	ret

00000000000001ea <strlen>:

uint
strlen(const char *s)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e422                	sd	s0,8(sp)
 1ee:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1f0:	00054783          	lbu	a5,0(a0)
 1f4:	cf91                	beqz	a5,210 <strlen+0x26>
 1f6:	0505                	addi	a0,a0,1
 1f8:	87aa                	mv	a5,a0
 1fa:	4685                	li	a3,1
 1fc:	9e89                	subw	a3,a3,a0
 1fe:	00f6853b          	addw	a0,a3,a5
 202:	0785                	addi	a5,a5,1
 204:	fff7c703          	lbu	a4,-1(a5)
 208:	fb7d                	bnez	a4,1fe <strlen+0x14>
    ;
  return n;
}
 20a:	6422                	ld	s0,8(sp)
 20c:	0141                	addi	sp,sp,16
 20e:	8082                	ret
  for(n = 0; s[n]; n++)
 210:	4501                	li	a0,0
 212:	bfe5                	j	20a <strlen+0x20>

0000000000000214 <memset>:

void*
memset(void *dst, int c, uint n)
{
 214:	1141                	addi	sp,sp,-16
 216:	e422                	sd	s0,8(sp)
 218:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 21a:	ce09                	beqz	a2,234 <memset+0x20>
 21c:	87aa                	mv	a5,a0
 21e:	fff6071b          	addiw	a4,a2,-1
 222:	1702                	slli	a4,a4,0x20
 224:	9301                	srli	a4,a4,0x20
 226:	0705                	addi	a4,a4,1
 228:	972a                	add	a4,a4,a0
    cdst[i] = c;
 22a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 22e:	0785                	addi	a5,a5,1
 230:	fee79de3          	bne	a5,a4,22a <memset+0x16>
  }
  return dst;
}
 234:	6422                	ld	s0,8(sp)
 236:	0141                	addi	sp,sp,16
 238:	8082                	ret

000000000000023a <strchr>:

char*
strchr(const char *s, char c)
{
 23a:	1141                	addi	sp,sp,-16
 23c:	e422                	sd	s0,8(sp)
 23e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 240:	00054783          	lbu	a5,0(a0)
 244:	cb99                	beqz	a5,25a <strchr+0x20>
    if(*s == c)
 246:	00f58763          	beq	a1,a5,254 <strchr+0x1a>
  for(; *s; s++)
 24a:	0505                	addi	a0,a0,1
 24c:	00054783          	lbu	a5,0(a0)
 250:	fbfd                	bnez	a5,246 <strchr+0xc>
      return (char*)s;
  return 0;
 252:	4501                	li	a0,0
}
 254:	6422                	ld	s0,8(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret
  return 0;
 25a:	4501                	li	a0,0
 25c:	bfe5                	j	254 <strchr+0x1a>

000000000000025e <gets>:

char*
gets(char *buf, int max)
{
 25e:	711d                	addi	sp,sp,-96
 260:	ec86                	sd	ra,88(sp)
 262:	e8a2                	sd	s0,80(sp)
 264:	e4a6                	sd	s1,72(sp)
 266:	e0ca                	sd	s2,64(sp)
 268:	fc4e                	sd	s3,56(sp)
 26a:	f852                	sd	s4,48(sp)
 26c:	f456                	sd	s5,40(sp)
 26e:	f05a                	sd	s6,32(sp)
 270:	ec5e                	sd	s7,24(sp)
 272:	1080                	addi	s0,sp,96
 274:	8baa                	mv	s7,a0
 276:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 278:	892a                	mv	s2,a0
 27a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 27c:	4aa9                	li	s5,10
 27e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 280:	89a6                	mv	s3,s1
 282:	2485                	addiw	s1,s1,1
 284:	0344d863          	bge	s1,s4,2b4 <gets+0x56>
    cc = read(0, &c, 1);
 288:	4605                	li	a2,1
 28a:	faf40593          	addi	a1,s0,-81
 28e:	4501                	li	a0,0
 290:	00000097          	auipc	ra,0x0
 294:	1a0080e7          	jalr	416(ra) # 430 <read>
    if(cc < 1)
 298:	00a05e63          	blez	a0,2b4 <gets+0x56>
    buf[i++] = c;
 29c:	faf44783          	lbu	a5,-81(s0)
 2a0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2a4:	01578763          	beq	a5,s5,2b2 <gets+0x54>
 2a8:	0905                	addi	s2,s2,1
 2aa:	fd679be3          	bne	a5,s6,280 <gets+0x22>
  for(i=0; i+1 < max; ){
 2ae:	89a6                	mv	s3,s1
 2b0:	a011                	j	2b4 <gets+0x56>
 2b2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2b4:	99de                	add	s3,s3,s7
 2b6:	00098023          	sb	zero,0(s3)
  return buf;
}
 2ba:	855e                	mv	a0,s7
 2bc:	60e6                	ld	ra,88(sp)
 2be:	6446                	ld	s0,80(sp)
 2c0:	64a6                	ld	s1,72(sp)
 2c2:	6906                	ld	s2,64(sp)
 2c4:	79e2                	ld	s3,56(sp)
 2c6:	7a42                	ld	s4,48(sp)
 2c8:	7aa2                	ld	s5,40(sp)
 2ca:	7b02                	ld	s6,32(sp)
 2cc:	6be2                	ld	s7,24(sp)
 2ce:	6125                	addi	sp,sp,96
 2d0:	8082                	ret

00000000000002d2 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d2:	1101                	addi	sp,sp,-32
 2d4:	ec06                	sd	ra,24(sp)
 2d6:	e822                	sd	s0,16(sp)
 2d8:	e426                	sd	s1,8(sp)
 2da:	e04a                	sd	s2,0(sp)
 2dc:	1000                	addi	s0,sp,32
 2de:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e0:	4581                	li	a1,0
 2e2:	00000097          	auipc	ra,0x0
 2e6:	176080e7          	jalr	374(ra) # 458 <open>
  if(fd < 0)
 2ea:	02054563          	bltz	a0,314 <stat+0x42>
 2ee:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2f0:	85ca                	mv	a1,s2
 2f2:	00000097          	auipc	ra,0x0
 2f6:	17e080e7          	jalr	382(ra) # 470 <fstat>
 2fa:	892a                	mv	s2,a0
  close(fd);
 2fc:	8526                	mv	a0,s1
 2fe:	00000097          	auipc	ra,0x0
 302:	142080e7          	jalr	322(ra) # 440 <close>
  return r;
}
 306:	854a                	mv	a0,s2
 308:	60e2                	ld	ra,24(sp)
 30a:	6442                	ld	s0,16(sp)
 30c:	64a2                	ld	s1,8(sp)
 30e:	6902                	ld	s2,0(sp)
 310:	6105                	addi	sp,sp,32
 312:	8082                	ret
    return -1;
 314:	597d                	li	s2,-1
 316:	bfc5                	j	306 <stat+0x34>

0000000000000318 <atoi>:

int
atoi(const char *s)
{
 318:	1141                	addi	sp,sp,-16
 31a:	e422                	sd	s0,8(sp)
 31c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 31e:	00054603          	lbu	a2,0(a0)
 322:	fd06079b          	addiw	a5,a2,-48
 326:	0ff7f793          	andi	a5,a5,255
 32a:	4725                	li	a4,9
 32c:	02f76963          	bltu	a4,a5,35e <atoi+0x46>
 330:	86aa                	mv	a3,a0
  n = 0;
 332:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 334:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 336:	0685                	addi	a3,a3,1
 338:	0025179b          	slliw	a5,a0,0x2
 33c:	9fa9                	addw	a5,a5,a0
 33e:	0017979b          	slliw	a5,a5,0x1
 342:	9fb1                	addw	a5,a5,a2
 344:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 348:	0006c603          	lbu	a2,0(a3)
 34c:	fd06071b          	addiw	a4,a2,-48
 350:	0ff77713          	andi	a4,a4,255
 354:	fee5f1e3          	bgeu	a1,a4,336 <atoi+0x1e>
  return n;
}
 358:	6422                	ld	s0,8(sp)
 35a:	0141                	addi	sp,sp,16
 35c:	8082                	ret
  n = 0;
 35e:	4501                	li	a0,0
 360:	bfe5                	j	358 <atoi+0x40>

0000000000000362 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 362:	1141                	addi	sp,sp,-16
 364:	e422                	sd	s0,8(sp)
 366:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 368:	02b57663          	bgeu	a0,a1,394 <memmove+0x32>
    while(n-- > 0)
 36c:	02c05163          	blez	a2,38e <memmove+0x2c>
 370:	fff6079b          	addiw	a5,a2,-1
 374:	1782                	slli	a5,a5,0x20
 376:	9381                	srli	a5,a5,0x20
 378:	0785                	addi	a5,a5,1
 37a:	97aa                	add	a5,a5,a0
  dst = vdst;
 37c:	872a                	mv	a4,a0
      *dst++ = *src++;
 37e:	0585                	addi	a1,a1,1
 380:	0705                	addi	a4,a4,1
 382:	fff5c683          	lbu	a3,-1(a1)
 386:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 38a:	fee79ae3          	bne	a5,a4,37e <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 38e:	6422                	ld	s0,8(sp)
 390:	0141                	addi	sp,sp,16
 392:	8082                	ret
    dst += n;
 394:	00c50733          	add	a4,a0,a2
    src += n;
 398:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 39a:	fec05ae3          	blez	a2,38e <memmove+0x2c>
 39e:	fff6079b          	addiw	a5,a2,-1
 3a2:	1782                	slli	a5,a5,0x20
 3a4:	9381                	srli	a5,a5,0x20
 3a6:	fff7c793          	not	a5,a5
 3aa:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3ac:	15fd                	addi	a1,a1,-1
 3ae:	177d                	addi	a4,a4,-1
 3b0:	0005c683          	lbu	a3,0(a1)
 3b4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3b8:	fee79ae3          	bne	a5,a4,3ac <memmove+0x4a>
 3bc:	bfc9                	j	38e <memmove+0x2c>

00000000000003be <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3be:	1141                	addi	sp,sp,-16
 3c0:	e422                	sd	s0,8(sp)
 3c2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3c4:	ca05                	beqz	a2,3f4 <memcmp+0x36>
 3c6:	fff6069b          	addiw	a3,a2,-1
 3ca:	1682                	slli	a3,a3,0x20
 3cc:	9281                	srli	a3,a3,0x20
 3ce:	0685                	addi	a3,a3,1
 3d0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3d2:	00054783          	lbu	a5,0(a0)
 3d6:	0005c703          	lbu	a4,0(a1)
 3da:	00e79863          	bne	a5,a4,3ea <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3de:	0505                	addi	a0,a0,1
    p2++;
 3e0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3e2:	fed518e3          	bne	a0,a3,3d2 <memcmp+0x14>
  }
  return 0;
 3e6:	4501                	li	a0,0
 3e8:	a019                	j	3ee <memcmp+0x30>
      return *p1 - *p2;
 3ea:	40e7853b          	subw	a0,a5,a4
}
 3ee:	6422                	ld	s0,8(sp)
 3f0:	0141                	addi	sp,sp,16
 3f2:	8082                	ret
  return 0;
 3f4:	4501                	li	a0,0
 3f6:	bfe5                	j	3ee <memcmp+0x30>

00000000000003f8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3f8:	1141                	addi	sp,sp,-16
 3fa:	e406                	sd	ra,8(sp)
 3fc:	e022                	sd	s0,0(sp)
 3fe:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 400:	00000097          	auipc	ra,0x0
 404:	f62080e7          	jalr	-158(ra) # 362 <memmove>
}
 408:	60a2                	ld	ra,8(sp)
 40a:	6402                	ld	s0,0(sp)
 40c:	0141                	addi	sp,sp,16
 40e:	8082                	ret

0000000000000410 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 410:	4885                	li	a7,1
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <exit>:
.global exit
exit:
 li a7, SYS_exit
 418:	4889                	li	a7,2
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <wait>:
.global wait
wait:
 li a7, SYS_wait
 420:	488d                	li	a7,3
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 428:	4891                	li	a7,4
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <read>:
.global read
read:
 li a7, SYS_read
 430:	4895                	li	a7,5
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <write>:
.global write
write:
 li a7, SYS_write
 438:	48c1                	li	a7,16
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <close>:
.global close
close:
 li a7, SYS_close
 440:	48d5                	li	a7,21
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <kill>:
.global kill
kill:
 li a7, SYS_kill
 448:	4899                	li	a7,6
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <exec>:
.global exec
exec:
 li a7, SYS_exec
 450:	489d                	li	a7,7
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <open>:
.global open
open:
 li a7, SYS_open
 458:	48bd                	li	a7,15
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 460:	48c5                	li	a7,17
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 468:	48c9                	li	a7,18
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 470:	48a1                	li	a7,8
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <link>:
.global link
link:
 li a7, SYS_link
 478:	48cd                	li	a7,19
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 480:	48d1                	li	a7,20
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 488:	48a5                	li	a7,9
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <dup>:
.global dup
dup:
 li a7, SYS_dup
 490:	48a9                	li	a7,10
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 498:	48ad                	li	a7,11
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4a0:	48b1                	li	a7,12
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4a8:	48b5                	li	a7,13
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4b0:	48b9                	li	a7,14
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
 4b8:	48d9                	li	a7,22
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4c0:	1101                	addi	sp,sp,-32
 4c2:	ec06                	sd	ra,24(sp)
 4c4:	e822                	sd	s0,16(sp)
 4c6:	1000                	addi	s0,sp,32
 4c8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4cc:	4605                	li	a2,1
 4ce:	fef40593          	addi	a1,s0,-17
 4d2:	00000097          	auipc	ra,0x0
 4d6:	f66080e7          	jalr	-154(ra) # 438 <write>
}
 4da:	60e2                	ld	ra,24(sp)
 4dc:	6442                	ld	s0,16(sp)
 4de:	6105                	addi	sp,sp,32
 4e0:	8082                	ret

00000000000004e2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e2:	7139                	addi	sp,sp,-64
 4e4:	fc06                	sd	ra,56(sp)
 4e6:	f822                	sd	s0,48(sp)
 4e8:	f426                	sd	s1,40(sp)
 4ea:	f04a                	sd	s2,32(sp)
 4ec:	ec4e                	sd	s3,24(sp)
 4ee:	0080                	addi	s0,sp,64
 4f0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4f2:	c299                	beqz	a3,4f8 <printint+0x16>
 4f4:	0805c863          	bltz	a1,584 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4f8:	2581                	sext.w	a1,a1
  neg = 0;
 4fa:	4881                	li	a7,0
 4fc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 500:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 502:	2601                	sext.w	a2,a2
 504:	00000517          	auipc	a0,0x0
 508:	56450513          	addi	a0,a0,1380 # a68 <digits>
 50c:	883a                	mv	a6,a4
 50e:	2705                	addiw	a4,a4,1
 510:	02c5f7bb          	remuw	a5,a1,a2
 514:	1782                	slli	a5,a5,0x20
 516:	9381                	srli	a5,a5,0x20
 518:	97aa                	add	a5,a5,a0
 51a:	0007c783          	lbu	a5,0(a5)
 51e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 522:	0005879b          	sext.w	a5,a1
 526:	02c5d5bb          	divuw	a1,a1,a2
 52a:	0685                	addi	a3,a3,1
 52c:	fec7f0e3          	bgeu	a5,a2,50c <printint+0x2a>
  if(neg)
 530:	00088b63          	beqz	a7,546 <printint+0x64>
    buf[i++] = '-';
 534:	fd040793          	addi	a5,s0,-48
 538:	973e                	add	a4,a4,a5
 53a:	02d00793          	li	a5,45
 53e:	fef70823          	sb	a5,-16(a4)
 542:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 546:	02e05863          	blez	a4,576 <printint+0x94>
 54a:	fc040793          	addi	a5,s0,-64
 54e:	00e78933          	add	s2,a5,a4
 552:	fff78993          	addi	s3,a5,-1
 556:	99ba                	add	s3,s3,a4
 558:	377d                	addiw	a4,a4,-1
 55a:	1702                	slli	a4,a4,0x20
 55c:	9301                	srli	a4,a4,0x20
 55e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 562:	fff94583          	lbu	a1,-1(s2)
 566:	8526                	mv	a0,s1
 568:	00000097          	auipc	ra,0x0
 56c:	f58080e7          	jalr	-168(ra) # 4c0 <putc>
  while(--i >= 0)
 570:	197d                	addi	s2,s2,-1
 572:	ff3918e3          	bne	s2,s3,562 <printint+0x80>
}
 576:	70e2                	ld	ra,56(sp)
 578:	7442                	ld	s0,48(sp)
 57a:	74a2                	ld	s1,40(sp)
 57c:	7902                	ld	s2,32(sp)
 57e:	69e2                	ld	s3,24(sp)
 580:	6121                	addi	sp,sp,64
 582:	8082                	ret
    x = -xx;
 584:	40b005bb          	negw	a1,a1
    neg = 1;
 588:	4885                	li	a7,1
    x = -xx;
 58a:	bf8d                	j	4fc <printint+0x1a>

000000000000058c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 58c:	7119                	addi	sp,sp,-128
 58e:	fc86                	sd	ra,120(sp)
 590:	f8a2                	sd	s0,112(sp)
 592:	f4a6                	sd	s1,104(sp)
 594:	f0ca                	sd	s2,96(sp)
 596:	ecce                	sd	s3,88(sp)
 598:	e8d2                	sd	s4,80(sp)
 59a:	e4d6                	sd	s5,72(sp)
 59c:	e0da                	sd	s6,64(sp)
 59e:	fc5e                	sd	s7,56(sp)
 5a0:	f862                	sd	s8,48(sp)
 5a2:	f466                	sd	s9,40(sp)
 5a4:	f06a                	sd	s10,32(sp)
 5a6:	ec6e                	sd	s11,24(sp)
 5a8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5aa:	0005c903          	lbu	s2,0(a1)
 5ae:	18090f63          	beqz	s2,74c <vprintf+0x1c0>
 5b2:	8aaa                	mv	s5,a0
 5b4:	8b32                	mv	s6,a2
 5b6:	00158493          	addi	s1,a1,1
  state = 0;
 5ba:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5bc:	02500a13          	li	s4,37
      if(c == 'd'){
 5c0:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5c4:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5c8:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5cc:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5d0:	00000b97          	auipc	s7,0x0
 5d4:	498b8b93          	addi	s7,s7,1176 # a68 <digits>
 5d8:	a839                	j	5f6 <vprintf+0x6a>
        putc(fd, c);
 5da:	85ca                	mv	a1,s2
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	ee2080e7          	jalr	-286(ra) # 4c0 <putc>
 5e6:	a019                	j	5ec <vprintf+0x60>
    } else if(state == '%'){
 5e8:	01498f63          	beq	s3,s4,606 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 5ec:	0485                	addi	s1,s1,1
 5ee:	fff4c903          	lbu	s2,-1(s1)
 5f2:	14090d63          	beqz	s2,74c <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 5f6:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5fa:	fe0997e3          	bnez	s3,5e8 <vprintf+0x5c>
      if(c == '%'){
 5fe:	fd479ee3          	bne	a5,s4,5da <vprintf+0x4e>
        state = '%';
 602:	89be                	mv	s3,a5
 604:	b7e5                	j	5ec <vprintf+0x60>
      if(c == 'd'){
 606:	05878063          	beq	a5,s8,646 <vprintf+0xba>
      } else if(c == 'l') {
 60a:	05978c63          	beq	a5,s9,662 <vprintf+0xd6>
      } else if(c == 'x') {
 60e:	07a78863          	beq	a5,s10,67e <vprintf+0xf2>
      } else if(c == 'p') {
 612:	09b78463          	beq	a5,s11,69a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 616:	07300713          	li	a4,115
 61a:	0ce78663          	beq	a5,a4,6e6 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 61e:	06300713          	li	a4,99
 622:	0ee78e63          	beq	a5,a4,71e <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 626:	11478863          	beq	a5,s4,736 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 62a:	85d2                	mv	a1,s4
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	e92080e7          	jalr	-366(ra) # 4c0 <putc>
        putc(fd, c);
 636:	85ca                	mv	a1,s2
 638:	8556                	mv	a0,s5
 63a:	00000097          	auipc	ra,0x0
 63e:	e86080e7          	jalr	-378(ra) # 4c0 <putc>
      }
      state = 0;
 642:	4981                	li	s3,0
 644:	b765                	j	5ec <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 646:	008b0913          	addi	s2,s6,8
 64a:	4685                	li	a3,1
 64c:	4629                	li	a2,10
 64e:	000b2583          	lw	a1,0(s6)
 652:	8556                	mv	a0,s5
 654:	00000097          	auipc	ra,0x0
 658:	e8e080e7          	jalr	-370(ra) # 4e2 <printint>
 65c:	8b4a                	mv	s6,s2
      state = 0;
 65e:	4981                	li	s3,0
 660:	b771                	j	5ec <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 662:	008b0913          	addi	s2,s6,8
 666:	4681                	li	a3,0
 668:	4629                	li	a2,10
 66a:	000b2583          	lw	a1,0(s6)
 66e:	8556                	mv	a0,s5
 670:	00000097          	auipc	ra,0x0
 674:	e72080e7          	jalr	-398(ra) # 4e2 <printint>
 678:	8b4a                	mv	s6,s2
      state = 0;
 67a:	4981                	li	s3,0
 67c:	bf85                	j	5ec <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 67e:	008b0913          	addi	s2,s6,8
 682:	4681                	li	a3,0
 684:	4641                	li	a2,16
 686:	000b2583          	lw	a1,0(s6)
 68a:	8556                	mv	a0,s5
 68c:	00000097          	auipc	ra,0x0
 690:	e56080e7          	jalr	-426(ra) # 4e2 <printint>
 694:	8b4a                	mv	s6,s2
      state = 0;
 696:	4981                	li	s3,0
 698:	bf91                	j	5ec <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 69a:	008b0793          	addi	a5,s6,8
 69e:	f8f43423          	sd	a5,-120(s0)
 6a2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6a6:	03000593          	li	a1,48
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	e14080e7          	jalr	-492(ra) # 4c0 <putc>
  putc(fd, 'x');
 6b4:	85ea                	mv	a1,s10
 6b6:	8556                	mv	a0,s5
 6b8:	00000097          	auipc	ra,0x0
 6bc:	e08080e7          	jalr	-504(ra) # 4c0 <putc>
 6c0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6c2:	03c9d793          	srli	a5,s3,0x3c
 6c6:	97de                	add	a5,a5,s7
 6c8:	0007c583          	lbu	a1,0(a5)
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	df2080e7          	jalr	-526(ra) # 4c0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6d6:	0992                	slli	s3,s3,0x4
 6d8:	397d                	addiw	s2,s2,-1
 6da:	fe0914e3          	bnez	s2,6c2 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6de:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6e2:	4981                	li	s3,0
 6e4:	b721                	j	5ec <vprintf+0x60>
        s = va_arg(ap, char*);
 6e6:	008b0993          	addi	s3,s6,8
 6ea:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 6ee:	02090163          	beqz	s2,710 <vprintf+0x184>
        while(*s != 0){
 6f2:	00094583          	lbu	a1,0(s2)
 6f6:	c9a1                	beqz	a1,746 <vprintf+0x1ba>
          putc(fd, *s);
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	dc6080e7          	jalr	-570(ra) # 4c0 <putc>
          s++;
 702:	0905                	addi	s2,s2,1
        while(*s != 0){
 704:	00094583          	lbu	a1,0(s2)
 708:	f9e5                	bnez	a1,6f8 <vprintf+0x16c>
        s = va_arg(ap, char*);
 70a:	8b4e                	mv	s6,s3
      state = 0;
 70c:	4981                	li	s3,0
 70e:	bdf9                	j	5ec <vprintf+0x60>
          s = "(null)";
 710:	00000917          	auipc	s2,0x0
 714:	35090913          	addi	s2,s2,848 # a60 <malloc+0x20a>
        while(*s != 0){
 718:	02800593          	li	a1,40
 71c:	bff1                	j	6f8 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 71e:	008b0913          	addi	s2,s6,8
 722:	000b4583          	lbu	a1,0(s6)
 726:	8556                	mv	a0,s5
 728:	00000097          	auipc	ra,0x0
 72c:	d98080e7          	jalr	-616(ra) # 4c0 <putc>
 730:	8b4a                	mv	s6,s2
      state = 0;
 732:	4981                	li	s3,0
 734:	bd65                	j	5ec <vprintf+0x60>
        putc(fd, c);
 736:	85d2                	mv	a1,s4
 738:	8556                	mv	a0,s5
 73a:	00000097          	auipc	ra,0x0
 73e:	d86080e7          	jalr	-634(ra) # 4c0 <putc>
      state = 0;
 742:	4981                	li	s3,0
 744:	b565                	j	5ec <vprintf+0x60>
        s = va_arg(ap, char*);
 746:	8b4e                	mv	s6,s3
      state = 0;
 748:	4981                	li	s3,0
 74a:	b54d                	j	5ec <vprintf+0x60>
    }
  }
}
 74c:	70e6                	ld	ra,120(sp)
 74e:	7446                	ld	s0,112(sp)
 750:	74a6                	ld	s1,104(sp)
 752:	7906                	ld	s2,96(sp)
 754:	69e6                	ld	s3,88(sp)
 756:	6a46                	ld	s4,80(sp)
 758:	6aa6                	ld	s5,72(sp)
 75a:	6b06                	ld	s6,64(sp)
 75c:	7be2                	ld	s7,56(sp)
 75e:	7c42                	ld	s8,48(sp)
 760:	7ca2                	ld	s9,40(sp)
 762:	7d02                	ld	s10,32(sp)
 764:	6de2                	ld	s11,24(sp)
 766:	6109                	addi	sp,sp,128
 768:	8082                	ret

000000000000076a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 76a:	715d                	addi	sp,sp,-80
 76c:	ec06                	sd	ra,24(sp)
 76e:	e822                	sd	s0,16(sp)
 770:	1000                	addi	s0,sp,32
 772:	e010                	sd	a2,0(s0)
 774:	e414                	sd	a3,8(s0)
 776:	e818                	sd	a4,16(s0)
 778:	ec1c                	sd	a5,24(s0)
 77a:	03043023          	sd	a6,32(s0)
 77e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 782:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 786:	8622                	mv	a2,s0
 788:	00000097          	auipc	ra,0x0
 78c:	e04080e7          	jalr	-508(ra) # 58c <vprintf>
}
 790:	60e2                	ld	ra,24(sp)
 792:	6442                	ld	s0,16(sp)
 794:	6161                	addi	sp,sp,80
 796:	8082                	ret

0000000000000798 <printf>:

void
printf(const char *fmt, ...)
{
 798:	711d                	addi	sp,sp,-96
 79a:	ec06                	sd	ra,24(sp)
 79c:	e822                	sd	s0,16(sp)
 79e:	1000                	addi	s0,sp,32
 7a0:	e40c                	sd	a1,8(s0)
 7a2:	e810                	sd	a2,16(s0)
 7a4:	ec14                	sd	a3,24(s0)
 7a6:	f018                	sd	a4,32(s0)
 7a8:	f41c                	sd	a5,40(s0)
 7aa:	03043823          	sd	a6,48(s0)
 7ae:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7b2:	00840613          	addi	a2,s0,8
 7b6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7ba:	85aa                	mv	a1,a0
 7bc:	4505                	li	a0,1
 7be:	00000097          	auipc	ra,0x0
 7c2:	dce080e7          	jalr	-562(ra) # 58c <vprintf>
}
 7c6:	60e2                	ld	ra,24(sp)
 7c8:	6442                	ld	s0,16(sp)
 7ca:	6125                	addi	sp,sp,96
 7cc:	8082                	ret

00000000000007ce <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7ce:	1141                	addi	sp,sp,-16
 7d0:	e422                	sd	s0,8(sp)
 7d2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7d4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d8:	00001797          	auipc	a5,0x1
 7dc:	8287b783          	ld	a5,-2008(a5) # 1000 <freep>
 7e0:	a805                	j	810 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7e2:	4618                	lw	a4,8(a2)
 7e4:	9db9                	addw	a1,a1,a4
 7e6:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7ea:	6398                	ld	a4,0(a5)
 7ec:	6318                	ld	a4,0(a4)
 7ee:	fee53823          	sd	a4,-16(a0)
 7f2:	a091                	j	836 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7f4:	ff852703          	lw	a4,-8(a0)
 7f8:	9e39                	addw	a2,a2,a4
 7fa:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7fc:	ff053703          	ld	a4,-16(a0)
 800:	e398                	sd	a4,0(a5)
 802:	a099                	j	848 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 804:	6398                	ld	a4,0(a5)
 806:	00e7e463          	bltu	a5,a4,80e <free+0x40>
 80a:	00e6ea63          	bltu	a3,a4,81e <free+0x50>
{
 80e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 810:	fed7fae3          	bgeu	a5,a3,804 <free+0x36>
 814:	6398                	ld	a4,0(a5)
 816:	00e6e463          	bltu	a3,a4,81e <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81a:	fee7eae3          	bltu	a5,a4,80e <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 81e:	ff852583          	lw	a1,-8(a0)
 822:	6390                	ld	a2,0(a5)
 824:	02059713          	slli	a4,a1,0x20
 828:	9301                	srli	a4,a4,0x20
 82a:	0712                	slli	a4,a4,0x4
 82c:	9736                	add	a4,a4,a3
 82e:	fae60ae3          	beq	a2,a4,7e2 <free+0x14>
    bp->s.ptr = p->s.ptr;
 832:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 836:	4790                	lw	a2,8(a5)
 838:	02061713          	slli	a4,a2,0x20
 83c:	9301                	srli	a4,a4,0x20
 83e:	0712                	slli	a4,a4,0x4
 840:	973e                	add	a4,a4,a5
 842:	fae689e3          	beq	a3,a4,7f4 <free+0x26>
  } else
    p->s.ptr = bp;
 846:	e394                	sd	a3,0(a5)
  freep = p;
 848:	00000717          	auipc	a4,0x0
 84c:	7af73c23          	sd	a5,1976(a4) # 1000 <freep>
}
 850:	6422                	ld	s0,8(sp)
 852:	0141                	addi	sp,sp,16
 854:	8082                	ret

0000000000000856 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 856:	7139                	addi	sp,sp,-64
 858:	fc06                	sd	ra,56(sp)
 85a:	f822                	sd	s0,48(sp)
 85c:	f426                	sd	s1,40(sp)
 85e:	f04a                	sd	s2,32(sp)
 860:	ec4e                	sd	s3,24(sp)
 862:	e852                	sd	s4,16(sp)
 864:	e456                	sd	s5,8(sp)
 866:	e05a                	sd	s6,0(sp)
 868:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 86a:	02051493          	slli	s1,a0,0x20
 86e:	9081                	srli	s1,s1,0x20
 870:	04bd                	addi	s1,s1,15
 872:	8091                	srli	s1,s1,0x4
 874:	0014899b          	addiw	s3,s1,1
 878:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 87a:	00000517          	auipc	a0,0x0
 87e:	78653503          	ld	a0,1926(a0) # 1000 <freep>
 882:	c515                	beqz	a0,8ae <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 884:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 886:	4798                	lw	a4,8(a5)
 888:	02977f63          	bgeu	a4,s1,8c6 <malloc+0x70>
 88c:	8a4e                	mv	s4,s3
 88e:	0009871b          	sext.w	a4,s3
 892:	6685                	lui	a3,0x1
 894:	00d77363          	bgeu	a4,a3,89a <malloc+0x44>
 898:	6a05                	lui	s4,0x1
 89a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 89e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8a2:	00000917          	auipc	s2,0x0
 8a6:	75e90913          	addi	s2,s2,1886 # 1000 <freep>
  if(p == (char*)-1)
 8aa:	5afd                	li	s5,-1
 8ac:	a88d                	j	91e <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 8ae:	00000797          	auipc	a5,0x0
 8b2:	76278793          	addi	a5,a5,1890 # 1010 <base>
 8b6:	00000717          	auipc	a4,0x0
 8ba:	74f73523          	sd	a5,1866(a4) # 1000 <freep>
 8be:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8c0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8c4:	b7e1                	j	88c <malloc+0x36>
      if(p->s.size == nunits)
 8c6:	02e48b63          	beq	s1,a4,8fc <malloc+0xa6>
        p->s.size -= nunits;
 8ca:	4137073b          	subw	a4,a4,s3
 8ce:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8d0:	1702                	slli	a4,a4,0x20
 8d2:	9301                	srli	a4,a4,0x20
 8d4:	0712                	slli	a4,a4,0x4
 8d6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8d8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8dc:	00000717          	auipc	a4,0x0
 8e0:	72a73223          	sd	a0,1828(a4) # 1000 <freep>
      return (void*)(p + 1);
 8e4:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8e8:	70e2                	ld	ra,56(sp)
 8ea:	7442                	ld	s0,48(sp)
 8ec:	74a2                	ld	s1,40(sp)
 8ee:	7902                	ld	s2,32(sp)
 8f0:	69e2                	ld	s3,24(sp)
 8f2:	6a42                	ld	s4,16(sp)
 8f4:	6aa2                	ld	s5,8(sp)
 8f6:	6b02                	ld	s6,0(sp)
 8f8:	6121                	addi	sp,sp,64
 8fa:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8fc:	6398                	ld	a4,0(a5)
 8fe:	e118                	sd	a4,0(a0)
 900:	bff1                	j	8dc <malloc+0x86>
  hp->s.size = nu;
 902:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 906:	0541                	addi	a0,a0,16
 908:	00000097          	auipc	ra,0x0
 90c:	ec6080e7          	jalr	-314(ra) # 7ce <free>
  return freep;
 910:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 914:	d971                	beqz	a0,8e8 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 916:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 918:	4798                	lw	a4,8(a5)
 91a:	fa9776e3          	bgeu	a4,s1,8c6 <malloc+0x70>
    if(p == freep)
 91e:	00093703          	ld	a4,0(s2)
 922:	853e                	mv	a0,a5
 924:	fef719e3          	bne	a4,a5,916 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 928:	8552                	mv	a0,s4
 92a:	00000097          	auipc	ra,0x0
 92e:	b76080e7          	jalr	-1162(ra) # 4a0 <sbrk>
  if(p == (char*)-1)
 932:	fd5518e3          	bne	a0,s5,902 <malloc+0xac>
        return 0;
 936:	4501                	li	a0,0
 938:	bf45                	j	8e8 <malloc+0x92>

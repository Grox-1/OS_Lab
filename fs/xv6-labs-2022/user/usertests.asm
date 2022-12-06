
user/_usertests：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	c04080e7          	jalr	-1020(ra) # 5c14 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	bf2080e7          	jalr	-1038(ra) # 5c14 <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	0e250513          	addi	a0,a0,226 # 6120 <malloc+0x10e>
      46:	00006097          	auipc	ra,0x6
      4a:	f0e080e7          	jalr	-242(ra) # 5f54 <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00006097          	auipc	ra,0x6
      54:	b84080e7          	jalr	-1148(ra) # 5bd4 <exit>

0000000000000058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      58:	0000a797          	auipc	a5,0xa
      5c:	51078793          	addi	a5,a5,1296 # a568 <uninit>
      60:	0000d697          	auipc	a3,0xd
      64:	c1868693          	addi	a3,a3,-1000 # cc78 <buf>
    if(uninit[i] != '\0'){
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      6e:	0785                	addi	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
{
      76:	1141                	addi	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	0c050513          	addi	a0,a0,192 # 6140 <malloc+0x12e>
      88:	00006097          	auipc	ra,0x6
      8c:	ecc080e7          	jalr	-308(ra) # 5f54 <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00006097          	auipc	ra,0x6
      96:	b42080e7          	jalr	-1214(ra) # 5bd4 <exit>

000000000000009a <opentest>:
{
      9a:	1101                	addi	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	addi	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	0b050513          	addi	a0,a0,176 # 6158 <malloc+0x146>
      b0:	00006097          	auipc	ra,0x6
      b4:	b64080e7          	jalr	-1180(ra) # 5c14 <open>
  if(fd < 0){
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00006097          	auipc	ra,0x6
      c0:	b40080e7          	jalr	-1216(ra) # 5bfc <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	0b250513          	addi	a0,a0,178 # 6178 <malloc+0x166>
      ce:	00006097          	auipc	ra,0x6
      d2:	b46080e7          	jalr	-1210(ra) # 5c14 <open>
  if(fd >= 0){
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	addi	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	07a50513          	addi	a0,a0,122 # 6160 <malloc+0x14e>
      ee:	00006097          	auipc	ra,0x6
      f2:	e66080e7          	jalr	-410(ra) # 5f54 <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00006097          	auipc	ra,0x6
      fc:	adc080e7          	jalr	-1316(ra) # 5bd4 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	08650513          	addi	a0,a0,134 # 6188 <malloc+0x176>
     10a:	00006097          	auipc	ra,0x6
     10e:	e4a080e7          	jalr	-438(ra) # 5f54 <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00006097          	auipc	ra,0x6
     118:	ac0080e7          	jalr	-1344(ra) # 5bd4 <exit>

000000000000011c <truncate2>:
{
     11c:	7179                	addi	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	addi	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	08450513          	addi	a0,a0,132 # 61b0 <malloc+0x19e>
     134:	00006097          	auipc	ra,0x6
     138:	af0080e7          	jalr	-1296(ra) # 5c24 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	07050513          	addi	a0,a0,112 # 61b0 <malloc+0x19e>
     148:	00006097          	auipc	ra,0x6
     14c:	acc080e7          	jalr	-1332(ra) # 5c14 <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	06c58593          	addi	a1,a1,108 # 61c0 <malloc+0x1ae>
     15c:	00006097          	auipc	ra,0x6
     160:	a98080e7          	jalr	-1384(ra) # 5bf4 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	04850513          	addi	a0,a0,72 # 61b0 <malloc+0x19e>
     170:	00006097          	auipc	ra,0x6
     174:	aa4080e7          	jalr	-1372(ra) # 5c14 <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	04c58593          	addi	a1,a1,76 # 61c8 <malloc+0x1b6>
     184:	8526                	mv	a0,s1
     186:	00006097          	auipc	ra,0x6
     18a:	a6e080e7          	jalr	-1426(ra) # 5bf4 <write>
  if(n != -1){
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	01c50513          	addi	a0,a0,28 # 61b0 <malloc+0x19e>
     19c:	00006097          	auipc	ra,0x6
     1a0:	a88080e7          	jalr	-1400(ra) # 5c24 <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00006097          	auipc	ra,0x6
     1aa:	a56080e7          	jalr	-1450(ra) # 5bfc <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00006097          	auipc	ra,0x6
     1b4:	a4c080e7          	jalr	-1460(ra) # 5bfc <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	addi	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	00650513          	addi	a0,a0,6 # 61d0 <malloc+0x1be>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	d82080e7          	jalr	-638(ra) # 5f54 <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00006097          	auipc	ra,0x6
     1e0:	9f8080e7          	jalr	-1544(ra) # 5bd4 <exit>

00000000000001e4 <createtest>:
{
     1e4:	7179                	addi	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	addi	a0,s0,-40
     210:	00006097          	auipc	ra,0x6
     214:	a04080e7          	jalr	-1532(ra) # 5c14 <open>
    close(fd);
     218:	00006097          	auipc	ra,0x6
     21c:	9e4080e7          	jalr	-1564(ra) # 5bfc <close>
  for(i = 0; i < N; i++){
     220:	2485                	addiw	s1,s1,1
     222:	0ff4f493          	andi	s1,s1,255
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	addi	a0,s0,-40
     246:	00006097          	auipc	ra,0x6
     24a:	9de080e7          	jalr	-1570(ra) # 5c24 <unlink>
  for(i = 0; i < N; i++){
     24e:	2485                	addiw	s1,s1,1
     250:	0ff4f493          	andi	s1,s1,255
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
{
     264:	715d                	addi	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	addi	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	f7c50513          	addi	a0,a0,-132 # 61f8 <malloc+0x1e6>
     284:	00006097          	auipc	ra,0x6
     288:	9a0080e7          	jalr	-1632(ra) # 5c24 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	f68a8a93          	addi	s5,s5,-152 # 61f8 <malloc+0x1e6>
      int cc = write(fd, buf, sz);
     298:	0000da17          	auipc	s4,0xd
     29c:	9e0a0a13          	addi	s4,s4,-1568 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	addi	s6,s6,457 # 31c9 <fourteen+0x1a1>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00006097          	auipc	ra,0x6
     2b0:	968080e7          	jalr	-1688(ra) # 5c14 <open>
     2b4:	892a                	mv	s2,a0
    if(fd < 0){
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00006097          	auipc	ra,0x6
     2c2:	936080e7          	jalr	-1738(ra) # 5bf4 <write>
     2c6:	89aa                	mv	s3,a0
      if(cc != sz){
     2c8:	06a49463          	bne	s1,a0,330 <bigwrite+0xcc>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00006097          	auipc	ra,0x6
     2d6:	922080e7          	jalr	-1758(ra) # 5bf4 <write>
      if(cc != sz){
     2da:	04951963          	bne	a0,s1,32c <bigwrite+0xc8>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00006097          	auipc	ra,0x6
     2e4:	91c080e7          	jalr	-1764(ra) # 5bfc <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00006097          	auipc	ra,0x6
     2ee:	93a080e7          	jalr	-1734(ra) # 5c24 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f2:	1d74849b          	addiw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	addi	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	ef650513          	addi	a0,a0,-266 # 6208 <malloc+0x1f6>
     31a:	00006097          	auipc	ra,0x6
     31e:	c3a080e7          	jalr	-966(ra) # 5f54 <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00006097          	auipc	ra,0x6
     328:	8b0080e7          	jalr	-1872(ra) # 5bd4 <exit>
     32c:	84ce                	mv	s1,s3
      int cc = write(fd, buf, sz);
     32e:	89aa                	mv	s3,a0
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     330:	86ce                	mv	a3,s3
     332:	8626                	mv	a2,s1
     334:	85de                	mv	a1,s7
     336:	00006517          	auipc	a0,0x6
     33a:	ef250513          	addi	a0,a0,-270 # 6228 <malloc+0x216>
     33e:	00006097          	auipc	ra,0x6
     342:	c16080e7          	jalr	-1002(ra) # 5f54 <printf>
        exit(1);
     346:	4505                	li	a0,1
     348:	00006097          	auipc	ra,0x6
     34c:	88c080e7          	jalr	-1908(ra) # 5bd4 <exit>

0000000000000350 <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     350:	7179                	addi	sp,sp,-48
     352:	f406                	sd	ra,40(sp)
     354:	f022                	sd	s0,32(sp)
     356:	ec26                	sd	s1,24(sp)
     358:	e84a                	sd	s2,16(sp)
     35a:	e44e                	sd	s3,8(sp)
     35c:	e052                	sd	s4,0(sp)
     35e:	1800                	addi	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
     360:	00006517          	auipc	a0,0x6
     364:	ee050513          	addi	a0,a0,-288 # 6240 <malloc+0x22e>
     368:	00006097          	auipc	ra,0x6
     36c:	8bc080e7          	jalr	-1860(ra) # 5c24 <unlink>
     370:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     374:	00006997          	auipc	s3,0x6
     378:	ecc98993          	addi	s3,s3,-308 # 6240 <malloc+0x22e>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     37c:	5a7d                	li	s4,-1
     37e:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     382:	20100593          	li	a1,513
     386:	854e                	mv	a0,s3
     388:	00006097          	auipc	ra,0x6
     38c:	88c080e7          	jalr	-1908(ra) # 5c14 <open>
     390:	84aa                	mv	s1,a0
    if(fd < 0){
     392:	06054b63          	bltz	a0,408 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
     396:	4605                	li	a2,1
     398:	85d2                	mv	a1,s4
     39a:	00006097          	auipc	ra,0x6
     39e:	85a080e7          	jalr	-1958(ra) # 5bf4 <write>
    close(fd);
     3a2:	8526                	mv	a0,s1
     3a4:	00006097          	auipc	ra,0x6
     3a8:	858080e7          	jalr	-1960(ra) # 5bfc <close>
    unlink("junk");
     3ac:	854e                	mv	a0,s3
     3ae:	00006097          	auipc	ra,0x6
     3b2:	876080e7          	jalr	-1930(ra) # 5c24 <unlink>
  for(int i = 0; i < assumed_free; i++){
     3b6:	397d                	addiw	s2,s2,-1
     3b8:	fc0915e3          	bnez	s2,382 <badwrite+0x32>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     3bc:	20100593          	li	a1,513
     3c0:	00006517          	auipc	a0,0x6
     3c4:	e8050513          	addi	a0,a0,-384 # 6240 <malloc+0x22e>
     3c8:	00006097          	auipc	ra,0x6
     3cc:	84c080e7          	jalr	-1972(ra) # 5c14 <open>
     3d0:	84aa                	mv	s1,a0
  if(fd < 0){
     3d2:	04054863          	bltz	a0,422 <badwrite+0xd2>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     3d6:	4605                	li	a2,1
     3d8:	00006597          	auipc	a1,0x6
     3dc:	df058593          	addi	a1,a1,-528 # 61c8 <malloc+0x1b6>
     3e0:	00006097          	auipc	ra,0x6
     3e4:	814080e7          	jalr	-2028(ra) # 5bf4 <write>
     3e8:	4785                	li	a5,1
     3ea:	04f50963          	beq	a0,a5,43c <badwrite+0xec>
    printf("write failed\n");
     3ee:	00006517          	auipc	a0,0x6
     3f2:	e7250513          	addi	a0,a0,-398 # 6260 <malloc+0x24e>
     3f6:	00006097          	auipc	ra,0x6
     3fa:	b5e080e7          	jalr	-1186(ra) # 5f54 <printf>
    exit(1);
     3fe:	4505                	li	a0,1
     400:	00005097          	auipc	ra,0x5
     404:	7d4080e7          	jalr	2004(ra) # 5bd4 <exit>
      printf("open junk failed\n");
     408:	00006517          	auipc	a0,0x6
     40c:	e4050513          	addi	a0,a0,-448 # 6248 <malloc+0x236>
     410:	00006097          	auipc	ra,0x6
     414:	b44080e7          	jalr	-1212(ra) # 5f54 <printf>
      exit(1);
     418:	4505                	li	a0,1
     41a:	00005097          	auipc	ra,0x5
     41e:	7ba080e7          	jalr	1978(ra) # 5bd4 <exit>
    printf("open junk failed\n");
     422:	00006517          	auipc	a0,0x6
     426:	e2650513          	addi	a0,a0,-474 # 6248 <malloc+0x236>
     42a:	00006097          	auipc	ra,0x6
     42e:	b2a080e7          	jalr	-1238(ra) # 5f54 <printf>
    exit(1);
     432:	4505                	li	a0,1
     434:	00005097          	auipc	ra,0x5
     438:	7a0080e7          	jalr	1952(ra) # 5bd4 <exit>
  }
  close(fd);
     43c:	8526                	mv	a0,s1
     43e:	00005097          	auipc	ra,0x5
     442:	7be080e7          	jalr	1982(ra) # 5bfc <close>
  unlink("junk");
     446:	00006517          	auipc	a0,0x6
     44a:	dfa50513          	addi	a0,a0,-518 # 6240 <malloc+0x22e>
     44e:	00005097          	auipc	ra,0x5
     452:	7d6080e7          	jalr	2006(ra) # 5c24 <unlink>

  exit(0);
     456:	4501                	li	a0,0
     458:	00005097          	auipc	ra,0x5
     45c:	77c080e7          	jalr	1916(ra) # 5bd4 <exit>

0000000000000460 <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     460:	715d                	addi	sp,sp,-80
     462:	e486                	sd	ra,72(sp)
     464:	e0a2                	sd	s0,64(sp)
     466:	fc26                	sd	s1,56(sp)
     468:	f84a                	sd	s2,48(sp)
     46a:	f44e                	sd	s3,40(sp)
     46c:	0880                	addi	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     46e:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     470:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     474:	40000993          	li	s3,1024
    name[0] = 'z';
     478:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     47c:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     480:	41f4d79b          	sraiw	a5,s1,0x1f
     484:	01b7d71b          	srliw	a4,a5,0x1b
     488:	009707bb          	addw	a5,a4,s1
     48c:	4057d69b          	sraiw	a3,a5,0x5
     490:	0306869b          	addiw	a3,a3,48
     494:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     498:	8bfd                	andi	a5,a5,31
     49a:	9f99                	subw	a5,a5,a4
     49c:	0307879b          	addiw	a5,a5,48
     4a0:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     4a4:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     4a8:	fb040513          	addi	a0,s0,-80
     4ac:	00005097          	auipc	ra,0x5
     4b0:	778080e7          	jalr	1912(ra) # 5c24 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     4b4:	60200593          	li	a1,1538
     4b8:	fb040513          	addi	a0,s0,-80
     4bc:	00005097          	auipc	ra,0x5
     4c0:	758080e7          	jalr	1880(ra) # 5c14 <open>
    if(fd < 0){
     4c4:	00054963          	bltz	a0,4d6 <outofinodes+0x76>
      // failure is eventually expected.
      break;
    }
    close(fd);
     4c8:	00005097          	auipc	ra,0x5
     4cc:	734080e7          	jalr	1844(ra) # 5bfc <close>
  for(int i = 0; i < nzz; i++){
     4d0:	2485                	addiw	s1,s1,1
     4d2:	fb3493e3          	bne	s1,s3,478 <outofinodes+0x18>
     4d6:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     4d8:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     4dc:	40000993          	li	s3,1024
    name[0] = 'z';
     4e0:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     4e4:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     4e8:	41f4d79b          	sraiw	a5,s1,0x1f
     4ec:	01b7d71b          	srliw	a4,a5,0x1b
     4f0:	009707bb          	addw	a5,a4,s1
     4f4:	4057d69b          	sraiw	a3,a5,0x5
     4f8:	0306869b          	addiw	a3,a3,48
     4fc:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     500:	8bfd                	andi	a5,a5,31
     502:	9f99                	subw	a5,a5,a4
     504:	0307879b          	addiw	a5,a5,48
     508:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     50c:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     510:	fb040513          	addi	a0,s0,-80
     514:	00005097          	auipc	ra,0x5
     518:	710080e7          	jalr	1808(ra) # 5c24 <unlink>
  for(int i = 0; i < nzz; i++){
     51c:	2485                	addiw	s1,s1,1
     51e:	fd3491e3          	bne	s1,s3,4e0 <outofinodes+0x80>
  }
}
     522:	60a6                	ld	ra,72(sp)
     524:	6406                	ld	s0,64(sp)
     526:	74e2                	ld	s1,56(sp)
     528:	7942                	ld	s2,48(sp)
     52a:	79a2                	ld	s3,40(sp)
     52c:	6161                	addi	sp,sp,80
     52e:	8082                	ret

0000000000000530 <copyin>:
{
     530:	715d                	addi	sp,sp,-80
     532:	e486                	sd	ra,72(sp)
     534:	e0a2                	sd	s0,64(sp)
     536:	fc26                	sd	s1,56(sp)
     538:	f84a                	sd	s2,48(sp)
     53a:	f44e                	sd	s3,40(sp)
     53c:	f052                	sd	s4,32(sp)
     53e:	0880                	addi	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     540:	4785                	li	a5,1
     542:	07fe                	slli	a5,a5,0x1f
     544:	fcf43023          	sd	a5,-64(s0)
     548:	57fd                	li	a5,-1
     54a:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     54e:	fc040913          	addi	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     552:	00006a17          	auipc	s4,0x6
     556:	d1ea0a13          	addi	s4,s4,-738 # 6270 <malloc+0x25e>
    uint64 addr = addrs[ai];
     55a:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     55e:	20100593          	li	a1,513
     562:	8552                	mv	a0,s4
     564:	00005097          	auipc	ra,0x5
     568:	6b0080e7          	jalr	1712(ra) # 5c14 <open>
     56c:	84aa                	mv	s1,a0
    if(fd < 0){
     56e:	08054863          	bltz	a0,5fe <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     572:	6609                	lui	a2,0x2
     574:	85ce                	mv	a1,s3
     576:	00005097          	auipc	ra,0x5
     57a:	67e080e7          	jalr	1662(ra) # 5bf4 <write>
    if(n >= 0){
     57e:	08055d63          	bgez	a0,618 <copyin+0xe8>
    close(fd);
     582:	8526                	mv	a0,s1
     584:	00005097          	auipc	ra,0x5
     588:	678080e7          	jalr	1656(ra) # 5bfc <close>
    unlink("copyin1");
     58c:	8552                	mv	a0,s4
     58e:	00005097          	auipc	ra,0x5
     592:	696080e7          	jalr	1686(ra) # 5c24 <unlink>
    n = write(1, (char*)addr, 8192);
     596:	6609                	lui	a2,0x2
     598:	85ce                	mv	a1,s3
     59a:	4505                	li	a0,1
     59c:	00005097          	auipc	ra,0x5
     5a0:	658080e7          	jalr	1624(ra) # 5bf4 <write>
    if(n > 0){
     5a4:	08a04963          	bgtz	a0,636 <copyin+0x106>
    if(pipe(fds) < 0){
     5a8:	fb840513          	addi	a0,s0,-72
     5ac:	00005097          	auipc	ra,0x5
     5b0:	638080e7          	jalr	1592(ra) # 5be4 <pipe>
     5b4:	0a054063          	bltz	a0,654 <copyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
     5b8:	6609                	lui	a2,0x2
     5ba:	85ce                	mv	a1,s3
     5bc:	fbc42503          	lw	a0,-68(s0)
     5c0:	00005097          	auipc	ra,0x5
     5c4:	634080e7          	jalr	1588(ra) # 5bf4 <write>
    if(n > 0){
     5c8:	0aa04363          	bgtz	a0,66e <copyin+0x13e>
    close(fds[0]);
     5cc:	fb842503          	lw	a0,-72(s0)
     5d0:	00005097          	auipc	ra,0x5
     5d4:	62c080e7          	jalr	1580(ra) # 5bfc <close>
    close(fds[1]);
     5d8:	fbc42503          	lw	a0,-68(s0)
     5dc:	00005097          	auipc	ra,0x5
     5e0:	620080e7          	jalr	1568(ra) # 5bfc <close>
  for(int ai = 0; ai < 2; ai++){
     5e4:	0921                	addi	s2,s2,8
     5e6:	fd040793          	addi	a5,s0,-48
     5ea:	f6f918e3          	bne	s2,a5,55a <copyin+0x2a>
}
     5ee:	60a6                	ld	ra,72(sp)
     5f0:	6406                	ld	s0,64(sp)
     5f2:	74e2                	ld	s1,56(sp)
     5f4:	7942                	ld	s2,48(sp)
     5f6:	79a2                	ld	s3,40(sp)
     5f8:	7a02                	ld	s4,32(sp)
     5fa:	6161                	addi	sp,sp,80
     5fc:	8082                	ret
      printf("open(copyin1) failed\n");
     5fe:	00006517          	auipc	a0,0x6
     602:	c7a50513          	addi	a0,a0,-902 # 6278 <malloc+0x266>
     606:	00006097          	auipc	ra,0x6
     60a:	94e080e7          	jalr	-1714(ra) # 5f54 <printf>
      exit(1);
     60e:	4505                	li	a0,1
     610:	00005097          	auipc	ra,0x5
     614:	5c4080e7          	jalr	1476(ra) # 5bd4 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     618:	862a                	mv	a2,a0
     61a:	85ce                	mv	a1,s3
     61c:	00006517          	auipc	a0,0x6
     620:	c7450513          	addi	a0,a0,-908 # 6290 <malloc+0x27e>
     624:	00006097          	auipc	ra,0x6
     628:	930080e7          	jalr	-1744(ra) # 5f54 <printf>
      exit(1);
     62c:	4505                	li	a0,1
     62e:	00005097          	auipc	ra,0x5
     632:	5a6080e7          	jalr	1446(ra) # 5bd4 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     636:	862a                	mv	a2,a0
     638:	85ce                	mv	a1,s3
     63a:	00006517          	auipc	a0,0x6
     63e:	c8650513          	addi	a0,a0,-890 # 62c0 <malloc+0x2ae>
     642:	00006097          	auipc	ra,0x6
     646:	912080e7          	jalr	-1774(ra) # 5f54 <printf>
      exit(1);
     64a:	4505                	li	a0,1
     64c:	00005097          	auipc	ra,0x5
     650:	588080e7          	jalr	1416(ra) # 5bd4 <exit>
      printf("pipe() failed\n");
     654:	00006517          	auipc	a0,0x6
     658:	c9c50513          	addi	a0,a0,-868 # 62f0 <malloc+0x2de>
     65c:	00006097          	auipc	ra,0x6
     660:	8f8080e7          	jalr	-1800(ra) # 5f54 <printf>
      exit(1);
     664:	4505                	li	a0,1
     666:	00005097          	auipc	ra,0x5
     66a:	56e080e7          	jalr	1390(ra) # 5bd4 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     66e:	862a                	mv	a2,a0
     670:	85ce                	mv	a1,s3
     672:	00006517          	auipc	a0,0x6
     676:	c8e50513          	addi	a0,a0,-882 # 6300 <malloc+0x2ee>
     67a:	00006097          	auipc	ra,0x6
     67e:	8da080e7          	jalr	-1830(ra) # 5f54 <printf>
      exit(1);
     682:	4505                	li	a0,1
     684:	00005097          	auipc	ra,0x5
     688:	550080e7          	jalr	1360(ra) # 5bd4 <exit>

000000000000068c <copyout>:
{
     68c:	711d                	addi	sp,sp,-96
     68e:	ec86                	sd	ra,88(sp)
     690:	e8a2                	sd	s0,80(sp)
     692:	e4a6                	sd	s1,72(sp)
     694:	e0ca                	sd	s2,64(sp)
     696:	fc4e                	sd	s3,56(sp)
     698:	f852                	sd	s4,48(sp)
     69a:	f456                	sd	s5,40(sp)
     69c:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     69e:	4785                	li	a5,1
     6a0:	07fe                	slli	a5,a5,0x1f
     6a2:	faf43823          	sd	a5,-80(s0)
     6a6:	57fd                	li	a5,-1
     6a8:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     6ac:	fb040913          	addi	s2,s0,-80
    int fd = open("README", 0);
     6b0:	00006a17          	auipc	s4,0x6
     6b4:	c80a0a13          	addi	s4,s4,-896 # 6330 <malloc+0x31e>
    n = write(fds[1], "x", 1);
     6b8:	00006a97          	auipc	s5,0x6
     6bc:	b10a8a93          	addi	s5,s5,-1264 # 61c8 <malloc+0x1b6>
    uint64 addr = addrs[ai];
     6c0:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     6c4:	4581                	li	a1,0
     6c6:	8552                	mv	a0,s4
     6c8:	00005097          	auipc	ra,0x5
     6cc:	54c080e7          	jalr	1356(ra) # 5c14 <open>
     6d0:	84aa                	mv	s1,a0
    if(fd < 0){
     6d2:	08054663          	bltz	a0,75e <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     6d6:	6609                	lui	a2,0x2
     6d8:	85ce                	mv	a1,s3
     6da:	00005097          	auipc	ra,0x5
     6de:	512080e7          	jalr	1298(ra) # 5bec <read>
    if(n > 0){
     6e2:	08a04b63          	bgtz	a0,778 <copyout+0xec>
    close(fd);
     6e6:	8526                	mv	a0,s1
     6e8:	00005097          	auipc	ra,0x5
     6ec:	514080e7          	jalr	1300(ra) # 5bfc <close>
    if(pipe(fds) < 0){
     6f0:	fa840513          	addi	a0,s0,-88
     6f4:	00005097          	auipc	ra,0x5
     6f8:	4f0080e7          	jalr	1264(ra) # 5be4 <pipe>
     6fc:	08054d63          	bltz	a0,796 <copyout+0x10a>
    n = write(fds[1], "x", 1);
     700:	4605                	li	a2,1
     702:	85d6                	mv	a1,s5
     704:	fac42503          	lw	a0,-84(s0)
     708:	00005097          	auipc	ra,0x5
     70c:	4ec080e7          	jalr	1260(ra) # 5bf4 <write>
    if(n != 1){
     710:	4785                	li	a5,1
     712:	08f51f63          	bne	a0,a5,7b0 <copyout+0x124>
    n = read(fds[0], (void*)addr, 8192);
     716:	6609                	lui	a2,0x2
     718:	85ce                	mv	a1,s3
     71a:	fa842503          	lw	a0,-88(s0)
     71e:	00005097          	auipc	ra,0x5
     722:	4ce080e7          	jalr	1230(ra) # 5bec <read>
    if(n > 0){
     726:	0aa04263          	bgtz	a0,7ca <copyout+0x13e>
    close(fds[0]);
     72a:	fa842503          	lw	a0,-88(s0)
     72e:	00005097          	auipc	ra,0x5
     732:	4ce080e7          	jalr	1230(ra) # 5bfc <close>
    close(fds[1]);
     736:	fac42503          	lw	a0,-84(s0)
     73a:	00005097          	auipc	ra,0x5
     73e:	4c2080e7          	jalr	1218(ra) # 5bfc <close>
  for(int ai = 0; ai < 2; ai++){
     742:	0921                	addi	s2,s2,8
     744:	fc040793          	addi	a5,s0,-64
     748:	f6f91ce3          	bne	s2,a5,6c0 <copyout+0x34>
}
     74c:	60e6                	ld	ra,88(sp)
     74e:	6446                	ld	s0,80(sp)
     750:	64a6                	ld	s1,72(sp)
     752:	6906                	ld	s2,64(sp)
     754:	79e2                	ld	s3,56(sp)
     756:	7a42                	ld	s4,48(sp)
     758:	7aa2                	ld	s5,40(sp)
     75a:	6125                	addi	sp,sp,96
     75c:	8082                	ret
      printf("open(README) failed\n");
     75e:	00006517          	auipc	a0,0x6
     762:	bda50513          	addi	a0,a0,-1062 # 6338 <malloc+0x326>
     766:	00005097          	auipc	ra,0x5
     76a:	7ee080e7          	jalr	2030(ra) # 5f54 <printf>
      exit(1);
     76e:	4505                	li	a0,1
     770:	00005097          	auipc	ra,0x5
     774:	464080e7          	jalr	1124(ra) # 5bd4 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     778:	862a                	mv	a2,a0
     77a:	85ce                	mv	a1,s3
     77c:	00006517          	auipc	a0,0x6
     780:	bd450513          	addi	a0,a0,-1068 # 6350 <malloc+0x33e>
     784:	00005097          	auipc	ra,0x5
     788:	7d0080e7          	jalr	2000(ra) # 5f54 <printf>
      exit(1);
     78c:	4505                	li	a0,1
     78e:	00005097          	auipc	ra,0x5
     792:	446080e7          	jalr	1094(ra) # 5bd4 <exit>
      printf("pipe() failed\n");
     796:	00006517          	auipc	a0,0x6
     79a:	b5a50513          	addi	a0,a0,-1190 # 62f0 <malloc+0x2de>
     79e:	00005097          	auipc	ra,0x5
     7a2:	7b6080e7          	jalr	1974(ra) # 5f54 <printf>
      exit(1);
     7a6:	4505                	li	a0,1
     7a8:	00005097          	auipc	ra,0x5
     7ac:	42c080e7          	jalr	1068(ra) # 5bd4 <exit>
      printf("pipe write failed\n");
     7b0:	00006517          	auipc	a0,0x6
     7b4:	bd050513          	addi	a0,a0,-1072 # 6380 <malloc+0x36e>
     7b8:	00005097          	auipc	ra,0x5
     7bc:	79c080e7          	jalr	1948(ra) # 5f54 <printf>
      exit(1);
     7c0:	4505                	li	a0,1
     7c2:	00005097          	auipc	ra,0x5
     7c6:	412080e7          	jalr	1042(ra) # 5bd4 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     7ca:	862a                	mv	a2,a0
     7cc:	85ce                	mv	a1,s3
     7ce:	00006517          	auipc	a0,0x6
     7d2:	bca50513          	addi	a0,a0,-1078 # 6398 <malloc+0x386>
     7d6:	00005097          	auipc	ra,0x5
     7da:	77e080e7          	jalr	1918(ra) # 5f54 <printf>
      exit(1);
     7de:	4505                	li	a0,1
     7e0:	00005097          	auipc	ra,0x5
     7e4:	3f4080e7          	jalr	1012(ra) # 5bd4 <exit>

00000000000007e8 <truncate1>:
{
     7e8:	711d                	addi	sp,sp,-96
     7ea:	ec86                	sd	ra,88(sp)
     7ec:	e8a2                	sd	s0,80(sp)
     7ee:	e4a6                	sd	s1,72(sp)
     7f0:	e0ca                	sd	s2,64(sp)
     7f2:	fc4e                	sd	s3,56(sp)
     7f4:	f852                	sd	s4,48(sp)
     7f6:	f456                	sd	s5,40(sp)
     7f8:	1080                	addi	s0,sp,96
     7fa:	8aaa                	mv	s5,a0
  unlink("truncfile");
     7fc:	00006517          	auipc	a0,0x6
     800:	9b450513          	addi	a0,a0,-1612 # 61b0 <malloc+0x19e>
     804:	00005097          	auipc	ra,0x5
     808:	420080e7          	jalr	1056(ra) # 5c24 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     80c:	60100593          	li	a1,1537
     810:	00006517          	auipc	a0,0x6
     814:	9a050513          	addi	a0,a0,-1632 # 61b0 <malloc+0x19e>
     818:	00005097          	auipc	ra,0x5
     81c:	3fc080e7          	jalr	1020(ra) # 5c14 <open>
     820:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     822:	4611                	li	a2,4
     824:	00006597          	auipc	a1,0x6
     828:	99c58593          	addi	a1,a1,-1636 # 61c0 <malloc+0x1ae>
     82c:	00005097          	auipc	ra,0x5
     830:	3c8080e7          	jalr	968(ra) # 5bf4 <write>
  close(fd1);
     834:	8526                	mv	a0,s1
     836:	00005097          	auipc	ra,0x5
     83a:	3c6080e7          	jalr	966(ra) # 5bfc <close>
  int fd2 = open("truncfile", O_RDONLY);
     83e:	4581                	li	a1,0
     840:	00006517          	auipc	a0,0x6
     844:	97050513          	addi	a0,a0,-1680 # 61b0 <malloc+0x19e>
     848:	00005097          	auipc	ra,0x5
     84c:	3cc080e7          	jalr	972(ra) # 5c14 <open>
     850:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     852:	02000613          	li	a2,32
     856:	fa040593          	addi	a1,s0,-96
     85a:	00005097          	auipc	ra,0x5
     85e:	392080e7          	jalr	914(ra) # 5bec <read>
  if(n != 4){
     862:	4791                	li	a5,4
     864:	0cf51e63          	bne	a0,a5,940 <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     868:	40100593          	li	a1,1025
     86c:	00006517          	auipc	a0,0x6
     870:	94450513          	addi	a0,a0,-1724 # 61b0 <malloc+0x19e>
     874:	00005097          	auipc	ra,0x5
     878:	3a0080e7          	jalr	928(ra) # 5c14 <open>
     87c:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     87e:	4581                	li	a1,0
     880:	00006517          	auipc	a0,0x6
     884:	93050513          	addi	a0,a0,-1744 # 61b0 <malloc+0x19e>
     888:	00005097          	auipc	ra,0x5
     88c:	38c080e7          	jalr	908(ra) # 5c14 <open>
     890:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     892:	02000613          	li	a2,32
     896:	fa040593          	addi	a1,s0,-96
     89a:	00005097          	auipc	ra,0x5
     89e:	352080e7          	jalr	850(ra) # 5bec <read>
     8a2:	8a2a                	mv	s4,a0
  if(n != 0){
     8a4:	ed4d                	bnez	a0,95e <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     8a6:	02000613          	li	a2,32
     8aa:	fa040593          	addi	a1,s0,-96
     8ae:	8526                	mv	a0,s1
     8b0:	00005097          	auipc	ra,0x5
     8b4:	33c080e7          	jalr	828(ra) # 5bec <read>
     8b8:	8a2a                	mv	s4,a0
  if(n != 0){
     8ba:	e971                	bnez	a0,98e <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     8bc:	4619                	li	a2,6
     8be:	00006597          	auipc	a1,0x6
     8c2:	b6a58593          	addi	a1,a1,-1174 # 6428 <malloc+0x416>
     8c6:	854e                	mv	a0,s3
     8c8:	00005097          	auipc	ra,0x5
     8cc:	32c080e7          	jalr	812(ra) # 5bf4 <write>
  n = read(fd3, buf, sizeof(buf));
     8d0:	02000613          	li	a2,32
     8d4:	fa040593          	addi	a1,s0,-96
     8d8:	854a                	mv	a0,s2
     8da:	00005097          	auipc	ra,0x5
     8de:	312080e7          	jalr	786(ra) # 5bec <read>
  if(n != 6){
     8e2:	4799                	li	a5,6
     8e4:	0cf51d63          	bne	a0,a5,9be <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     8e8:	02000613          	li	a2,32
     8ec:	fa040593          	addi	a1,s0,-96
     8f0:	8526                	mv	a0,s1
     8f2:	00005097          	auipc	ra,0x5
     8f6:	2fa080e7          	jalr	762(ra) # 5bec <read>
  if(n != 2){
     8fa:	4789                	li	a5,2
     8fc:	0ef51063          	bne	a0,a5,9dc <truncate1+0x1f4>
  unlink("truncfile");
     900:	00006517          	auipc	a0,0x6
     904:	8b050513          	addi	a0,a0,-1872 # 61b0 <malloc+0x19e>
     908:	00005097          	auipc	ra,0x5
     90c:	31c080e7          	jalr	796(ra) # 5c24 <unlink>
  close(fd1);
     910:	854e                	mv	a0,s3
     912:	00005097          	auipc	ra,0x5
     916:	2ea080e7          	jalr	746(ra) # 5bfc <close>
  close(fd2);
     91a:	8526                	mv	a0,s1
     91c:	00005097          	auipc	ra,0x5
     920:	2e0080e7          	jalr	736(ra) # 5bfc <close>
  close(fd3);
     924:	854a                	mv	a0,s2
     926:	00005097          	auipc	ra,0x5
     92a:	2d6080e7          	jalr	726(ra) # 5bfc <close>
}
     92e:	60e6                	ld	ra,88(sp)
     930:	6446                	ld	s0,80(sp)
     932:	64a6                	ld	s1,72(sp)
     934:	6906                	ld	s2,64(sp)
     936:	79e2                	ld	s3,56(sp)
     938:	7a42                	ld	s4,48(sp)
     93a:	7aa2                	ld	s5,40(sp)
     93c:	6125                	addi	sp,sp,96
     93e:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     940:	862a                	mv	a2,a0
     942:	85d6                	mv	a1,s5
     944:	00006517          	auipc	a0,0x6
     948:	a8450513          	addi	a0,a0,-1404 # 63c8 <malloc+0x3b6>
     94c:	00005097          	auipc	ra,0x5
     950:	608080e7          	jalr	1544(ra) # 5f54 <printf>
    exit(1);
     954:	4505                	li	a0,1
     956:	00005097          	auipc	ra,0x5
     95a:	27e080e7          	jalr	638(ra) # 5bd4 <exit>
    printf("aaa fd3=%d\n", fd3);
     95e:	85ca                	mv	a1,s2
     960:	00006517          	auipc	a0,0x6
     964:	a8850513          	addi	a0,a0,-1400 # 63e8 <malloc+0x3d6>
     968:	00005097          	auipc	ra,0x5
     96c:	5ec080e7          	jalr	1516(ra) # 5f54 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     970:	8652                	mv	a2,s4
     972:	85d6                	mv	a1,s5
     974:	00006517          	auipc	a0,0x6
     978:	a8450513          	addi	a0,a0,-1404 # 63f8 <malloc+0x3e6>
     97c:	00005097          	auipc	ra,0x5
     980:	5d8080e7          	jalr	1496(ra) # 5f54 <printf>
    exit(1);
     984:	4505                	li	a0,1
     986:	00005097          	auipc	ra,0x5
     98a:	24e080e7          	jalr	590(ra) # 5bd4 <exit>
    printf("bbb fd2=%d\n", fd2);
     98e:	85a6                	mv	a1,s1
     990:	00006517          	auipc	a0,0x6
     994:	a8850513          	addi	a0,a0,-1400 # 6418 <malloc+0x406>
     998:	00005097          	auipc	ra,0x5
     99c:	5bc080e7          	jalr	1468(ra) # 5f54 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     9a0:	8652                	mv	a2,s4
     9a2:	85d6                	mv	a1,s5
     9a4:	00006517          	auipc	a0,0x6
     9a8:	a5450513          	addi	a0,a0,-1452 # 63f8 <malloc+0x3e6>
     9ac:	00005097          	auipc	ra,0x5
     9b0:	5a8080e7          	jalr	1448(ra) # 5f54 <printf>
    exit(1);
     9b4:	4505                	li	a0,1
     9b6:	00005097          	auipc	ra,0x5
     9ba:	21e080e7          	jalr	542(ra) # 5bd4 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     9be:	862a                	mv	a2,a0
     9c0:	85d6                	mv	a1,s5
     9c2:	00006517          	auipc	a0,0x6
     9c6:	a6e50513          	addi	a0,a0,-1426 # 6430 <malloc+0x41e>
     9ca:	00005097          	auipc	ra,0x5
     9ce:	58a080e7          	jalr	1418(ra) # 5f54 <printf>
    exit(1);
     9d2:	4505                	li	a0,1
     9d4:	00005097          	auipc	ra,0x5
     9d8:	200080e7          	jalr	512(ra) # 5bd4 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     9dc:	862a                	mv	a2,a0
     9de:	85d6                	mv	a1,s5
     9e0:	00006517          	auipc	a0,0x6
     9e4:	a7050513          	addi	a0,a0,-1424 # 6450 <malloc+0x43e>
     9e8:	00005097          	auipc	ra,0x5
     9ec:	56c080e7          	jalr	1388(ra) # 5f54 <printf>
    exit(1);
     9f0:	4505                	li	a0,1
     9f2:	00005097          	auipc	ra,0x5
     9f6:	1e2080e7          	jalr	482(ra) # 5bd4 <exit>

00000000000009fa <writetest>:
{
     9fa:	7139                	addi	sp,sp,-64
     9fc:	fc06                	sd	ra,56(sp)
     9fe:	f822                	sd	s0,48(sp)
     a00:	f426                	sd	s1,40(sp)
     a02:	f04a                	sd	s2,32(sp)
     a04:	ec4e                	sd	s3,24(sp)
     a06:	e852                	sd	s4,16(sp)
     a08:	e456                	sd	s5,8(sp)
     a0a:	e05a                	sd	s6,0(sp)
     a0c:	0080                	addi	s0,sp,64
     a0e:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     a10:	20200593          	li	a1,514
     a14:	00006517          	auipc	a0,0x6
     a18:	a5c50513          	addi	a0,a0,-1444 # 6470 <malloc+0x45e>
     a1c:	00005097          	auipc	ra,0x5
     a20:	1f8080e7          	jalr	504(ra) # 5c14 <open>
  if(fd < 0){
     a24:	0a054d63          	bltz	a0,ade <writetest+0xe4>
     a28:	892a                	mv	s2,a0
     a2a:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a2c:	00006997          	auipc	s3,0x6
     a30:	a6c98993          	addi	s3,s3,-1428 # 6498 <malloc+0x486>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a34:	00006a97          	auipc	s5,0x6
     a38:	a9ca8a93          	addi	s5,s5,-1380 # 64d0 <malloc+0x4be>
  for(i = 0; i < N; i++){
     a3c:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a40:	4629                	li	a2,10
     a42:	85ce                	mv	a1,s3
     a44:	854a                	mv	a0,s2
     a46:	00005097          	auipc	ra,0x5
     a4a:	1ae080e7          	jalr	430(ra) # 5bf4 <write>
     a4e:	47a9                	li	a5,10
     a50:	0af51563          	bne	a0,a5,afa <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a54:	4629                	li	a2,10
     a56:	85d6                	mv	a1,s5
     a58:	854a                	mv	a0,s2
     a5a:	00005097          	auipc	ra,0x5
     a5e:	19a080e7          	jalr	410(ra) # 5bf4 <write>
     a62:	47a9                	li	a5,10
     a64:	0af51a63          	bne	a0,a5,b18 <writetest+0x11e>
  for(i = 0; i < N; i++){
     a68:	2485                	addiw	s1,s1,1
     a6a:	fd449be3          	bne	s1,s4,a40 <writetest+0x46>
  close(fd);
     a6e:	854a                	mv	a0,s2
     a70:	00005097          	auipc	ra,0x5
     a74:	18c080e7          	jalr	396(ra) # 5bfc <close>
  fd = open("small", O_RDONLY);
     a78:	4581                	li	a1,0
     a7a:	00006517          	auipc	a0,0x6
     a7e:	9f650513          	addi	a0,a0,-1546 # 6470 <malloc+0x45e>
     a82:	00005097          	auipc	ra,0x5
     a86:	192080e7          	jalr	402(ra) # 5c14 <open>
     a8a:	84aa                	mv	s1,a0
  if(fd < 0){
     a8c:	0a054563          	bltz	a0,b36 <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     a90:	7d000613          	li	a2,2000
     a94:	0000c597          	auipc	a1,0xc
     a98:	1e458593          	addi	a1,a1,484 # cc78 <buf>
     a9c:	00005097          	auipc	ra,0x5
     aa0:	150080e7          	jalr	336(ra) # 5bec <read>
  if(i != N*SZ*2){
     aa4:	7d000793          	li	a5,2000
     aa8:	0af51563          	bne	a0,a5,b52 <writetest+0x158>
  close(fd);
     aac:	8526                	mv	a0,s1
     aae:	00005097          	auipc	ra,0x5
     ab2:	14e080e7          	jalr	334(ra) # 5bfc <close>
  if(unlink("small") < 0){
     ab6:	00006517          	auipc	a0,0x6
     aba:	9ba50513          	addi	a0,a0,-1606 # 6470 <malloc+0x45e>
     abe:	00005097          	auipc	ra,0x5
     ac2:	166080e7          	jalr	358(ra) # 5c24 <unlink>
     ac6:	0a054463          	bltz	a0,b6e <writetest+0x174>
}
     aca:	70e2                	ld	ra,56(sp)
     acc:	7442                	ld	s0,48(sp)
     ace:	74a2                	ld	s1,40(sp)
     ad0:	7902                	ld	s2,32(sp)
     ad2:	69e2                	ld	s3,24(sp)
     ad4:	6a42                	ld	s4,16(sp)
     ad6:	6aa2                	ld	s5,8(sp)
     ad8:	6b02                	ld	s6,0(sp)
     ada:	6121                	addi	sp,sp,64
     adc:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     ade:	85da                	mv	a1,s6
     ae0:	00006517          	auipc	a0,0x6
     ae4:	99850513          	addi	a0,a0,-1640 # 6478 <malloc+0x466>
     ae8:	00005097          	auipc	ra,0x5
     aec:	46c080e7          	jalr	1132(ra) # 5f54 <printf>
    exit(1);
     af0:	4505                	li	a0,1
     af2:	00005097          	auipc	ra,0x5
     af6:	0e2080e7          	jalr	226(ra) # 5bd4 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     afa:	8626                	mv	a2,s1
     afc:	85da                	mv	a1,s6
     afe:	00006517          	auipc	a0,0x6
     b02:	9aa50513          	addi	a0,a0,-1622 # 64a8 <malloc+0x496>
     b06:	00005097          	auipc	ra,0x5
     b0a:	44e080e7          	jalr	1102(ra) # 5f54 <printf>
      exit(1);
     b0e:	4505                	li	a0,1
     b10:	00005097          	auipc	ra,0x5
     b14:	0c4080e7          	jalr	196(ra) # 5bd4 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     b18:	8626                	mv	a2,s1
     b1a:	85da                	mv	a1,s6
     b1c:	00006517          	auipc	a0,0x6
     b20:	9c450513          	addi	a0,a0,-1596 # 64e0 <malloc+0x4ce>
     b24:	00005097          	auipc	ra,0x5
     b28:	430080e7          	jalr	1072(ra) # 5f54 <printf>
      exit(1);
     b2c:	4505                	li	a0,1
     b2e:	00005097          	auipc	ra,0x5
     b32:	0a6080e7          	jalr	166(ra) # 5bd4 <exit>
    printf("%s: error: open small failed!\n", s);
     b36:	85da                	mv	a1,s6
     b38:	00006517          	auipc	a0,0x6
     b3c:	9d050513          	addi	a0,a0,-1584 # 6508 <malloc+0x4f6>
     b40:	00005097          	auipc	ra,0x5
     b44:	414080e7          	jalr	1044(ra) # 5f54 <printf>
    exit(1);
     b48:	4505                	li	a0,1
     b4a:	00005097          	auipc	ra,0x5
     b4e:	08a080e7          	jalr	138(ra) # 5bd4 <exit>
    printf("%s: read failed\n", s);
     b52:	85da                	mv	a1,s6
     b54:	00006517          	auipc	a0,0x6
     b58:	9d450513          	addi	a0,a0,-1580 # 6528 <malloc+0x516>
     b5c:	00005097          	auipc	ra,0x5
     b60:	3f8080e7          	jalr	1016(ra) # 5f54 <printf>
    exit(1);
     b64:	4505                	li	a0,1
     b66:	00005097          	auipc	ra,0x5
     b6a:	06e080e7          	jalr	110(ra) # 5bd4 <exit>
    printf("%s: unlink small failed\n", s);
     b6e:	85da                	mv	a1,s6
     b70:	00006517          	auipc	a0,0x6
     b74:	9d050513          	addi	a0,a0,-1584 # 6540 <malloc+0x52e>
     b78:	00005097          	auipc	ra,0x5
     b7c:	3dc080e7          	jalr	988(ra) # 5f54 <printf>
    exit(1);
     b80:	4505                	li	a0,1
     b82:	00005097          	auipc	ra,0x5
     b86:	052080e7          	jalr	82(ra) # 5bd4 <exit>

0000000000000b8a <writebig>:
{
     b8a:	7139                	addi	sp,sp,-64
     b8c:	fc06                	sd	ra,56(sp)
     b8e:	f822                	sd	s0,48(sp)
     b90:	f426                	sd	s1,40(sp)
     b92:	f04a                	sd	s2,32(sp)
     b94:	ec4e                	sd	s3,24(sp)
     b96:	e852                	sd	s4,16(sp)
     b98:	e456                	sd	s5,8(sp)
     b9a:	0080                	addi	s0,sp,64
     b9c:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     b9e:	20200593          	li	a1,514
     ba2:	00006517          	auipc	a0,0x6
     ba6:	9be50513          	addi	a0,a0,-1602 # 6560 <malloc+0x54e>
     baa:	00005097          	auipc	ra,0x5
     bae:	06a080e7          	jalr	106(ra) # 5c14 <open>
  if(fd < 0){
     bb2:	08054563          	bltz	a0,c3c <writebig+0xb2>
     bb6:	89aa                	mv	s3,a0
     bb8:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     bba:	0000c917          	auipc	s2,0xc
     bbe:	0be90913          	addi	s2,s2,190 # cc78 <buf>
  for(i = 0; i < MAXFILE; i++){
     bc2:	6a41                	lui	s4,0x10
     bc4:	10ba0a13          	addi	s4,s4,267 # 1010b <base+0x493>
    ((int*)buf)[0] = i;
     bc8:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     bcc:	40000613          	li	a2,1024
     bd0:	85ca                	mv	a1,s2
     bd2:	854e                	mv	a0,s3
     bd4:	00005097          	auipc	ra,0x5
     bd8:	020080e7          	jalr	32(ra) # 5bf4 <write>
     bdc:	40000793          	li	a5,1024
     be0:	06f51c63          	bne	a0,a5,c58 <writebig+0xce>
  for(i = 0; i < MAXFILE; i++){
     be4:	2485                	addiw	s1,s1,1
     be6:	ff4491e3          	bne	s1,s4,bc8 <writebig+0x3e>
  close(fd);
     bea:	854e                	mv	a0,s3
     bec:	00005097          	auipc	ra,0x5
     bf0:	010080e7          	jalr	16(ra) # 5bfc <close>
  fd = open("big", O_RDONLY);
     bf4:	4581                	li	a1,0
     bf6:	00006517          	auipc	a0,0x6
     bfa:	96a50513          	addi	a0,a0,-1686 # 6560 <malloc+0x54e>
     bfe:	00005097          	auipc	ra,0x5
     c02:	016080e7          	jalr	22(ra) # 5c14 <open>
     c06:	89aa                	mv	s3,a0
  n = 0;
     c08:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     c0a:	0000c917          	auipc	s2,0xc
     c0e:	06e90913          	addi	s2,s2,110 # cc78 <buf>
  if(fd < 0){
     c12:	06054263          	bltz	a0,c76 <writebig+0xec>
    i = read(fd, buf, BSIZE);
     c16:	40000613          	li	a2,1024
     c1a:	85ca                	mv	a1,s2
     c1c:	854e                	mv	a0,s3
     c1e:	00005097          	auipc	ra,0x5
     c22:	fce080e7          	jalr	-50(ra) # 5bec <read>
    if(i == 0){
     c26:	c535                	beqz	a0,c92 <writebig+0x108>
    } else if(i != BSIZE){
     c28:	40000793          	li	a5,1024
     c2c:	0af51f63          	bne	a0,a5,cea <writebig+0x160>
    if(((int*)buf)[0] != n){
     c30:	00092683          	lw	a3,0(s2)
     c34:	0c969a63          	bne	a3,s1,d08 <writebig+0x17e>
    n++;
     c38:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     c3a:	bff1                	j	c16 <writebig+0x8c>
    printf("%s: error: creat big failed!\n", s);
     c3c:	85d6                	mv	a1,s5
     c3e:	00006517          	auipc	a0,0x6
     c42:	92a50513          	addi	a0,a0,-1750 # 6568 <malloc+0x556>
     c46:	00005097          	auipc	ra,0x5
     c4a:	30e080e7          	jalr	782(ra) # 5f54 <printf>
    exit(1);
     c4e:	4505                	li	a0,1
     c50:	00005097          	auipc	ra,0x5
     c54:	f84080e7          	jalr	-124(ra) # 5bd4 <exit>
      printf("%s: error: write big file failed\n", s, i);
     c58:	8626                	mv	a2,s1
     c5a:	85d6                	mv	a1,s5
     c5c:	00006517          	auipc	a0,0x6
     c60:	92c50513          	addi	a0,a0,-1748 # 6588 <malloc+0x576>
     c64:	00005097          	auipc	ra,0x5
     c68:	2f0080e7          	jalr	752(ra) # 5f54 <printf>
      exit(1);
     c6c:	4505                	li	a0,1
     c6e:	00005097          	auipc	ra,0x5
     c72:	f66080e7          	jalr	-154(ra) # 5bd4 <exit>
    printf("%s: error: open big failed!\n", s);
     c76:	85d6                	mv	a1,s5
     c78:	00006517          	auipc	a0,0x6
     c7c:	93850513          	addi	a0,a0,-1736 # 65b0 <malloc+0x59e>
     c80:	00005097          	auipc	ra,0x5
     c84:	2d4080e7          	jalr	724(ra) # 5f54 <printf>
    exit(1);
     c88:	4505                	li	a0,1
     c8a:	00005097          	auipc	ra,0x5
     c8e:	f4a080e7          	jalr	-182(ra) # 5bd4 <exit>
      if(n == MAXFILE - 1){
     c92:	67c1                	lui	a5,0x10
     c94:	10a78793          	addi	a5,a5,266 # 1010a <base+0x492>
     c98:	02f48a63          	beq	s1,a5,ccc <writebig+0x142>
  close(fd);
     c9c:	854e                	mv	a0,s3
     c9e:	00005097          	auipc	ra,0x5
     ca2:	f5e080e7          	jalr	-162(ra) # 5bfc <close>
  if(unlink("big") < 0){
     ca6:	00006517          	auipc	a0,0x6
     caa:	8ba50513          	addi	a0,a0,-1862 # 6560 <malloc+0x54e>
     cae:	00005097          	auipc	ra,0x5
     cb2:	f76080e7          	jalr	-138(ra) # 5c24 <unlink>
     cb6:	06054863          	bltz	a0,d26 <writebig+0x19c>
}
     cba:	70e2                	ld	ra,56(sp)
     cbc:	7442                	ld	s0,48(sp)
     cbe:	74a2                	ld	s1,40(sp)
     cc0:	7902                	ld	s2,32(sp)
     cc2:	69e2                	ld	s3,24(sp)
     cc4:	6a42                	ld	s4,16(sp)
     cc6:	6aa2                	ld	s5,8(sp)
     cc8:	6121                	addi	sp,sp,64
     cca:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     ccc:	863e                	mv	a2,a5
     cce:	85d6                	mv	a1,s5
     cd0:	00006517          	auipc	a0,0x6
     cd4:	90050513          	addi	a0,a0,-1792 # 65d0 <malloc+0x5be>
     cd8:	00005097          	auipc	ra,0x5
     cdc:	27c080e7          	jalr	636(ra) # 5f54 <printf>
        exit(1);
     ce0:	4505                	li	a0,1
     ce2:	00005097          	auipc	ra,0x5
     ce6:	ef2080e7          	jalr	-270(ra) # 5bd4 <exit>
      printf("%s: read failed %d\n", s, i);
     cea:	862a                	mv	a2,a0
     cec:	85d6                	mv	a1,s5
     cee:	00006517          	auipc	a0,0x6
     cf2:	90a50513          	addi	a0,a0,-1782 # 65f8 <malloc+0x5e6>
     cf6:	00005097          	auipc	ra,0x5
     cfa:	25e080e7          	jalr	606(ra) # 5f54 <printf>
      exit(1);
     cfe:	4505                	li	a0,1
     d00:	00005097          	auipc	ra,0x5
     d04:	ed4080e7          	jalr	-300(ra) # 5bd4 <exit>
      printf("%s: read content of block %d is %d\n", s,
     d08:	8626                	mv	a2,s1
     d0a:	85d6                	mv	a1,s5
     d0c:	00006517          	auipc	a0,0x6
     d10:	90450513          	addi	a0,a0,-1788 # 6610 <malloc+0x5fe>
     d14:	00005097          	auipc	ra,0x5
     d18:	240080e7          	jalr	576(ra) # 5f54 <printf>
      exit(1);
     d1c:	4505                	li	a0,1
     d1e:	00005097          	auipc	ra,0x5
     d22:	eb6080e7          	jalr	-330(ra) # 5bd4 <exit>
    printf("%s: unlink big failed\n", s);
     d26:	85d6                	mv	a1,s5
     d28:	00006517          	auipc	a0,0x6
     d2c:	91050513          	addi	a0,a0,-1776 # 6638 <malloc+0x626>
     d30:	00005097          	auipc	ra,0x5
     d34:	224080e7          	jalr	548(ra) # 5f54 <printf>
    exit(1);
     d38:	4505                	li	a0,1
     d3a:	00005097          	auipc	ra,0x5
     d3e:	e9a080e7          	jalr	-358(ra) # 5bd4 <exit>

0000000000000d42 <unlinkread>:
{
     d42:	7179                	addi	sp,sp,-48
     d44:	f406                	sd	ra,40(sp)
     d46:	f022                	sd	s0,32(sp)
     d48:	ec26                	sd	s1,24(sp)
     d4a:	e84a                	sd	s2,16(sp)
     d4c:	e44e                	sd	s3,8(sp)
     d4e:	1800                	addi	s0,sp,48
     d50:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     d52:	20200593          	li	a1,514
     d56:	00006517          	auipc	a0,0x6
     d5a:	8fa50513          	addi	a0,a0,-1798 # 6650 <malloc+0x63e>
     d5e:	00005097          	auipc	ra,0x5
     d62:	eb6080e7          	jalr	-330(ra) # 5c14 <open>
  if(fd < 0){
     d66:	0e054563          	bltz	a0,e50 <unlinkread+0x10e>
     d6a:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     d6c:	4615                	li	a2,5
     d6e:	00006597          	auipc	a1,0x6
     d72:	91258593          	addi	a1,a1,-1774 # 6680 <malloc+0x66e>
     d76:	00005097          	auipc	ra,0x5
     d7a:	e7e080e7          	jalr	-386(ra) # 5bf4 <write>
  close(fd);
     d7e:	8526                	mv	a0,s1
     d80:	00005097          	auipc	ra,0x5
     d84:	e7c080e7          	jalr	-388(ra) # 5bfc <close>
  fd = open("unlinkread", O_RDWR);
     d88:	4589                	li	a1,2
     d8a:	00006517          	auipc	a0,0x6
     d8e:	8c650513          	addi	a0,a0,-1850 # 6650 <malloc+0x63e>
     d92:	00005097          	auipc	ra,0x5
     d96:	e82080e7          	jalr	-382(ra) # 5c14 <open>
     d9a:	84aa                	mv	s1,a0
  if(fd < 0){
     d9c:	0c054863          	bltz	a0,e6c <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     da0:	00006517          	auipc	a0,0x6
     da4:	8b050513          	addi	a0,a0,-1872 # 6650 <malloc+0x63e>
     da8:	00005097          	auipc	ra,0x5
     dac:	e7c080e7          	jalr	-388(ra) # 5c24 <unlink>
     db0:	ed61                	bnez	a0,e88 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     db2:	20200593          	li	a1,514
     db6:	00006517          	auipc	a0,0x6
     dba:	89a50513          	addi	a0,a0,-1894 # 6650 <malloc+0x63e>
     dbe:	00005097          	auipc	ra,0x5
     dc2:	e56080e7          	jalr	-426(ra) # 5c14 <open>
     dc6:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     dc8:	460d                	li	a2,3
     dca:	00006597          	auipc	a1,0x6
     dce:	8fe58593          	addi	a1,a1,-1794 # 66c8 <malloc+0x6b6>
     dd2:	00005097          	auipc	ra,0x5
     dd6:	e22080e7          	jalr	-478(ra) # 5bf4 <write>
  close(fd1);
     dda:	854a                	mv	a0,s2
     ddc:	00005097          	auipc	ra,0x5
     de0:	e20080e7          	jalr	-480(ra) # 5bfc <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     de4:	660d                	lui	a2,0x3
     de6:	0000c597          	auipc	a1,0xc
     dea:	e9258593          	addi	a1,a1,-366 # cc78 <buf>
     dee:	8526                	mv	a0,s1
     df0:	00005097          	auipc	ra,0x5
     df4:	dfc080e7          	jalr	-516(ra) # 5bec <read>
     df8:	4795                	li	a5,5
     dfa:	0af51563          	bne	a0,a5,ea4 <unlinkread+0x162>
  if(buf[0] != 'h'){
     dfe:	0000c717          	auipc	a4,0xc
     e02:	e7a74703          	lbu	a4,-390(a4) # cc78 <buf>
     e06:	06800793          	li	a5,104
     e0a:	0af71b63          	bne	a4,a5,ec0 <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     e0e:	4629                	li	a2,10
     e10:	0000c597          	auipc	a1,0xc
     e14:	e6858593          	addi	a1,a1,-408 # cc78 <buf>
     e18:	8526                	mv	a0,s1
     e1a:	00005097          	auipc	ra,0x5
     e1e:	dda080e7          	jalr	-550(ra) # 5bf4 <write>
     e22:	47a9                	li	a5,10
     e24:	0af51c63          	bne	a0,a5,edc <unlinkread+0x19a>
  close(fd);
     e28:	8526                	mv	a0,s1
     e2a:	00005097          	auipc	ra,0x5
     e2e:	dd2080e7          	jalr	-558(ra) # 5bfc <close>
  unlink("unlinkread");
     e32:	00006517          	auipc	a0,0x6
     e36:	81e50513          	addi	a0,a0,-2018 # 6650 <malloc+0x63e>
     e3a:	00005097          	auipc	ra,0x5
     e3e:	dea080e7          	jalr	-534(ra) # 5c24 <unlink>
}
     e42:	70a2                	ld	ra,40(sp)
     e44:	7402                	ld	s0,32(sp)
     e46:	64e2                	ld	s1,24(sp)
     e48:	6942                	ld	s2,16(sp)
     e4a:	69a2                	ld	s3,8(sp)
     e4c:	6145                	addi	sp,sp,48
     e4e:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     e50:	85ce                	mv	a1,s3
     e52:	00006517          	auipc	a0,0x6
     e56:	80e50513          	addi	a0,a0,-2034 # 6660 <malloc+0x64e>
     e5a:	00005097          	auipc	ra,0x5
     e5e:	0fa080e7          	jalr	250(ra) # 5f54 <printf>
    exit(1);
     e62:	4505                	li	a0,1
     e64:	00005097          	auipc	ra,0x5
     e68:	d70080e7          	jalr	-656(ra) # 5bd4 <exit>
    printf("%s: open unlinkread failed\n", s);
     e6c:	85ce                	mv	a1,s3
     e6e:	00006517          	auipc	a0,0x6
     e72:	81a50513          	addi	a0,a0,-2022 # 6688 <malloc+0x676>
     e76:	00005097          	auipc	ra,0x5
     e7a:	0de080e7          	jalr	222(ra) # 5f54 <printf>
    exit(1);
     e7e:	4505                	li	a0,1
     e80:	00005097          	auipc	ra,0x5
     e84:	d54080e7          	jalr	-684(ra) # 5bd4 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     e88:	85ce                	mv	a1,s3
     e8a:	00006517          	auipc	a0,0x6
     e8e:	81e50513          	addi	a0,a0,-2018 # 66a8 <malloc+0x696>
     e92:	00005097          	auipc	ra,0x5
     e96:	0c2080e7          	jalr	194(ra) # 5f54 <printf>
    exit(1);
     e9a:	4505                	li	a0,1
     e9c:	00005097          	auipc	ra,0x5
     ea0:	d38080e7          	jalr	-712(ra) # 5bd4 <exit>
    printf("%s: unlinkread read failed", s);
     ea4:	85ce                	mv	a1,s3
     ea6:	00006517          	auipc	a0,0x6
     eaa:	82a50513          	addi	a0,a0,-2006 # 66d0 <malloc+0x6be>
     eae:	00005097          	auipc	ra,0x5
     eb2:	0a6080e7          	jalr	166(ra) # 5f54 <printf>
    exit(1);
     eb6:	4505                	li	a0,1
     eb8:	00005097          	auipc	ra,0x5
     ebc:	d1c080e7          	jalr	-740(ra) # 5bd4 <exit>
    printf("%s: unlinkread wrong data\n", s);
     ec0:	85ce                	mv	a1,s3
     ec2:	00006517          	auipc	a0,0x6
     ec6:	82e50513          	addi	a0,a0,-2002 # 66f0 <malloc+0x6de>
     eca:	00005097          	auipc	ra,0x5
     ece:	08a080e7          	jalr	138(ra) # 5f54 <printf>
    exit(1);
     ed2:	4505                	li	a0,1
     ed4:	00005097          	auipc	ra,0x5
     ed8:	d00080e7          	jalr	-768(ra) # 5bd4 <exit>
    printf("%s: unlinkread write failed\n", s);
     edc:	85ce                	mv	a1,s3
     ede:	00006517          	auipc	a0,0x6
     ee2:	83250513          	addi	a0,a0,-1998 # 6710 <malloc+0x6fe>
     ee6:	00005097          	auipc	ra,0x5
     eea:	06e080e7          	jalr	110(ra) # 5f54 <printf>
    exit(1);
     eee:	4505                	li	a0,1
     ef0:	00005097          	auipc	ra,0x5
     ef4:	ce4080e7          	jalr	-796(ra) # 5bd4 <exit>

0000000000000ef8 <linktest>:
{
     ef8:	1101                	addi	sp,sp,-32
     efa:	ec06                	sd	ra,24(sp)
     efc:	e822                	sd	s0,16(sp)
     efe:	e426                	sd	s1,8(sp)
     f00:	e04a                	sd	s2,0(sp)
     f02:	1000                	addi	s0,sp,32
     f04:	892a                	mv	s2,a0
  unlink("lf1");
     f06:	00006517          	auipc	a0,0x6
     f0a:	82a50513          	addi	a0,a0,-2006 # 6730 <malloc+0x71e>
     f0e:	00005097          	auipc	ra,0x5
     f12:	d16080e7          	jalr	-746(ra) # 5c24 <unlink>
  unlink("lf2");
     f16:	00006517          	auipc	a0,0x6
     f1a:	82250513          	addi	a0,a0,-2014 # 6738 <malloc+0x726>
     f1e:	00005097          	auipc	ra,0x5
     f22:	d06080e7          	jalr	-762(ra) # 5c24 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     f26:	20200593          	li	a1,514
     f2a:	00006517          	auipc	a0,0x6
     f2e:	80650513          	addi	a0,a0,-2042 # 6730 <malloc+0x71e>
     f32:	00005097          	auipc	ra,0x5
     f36:	ce2080e7          	jalr	-798(ra) # 5c14 <open>
  if(fd < 0){
     f3a:	10054763          	bltz	a0,1048 <linktest+0x150>
     f3e:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     f40:	4615                	li	a2,5
     f42:	00005597          	auipc	a1,0x5
     f46:	73e58593          	addi	a1,a1,1854 # 6680 <malloc+0x66e>
     f4a:	00005097          	auipc	ra,0x5
     f4e:	caa080e7          	jalr	-854(ra) # 5bf4 <write>
     f52:	4795                	li	a5,5
     f54:	10f51863          	bne	a0,a5,1064 <linktest+0x16c>
  close(fd);
     f58:	8526                	mv	a0,s1
     f5a:	00005097          	auipc	ra,0x5
     f5e:	ca2080e7          	jalr	-862(ra) # 5bfc <close>
  if(link("lf1", "lf2") < 0){
     f62:	00005597          	auipc	a1,0x5
     f66:	7d658593          	addi	a1,a1,2006 # 6738 <malloc+0x726>
     f6a:	00005517          	auipc	a0,0x5
     f6e:	7c650513          	addi	a0,a0,1990 # 6730 <malloc+0x71e>
     f72:	00005097          	auipc	ra,0x5
     f76:	cc2080e7          	jalr	-830(ra) # 5c34 <link>
     f7a:	10054363          	bltz	a0,1080 <linktest+0x188>
  unlink("lf1");
     f7e:	00005517          	auipc	a0,0x5
     f82:	7b250513          	addi	a0,a0,1970 # 6730 <malloc+0x71e>
     f86:	00005097          	auipc	ra,0x5
     f8a:	c9e080e7          	jalr	-866(ra) # 5c24 <unlink>
  if(open("lf1", 0) >= 0){
     f8e:	4581                	li	a1,0
     f90:	00005517          	auipc	a0,0x5
     f94:	7a050513          	addi	a0,a0,1952 # 6730 <malloc+0x71e>
     f98:	00005097          	auipc	ra,0x5
     f9c:	c7c080e7          	jalr	-900(ra) # 5c14 <open>
     fa0:	0e055e63          	bgez	a0,109c <linktest+0x1a4>
  fd = open("lf2", 0);
     fa4:	4581                	li	a1,0
     fa6:	00005517          	auipc	a0,0x5
     faa:	79250513          	addi	a0,a0,1938 # 6738 <malloc+0x726>
     fae:	00005097          	auipc	ra,0x5
     fb2:	c66080e7          	jalr	-922(ra) # 5c14 <open>
     fb6:	84aa                	mv	s1,a0
  if(fd < 0){
     fb8:	10054063          	bltz	a0,10b8 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     fbc:	660d                	lui	a2,0x3
     fbe:	0000c597          	auipc	a1,0xc
     fc2:	cba58593          	addi	a1,a1,-838 # cc78 <buf>
     fc6:	00005097          	auipc	ra,0x5
     fca:	c26080e7          	jalr	-986(ra) # 5bec <read>
     fce:	4795                	li	a5,5
     fd0:	10f51263          	bne	a0,a5,10d4 <linktest+0x1dc>
  close(fd);
     fd4:	8526                	mv	a0,s1
     fd6:	00005097          	auipc	ra,0x5
     fda:	c26080e7          	jalr	-986(ra) # 5bfc <close>
  if(link("lf2", "lf2") >= 0){
     fde:	00005597          	auipc	a1,0x5
     fe2:	75a58593          	addi	a1,a1,1882 # 6738 <malloc+0x726>
     fe6:	852e                	mv	a0,a1
     fe8:	00005097          	auipc	ra,0x5
     fec:	c4c080e7          	jalr	-948(ra) # 5c34 <link>
     ff0:	10055063          	bgez	a0,10f0 <linktest+0x1f8>
  unlink("lf2");
     ff4:	00005517          	auipc	a0,0x5
     ff8:	74450513          	addi	a0,a0,1860 # 6738 <malloc+0x726>
     ffc:	00005097          	auipc	ra,0x5
    1000:	c28080e7          	jalr	-984(ra) # 5c24 <unlink>
  if(link("lf2", "lf1") >= 0){
    1004:	00005597          	auipc	a1,0x5
    1008:	72c58593          	addi	a1,a1,1836 # 6730 <malloc+0x71e>
    100c:	00005517          	auipc	a0,0x5
    1010:	72c50513          	addi	a0,a0,1836 # 6738 <malloc+0x726>
    1014:	00005097          	auipc	ra,0x5
    1018:	c20080e7          	jalr	-992(ra) # 5c34 <link>
    101c:	0e055863          	bgez	a0,110c <linktest+0x214>
  if(link(".", "lf1") >= 0){
    1020:	00005597          	auipc	a1,0x5
    1024:	71058593          	addi	a1,a1,1808 # 6730 <malloc+0x71e>
    1028:	00006517          	auipc	a0,0x6
    102c:	81850513          	addi	a0,a0,-2024 # 6840 <malloc+0x82e>
    1030:	00005097          	auipc	ra,0x5
    1034:	c04080e7          	jalr	-1020(ra) # 5c34 <link>
    1038:	0e055863          	bgez	a0,1128 <linktest+0x230>
}
    103c:	60e2                	ld	ra,24(sp)
    103e:	6442                	ld	s0,16(sp)
    1040:	64a2                	ld	s1,8(sp)
    1042:	6902                	ld	s2,0(sp)
    1044:	6105                	addi	sp,sp,32
    1046:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    1048:	85ca                	mv	a1,s2
    104a:	00005517          	auipc	a0,0x5
    104e:	6f650513          	addi	a0,a0,1782 # 6740 <malloc+0x72e>
    1052:	00005097          	auipc	ra,0x5
    1056:	f02080e7          	jalr	-254(ra) # 5f54 <printf>
    exit(1);
    105a:	4505                	li	a0,1
    105c:	00005097          	auipc	ra,0x5
    1060:	b78080e7          	jalr	-1160(ra) # 5bd4 <exit>
    printf("%s: write lf1 failed\n", s);
    1064:	85ca                	mv	a1,s2
    1066:	00005517          	auipc	a0,0x5
    106a:	6f250513          	addi	a0,a0,1778 # 6758 <malloc+0x746>
    106e:	00005097          	auipc	ra,0x5
    1072:	ee6080e7          	jalr	-282(ra) # 5f54 <printf>
    exit(1);
    1076:	4505                	li	a0,1
    1078:	00005097          	auipc	ra,0x5
    107c:	b5c080e7          	jalr	-1188(ra) # 5bd4 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    1080:	85ca                	mv	a1,s2
    1082:	00005517          	auipc	a0,0x5
    1086:	6ee50513          	addi	a0,a0,1774 # 6770 <malloc+0x75e>
    108a:	00005097          	auipc	ra,0x5
    108e:	eca080e7          	jalr	-310(ra) # 5f54 <printf>
    exit(1);
    1092:	4505                	li	a0,1
    1094:	00005097          	auipc	ra,0x5
    1098:	b40080e7          	jalr	-1216(ra) # 5bd4 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    109c:	85ca                	mv	a1,s2
    109e:	00005517          	auipc	a0,0x5
    10a2:	6f250513          	addi	a0,a0,1778 # 6790 <malloc+0x77e>
    10a6:	00005097          	auipc	ra,0x5
    10aa:	eae080e7          	jalr	-338(ra) # 5f54 <printf>
    exit(1);
    10ae:	4505                	li	a0,1
    10b0:	00005097          	auipc	ra,0x5
    10b4:	b24080e7          	jalr	-1244(ra) # 5bd4 <exit>
    printf("%s: open lf2 failed\n", s);
    10b8:	85ca                	mv	a1,s2
    10ba:	00005517          	auipc	a0,0x5
    10be:	70650513          	addi	a0,a0,1798 # 67c0 <malloc+0x7ae>
    10c2:	00005097          	auipc	ra,0x5
    10c6:	e92080e7          	jalr	-366(ra) # 5f54 <printf>
    exit(1);
    10ca:	4505                	li	a0,1
    10cc:	00005097          	auipc	ra,0x5
    10d0:	b08080e7          	jalr	-1272(ra) # 5bd4 <exit>
    printf("%s: read lf2 failed\n", s);
    10d4:	85ca                	mv	a1,s2
    10d6:	00005517          	auipc	a0,0x5
    10da:	70250513          	addi	a0,a0,1794 # 67d8 <malloc+0x7c6>
    10de:	00005097          	auipc	ra,0x5
    10e2:	e76080e7          	jalr	-394(ra) # 5f54 <printf>
    exit(1);
    10e6:	4505                	li	a0,1
    10e8:	00005097          	auipc	ra,0x5
    10ec:	aec080e7          	jalr	-1300(ra) # 5bd4 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    10f0:	85ca                	mv	a1,s2
    10f2:	00005517          	auipc	a0,0x5
    10f6:	6fe50513          	addi	a0,a0,1790 # 67f0 <malloc+0x7de>
    10fa:	00005097          	auipc	ra,0x5
    10fe:	e5a080e7          	jalr	-422(ra) # 5f54 <printf>
    exit(1);
    1102:	4505                	li	a0,1
    1104:	00005097          	auipc	ra,0x5
    1108:	ad0080e7          	jalr	-1328(ra) # 5bd4 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
    110c:	85ca                	mv	a1,s2
    110e:	00005517          	auipc	a0,0x5
    1112:	70a50513          	addi	a0,a0,1802 # 6818 <malloc+0x806>
    1116:	00005097          	auipc	ra,0x5
    111a:	e3e080e7          	jalr	-450(ra) # 5f54 <printf>
    exit(1);
    111e:	4505                	li	a0,1
    1120:	00005097          	auipc	ra,0x5
    1124:	ab4080e7          	jalr	-1356(ra) # 5bd4 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    1128:	85ca                	mv	a1,s2
    112a:	00005517          	auipc	a0,0x5
    112e:	71e50513          	addi	a0,a0,1822 # 6848 <malloc+0x836>
    1132:	00005097          	auipc	ra,0x5
    1136:	e22080e7          	jalr	-478(ra) # 5f54 <printf>
    exit(1);
    113a:	4505                	li	a0,1
    113c:	00005097          	auipc	ra,0x5
    1140:	a98080e7          	jalr	-1384(ra) # 5bd4 <exit>

0000000000001144 <validatetest>:
{
    1144:	7139                	addi	sp,sp,-64
    1146:	fc06                	sd	ra,56(sp)
    1148:	f822                	sd	s0,48(sp)
    114a:	f426                	sd	s1,40(sp)
    114c:	f04a                	sd	s2,32(sp)
    114e:	ec4e                	sd	s3,24(sp)
    1150:	e852                	sd	s4,16(sp)
    1152:	e456                	sd	s5,8(sp)
    1154:	e05a                	sd	s6,0(sp)
    1156:	0080                	addi	s0,sp,64
    1158:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    115a:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    115c:	00005997          	auipc	s3,0x5
    1160:	70c98993          	addi	s3,s3,1804 # 6868 <malloc+0x856>
    1164:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1166:	6a85                	lui	s5,0x1
    1168:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    116c:	85a6                	mv	a1,s1
    116e:	854e                	mv	a0,s3
    1170:	00005097          	auipc	ra,0x5
    1174:	ac4080e7          	jalr	-1340(ra) # 5c34 <link>
    1178:	01251f63          	bne	a0,s2,1196 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    117c:	94d6                	add	s1,s1,s5
    117e:	ff4497e3          	bne	s1,s4,116c <validatetest+0x28>
}
    1182:	70e2                	ld	ra,56(sp)
    1184:	7442                	ld	s0,48(sp)
    1186:	74a2                	ld	s1,40(sp)
    1188:	7902                	ld	s2,32(sp)
    118a:	69e2                	ld	s3,24(sp)
    118c:	6a42                	ld	s4,16(sp)
    118e:	6aa2                	ld	s5,8(sp)
    1190:	6b02                	ld	s6,0(sp)
    1192:	6121                	addi	sp,sp,64
    1194:	8082                	ret
      printf("%s: link should not succeed\n", s);
    1196:	85da                	mv	a1,s6
    1198:	00005517          	auipc	a0,0x5
    119c:	6e050513          	addi	a0,a0,1760 # 6878 <malloc+0x866>
    11a0:	00005097          	auipc	ra,0x5
    11a4:	db4080e7          	jalr	-588(ra) # 5f54 <printf>
      exit(1);
    11a8:	4505                	li	a0,1
    11aa:	00005097          	auipc	ra,0x5
    11ae:	a2a080e7          	jalr	-1494(ra) # 5bd4 <exit>

00000000000011b2 <bigdir>:
{
    11b2:	715d                	addi	sp,sp,-80
    11b4:	e486                	sd	ra,72(sp)
    11b6:	e0a2                	sd	s0,64(sp)
    11b8:	fc26                	sd	s1,56(sp)
    11ba:	f84a                	sd	s2,48(sp)
    11bc:	f44e                	sd	s3,40(sp)
    11be:	f052                	sd	s4,32(sp)
    11c0:	ec56                	sd	s5,24(sp)
    11c2:	e85a                	sd	s6,16(sp)
    11c4:	0880                	addi	s0,sp,80
    11c6:	89aa                	mv	s3,a0
  unlink("bd");
    11c8:	00005517          	auipc	a0,0x5
    11cc:	6d050513          	addi	a0,a0,1744 # 6898 <malloc+0x886>
    11d0:	00005097          	auipc	ra,0x5
    11d4:	a54080e7          	jalr	-1452(ra) # 5c24 <unlink>
  fd = open("bd", O_CREATE);
    11d8:	20000593          	li	a1,512
    11dc:	00005517          	auipc	a0,0x5
    11e0:	6bc50513          	addi	a0,a0,1724 # 6898 <malloc+0x886>
    11e4:	00005097          	auipc	ra,0x5
    11e8:	a30080e7          	jalr	-1488(ra) # 5c14 <open>
  if(fd < 0){
    11ec:	0c054963          	bltz	a0,12be <bigdir+0x10c>
  close(fd);
    11f0:	00005097          	auipc	ra,0x5
    11f4:	a0c080e7          	jalr	-1524(ra) # 5bfc <close>
  for(i = 0; i < N; i++){
    11f8:	4901                	li	s2,0
    name[0] = 'x';
    11fa:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    11fe:	00005a17          	auipc	s4,0x5
    1202:	69aa0a13          	addi	s4,s4,1690 # 6898 <malloc+0x886>
  for(i = 0; i < N; i++){
    1206:	1f400b13          	li	s6,500
    name[0] = 'x';
    120a:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    120e:	41f9579b          	sraiw	a5,s2,0x1f
    1212:	01a7d71b          	srliw	a4,a5,0x1a
    1216:	012707bb          	addw	a5,a4,s2
    121a:	4067d69b          	sraiw	a3,a5,0x6
    121e:	0306869b          	addiw	a3,a3,48
    1222:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1226:	03f7f793          	andi	a5,a5,63
    122a:	9f99                	subw	a5,a5,a4
    122c:	0307879b          	addiw	a5,a5,48
    1230:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1234:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    1238:	fb040593          	addi	a1,s0,-80
    123c:	8552                	mv	a0,s4
    123e:	00005097          	auipc	ra,0x5
    1242:	9f6080e7          	jalr	-1546(ra) # 5c34 <link>
    1246:	84aa                	mv	s1,a0
    1248:	e949                	bnez	a0,12da <bigdir+0x128>
  for(i = 0; i < N; i++){
    124a:	2905                	addiw	s2,s2,1
    124c:	fb691fe3          	bne	s2,s6,120a <bigdir+0x58>
  unlink("bd");
    1250:	00005517          	auipc	a0,0x5
    1254:	64850513          	addi	a0,a0,1608 # 6898 <malloc+0x886>
    1258:	00005097          	auipc	ra,0x5
    125c:	9cc080e7          	jalr	-1588(ra) # 5c24 <unlink>
    name[0] = 'x';
    1260:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    1264:	1f400a13          	li	s4,500
    name[0] = 'x';
    1268:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    126c:	41f4d79b          	sraiw	a5,s1,0x1f
    1270:	01a7d71b          	srliw	a4,a5,0x1a
    1274:	009707bb          	addw	a5,a4,s1
    1278:	4067d69b          	sraiw	a3,a5,0x6
    127c:	0306869b          	addiw	a3,a3,48
    1280:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1284:	03f7f793          	andi	a5,a5,63
    1288:	9f99                	subw	a5,a5,a4
    128a:	0307879b          	addiw	a5,a5,48
    128e:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1292:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    1296:	fb040513          	addi	a0,s0,-80
    129a:	00005097          	auipc	ra,0x5
    129e:	98a080e7          	jalr	-1654(ra) # 5c24 <unlink>
    12a2:	ed21                	bnez	a0,12fa <bigdir+0x148>
  for(i = 0; i < N; i++){
    12a4:	2485                	addiw	s1,s1,1
    12a6:	fd4491e3          	bne	s1,s4,1268 <bigdir+0xb6>
}
    12aa:	60a6                	ld	ra,72(sp)
    12ac:	6406                	ld	s0,64(sp)
    12ae:	74e2                	ld	s1,56(sp)
    12b0:	7942                	ld	s2,48(sp)
    12b2:	79a2                	ld	s3,40(sp)
    12b4:	7a02                	ld	s4,32(sp)
    12b6:	6ae2                	ld	s5,24(sp)
    12b8:	6b42                	ld	s6,16(sp)
    12ba:	6161                	addi	sp,sp,80
    12bc:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    12be:	85ce                	mv	a1,s3
    12c0:	00005517          	auipc	a0,0x5
    12c4:	5e050513          	addi	a0,a0,1504 # 68a0 <malloc+0x88e>
    12c8:	00005097          	auipc	ra,0x5
    12cc:	c8c080e7          	jalr	-884(ra) # 5f54 <printf>
    exit(1);
    12d0:	4505                	li	a0,1
    12d2:	00005097          	auipc	ra,0x5
    12d6:	902080e7          	jalr	-1790(ra) # 5bd4 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    12da:	fb040613          	addi	a2,s0,-80
    12de:	85ce                	mv	a1,s3
    12e0:	00005517          	auipc	a0,0x5
    12e4:	5e050513          	addi	a0,a0,1504 # 68c0 <malloc+0x8ae>
    12e8:	00005097          	auipc	ra,0x5
    12ec:	c6c080e7          	jalr	-916(ra) # 5f54 <printf>
      exit(1);
    12f0:	4505                	li	a0,1
    12f2:	00005097          	auipc	ra,0x5
    12f6:	8e2080e7          	jalr	-1822(ra) # 5bd4 <exit>
      printf("%s: bigdir unlink failed", s);
    12fa:	85ce                	mv	a1,s3
    12fc:	00005517          	auipc	a0,0x5
    1300:	5e450513          	addi	a0,a0,1508 # 68e0 <malloc+0x8ce>
    1304:	00005097          	auipc	ra,0x5
    1308:	c50080e7          	jalr	-944(ra) # 5f54 <printf>
      exit(1);
    130c:	4505                	li	a0,1
    130e:	00005097          	auipc	ra,0x5
    1312:	8c6080e7          	jalr	-1850(ra) # 5bd4 <exit>

0000000000001316 <pgbug>:
{
    1316:	7179                	addi	sp,sp,-48
    1318:	f406                	sd	ra,40(sp)
    131a:	f022                	sd	s0,32(sp)
    131c:	ec26                	sd	s1,24(sp)
    131e:	1800                	addi	s0,sp,48
  argv[0] = 0;
    1320:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1324:	00008497          	auipc	s1,0x8
    1328:	cdc48493          	addi	s1,s1,-804 # 9000 <big>
    132c:	fd840593          	addi	a1,s0,-40
    1330:	6088                	ld	a0,0(s1)
    1332:	00005097          	auipc	ra,0x5
    1336:	8da080e7          	jalr	-1830(ra) # 5c0c <exec>
  pipe(big);
    133a:	6088                	ld	a0,0(s1)
    133c:	00005097          	auipc	ra,0x5
    1340:	8a8080e7          	jalr	-1880(ra) # 5be4 <pipe>
  exit(0);
    1344:	4501                	li	a0,0
    1346:	00005097          	auipc	ra,0x5
    134a:	88e080e7          	jalr	-1906(ra) # 5bd4 <exit>

000000000000134e <badarg>:
{
    134e:	7139                	addi	sp,sp,-64
    1350:	fc06                	sd	ra,56(sp)
    1352:	f822                	sd	s0,48(sp)
    1354:	f426                	sd	s1,40(sp)
    1356:	f04a                	sd	s2,32(sp)
    1358:	ec4e                	sd	s3,24(sp)
    135a:	0080                	addi	s0,sp,64
    135c:	64b1                	lui	s1,0xc
    135e:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    1362:	597d                	li	s2,-1
    1364:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    1368:	00005997          	auipc	s3,0x5
    136c:	df098993          	addi	s3,s3,-528 # 6158 <malloc+0x146>
    argv[0] = (char*)0xffffffff;
    1370:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1374:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1378:	fc040593          	addi	a1,s0,-64
    137c:	854e                	mv	a0,s3
    137e:	00005097          	auipc	ra,0x5
    1382:	88e080e7          	jalr	-1906(ra) # 5c0c <exec>
  for(int i = 0; i < 50000; i++){
    1386:	34fd                	addiw	s1,s1,-1
    1388:	f4e5                	bnez	s1,1370 <badarg+0x22>
  exit(0);
    138a:	4501                	li	a0,0
    138c:	00005097          	auipc	ra,0x5
    1390:	848080e7          	jalr	-1976(ra) # 5bd4 <exit>

0000000000001394 <copyinstr2>:
{
    1394:	7155                	addi	sp,sp,-208
    1396:	e586                	sd	ra,200(sp)
    1398:	e1a2                	sd	s0,192(sp)
    139a:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    139c:	f6840793          	addi	a5,s0,-152
    13a0:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    13a4:	07800713          	li	a4,120
    13a8:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    13ac:	0785                	addi	a5,a5,1
    13ae:	fed79de3          	bne	a5,a3,13a8 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    13b2:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    13b6:	f6840513          	addi	a0,s0,-152
    13ba:	00005097          	auipc	ra,0x5
    13be:	86a080e7          	jalr	-1942(ra) # 5c24 <unlink>
  if(ret != -1){
    13c2:	57fd                	li	a5,-1
    13c4:	0ef51063          	bne	a0,a5,14a4 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    13c8:	20100593          	li	a1,513
    13cc:	f6840513          	addi	a0,s0,-152
    13d0:	00005097          	auipc	ra,0x5
    13d4:	844080e7          	jalr	-1980(ra) # 5c14 <open>
  if(fd != -1){
    13d8:	57fd                	li	a5,-1
    13da:	0ef51563          	bne	a0,a5,14c4 <copyinstr2+0x130>
  ret = link(b, b);
    13de:	f6840593          	addi	a1,s0,-152
    13e2:	852e                	mv	a0,a1
    13e4:	00005097          	auipc	ra,0x5
    13e8:	850080e7          	jalr	-1968(ra) # 5c34 <link>
  if(ret != -1){
    13ec:	57fd                	li	a5,-1
    13ee:	0ef51b63          	bne	a0,a5,14e4 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    13f2:	00006797          	auipc	a5,0x6
    13f6:	74678793          	addi	a5,a5,1862 # 7b38 <malloc+0x1b26>
    13fa:	f4f43c23          	sd	a5,-168(s0)
    13fe:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1402:	f5840593          	addi	a1,s0,-168
    1406:	f6840513          	addi	a0,s0,-152
    140a:	00005097          	auipc	ra,0x5
    140e:	802080e7          	jalr	-2046(ra) # 5c0c <exec>
  if(ret != -1){
    1412:	57fd                	li	a5,-1
    1414:	0ef51963          	bne	a0,a5,1506 <copyinstr2+0x172>
  int pid = fork();
    1418:	00004097          	auipc	ra,0x4
    141c:	7b4080e7          	jalr	1972(ra) # 5bcc <fork>
  if(pid < 0){
    1420:	10054363          	bltz	a0,1526 <copyinstr2+0x192>
  if(pid == 0){
    1424:	12051463          	bnez	a0,154c <copyinstr2+0x1b8>
    1428:	00008797          	auipc	a5,0x8
    142c:	13878793          	addi	a5,a5,312 # 9560 <big.1269>
    1430:	00009697          	auipc	a3,0x9
    1434:	13068693          	addi	a3,a3,304 # a560 <big.1269+0x1000>
      big[i] = 'x';
    1438:	07800713          	li	a4,120
    143c:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    1440:	0785                	addi	a5,a5,1
    1442:	fed79de3          	bne	a5,a3,143c <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    1446:	00009797          	auipc	a5,0x9
    144a:	10078d23          	sb	zero,282(a5) # a560 <big.1269+0x1000>
    char *args2[] = { big, big, big, 0 };
    144e:	00007797          	auipc	a5,0x7
    1452:	10a78793          	addi	a5,a5,266 # 8558 <malloc+0x2546>
    1456:	6390                	ld	a2,0(a5)
    1458:	6794                	ld	a3,8(a5)
    145a:	6b98                	ld	a4,16(a5)
    145c:	6f9c                	ld	a5,24(a5)
    145e:	f2c43823          	sd	a2,-208(s0)
    1462:	f2d43c23          	sd	a3,-200(s0)
    1466:	f4e43023          	sd	a4,-192(s0)
    146a:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    146e:	f3040593          	addi	a1,s0,-208
    1472:	00005517          	auipc	a0,0x5
    1476:	ce650513          	addi	a0,a0,-794 # 6158 <malloc+0x146>
    147a:	00004097          	auipc	ra,0x4
    147e:	792080e7          	jalr	1938(ra) # 5c0c <exec>
    if(ret != -1){
    1482:	57fd                	li	a5,-1
    1484:	0af50e63          	beq	a0,a5,1540 <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    1488:	55fd                	li	a1,-1
    148a:	00005517          	auipc	a0,0x5
    148e:	4fe50513          	addi	a0,a0,1278 # 6988 <malloc+0x976>
    1492:	00005097          	auipc	ra,0x5
    1496:	ac2080e7          	jalr	-1342(ra) # 5f54 <printf>
      exit(1);
    149a:	4505                	li	a0,1
    149c:	00004097          	auipc	ra,0x4
    14a0:	738080e7          	jalr	1848(ra) # 5bd4 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    14a4:	862a                	mv	a2,a0
    14a6:	f6840593          	addi	a1,s0,-152
    14aa:	00005517          	auipc	a0,0x5
    14ae:	45650513          	addi	a0,a0,1110 # 6900 <malloc+0x8ee>
    14b2:	00005097          	auipc	ra,0x5
    14b6:	aa2080e7          	jalr	-1374(ra) # 5f54 <printf>
    exit(1);
    14ba:	4505                	li	a0,1
    14bc:	00004097          	auipc	ra,0x4
    14c0:	718080e7          	jalr	1816(ra) # 5bd4 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    14c4:	862a                	mv	a2,a0
    14c6:	f6840593          	addi	a1,s0,-152
    14ca:	00005517          	auipc	a0,0x5
    14ce:	45650513          	addi	a0,a0,1110 # 6920 <malloc+0x90e>
    14d2:	00005097          	auipc	ra,0x5
    14d6:	a82080e7          	jalr	-1406(ra) # 5f54 <printf>
    exit(1);
    14da:	4505                	li	a0,1
    14dc:	00004097          	auipc	ra,0x4
    14e0:	6f8080e7          	jalr	1784(ra) # 5bd4 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    14e4:	86aa                	mv	a3,a0
    14e6:	f6840613          	addi	a2,s0,-152
    14ea:	85b2                	mv	a1,a2
    14ec:	00005517          	auipc	a0,0x5
    14f0:	45450513          	addi	a0,a0,1108 # 6940 <malloc+0x92e>
    14f4:	00005097          	auipc	ra,0x5
    14f8:	a60080e7          	jalr	-1440(ra) # 5f54 <printf>
    exit(1);
    14fc:	4505                	li	a0,1
    14fe:	00004097          	auipc	ra,0x4
    1502:	6d6080e7          	jalr	1750(ra) # 5bd4 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1506:	567d                	li	a2,-1
    1508:	f6840593          	addi	a1,s0,-152
    150c:	00005517          	auipc	a0,0x5
    1510:	45c50513          	addi	a0,a0,1116 # 6968 <malloc+0x956>
    1514:	00005097          	auipc	ra,0x5
    1518:	a40080e7          	jalr	-1472(ra) # 5f54 <printf>
    exit(1);
    151c:	4505                	li	a0,1
    151e:	00004097          	auipc	ra,0x4
    1522:	6b6080e7          	jalr	1718(ra) # 5bd4 <exit>
    printf("fork failed\n");
    1526:	00006517          	auipc	a0,0x6
    152a:	8c250513          	addi	a0,a0,-1854 # 6de8 <malloc+0xdd6>
    152e:	00005097          	auipc	ra,0x5
    1532:	a26080e7          	jalr	-1498(ra) # 5f54 <printf>
    exit(1);
    1536:	4505                	li	a0,1
    1538:	00004097          	auipc	ra,0x4
    153c:	69c080e7          	jalr	1692(ra) # 5bd4 <exit>
    exit(747); // OK
    1540:	2eb00513          	li	a0,747
    1544:	00004097          	auipc	ra,0x4
    1548:	690080e7          	jalr	1680(ra) # 5bd4 <exit>
  int st = 0;
    154c:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    1550:	f5440513          	addi	a0,s0,-172
    1554:	00004097          	auipc	ra,0x4
    1558:	688080e7          	jalr	1672(ra) # 5bdc <wait>
  if(st != 747){
    155c:	f5442703          	lw	a4,-172(s0)
    1560:	2eb00793          	li	a5,747
    1564:	00f71663          	bne	a4,a5,1570 <copyinstr2+0x1dc>
}
    1568:	60ae                	ld	ra,200(sp)
    156a:	640e                	ld	s0,192(sp)
    156c:	6169                	addi	sp,sp,208
    156e:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    1570:	00005517          	auipc	a0,0x5
    1574:	44050513          	addi	a0,a0,1088 # 69b0 <malloc+0x99e>
    1578:	00005097          	auipc	ra,0x5
    157c:	9dc080e7          	jalr	-1572(ra) # 5f54 <printf>
    exit(1);
    1580:	4505                	li	a0,1
    1582:	00004097          	auipc	ra,0x4
    1586:	652080e7          	jalr	1618(ra) # 5bd4 <exit>

000000000000158a <truncate3>:
{
    158a:	7159                	addi	sp,sp,-112
    158c:	f486                	sd	ra,104(sp)
    158e:	f0a2                	sd	s0,96(sp)
    1590:	eca6                	sd	s1,88(sp)
    1592:	e8ca                	sd	s2,80(sp)
    1594:	e4ce                	sd	s3,72(sp)
    1596:	e0d2                	sd	s4,64(sp)
    1598:	fc56                	sd	s5,56(sp)
    159a:	1880                	addi	s0,sp,112
    159c:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    159e:	60100593          	li	a1,1537
    15a2:	00005517          	auipc	a0,0x5
    15a6:	c0e50513          	addi	a0,a0,-1010 # 61b0 <malloc+0x19e>
    15aa:	00004097          	auipc	ra,0x4
    15ae:	66a080e7          	jalr	1642(ra) # 5c14 <open>
    15b2:	00004097          	auipc	ra,0x4
    15b6:	64a080e7          	jalr	1610(ra) # 5bfc <close>
  pid = fork();
    15ba:	00004097          	auipc	ra,0x4
    15be:	612080e7          	jalr	1554(ra) # 5bcc <fork>
  if(pid < 0){
    15c2:	08054063          	bltz	a0,1642 <truncate3+0xb8>
  if(pid == 0){
    15c6:	e969                	bnez	a0,1698 <truncate3+0x10e>
    15c8:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    15cc:	00005a17          	auipc	s4,0x5
    15d0:	be4a0a13          	addi	s4,s4,-1052 # 61b0 <malloc+0x19e>
      int n = write(fd, "1234567890", 10);
    15d4:	00005a97          	auipc	s5,0x5
    15d8:	43ca8a93          	addi	s5,s5,1084 # 6a10 <malloc+0x9fe>
      int fd = open("truncfile", O_WRONLY);
    15dc:	4585                	li	a1,1
    15de:	8552                	mv	a0,s4
    15e0:	00004097          	auipc	ra,0x4
    15e4:	634080e7          	jalr	1588(ra) # 5c14 <open>
    15e8:	84aa                	mv	s1,a0
      if(fd < 0){
    15ea:	06054a63          	bltz	a0,165e <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    15ee:	4629                	li	a2,10
    15f0:	85d6                	mv	a1,s5
    15f2:	00004097          	auipc	ra,0x4
    15f6:	602080e7          	jalr	1538(ra) # 5bf4 <write>
      if(n != 10){
    15fa:	47a9                	li	a5,10
    15fc:	06f51f63          	bne	a0,a5,167a <truncate3+0xf0>
      close(fd);
    1600:	8526                	mv	a0,s1
    1602:	00004097          	auipc	ra,0x4
    1606:	5fa080e7          	jalr	1530(ra) # 5bfc <close>
      fd = open("truncfile", O_RDONLY);
    160a:	4581                	li	a1,0
    160c:	8552                	mv	a0,s4
    160e:	00004097          	auipc	ra,0x4
    1612:	606080e7          	jalr	1542(ra) # 5c14 <open>
    1616:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1618:	02000613          	li	a2,32
    161c:	f9840593          	addi	a1,s0,-104
    1620:	00004097          	auipc	ra,0x4
    1624:	5cc080e7          	jalr	1484(ra) # 5bec <read>
      close(fd);
    1628:	8526                	mv	a0,s1
    162a:	00004097          	auipc	ra,0x4
    162e:	5d2080e7          	jalr	1490(ra) # 5bfc <close>
    for(int i = 0; i < 100; i++){
    1632:	39fd                	addiw	s3,s3,-1
    1634:	fa0994e3          	bnez	s3,15dc <truncate3+0x52>
    exit(0);
    1638:	4501                	li	a0,0
    163a:	00004097          	auipc	ra,0x4
    163e:	59a080e7          	jalr	1434(ra) # 5bd4 <exit>
    printf("%s: fork failed\n", s);
    1642:	85ca                	mv	a1,s2
    1644:	00005517          	auipc	a0,0x5
    1648:	39c50513          	addi	a0,a0,924 # 69e0 <malloc+0x9ce>
    164c:	00005097          	auipc	ra,0x5
    1650:	908080e7          	jalr	-1784(ra) # 5f54 <printf>
    exit(1);
    1654:	4505                	li	a0,1
    1656:	00004097          	auipc	ra,0x4
    165a:	57e080e7          	jalr	1406(ra) # 5bd4 <exit>
        printf("%s: open failed\n", s);
    165e:	85ca                	mv	a1,s2
    1660:	00005517          	auipc	a0,0x5
    1664:	39850513          	addi	a0,a0,920 # 69f8 <malloc+0x9e6>
    1668:	00005097          	auipc	ra,0x5
    166c:	8ec080e7          	jalr	-1812(ra) # 5f54 <printf>
        exit(1);
    1670:	4505                	li	a0,1
    1672:	00004097          	auipc	ra,0x4
    1676:	562080e7          	jalr	1378(ra) # 5bd4 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    167a:	862a                	mv	a2,a0
    167c:	85ca                	mv	a1,s2
    167e:	00005517          	auipc	a0,0x5
    1682:	3a250513          	addi	a0,a0,930 # 6a20 <malloc+0xa0e>
    1686:	00005097          	auipc	ra,0x5
    168a:	8ce080e7          	jalr	-1842(ra) # 5f54 <printf>
        exit(1);
    168e:	4505                	li	a0,1
    1690:	00004097          	auipc	ra,0x4
    1694:	544080e7          	jalr	1348(ra) # 5bd4 <exit>
    1698:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    169c:	00005a17          	auipc	s4,0x5
    16a0:	b14a0a13          	addi	s4,s4,-1260 # 61b0 <malloc+0x19e>
    int n = write(fd, "xxx", 3);
    16a4:	00005a97          	auipc	s5,0x5
    16a8:	39ca8a93          	addi	s5,s5,924 # 6a40 <malloc+0xa2e>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    16ac:	60100593          	li	a1,1537
    16b0:	8552                	mv	a0,s4
    16b2:	00004097          	auipc	ra,0x4
    16b6:	562080e7          	jalr	1378(ra) # 5c14 <open>
    16ba:	84aa                	mv	s1,a0
    if(fd < 0){
    16bc:	04054763          	bltz	a0,170a <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    16c0:	460d                	li	a2,3
    16c2:	85d6                	mv	a1,s5
    16c4:	00004097          	auipc	ra,0x4
    16c8:	530080e7          	jalr	1328(ra) # 5bf4 <write>
    if(n != 3){
    16cc:	478d                	li	a5,3
    16ce:	04f51c63          	bne	a0,a5,1726 <truncate3+0x19c>
    close(fd);
    16d2:	8526                	mv	a0,s1
    16d4:	00004097          	auipc	ra,0x4
    16d8:	528080e7          	jalr	1320(ra) # 5bfc <close>
  for(int i = 0; i < 150; i++){
    16dc:	39fd                	addiw	s3,s3,-1
    16de:	fc0997e3          	bnez	s3,16ac <truncate3+0x122>
  wait(&xstatus);
    16e2:	fbc40513          	addi	a0,s0,-68
    16e6:	00004097          	auipc	ra,0x4
    16ea:	4f6080e7          	jalr	1270(ra) # 5bdc <wait>
  unlink("truncfile");
    16ee:	00005517          	auipc	a0,0x5
    16f2:	ac250513          	addi	a0,a0,-1342 # 61b0 <malloc+0x19e>
    16f6:	00004097          	auipc	ra,0x4
    16fa:	52e080e7          	jalr	1326(ra) # 5c24 <unlink>
  exit(xstatus);
    16fe:	fbc42503          	lw	a0,-68(s0)
    1702:	00004097          	auipc	ra,0x4
    1706:	4d2080e7          	jalr	1234(ra) # 5bd4 <exit>
      printf("%s: open failed\n", s);
    170a:	85ca                	mv	a1,s2
    170c:	00005517          	auipc	a0,0x5
    1710:	2ec50513          	addi	a0,a0,748 # 69f8 <malloc+0x9e6>
    1714:	00005097          	auipc	ra,0x5
    1718:	840080e7          	jalr	-1984(ra) # 5f54 <printf>
      exit(1);
    171c:	4505                	li	a0,1
    171e:	00004097          	auipc	ra,0x4
    1722:	4b6080e7          	jalr	1206(ra) # 5bd4 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1726:	862a                	mv	a2,a0
    1728:	85ca                	mv	a1,s2
    172a:	00005517          	auipc	a0,0x5
    172e:	31e50513          	addi	a0,a0,798 # 6a48 <malloc+0xa36>
    1732:	00005097          	auipc	ra,0x5
    1736:	822080e7          	jalr	-2014(ra) # 5f54 <printf>
      exit(1);
    173a:	4505                	li	a0,1
    173c:	00004097          	auipc	ra,0x4
    1740:	498080e7          	jalr	1176(ra) # 5bd4 <exit>

0000000000001744 <exectest>:
{
    1744:	715d                	addi	sp,sp,-80
    1746:	e486                	sd	ra,72(sp)
    1748:	e0a2                	sd	s0,64(sp)
    174a:	fc26                	sd	s1,56(sp)
    174c:	f84a                	sd	s2,48(sp)
    174e:	0880                	addi	s0,sp,80
    1750:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    1752:	00005797          	auipc	a5,0x5
    1756:	a0678793          	addi	a5,a5,-1530 # 6158 <malloc+0x146>
    175a:	fcf43023          	sd	a5,-64(s0)
    175e:	00005797          	auipc	a5,0x5
    1762:	30a78793          	addi	a5,a5,778 # 6a68 <malloc+0xa56>
    1766:	fcf43423          	sd	a5,-56(s0)
    176a:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    176e:	00005517          	auipc	a0,0x5
    1772:	30250513          	addi	a0,a0,770 # 6a70 <malloc+0xa5e>
    1776:	00004097          	auipc	ra,0x4
    177a:	4ae080e7          	jalr	1198(ra) # 5c24 <unlink>
  pid = fork();
    177e:	00004097          	auipc	ra,0x4
    1782:	44e080e7          	jalr	1102(ra) # 5bcc <fork>
  if(pid < 0) {
    1786:	04054663          	bltz	a0,17d2 <exectest+0x8e>
    178a:	84aa                	mv	s1,a0
  if(pid == 0) {
    178c:	e959                	bnez	a0,1822 <exectest+0xde>
    close(1);
    178e:	4505                	li	a0,1
    1790:	00004097          	auipc	ra,0x4
    1794:	46c080e7          	jalr	1132(ra) # 5bfc <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1798:	20100593          	li	a1,513
    179c:	00005517          	auipc	a0,0x5
    17a0:	2d450513          	addi	a0,a0,724 # 6a70 <malloc+0xa5e>
    17a4:	00004097          	auipc	ra,0x4
    17a8:	470080e7          	jalr	1136(ra) # 5c14 <open>
    if(fd < 0) {
    17ac:	04054163          	bltz	a0,17ee <exectest+0xaa>
    if(fd != 1) {
    17b0:	4785                	li	a5,1
    17b2:	04f50c63          	beq	a0,a5,180a <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    17b6:	85ca                	mv	a1,s2
    17b8:	00005517          	auipc	a0,0x5
    17bc:	2d850513          	addi	a0,a0,728 # 6a90 <malloc+0xa7e>
    17c0:	00004097          	auipc	ra,0x4
    17c4:	794080e7          	jalr	1940(ra) # 5f54 <printf>
      exit(1);
    17c8:	4505                	li	a0,1
    17ca:	00004097          	auipc	ra,0x4
    17ce:	40a080e7          	jalr	1034(ra) # 5bd4 <exit>
     printf("%s: fork failed\n", s);
    17d2:	85ca                	mv	a1,s2
    17d4:	00005517          	auipc	a0,0x5
    17d8:	20c50513          	addi	a0,a0,524 # 69e0 <malloc+0x9ce>
    17dc:	00004097          	auipc	ra,0x4
    17e0:	778080e7          	jalr	1912(ra) # 5f54 <printf>
     exit(1);
    17e4:	4505                	li	a0,1
    17e6:	00004097          	auipc	ra,0x4
    17ea:	3ee080e7          	jalr	1006(ra) # 5bd4 <exit>
      printf("%s: create failed\n", s);
    17ee:	85ca                	mv	a1,s2
    17f0:	00005517          	auipc	a0,0x5
    17f4:	28850513          	addi	a0,a0,648 # 6a78 <malloc+0xa66>
    17f8:	00004097          	auipc	ra,0x4
    17fc:	75c080e7          	jalr	1884(ra) # 5f54 <printf>
      exit(1);
    1800:	4505                	li	a0,1
    1802:	00004097          	auipc	ra,0x4
    1806:	3d2080e7          	jalr	978(ra) # 5bd4 <exit>
    if(exec("echo", echoargv) < 0){
    180a:	fc040593          	addi	a1,s0,-64
    180e:	00005517          	auipc	a0,0x5
    1812:	94a50513          	addi	a0,a0,-1718 # 6158 <malloc+0x146>
    1816:	00004097          	auipc	ra,0x4
    181a:	3f6080e7          	jalr	1014(ra) # 5c0c <exec>
    181e:	02054163          	bltz	a0,1840 <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    1822:	fdc40513          	addi	a0,s0,-36
    1826:	00004097          	auipc	ra,0x4
    182a:	3b6080e7          	jalr	950(ra) # 5bdc <wait>
    182e:	02951763          	bne	a0,s1,185c <exectest+0x118>
  if(xstatus != 0)
    1832:	fdc42503          	lw	a0,-36(s0)
    1836:	cd0d                	beqz	a0,1870 <exectest+0x12c>
    exit(xstatus);
    1838:	00004097          	auipc	ra,0x4
    183c:	39c080e7          	jalr	924(ra) # 5bd4 <exit>
      printf("%s: exec echo failed\n", s);
    1840:	85ca                	mv	a1,s2
    1842:	00005517          	auipc	a0,0x5
    1846:	25e50513          	addi	a0,a0,606 # 6aa0 <malloc+0xa8e>
    184a:	00004097          	auipc	ra,0x4
    184e:	70a080e7          	jalr	1802(ra) # 5f54 <printf>
      exit(1);
    1852:	4505                	li	a0,1
    1854:	00004097          	auipc	ra,0x4
    1858:	380080e7          	jalr	896(ra) # 5bd4 <exit>
    printf("%s: wait failed!\n", s);
    185c:	85ca                	mv	a1,s2
    185e:	00005517          	auipc	a0,0x5
    1862:	25a50513          	addi	a0,a0,602 # 6ab8 <malloc+0xaa6>
    1866:	00004097          	auipc	ra,0x4
    186a:	6ee080e7          	jalr	1774(ra) # 5f54 <printf>
    186e:	b7d1                	j	1832 <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    1870:	4581                	li	a1,0
    1872:	00005517          	auipc	a0,0x5
    1876:	1fe50513          	addi	a0,a0,510 # 6a70 <malloc+0xa5e>
    187a:	00004097          	auipc	ra,0x4
    187e:	39a080e7          	jalr	922(ra) # 5c14 <open>
  if(fd < 0) {
    1882:	02054a63          	bltz	a0,18b6 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    1886:	4609                	li	a2,2
    1888:	fb840593          	addi	a1,s0,-72
    188c:	00004097          	auipc	ra,0x4
    1890:	360080e7          	jalr	864(ra) # 5bec <read>
    1894:	4789                	li	a5,2
    1896:	02f50e63          	beq	a0,a5,18d2 <exectest+0x18e>
    printf("%s: read failed\n", s);
    189a:	85ca                	mv	a1,s2
    189c:	00005517          	auipc	a0,0x5
    18a0:	c8c50513          	addi	a0,a0,-884 # 6528 <malloc+0x516>
    18a4:	00004097          	auipc	ra,0x4
    18a8:	6b0080e7          	jalr	1712(ra) # 5f54 <printf>
    exit(1);
    18ac:	4505                	li	a0,1
    18ae:	00004097          	auipc	ra,0x4
    18b2:	326080e7          	jalr	806(ra) # 5bd4 <exit>
    printf("%s: open failed\n", s);
    18b6:	85ca                	mv	a1,s2
    18b8:	00005517          	auipc	a0,0x5
    18bc:	14050513          	addi	a0,a0,320 # 69f8 <malloc+0x9e6>
    18c0:	00004097          	auipc	ra,0x4
    18c4:	694080e7          	jalr	1684(ra) # 5f54 <printf>
    exit(1);
    18c8:	4505                	li	a0,1
    18ca:	00004097          	auipc	ra,0x4
    18ce:	30a080e7          	jalr	778(ra) # 5bd4 <exit>
  unlink("echo-ok");
    18d2:	00005517          	auipc	a0,0x5
    18d6:	19e50513          	addi	a0,a0,414 # 6a70 <malloc+0xa5e>
    18da:	00004097          	auipc	ra,0x4
    18de:	34a080e7          	jalr	842(ra) # 5c24 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    18e2:	fb844703          	lbu	a4,-72(s0)
    18e6:	04f00793          	li	a5,79
    18ea:	00f71863          	bne	a4,a5,18fa <exectest+0x1b6>
    18ee:	fb944703          	lbu	a4,-71(s0)
    18f2:	04b00793          	li	a5,75
    18f6:	02f70063          	beq	a4,a5,1916 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    18fa:	85ca                	mv	a1,s2
    18fc:	00005517          	auipc	a0,0x5
    1900:	1d450513          	addi	a0,a0,468 # 6ad0 <malloc+0xabe>
    1904:	00004097          	auipc	ra,0x4
    1908:	650080e7          	jalr	1616(ra) # 5f54 <printf>
    exit(1);
    190c:	4505                	li	a0,1
    190e:	00004097          	auipc	ra,0x4
    1912:	2c6080e7          	jalr	710(ra) # 5bd4 <exit>
    exit(0);
    1916:	4501                	li	a0,0
    1918:	00004097          	auipc	ra,0x4
    191c:	2bc080e7          	jalr	700(ra) # 5bd4 <exit>

0000000000001920 <pipe1>:
{
    1920:	711d                	addi	sp,sp,-96
    1922:	ec86                	sd	ra,88(sp)
    1924:	e8a2                	sd	s0,80(sp)
    1926:	e4a6                	sd	s1,72(sp)
    1928:	e0ca                	sd	s2,64(sp)
    192a:	fc4e                	sd	s3,56(sp)
    192c:	f852                	sd	s4,48(sp)
    192e:	f456                	sd	s5,40(sp)
    1930:	f05a                	sd	s6,32(sp)
    1932:	ec5e                	sd	s7,24(sp)
    1934:	1080                	addi	s0,sp,96
    1936:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    1938:	fa840513          	addi	a0,s0,-88
    193c:	00004097          	auipc	ra,0x4
    1940:	2a8080e7          	jalr	680(ra) # 5be4 <pipe>
    1944:	ed25                	bnez	a0,19bc <pipe1+0x9c>
    1946:	84aa                	mv	s1,a0
  pid = fork();
    1948:	00004097          	auipc	ra,0x4
    194c:	284080e7          	jalr	644(ra) # 5bcc <fork>
    1950:	8a2a                	mv	s4,a0
  if(pid == 0){
    1952:	c159                	beqz	a0,19d8 <pipe1+0xb8>
  } else if(pid > 0){
    1954:	16a05e63          	blez	a0,1ad0 <pipe1+0x1b0>
    close(fds[1]);
    1958:	fac42503          	lw	a0,-84(s0)
    195c:	00004097          	auipc	ra,0x4
    1960:	2a0080e7          	jalr	672(ra) # 5bfc <close>
    total = 0;
    1964:	8a26                	mv	s4,s1
    cc = 1;
    1966:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    1968:	0000ba97          	auipc	s5,0xb
    196c:	310a8a93          	addi	s5,s5,784 # cc78 <buf>
      if(cc > sizeof(buf))
    1970:	6b0d                	lui	s6,0x3
    while((n = read(fds[0], buf, cc)) > 0){
    1972:	864e                	mv	a2,s3
    1974:	85d6                	mv	a1,s5
    1976:	fa842503          	lw	a0,-88(s0)
    197a:	00004097          	auipc	ra,0x4
    197e:	272080e7          	jalr	626(ra) # 5bec <read>
    1982:	10a05263          	blez	a0,1a86 <pipe1+0x166>
      for(i = 0; i < n; i++){
    1986:	0000b717          	auipc	a4,0xb
    198a:	2f270713          	addi	a4,a4,754 # cc78 <buf>
    198e:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1992:	00074683          	lbu	a3,0(a4)
    1996:	0ff4f793          	andi	a5,s1,255
    199a:	2485                	addiw	s1,s1,1
    199c:	0cf69163          	bne	a3,a5,1a5e <pipe1+0x13e>
      for(i = 0; i < n; i++){
    19a0:	0705                	addi	a4,a4,1
    19a2:	fec498e3          	bne	s1,a2,1992 <pipe1+0x72>
      total += n;
    19a6:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    19aa:	0019979b          	slliw	a5,s3,0x1
    19ae:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    19b2:	013b7363          	bgeu	s6,s3,19b8 <pipe1+0x98>
        cc = sizeof(buf);
    19b6:	89da                	mv	s3,s6
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    19b8:	84b2                	mv	s1,a2
    19ba:	bf65                	j	1972 <pipe1+0x52>
    printf("%s: pipe() failed\n", s);
    19bc:	85ca                	mv	a1,s2
    19be:	00005517          	auipc	a0,0x5
    19c2:	12a50513          	addi	a0,a0,298 # 6ae8 <malloc+0xad6>
    19c6:	00004097          	auipc	ra,0x4
    19ca:	58e080e7          	jalr	1422(ra) # 5f54 <printf>
    exit(1);
    19ce:	4505                	li	a0,1
    19d0:	00004097          	auipc	ra,0x4
    19d4:	204080e7          	jalr	516(ra) # 5bd4 <exit>
    close(fds[0]);
    19d8:	fa842503          	lw	a0,-88(s0)
    19dc:	00004097          	auipc	ra,0x4
    19e0:	220080e7          	jalr	544(ra) # 5bfc <close>
    for(n = 0; n < N; n++){
    19e4:	0000bb17          	auipc	s6,0xb
    19e8:	294b0b13          	addi	s6,s6,660 # cc78 <buf>
    19ec:	416004bb          	negw	s1,s6
    19f0:	0ff4f493          	andi	s1,s1,255
    19f4:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    19f8:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    19fa:	6a85                	lui	s5,0x1
    19fc:	42da8a93          	addi	s5,s5,1069 # 142d <copyinstr2+0x99>
{
    1a00:	87da                	mv	a5,s6
        buf[i] = seq++;
    1a02:	0097873b          	addw	a4,a5,s1
    1a06:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1a0a:	0785                	addi	a5,a5,1
    1a0c:	fef99be3          	bne	s3,a5,1a02 <pipe1+0xe2>
    1a10:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1a14:	40900613          	li	a2,1033
    1a18:	85de                	mv	a1,s7
    1a1a:	fac42503          	lw	a0,-84(s0)
    1a1e:	00004097          	auipc	ra,0x4
    1a22:	1d6080e7          	jalr	470(ra) # 5bf4 <write>
    1a26:	40900793          	li	a5,1033
    1a2a:	00f51c63          	bne	a0,a5,1a42 <pipe1+0x122>
    for(n = 0; n < N; n++){
    1a2e:	24a5                	addiw	s1,s1,9
    1a30:	0ff4f493          	andi	s1,s1,255
    1a34:	fd5a16e3          	bne	s4,s5,1a00 <pipe1+0xe0>
    exit(0);
    1a38:	4501                	li	a0,0
    1a3a:	00004097          	auipc	ra,0x4
    1a3e:	19a080e7          	jalr	410(ra) # 5bd4 <exit>
        printf("%s: pipe1 oops 1\n", s);
    1a42:	85ca                	mv	a1,s2
    1a44:	00005517          	auipc	a0,0x5
    1a48:	0bc50513          	addi	a0,a0,188 # 6b00 <malloc+0xaee>
    1a4c:	00004097          	auipc	ra,0x4
    1a50:	508080e7          	jalr	1288(ra) # 5f54 <printf>
        exit(1);
    1a54:	4505                	li	a0,1
    1a56:	00004097          	auipc	ra,0x4
    1a5a:	17e080e7          	jalr	382(ra) # 5bd4 <exit>
          printf("%s: pipe1 oops 2\n", s);
    1a5e:	85ca                	mv	a1,s2
    1a60:	00005517          	auipc	a0,0x5
    1a64:	0b850513          	addi	a0,a0,184 # 6b18 <malloc+0xb06>
    1a68:	00004097          	auipc	ra,0x4
    1a6c:	4ec080e7          	jalr	1260(ra) # 5f54 <printf>
}
    1a70:	60e6                	ld	ra,88(sp)
    1a72:	6446                	ld	s0,80(sp)
    1a74:	64a6                	ld	s1,72(sp)
    1a76:	6906                	ld	s2,64(sp)
    1a78:	79e2                	ld	s3,56(sp)
    1a7a:	7a42                	ld	s4,48(sp)
    1a7c:	7aa2                	ld	s5,40(sp)
    1a7e:	7b02                	ld	s6,32(sp)
    1a80:	6be2                	ld	s7,24(sp)
    1a82:	6125                	addi	sp,sp,96
    1a84:	8082                	ret
    if(total != N * SZ){
    1a86:	6785                	lui	a5,0x1
    1a88:	42d78793          	addi	a5,a5,1069 # 142d <copyinstr2+0x99>
    1a8c:	02fa0063          	beq	s4,a5,1aac <pipe1+0x18c>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1a90:	85d2                	mv	a1,s4
    1a92:	00005517          	auipc	a0,0x5
    1a96:	09e50513          	addi	a0,a0,158 # 6b30 <malloc+0xb1e>
    1a9a:	00004097          	auipc	ra,0x4
    1a9e:	4ba080e7          	jalr	1210(ra) # 5f54 <printf>
      exit(1);
    1aa2:	4505                	li	a0,1
    1aa4:	00004097          	auipc	ra,0x4
    1aa8:	130080e7          	jalr	304(ra) # 5bd4 <exit>
    close(fds[0]);
    1aac:	fa842503          	lw	a0,-88(s0)
    1ab0:	00004097          	auipc	ra,0x4
    1ab4:	14c080e7          	jalr	332(ra) # 5bfc <close>
    wait(&xstatus);
    1ab8:	fa440513          	addi	a0,s0,-92
    1abc:	00004097          	auipc	ra,0x4
    1ac0:	120080e7          	jalr	288(ra) # 5bdc <wait>
    exit(xstatus);
    1ac4:	fa442503          	lw	a0,-92(s0)
    1ac8:	00004097          	auipc	ra,0x4
    1acc:	10c080e7          	jalr	268(ra) # 5bd4 <exit>
    printf("%s: fork() failed\n", s);
    1ad0:	85ca                	mv	a1,s2
    1ad2:	00005517          	auipc	a0,0x5
    1ad6:	07e50513          	addi	a0,a0,126 # 6b50 <malloc+0xb3e>
    1ada:	00004097          	auipc	ra,0x4
    1ade:	47a080e7          	jalr	1146(ra) # 5f54 <printf>
    exit(1);
    1ae2:	4505                	li	a0,1
    1ae4:	00004097          	auipc	ra,0x4
    1ae8:	0f0080e7          	jalr	240(ra) # 5bd4 <exit>

0000000000001aec <exitwait>:
{
    1aec:	7139                	addi	sp,sp,-64
    1aee:	fc06                	sd	ra,56(sp)
    1af0:	f822                	sd	s0,48(sp)
    1af2:	f426                	sd	s1,40(sp)
    1af4:	f04a                	sd	s2,32(sp)
    1af6:	ec4e                	sd	s3,24(sp)
    1af8:	e852                	sd	s4,16(sp)
    1afa:	0080                	addi	s0,sp,64
    1afc:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1afe:	4901                	li	s2,0
    1b00:	06400993          	li	s3,100
    pid = fork();
    1b04:	00004097          	auipc	ra,0x4
    1b08:	0c8080e7          	jalr	200(ra) # 5bcc <fork>
    1b0c:	84aa                	mv	s1,a0
    if(pid < 0){
    1b0e:	02054a63          	bltz	a0,1b42 <exitwait+0x56>
    if(pid){
    1b12:	c151                	beqz	a0,1b96 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    1b14:	fcc40513          	addi	a0,s0,-52
    1b18:	00004097          	auipc	ra,0x4
    1b1c:	0c4080e7          	jalr	196(ra) # 5bdc <wait>
    1b20:	02951f63          	bne	a0,s1,1b5e <exitwait+0x72>
      if(i != xstate) {
    1b24:	fcc42783          	lw	a5,-52(s0)
    1b28:	05279963          	bne	a5,s2,1b7a <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    1b2c:	2905                	addiw	s2,s2,1
    1b2e:	fd391be3          	bne	s2,s3,1b04 <exitwait+0x18>
}
    1b32:	70e2                	ld	ra,56(sp)
    1b34:	7442                	ld	s0,48(sp)
    1b36:	74a2                	ld	s1,40(sp)
    1b38:	7902                	ld	s2,32(sp)
    1b3a:	69e2                	ld	s3,24(sp)
    1b3c:	6a42                	ld	s4,16(sp)
    1b3e:	6121                	addi	sp,sp,64
    1b40:	8082                	ret
      printf("%s: fork failed\n", s);
    1b42:	85d2                	mv	a1,s4
    1b44:	00005517          	auipc	a0,0x5
    1b48:	e9c50513          	addi	a0,a0,-356 # 69e0 <malloc+0x9ce>
    1b4c:	00004097          	auipc	ra,0x4
    1b50:	408080e7          	jalr	1032(ra) # 5f54 <printf>
      exit(1);
    1b54:	4505                	li	a0,1
    1b56:	00004097          	auipc	ra,0x4
    1b5a:	07e080e7          	jalr	126(ra) # 5bd4 <exit>
        printf("%s: wait wrong pid\n", s);
    1b5e:	85d2                	mv	a1,s4
    1b60:	00005517          	auipc	a0,0x5
    1b64:	00850513          	addi	a0,a0,8 # 6b68 <malloc+0xb56>
    1b68:	00004097          	auipc	ra,0x4
    1b6c:	3ec080e7          	jalr	1004(ra) # 5f54 <printf>
        exit(1);
    1b70:	4505                	li	a0,1
    1b72:	00004097          	auipc	ra,0x4
    1b76:	062080e7          	jalr	98(ra) # 5bd4 <exit>
        printf("%s: wait wrong exit status\n", s);
    1b7a:	85d2                	mv	a1,s4
    1b7c:	00005517          	auipc	a0,0x5
    1b80:	00450513          	addi	a0,a0,4 # 6b80 <malloc+0xb6e>
    1b84:	00004097          	auipc	ra,0x4
    1b88:	3d0080e7          	jalr	976(ra) # 5f54 <printf>
        exit(1);
    1b8c:	4505                	li	a0,1
    1b8e:	00004097          	auipc	ra,0x4
    1b92:	046080e7          	jalr	70(ra) # 5bd4 <exit>
      exit(i);
    1b96:	854a                	mv	a0,s2
    1b98:	00004097          	auipc	ra,0x4
    1b9c:	03c080e7          	jalr	60(ra) # 5bd4 <exit>

0000000000001ba0 <twochildren>:
{
    1ba0:	1101                	addi	sp,sp,-32
    1ba2:	ec06                	sd	ra,24(sp)
    1ba4:	e822                	sd	s0,16(sp)
    1ba6:	e426                	sd	s1,8(sp)
    1ba8:	e04a                	sd	s2,0(sp)
    1baa:	1000                	addi	s0,sp,32
    1bac:	892a                	mv	s2,a0
    1bae:	3e800493          	li	s1,1000
    int pid1 = fork();
    1bb2:	00004097          	auipc	ra,0x4
    1bb6:	01a080e7          	jalr	26(ra) # 5bcc <fork>
    if(pid1 < 0){
    1bba:	02054c63          	bltz	a0,1bf2 <twochildren+0x52>
    if(pid1 == 0){
    1bbe:	c921                	beqz	a0,1c0e <twochildren+0x6e>
      int pid2 = fork();
    1bc0:	00004097          	auipc	ra,0x4
    1bc4:	00c080e7          	jalr	12(ra) # 5bcc <fork>
      if(pid2 < 0){
    1bc8:	04054763          	bltz	a0,1c16 <twochildren+0x76>
      if(pid2 == 0){
    1bcc:	c13d                	beqz	a0,1c32 <twochildren+0x92>
        wait(0);
    1bce:	4501                	li	a0,0
    1bd0:	00004097          	auipc	ra,0x4
    1bd4:	00c080e7          	jalr	12(ra) # 5bdc <wait>
        wait(0);
    1bd8:	4501                	li	a0,0
    1bda:	00004097          	auipc	ra,0x4
    1bde:	002080e7          	jalr	2(ra) # 5bdc <wait>
  for(int i = 0; i < 1000; i++){
    1be2:	34fd                	addiw	s1,s1,-1
    1be4:	f4f9                	bnez	s1,1bb2 <twochildren+0x12>
}
    1be6:	60e2                	ld	ra,24(sp)
    1be8:	6442                	ld	s0,16(sp)
    1bea:	64a2                	ld	s1,8(sp)
    1bec:	6902                	ld	s2,0(sp)
    1bee:	6105                	addi	sp,sp,32
    1bf0:	8082                	ret
      printf("%s: fork failed\n", s);
    1bf2:	85ca                	mv	a1,s2
    1bf4:	00005517          	auipc	a0,0x5
    1bf8:	dec50513          	addi	a0,a0,-532 # 69e0 <malloc+0x9ce>
    1bfc:	00004097          	auipc	ra,0x4
    1c00:	358080e7          	jalr	856(ra) # 5f54 <printf>
      exit(1);
    1c04:	4505                	li	a0,1
    1c06:	00004097          	auipc	ra,0x4
    1c0a:	fce080e7          	jalr	-50(ra) # 5bd4 <exit>
      exit(0);
    1c0e:	00004097          	auipc	ra,0x4
    1c12:	fc6080e7          	jalr	-58(ra) # 5bd4 <exit>
        printf("%s: fork failed\n", s);
    1c16:	85ca                	mv	a1,s2
    1c18:	00005517          	auipc	a0,0x5
    1c1c:	dc850513          	addi	a0,a0,-568 # 69e0 <malloc+0x9ce>
    1c20:	00004097          	auipc	ra,0x4
    1c24:	334080e7          	jalr	820(ra) # 5f54 <printf>
        exit(1);
    1c28:	4505                	li	a0,1
    1c2a:	00004097          	auipc	ra,0x4
    1c2e:	faa080e7          	jalr	-86(ra) # 5bd4 <exit>
        exit(0);
    1c32:	00004097          	auipc	ra,0x4
    1c36:	fa2080e7          	jalr	-94(ra) # 5bd4 <exit>

0000000000001c3a <forkfork>:
{
    1c3a:	7179                	addi	sp,sp,-48
    1c3c:	f406                	sd	ra,40(sp)
    1c3e:	f022                	sd	s0,32(sp)
    1c40:	ec26                	sd	s1,24(sp)
    1c42:	1800                	addi	s0,sp,48
    1c44:	84aa                	mv	s1,a0
    int pid = fork();
    1c46:	00004097          	auipc	ra,0x4
    1c4a:	f86080e7          	jalr	-122(ra) # 5bcc <fork>
    if(pid < 0){
    1c4e:	04054163          	bltz	a0,1c90 <forkfork+0x56>
    if(pid == 0){
    1c52:	cd29                	beqz	a0,1cac <forkfork+0x72>
    int pid = fork();
    1c54:	00004097          	auipc	ra,0x4
    1c58:	f78080e7          	jalr	-136(ra) # 5bcc <fork>
    if(pid < 0){
    1c5c:	02054a63          	bltz	a0,1c90 <forkfork+0x56>
    if(pid == 0){
    1c60:	c531                	beqz	a0,1cac <forkfork+0x72>
    wait(&xstatus);
    1c62:	fdc40513          	addi	a0,s0,-36
    1c66:	00004097          	auipc	ra,0x4
    1c6a:	f76080e7          	jalr	-138(ra) # 5bdc <wait>
    if(xstatus != 0) {
    1c6e:	fdc42783          	lw	a5,-36(s0)
    1c72:	ebbd                	bnez	a5,1ce8 <forkfork+0xae>
    wait(&xstatus);
    1c74:	fdc40513          	addi	a0,s0,-36
    1c78:	00004097          	auipc	ra,0x4
    1c7c:	f64080e7          	jalr	-156(ra) # 5bdc <wait>
    if(xstatus != 0) {
    1c80:	fdc42783          	lw	a5,-36(s0)
    1c84:	e3b5                	bnez	a5,1ce8 <forkfork+0xae>
}
    1c86:	70a2                	ld	ra,40(sp)
    1c88:	7402                	ld	s0,32(sp)
    1c8a:	64e2                	ld	s1,24(sp)
    1c8c:	6145                	addi	sp,sp,48
    1c8e:	8082                	ret
      printf("%s: fork failed", s);
    1c90:	85a6                	mv	a1,s1
    1c92:	00005517          	auipc	a0,0x5
    1c96:	f0e50513          	addi	a0,a0,-242 # 6ba0 <malloc+0xb8e>
    1c9a:	00004097          	auipc	ra,0x4
    1c9e:	2ba080e7          	jalr	698(ra) # 5f54 <printf>
      exit(1);
    1ca2:	4505                	li	a0,1
    1ca4:	00004097          	auipc	ra,0x4
    1ca8:	f30080e7          	jalr	-208(ra) # 5bd4 <exit>
{
    1cac:	0c800493          	li	s1,200
        int pid1 = fork();
    1cb0:	00004097          	auipc	ra,0x4
    1cb4:	f1c080e7          	jalr	-228(ra) # 5bcc <fork>
        if(pid1 < 0){
    1cb8:	00054f63          	bltz	a0,1cd6 <forkfork+0x9c>
        if(pid1 == 0){
    1cbc:	c115                	beqz	a0,1ce0 <forkfork+0xa6>
        wait(0);
    1cbe:	4501                	li	a0,0
    1cc0:	00004097          	auipc	ra,0x4
    1cc4:	f1c080e7          	jalr	-228(ra) # 5bdc <wait>
      for(int j = 0; j < 200; j++){
    1cc8:	34fd                	addiw	s1,s1,-1
    1cca:	f0fd                	bnez	s1,1cb0 <forkfork+0x76>
      exit(0);
    1ccc:	4501                	li	a0,0
    1cce:	00004097          	auipc	ra,0x4
    1cd2:	f06080e7          	jalr	-250(ra) # 5bd4 <exit>
          exit(1);
    1cd6:	4505                	li	a0,1
    1cd8:	00004097          	auipc	ra,0x4
    1cdc:	efc080e7          	jalr	-260(ra) # 5bd4 <exit>
          exit(0);
    1ce0:	00004097          	auipc	ra,0x4
    1ce4:	ef4080e7          	jalr	-268(ra) # 5bd4 <exit>
      printf("%s: fork in child failed", s);
    1ce8:	85a6                	mv	a1,s1
    1cea:	00005517          	auipc	a0,0x5
    1cee:	ec650513          	addi	a0,a0,-314 # 6bb0 <malloc+0xb9e>
    1cf2:	00004097          	auipc	ra,0x4
    1cf6:	262080e7          	jalr	610(ra) # 5f54 <printf>
      exit(1);
    1cfa:	4505                	li	a0,1
    1cfc:	00004097          	auipc	ra,0x4
    1d00:	ed8080e7          	jalr	-296(ra) # 5bd4 <exit>

0000000000001d04 <reparent2>:
{
    1d04:	1101                	addi	sp,sp,-32
    1d06:	ec06                	sd	ra,24(sp)
    1d08:	e822                	sd	s0,16(sp)
    1d0a:	e426                	sd	s1,8(sp)
    1d0c:	1000                	addi	s0,sp,32
    1d0e:	32000493          	li	s1,800
    int pid1 = fork();
    1d12:	00004097          	auipc	ra,0x4
    1d16:	eba080e7          	jalr	-326(ra) # 5bcc <fork>
    if(pid1 < 0){
    1d1a:	00054f63          	bltz	a0,1d38 <reparent2+0x34>
    if(pid1 == 0){
    1d1e:	c915                	beqz	a0,1d52 <reparent2+0x4e>
    wait(0);
    1d20:	4501                	li	a0,0
    1d22:	00004097          	auipc	ra,0x4
    1d26:	eba080e7          	jalr	-326(ra) # 5bdc <wait>
  for(int i = 0; i < 800; i++){
    1d2a:	34fd                	addiw	s1,s1,-1
    1d2c:	f0fd                	bnez	s1,1d12 <reparent2+0xe>
  exit(0);
    1d2e:	4501                	li	a0,0
    1d30:	00004097          	auipc	ra,0x4
    1d34:	ea4080e7          	jalr	-348(ra) # 5bd4 <exit>
      printf("fork failed\n");
    1d38:	00005517          	auipc	a0,0x5
    1d3c:	0b050513          	addi	a0,a0,176 # 6de8 <malloc+0xdd6>
    1d40:	00004097          	auipc	ra,0x4
    1d44:	214080e7          	jalr	532(ra) # 5f54 <printf>
      exit(1);
    1d48:	4505                	li	a0,1
    1d4a:	00004097          	auipc	ra,0x4
    1d4e:	e8a080e7          	jalr	-374(ra) # 5bd4 <exit>
      fork();
    1d52:	00004097          	auipc	ra,0x4
    1d56:	e7a080e7          	jalr	-390(ra) # 5bcc <fork>
      fork();
    1d5a:	00004097          	auipc	ra,0x4
    1d5e:	e72080e7          	jalr	-398(ra) # 5bcc <fork>
      exit(0);
    1d62:	4501                	li	a0,0
    1d64:	00004097          	auipc	ra,0x4
    1d68:	e70080e7          	jalr	-400(ra) # 5bd4 <exit>

0000000000001d6c <createdelete>:
{
    1d6c:	7175                	addi	sp,sp,-144
    1d6e:	e506                	sd	ra,136(sp)
    1d70:	e122                	sd	s0,128(sp)
    1d72:	fca6                	sd	s1,120(sp)
    1d74:	f8ca                	sd	s2,112(sp)
    1d76:	f4ce                	sd	s3,104(sp)
    1d78:	f0d2                	sd	s4,96(sp)
    1d7a:	ecd6                	sd	s5,88(sp)
    1d7c:	e8da                	sd	s6,80(sp)
    1d7e:	e4de                	sd	s7,72(sp)
    1d80:	e0e2                	sd	s8,64(sp)
    1d82:	fc66                	sd	s9,56(sp)
    1d84:	0900                	addi	s0,sp,144
    1d86:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1d88:	4901                	li	s2,0
    1d8a:	4991                	li	s3,4
    pid = fork();
    1d8c:	00004097          	auipc	ra,0x4
    1d90:	e40080e7          	jalr	-448(ra) # 5bcc <fork>
    1d94:	84aa                	mv	s1,a0
    if(pid < 0){
    1d96:	02054f63          	bltz	a0,1dd4 <createdelete+0x68>
    if(pid == 0){
    1d9a:	c939                	beqz	a0,1df0 <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1d9c:	2905                	addiw	s2,s2,1
    1d9e:	ff3917e3          	bne	s2,s3,1d8c <createdelete+0x20>
    1da2:	4491                	li	s1,4
    wait(&xstatus);
    1da4:	f7c40513          	addi	a0,s0,-132
    1da8:	00004097          	auipc	ra,0x4
    1dac:	e34080e7          	jalr	-460(ra) # 5bdc <wait>
    if(xstatus != 0)
    1db0:	f7c42903          	lw	s2,-132(s0)
    1db4:	0e091263          	bnez	s2,1e98 <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    1db8:	34fd                	addiw	s1,s1,-1
    1dba:	f4ed                	bnez	s1,1da4 <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1dbc:	f8040123          	sb	zero,-126(s0)
    1dc0:	03000993          	li	s3,48
    1dc4:	5a7d                	li	s4,-1
    1dc6:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1dca:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1dcc:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1dce:	07400a93          	li	s5,116
    1dd2:	a29d                	j	1f38 <createdelete+0x1cc>
      printf("fork failed\n", s);
    1dd4:	85e6                	mv	a1,s9
    1dd6:	00005517          	auipc	a0,0x5
    1dda:	01250513          	addi	a0,a0,18 # 6de8 <malloc+0xdd6>
    1dde:	00004097          	auipc	ra,0x4
    1de2:	176080e7          	jalr	374(ra) # 5f54 <printf>
      exit(1);
    1de6:	4505                	li	a0,1
    1de8:	00004097          	auipc	ra,0x4
    1dec:	dec080e7          	jalr	-532(ra) # 5bd4 <exit>
      name[0] = 'p' + pi;
    1df0:	0709091b          	addiw	s2,s2,112
    1df4:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1df8:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1dfc:	4951                	li	s2,20
    1dfe:	a015                	j	1e22 <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1e00:	85e6                	mv	a1,s9
    1e02:	00005517          	auipc	a0,0x5
    1e06:	c7650513          	addi	a0,a0,-906 # 6a78 <malloc+0xa66>
    1e0a:	00004097          	auipc	ra,0x4
    1e0e:	14a080e7          	jalr	330(ra) # 5f54 <printf>
          exit(1);
    1e12:	4505                	li	a0,1
    1e14:	00004097          	auipc	ra,0x4
    1e18:	dc0080e7          	jalr	-576(ra) # 5bd4 <exit>
      for(i = 0; i < N; i++){
    1e1c:	2485                	addiw	s1,s1,1
    1e1e:	07248863          	beq	s1,s2,1e8e <createdelete+0x122>
        name[1] = '0' + i;
    1e22:	0304879b          	addiw	a5,s1,48
    1e26:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1e2a:	20200593          	li	a1,514
    1e2e:	f8040513          	addi	a0,s0,-128
    1e32:	00004097          	auipc	ra,0x4
    1e36:	de2080e7          	jalr	-542(ra) # 5c14 <open>
        if(fd < 0){
    1e3a:	fc0543e3          	bltz	a0,1e00 <createdelete+0x94>
        close(fd);
    1e3e:	00004097          	auipc	ra,0x4
    1e42:	dbe080e7          	jalr	-578(ra) # 5bfc <close>
        if(i > 0 && (i % 2 ) == 0){
    1e46:	fc905be3          	blez	s1,1e1c <createdelete+0xb0>
    1e4a:	0014f793          	andi	a5,s1,1
    1e4e:	f7f9                	bnez	a5,1e1c <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1e50:	01f4d79b          	srliw	a5,s1,0x1f
    1e54:	9fa5                	addw	a5,a5,s1
    1e56:	4017d79b          	sraiw	a5,a5,0x1
    1e5a:	0307879b          	addiw	a5,a5,48
    1e5e:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1e62:	f8040513          	addi	a0,s0,-128
    1e66:	00004097          	auipc	ra,0x4
    1e6a:	dbe080e7          	jalr	-578(ra) # 5c24 <unlink>
    1e6e:	fa0557e3          	bgez	a0,1e1c <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1e72:	85e6                	mv	a1,s9
    1e74:	00005517          	auipc	a0,0x5
    1e78:	d5c50513          	addi	a0,a0,-676 # 6bd0 <malloc+0xbbe>
    1e7c:	00004097          	auipc	ra,0x4
    1e80:	0d8080e7          	jalr	216(ra) # 5f54 <printf>
            exit(1);
    1e84:	4505                	li	a0,1
    1e86:	00004097          	auipc	ra,0x4
    1e8a:	d4e080e7          	jalr	-690(ra) # 5bd4 <exit>
      exit(0);
    1e8e:	4501                	li	a0,0
    1e90:	00004097          	auipc	ra,0x4
    1e94:	d44080e7          	jalr	-700(ra) # 5bd4 <exit>
      exit(1);
    1e98:	4505                	li	a0,1
    1e9a:	00004097          	auipc	ra,0x4
    1e9e:	d3a080e7          	jalr	-710(ra) # 5bd4 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1ea2:	f8040613          	addi	a2,s0,-128
    1ea6:	85e6                	mv	a1,s9
    1ea8:	00005517          	auipc	a0,0x5
    1eac:	d4050513          	addi	a0,a0,-704 # 6be8 <malloc+0xbd6>
    1eb0:	00004097          	auipc	ra,0x4
    1eb4:	0a4080e7          	jalr	164(ra) # 5f54 <printf>
        exit(1);
    1eb8:	4505                	li	a0,1
    1eba:	00004097          	auipc	ra,0x4
    1ebe:	d1a080e7          	jalr	-742(ra) # 5bd4 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ec2:	054b7163          	bgeu	s6,s4,1f04 <createdelete+0x198>
      if(fd >= 0)
    1ec6:	02055a63          	bgez	a0,1efa <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
    1eca:	2485                	addiw	s1,s1,1
    1ecc:	0ff4f493          	andi	s1,s1,255
    1ed0:	05548c63          	beq	s1,s5,1f28 <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1ed4:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1ed8:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1edc:	4581                	li	a1,0
    1ede:	f8040513          	addi	a0,s0,-128
    1ee2:	00004097          	auipc	ra,0x4
    1ee6:	d32080e7          	jalr	-718(ra) # 5c14 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1eea:	00090463          	beqz	s2,1ef2 <createdelete+0x186>
    1eee:	fd2bdae3          	bge	s7,s2,1ec2 <createdelete+0x156>
    1ef2:	fa0548e3          	bltz	a0,1ea2 <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ef6:	014b7963          	bgeu	s6,s4,1f08 <createdelete+0x19c>
        close(fd);
    1efa:	00004097          	auipc	ra,0x4
    1efe:	d02080e7          	jalr	-766(ra) # 5bfc <close>
    1f02:	b7e1                	j	1eca <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1f04:	fc0543e3          	bltz	a0,1eca <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1f08:	f8040613          	addi	a2,s0,-128
    1f0c:	85e6                	mv	a1,s9
    1f0e:	00005517          	auipc	a0,0x5
    1f12:	d0250513          	addi	a0,a0,-766 # 6c10 <malloc+0xbfe>
    1f16:	00004097          	auipc	ra,0x4
    1f1a:	03e080e7          	jalr	62(ra) # 5f54 <printf>
        exit(1);
    1f1e:	4505                	li	a0,1
    1f20:	00004097          	auipc	ra,0x4
    1f24:	cb4080e7          	jalr	-844(ra) # 5bd4 <exit>
  for(i = 0; i < N; i++){
    1f28:	2905                	addiw	s2,s2,1
    1f2a:	2a05                	addiw	s4,s4,1
    1f2c:	2985                	addiw	s3,s3,1
    1f2e:	0ff9f993          	andi	s3,s3,255
    1f32:	47d1                	li	a5,20
    1f34:	02f90a63          	beq	s2,a5,1f68 <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
    1f38:	84e2                	mv	s1,s8
    1f3a:	bf69                	j	1ed4 <createdelete+0x168>
  for(i = 0; i < N; i++){
    1f3c:	2905                	addiw	s2,s2,1
    1f3e:	0ff97913          	andi	s2,s2,255
    1f42:	2985                	addiw	s3,s3,1
    1f44:	0ff9f993          	andi	s3,s3,255
    1f48:	03490863          	beq	s2,s4,1f78 <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1f4c:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1f4e:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1f52:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1f56:	f8040513          	addi	a0,s0,-128
    1f5a:	00004097          	auipc	ra,0x4
    1f5e:	cca080e7          	jalr	-822(ra) # 5c24 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1f62:	34fd                	addiw	s1,s1,-1
    1f64:	f4ed                	bnez	s1,1f4e <createdelete+0x1e2>
    1f66:	bfd9                	j	1f3c <createdelete+0x1d0>
    1f68:	03000993          	li	s3,48
    1f6c:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1f70:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1f72:	08400a13          	li	s4,132
    1f76:	bfd9                	j	1f4c <createdelete+0x1e0>
}
    1f78:	60aa                	ld	ra,136(sp)
    1f7a:	640a                	ld	s0,128(sp)
    1f7c:	74e6                	ld	s1,120(sp)
    1f7e:	7946                	ld	s2,112(sp)
    1f80:	79a6                	ld	s3,104(sp)
    1f82:	7a06                	ld	s4,96(sp)
    1f84:	6ae6                	ld	s5,88(sp)
    1f86:	6b46                	ld	s6,80(sp)
    1f88:	6ba6                	ld	s7,72(sp)
    1f8a:	6c06                	ld	s8,64(sp)
    1f8c:	7ce2                	ld	s9,56(sp)
    1f8e:	6149                	addi	sp,sp,144
    1f90:	8082                	ret

0000000000001f92 <linkunlink>:
{
    1f92:	711d                	addi	sp,sp,-96
    1f94:	ec86                	sd	ra,88(sp)
    1f96:	e8a2                	sd	s0,80(sp)
    1f98:	e4a6                	sd	s1,72(sp)
    1f9a:	e0ca                	sd	s2,64(sp)
    1f9c:	fc4e                	sd	s3,56(sp)
    1f9e:	f852                	sd	s4,48(sp)
    1fa0:	f456                	sd	s5,40(sp)
    1fa2:	f05a                	sd	s6,32(sp)
    1fa4:	ec5e                	sd	s7,24(sp)
    1fa6:	e862                	sd	s8,16(sp)
    1fa8:	e466                	sd	s9,8(sp)
    1faa:	1080                	addi	s0,sp,96
    1fac:	84aa                	mv	s1,a0
  unlink("x");
    1fae:	00004517          	auipc	a0,0x4
    1fb2:	21a50513          	addi	a0,a0,538 # 61c8 <malloc+0x1b6>
    1fb6:	00004097          	auipc	ra,0x4
    1fba:	c6e080e7          	jalr	-914(ra) # 5c24 <unlink>
  pid = fork();
    1fbe:	00004097          	auipc	ra,0x4
    1fc2:	c0e080e7          	jalr	-1010(ra) # 5bcc <fork>
  if(pid < 0){
    1fc6:	02054b63          	bltz	a0,1ffc <linkunlink+0x6a>
    1fca:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1fcc:	4c85                	li	s9,1
    1fce:	e119                	bnez	a0,1fd4 <linkunlink+0x42>
    1fd0:	06100c93          	li	s9,97
    1fd4:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1fd8:	41c659b7          	lui	s3,0x41c65
    1fdc:	e6d9899b          	addiw	s3,s3,-403
    1fe0:	690d                	lui	s2,0x3
    1fe2:	0399091b          	addiw	s2,s2,57
    if((x % 3) == 0){
    1fe6:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    1fe8:	4b05                	li	s6,1
      unlink("x");
    1fea:	00004a97          	auipc	s5,0x4
    1fee:	1dea8a93          	addi	s5,s5,478 # 61c8 <malloc+0x1b6>
      link("cat", "x");
    1ff2:	00005b97          	auipc	s7,0x5
    1ff6:	c46b8b93          	addi	s7,s7,-954 # 6c38 <malloc+0xc26>
    1ffa:	a091                	j	203e <linkunlink+0xac>
    printf("%s: fork failed\n", s);
    1ffc:	85a6                	mv	a1,s1
    1ffe:	00005517          	auipc	a0,0x5
    2002:	9e250513          	addi	a0,a0,-1566 # 69e0 <malloc+0x9ce>
    2006:	00004097          	auipc	ra,0x4
    200a:	f4e080e7          	jalr	-178(ra) # 5f54 <printf>
    exit(1);
    200e:	4505                	li	a0,1
    2010:	00004097          	auipc	ra,0x4
    2014:	bc4080e7          	jalr	-1084(ra) # 5bd4 <exit>
      close(open("x", O_RDWR | O_CREATE));
    2018:	20200593          	li	a1,514
    201c:	8556                	mv	a0,s5
    201e:	00004097          	auipc	ra,0x4
    2022:	bf6080e7          	jalr	-1034(ra) # 5c14 <open>
    2026:	00004097          	auipc	ra,0x4
    202a:	bd6080e7          	jalr	-1066(ra) # 5bfc <close>
    202e:	a031                	j	203a <linkunlink+0xa8>
      unlink("x");
    2030:	8556                	mv	a0,s5
    2032:	00004097          	auipc	ra,0x4
    2036:	bf2080e7          	jalr	-1038(ra) # 5c24 <unlink>
  for(i = 0; i < 100; i++){
    203a:	34fd                	addiw	s1,s1,-1
    203c:	c09d                	beqz	s1,2062 <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    203e:	033c87bb          	mulw	a5,s9,s3
    2042:	012787bb          	addw	a5,a5,s2
    2046:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    204a:	0347f7bb          	remuw	a5,a5,s4
    204e:	d7e9                	beqz	a5,2018 <linkunlink+0x86>
    } else if((x % 3) == 1){
    2050:	ff6790e3          	bne	a5,s6,2030 <linkunlink+0x9e>
      link("cat", "x");
    2054:	85d6                	mv	a1,s5
    2056:	855e                	mv	a0,s7
    2058:	00004097          	auipc	ra,0x4
    205c:	bdc080e7          	jalr	-1060(ra) # 5c34 <link>
    2060:	bfe9                	j	203a <linkunlink+0xa8>
  if(pid)
    2062:	020c0463          	beqz	s8,208a <linkunlink+0xf8>
    wait(0);
    2066:	4501                	li	a0,0
    2068:	00004097          	auipc	ra,0x4
    206c:	b74080e7          	jalr	-1164(ra) # 5bdc <wait>
}
    2070:	60e6                	ld	ra,88(sp)
    2072:	6446                	ld	s0,80(sp)
    2074:	64a6                	ld	s1,72(sp)
    2076:	6906                	ld	s2,64(sp)
    2078:	79e2                	ld	s3,56(sp)
    207a:	7a42                	ld	s4,48(sp)
    207c:	7aa2                	ld	s5,40(sp)
    207e:	7b02                	ld	s6,32(sp)
    2080:	6be2                	ld	s7,24(sp)
    2082:	6c42                	ld	s8,16(sp)
    2084:	6ca2                	ld	s9,8(sp)
    2086:	6125                	addi	sp,sp,96
    2088:	8082                	ret
    exit(0);
    208a:	4501                	li	a0,0
    208c:	00004097          	auipc	ra,0x4
    2090:	b48080e7          	jalr	-1208(ra) # 5bd4 <exit>

0000000000002094 <forktest>:
{
    2094:	7179                	addi	sp,sp,-48
    2096:	f406                	sd	ra,40(sp)
    2098:	f022                	sd	s0,32(sp)
    209a:	ec26                	sd	s1,24(sp)
    209c:	e84a                	sd	s2,16(sp)
    209e:	e44e                	sd	s3,8(sp)
    20a0:	1800                	addi	s0,sp,48
    20a2:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    20a4:	4481                	li	s1,0
    20a6:	3e800913          	li	s2,1000
    pid = fork();
    20aa:	00004097          	auipc	ra,0x4
    20ae:	b22080e7          	jalr	-1246(ra) # 5bcc <fork>
    if(pid < 0)
    20b2:	02054863          	bltz	a0,20e2 <forktest+0x4e>
    if(pid == 0)
    20b6:	c115                	beqz	a0,20da <forktest+0x46>
  for(n=0; n<N; n++){
    20b8:	2485                	addiw	s1,s1,1
    20ba:	ff2498e3          	bne	s1,s2,20aa <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    20be:	85ce                	mv	a1,s3
    20c0:	00005517          	auipc	a0,0x5
    20c4:	b9850513          	addi	a0,a0,-1128 # 6c58 <malloc+0xc46>
    20c8:	00004097          	auipc	ra,0x4
    20cc:	e8c080e7          	jalr	-372(ra) # 5f54 <printf>
    exit(1);
    20d0:	4505                	li	a0,1
    20d2:	00004097          	auipc	ra,0x4
    20d6:	b02080e7          	jalr	-1278(ra) # 5bd4 <exit>
      exit(0);
    20da:	00004097          	auipc	ra,0x4
    20de:	afa080e7          	jalr	-1286(ra) # 5bd4 <exit>
  if (n == 0) {
    20e2:	cc9d                	beqz	s1,2120 <forktest+0x8c>
  if(n == N){
    20e4:	3e800793          	li	a5,1000
    20e8:	fcf48be3          	beq	s1,a5,20be <forktest+0x2a>
  for(; n > 0; n--){
    20ec:	00905b63          	blez	s1,2102 <forktest+0x6e>
    if(wait(0) < 0){
    20f0:	4501                	li	a0,0
    20f2:	00004097          	auipc	ra,0x4
    20f6:	aea080e7          	jalr	-1302(ra) # 5bdc <wait>
    20fa:	04054163          	bltz	a0,213c <forktest+0xa8>
  for(; n > 0; n--){
    20fe:	34fd                	addiw	s1,s1,-1
    2100:	f8e5                	bnez	s1,20f0 <forktest+0x5c>
  if(wait(0) != -1){
    2102:	4501                	li	a0,0
    2104:	00004097          	auipc	ra,0x4
    2108:	ad8080e7          	jalr	-1320(ra) # 5bdc <wait>
    210c:	57fd                	li	a5,-1
    210e:	04f51563          	bne	a0,a5,2158 <forktest+0xc4>
}
    2112:	70a2                	ld	ra,40(sp)
    2114:	7402                	ld	s0,32(sp)
    2116:	64e2                	ld	s1,24(sp)
    2118:	6942                	ld	s2,16(sp)
    211a:	69a2                	ld	s3,8(sp)
    211c:	6145                	addi	sp,sp,48
    211e:	8082                	ret
    printf("%s: no fork at all!\n", s);
    2120:	85ce                	mv	a1,s3
    2122:	00005517          	auipc	a0,0x5
    2126:	b1e50513          	addi	a0,a0,-1250 # 6c40 <malloc+0xc2e>
    212a:	00004097          	auipc	ra,0x4
    212e:	e2a080e7          	jalr	-470(ra) # 5f54 <printf>
    exit(1);
    2132:	4505                	li	a0,1
    2134:	00004097          	auipc	ra,0x4
    2138:	aa0080e7          	jalr	-1376(ra) # 5bd4 <exit>
      printf("%s: wait stopped early\n", s);
    213c:	85ce                	mv	a1,s3
    213e:	00005517          	auipc	a0,0x5
    2142:	b4250513          	addi	a0,a0,-1214 # 6c80 <malloc+0xc6e>
    2146:	00004097          	auipc	ra,0x4
    214a:	e0e080e7          	jalr	-498(ra) # 5f54 <printf>
      exit(1);
    214e:	4505                	li	a0,1
    2150:	00004097          	auipc	ra,0x4
    2154:	a84080e7          	jalr	-1404(ra) # 5bd4 <exit>
    printf("%s: wait got too many\n", s);
    2158:	85ce                	mv	a1,s3
    215a:	00005517          	auipc	a0,0x5
    215e:	b3e50513          	addi	a0,a0,-1218 # 6c98 <malloc+0xc86>
    2162:	00004097          	auipc	ra,0x4
    2166:	df2080e7          	jalr	-526(ra) # 5f54 <printf>
    exit(1);
    216a:	4505                	li	a0,1
    216c:	00004097          	auipc	ra,0x4
    2170:	a68080e7          	jalr	-1432(ra) # 5bd4 <exit>

0000000000002174 <kernmem>:
{
    2174:	715d                	addi	sp,sp,-80
    2176:	e486                	sd	ra,72(sp)
    2178:	e0a2                	sd	s0,64(sp)
    217a:	fc26                	sd	s1,56(sp)
    217c:	f84a                	sd	s2,48(sp)
    217e:	f44e                	sd	s3,40(sp)
    2180:	f052                	sd	s4,32(sp)
    2182:	ec56                	sd	s5,24(sp)
    2184:	0880                	addi	s0,sp,80
    2186:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2188:	4485                	li	s1,1
    218a:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    218c:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    218e:	69b1                	lui	s3,0xc
    2190:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1de8>
    2194:	1003d937          	lui	s2,0x1003d
    2198:	090e                	slli	s2,s2,0x3
    219a:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    219e:	00004097          	auipc	ra,0x4
    21a2:	a2e080e7          	jalr	-1490(ra) # 5bcc <fork>
    if(pid < 0){
    21a6:	02054963          	bltz	a0,21d8 <kernmem+0x64>
    if(pid == 0){
    21aa:	c529                	beqz	a0,21f4 <kernmem+0x80>
    wait(&xstatus);
    21ac:	fbc40513          	addi	a0,s0,-68
    21b0:	00004097          	auipc	ra,0x4
    21b4:	a2c080e7          	jalr	-1492(ra) # 5bdc <wait>
    if(xstatus != -1)  // did kernel kill child?
    21b8:	fbc42783          	lw	a5,-68(s0)
    21bc:	05579d63          	bne	a5,s5,2216 <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    21c0:	94ce                	add	s1,s1,s3
    21c2:	fd249ee3          	bne	s1,s2,219e <kernmem+0x2a>
}
    21c6:	60a6                	ld	ra,72(sp)
    21c8:	6406                	ld	s0,64(sp)
    21ca:	74e2                	ld	s1,56(sp)
    21cc:	7942                	ld	s2,48(sp)
    21ce:	79a2                	ld	s3,40(sp)
    21d0:	7a02                	ld	s4,32(sp)
    21d2:	6ae2                	ld	s5,24(sp)
    21d4:	6161                	addi	sp,sp,80
    21d6:	8082                	ret
      printf("%s: fork failed\n", s);
    21d8:	85d2                	mv	a1,s4
    21da:	00005517          	auipc	a0,0x5
    21de:	80650513          	addi	a0,a0,-2042 # 69e0 <malloc+0x9ce>
    21e2:	00004097          	auipc	ra,0x4
    21e6:	d72080e7          	jalr	-654(ra) # 5f54 <printf>
      exit(1);
    21ea:	4505                	li	a0,1
    21ec:	00004097          	auipc	ra,0x4
    21f0:	9e8080e7          	jalr	-1560(ra) # 5bd4 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    21f4:	0004c683          	lbu	a3,0(s1)
    21f8:	8626                	mv	a2,s1
    21fa:	85d2                	mv	a1,s4
    21fc:	00005517          	auipc	a0,0x5
    2200:	ab450513          	addi	a0,a0,-1356 # 6cb0 <malloc+0xc9e>
    2204:	00004097          	auipc	ra,0x4
    2208:	d50080e7          	jalr	-688(ra) # 5f54 <printf>
      exit(1);
    220c:	4505                	li	a0,1
    220e:	00004097          	auipc	ra,0x4
    2212:	9c6080e7          	jalr	-1594(ra) # 5bd4 <exit>
      exit(1);
    2216:	4505                	li	a0,1
    2218:	00004097          	auipc	ra,0x4
    221c:	9bc080e7          	jalr	-1604(ra) # 5bd4 <exit>

0000000000002220 <MAXVAplus>:
{
    2220:	7179                	addi	sp,sp,-48
    2222:	f406                	sd	ra,40(sp)
    2224:	f022                	sd	s0,32(sp)
    2226:	ec26                	sd	s1,24(sp)
    2228:	e84a                	sd	s2,16(sp)
    222a:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    222c:	4785                	li	a5,1
    222e:	179a                	slli	a5,a5,0x26
    2230:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    2234:	fd843783          	ld	a5,-40(s0)
    2238:	cf85                	beqz	a5,2270 <MAXVAplus+0x50>
    223a:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    223c:	54fd                	li	s1,-1
    pid = fork();
    223e:	00004097          	auipc	ra,0x4
    2242:	98e080e7          	jalr	-1650(ra) # 5bcc <fork>
    if(pid < 0){
    2246:	02054b63          	bltz	a0,227c <MAXVAplus+0x5c>
    if(pid == 0){
    224a:	c539                	beqz	a0,2298 <MAXVAplus+0x78>
    wait(&xstatus);
    224c:	fd440513          	addi	a0,s0,-44
    2250:	00004097          	auipc	ra,0x4
    2254:	98c080e7          	jalr	-1652(ra) # 5bdc <wait>
    if(xstatus != -1)  // did kernel kill child?
    2258:	fd442783          	lw	a5,-44(s0)
    225c:	06979463          	bne	a5,s1,22c4 <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    2260:	fd843783          	ld	a5,-40(s0)
    2264:	0786                	slli	a5,a5,0x1
    2266:	fcf43c23          	sd	a5,-40(s0)
    226a:	fd843783          	ld	a5,-40(s0)
    226e:	fbe1                	bnez	a5,223e <MAXVAplus+0x1e>
}
    2270:	70a2                	ld	ra,40(sp)
    2272:	7402                	ld	s0,32(sp)
    2274:	64e2                	ld	s1,24(sp)
    2276:	6942                	ld	s2,16(sp)
    2278:	6145                	addi	sp,sp,48
    227a:	8082                	ret
      printf("%s: fork failed\n", s);
    227c:	85ca                	mv	a1,s2
    227e:	00004517          	auipc	a0,0x4
    2282:	76250513          	addi	a0,a0,1890 # 69e0 <malloc+0x9ce>
    2286:	00004097          	auipc	ra,0x4
    228a:	cce080e7          	jalr	-818(ra) # 5f54 <printf>
      exit(1);
    228e:	4505                	li	a0,1
    2290:	00004097          	auipc	ra,0x4
    2294:	944080e7          	jalr	-1724(ra) # 5bd4 <exit>
      *(char*)a = 99;
    2298:	fd843783          	ld	a5,-40(s0)
    229c:	06300713          	li	a4,99
    22a0:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    22a4:	fd843603          	ld	a2,-40(s0)
    22a8:	85ca                	mv	a1,s2
    22aa:	00005517          	auipc	a0,0x5
    22ae:	a2650513          	addi	a0,a0,-1498 # 6cd0 <malloc+0xcbe>
    22b2:	00004097          	auipc	ra,0x4
    22b6:	ca2080e7          	jalr	-862(ra) # 5f54 <printf>
      exit(1);
    22ba:	4505                	li	a0,1
    22bc:	00004097          	auipc	ra,0x4
    22c0:	918080e7          	jalr	-1768(ra) # 5bd4 <exit>
      exit(1);
    22c4:	4505                	li	a0,1
    22c6:	00004097          	auipc	ra,0x4
    22ca:	90e080e7          	jalr	-1778(ra) # 5bd4 <exit>

00000000000022ce <bigargtest>:
{
    22ce:	7179                	addi	sp,sp,-48
    22d0:	f406                	sd	ra,40(sp)
    22d2:	f022                	sd	s0,32(sp)
    22d4:	ec26                	sd	s1,24(sp)
    22d6:	1800                	addi	s0,sp,48
    22d8:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    22da:	00005517          	auipc	a0,0x5
    22de:	a0e50513          	addi	a0,a0,-1522 # 6ce8 <malloc+0xcd6>
    22e2:	00004097          	auipc	ra,0x4
    22e6:	942080e7          	jalr	-1726(ra) # 5c24 <unlink>
  pid = fork();
    22ea:	00004097          	auipc	ra,0x4
    22ee:	8e2080e7          	jalr	-1822(ra) # 5bcc <fork>
  if(pid == 0){
    22f2:	c121                	beqz	a0,2332 <bigargtest+0x64>
  } else if(pid < 0){
    22f4:	0a054063          	bltz	a0,2394 <bigargtest+0xc6>
  wait(&xstatus);
    22f8:	fdc40513          	addi	a0,s0,-36
    22fc:	00004097          	auipc	ra,0x4
    2300:	8e0080e7          	jalr	-1824(ra) # 5bdc <wait>
  if(xstatus != 0)
    2304:	fdc42503          	lw	a0,-36(s0)
    2308:	e545                	bnez	a0,23b0 <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    230a:	4581                	li	a1,0
    230c:	00005517          	auipc	a0,0x5
    2310:	9dc50513          	addi	a0,a0,-1572 # 6ce8 <malloc+0xcd6>
    2314:	00004097          	auipc	ra,0x4
    2318:	900080e7          	jalr	-1792(ra) # 5c14 <open>
  if(fd < 0){
    231c:	08054e63          	bltz	a0,23b8 <bigargtest+0xea>
  close(fd);
    2320:	00004097          	auipc	ra,0x4
    2324:	8dc080e7          	jalr	-1828(ra) # 5bfc <close>
}
    2328:	70a2                	ld	ra,40(sp)
    232a:	7402                	ld	s0,32(sp)
    232c:	64e2                	ld	s1,24(sp)
    232e:	6145                	addi	sp,sp,48
    2330:	8082                	ret
    2332:	00007797          	auipc	a5,0x7
    2336:	12e78793          	addi	a5,a5,302 # 9460 <args.1817>
    233a:	00007697          	auipc	a3,0x7
    233e:	21e68693          	addi	a3,a3,542 # 9558 <args.1817+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    2342:	00005717          	auipc	a4,0x5
    2346:	9b670713          	addi	a4,a4,-1610 # 6cf8 <malloc+0xce6>
    234a:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    234c:	07a1                	addi	a5,a5,8
    234e:	fed79ee3          	bne	a5,a3,234a <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    2352:	00007597          	auipc	a1,0x7
    2356:	10e58593          	addi	a1,a1,270 # 9460 <args.1817>
    235a:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    235e:	00004517          	auipc	a0,0x4
    2362:	dfa50513          	addi	a0,a0,-518 # 6158 <malloc+0x146>
    2366:	00004097          	auipc	ra,0x4
    236a:	8a6080e7          	jalr	-1882(ra) # 5c0c <exec>
    fd = open("bigarg-ok", O_CREATE);
    236e:	20000593          	li	a1,512
    2372:	00005517          	auipc	a0,0x5
    2376:	97650513          	addi	a0,a0,-1674 # 6ce8 <malloc+0xcd6>
    237a:	00004097          	auipc	ra,0x4
    237e:	89a080e7          	jalr	-1894(ra) # 5c14 <open>
    close(fd);
    2382:	00004097          	auipc	ra,0x4
    2386:	87a080e7          	jalr	-1926(ra) # 5bfc <close>
    exit(0);
    238a:	4501                	li	a0,0
    238c:	00004097          	auipc	ra,0x4
    2390:	848080e7          	jalr	-1976(ra) # 5bd4 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    2394:	85a6                	mv	a1,s1
    2396:	00005517          	auipc	a0,0x5
    239a:	a4250513          	addi	a0,a0,-1470 # 6dd8 <malloc+0xdc6>
    239e:	00004097          	auipc	ra,0x4
    23a2:	bb6080e7          	jalr	-1098(ra) # 5f54 <printf>
    exit(1);
    23a6:	4505                	li	a0,1
    23a8:	00004097          	auipc	ra,0x4
    23ac:	82c080e7          	jalr	-2004(ra) # 5bd4 <exit>
    exit(xstatus);
    23b0:	00004097          	auipc	ra,0x4
    23b4:	824080e7          	jalr	-2012(ra) # 5bd4 <exit>
    printf("%s: bigarg test failed!\n", s);
    23b8:	85a6                	mv	a1,s1
    23ba:	00005517          	auipc	a0,0x5
    23be:	a3e50513          	addi	a0,a0,-1474 # 6df8 <malloc+0xde6>
    23c2:	00004097          	auipc	ra,0x4
    23c6:	b92080e7          	jalr	-1134(ra) # 5f54 <printf>
    exit(1);
    23ca:	4505                	li	a0,1
    23cc:	00004097          	auipc	ra,0x4
    23d0:	808080e7          	jalr	-2040(ra) # 5bd4 <exit>

00000000000023d4 <stacktest>:
{
    23d4:	7179                	addi	sp,sp,-48
    23d6:	f406                	sd	ra,40(sp)
    23d8:	f022                	sd	s0,32(sp)
    23da:	ec26                	sd	s1,24(sp)
    23dc:	1800                	addi	s0,sp,48
    23de:	84aa                	mv	s1,a0
  pid = fork();
    23e0:	00003097          	auipc	ra,0x3
    23e4:	7ec080e7          	jalr	2028(ra) # 5bcc <fork>
  if(pid == 0) {
    23e8:	c115                	beqz	a0,240c <stacktest+0x38>
  } else if(pid < 0){
    23ea:	04054463          	bltz	a0,2432 <stacktest+0x5e>
  wait(&xstatus);
    23ee:	fdc40513          	addi	a0,s0,-36
    23f2:	00003097          	auipc	ra,0x3
    23f6:	7ea080e7          	jalr	2026(ra) # 5bdc <wait>
  if(xstatus == -1)  // kernel killed child?
    23fa:	fdc42503          	lw	a0,-36(s0)
    23fe:	57fd                	li	a5,-1
    2400:	04f50763          	beq	a0,a5,244e <stacktest+0x7a>
    exit(xstatus);
    2404:	00003097          	auipc	ra,0x3
    2408:	7d0080e7          	jalr	2000(ra) # 5bd4 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    240c:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    240e:	77fd                	lui	a5,0xfffff
    2410:	97ba                	add	a5,a5,a4
    2412:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    2416:	85a6                	mv	a1,s1
    2418:	00005517          	auipc	a0,0x5
    241c:	a0050513          	addi	a0,a0,-1536 # 6e18 <malloc+0xe06>
    2420:	00004097          	auipc	ra,0x4
    2424:	b34080e7          	jalr	-1228(ra) # 5f54 <printf>
    exit(1);
    2428:	4505                	li	a0,1
    242a:	00003097          	auipc	ra,0x3
    242e:	7aa080e7          	jalr	1962(ra) # 5bd4 <exit>
    printf("%s: fork failed\n", s);
    2432:	85a6                	mv	a1,s1
    2434:	00004517          	auipc	a0,0x4
    2438:	5ac50513          	addi	a0,a0,1452 # 69e0 <malloc+0x9ce>
    243c:	00004097          	auipc	ra,0x4
    2440:	b18080e7          	jalr	-1256(ra) # 5f54 <printf>
    exit(1);
    2444:	4505                	li	a0,1
    2446:	00003097          	auipc	ra,0x3
    244a:	78e080e7          	jalr	1934(ra) # 5bd4 <exit>
    exit(0);
    244e:	4501                	li	a0,0
    2450:	00003097          	auipc	ra,0x3
    2454:	784080e7          	jalr	1924(ra) # 5bd4 <exit>

0000000000002458 <textwrite>:
{
    2458:	7179                	addi	sp,sp,-48
    245a:	f406                	sd	ra,40(sp)
    245c:	f022                	sd	s0,32(sp)
    245e:	ec26                	sd	s1,24(sp)
    2460:	1800                	addi	s0,sp,48
    2462:	84aa                	mv	s1,a0
  pid = fork();
    2464:	00003097          	auipc	ra,0x3
    2468:	768080e7          	jalr	1896(ra) # 5bcc <fork>
  if(pid == 0) {
    246c:	c115                	beqz	a0,2490 <textwrite+0x38>
  } else if(pid < 0){
    246e:	02054963          	bltz	a0,24a0 <textwrite+0x48>
  wait(&xstatus);
    2472:	fdc40513          	addi	a0,s0,-36
    2476:	00003097          	auipc	ra,0x3
    247a:	766080e7          	jalr	1894(ra) # 5bdc <wait>
  if(xstatus == -1)  // kernel killed child?
    247e:	fdc42503          	lw	a0,-36(s0)
    2482:	57fd                	li	a5,-1
    2484:	02f50c63          	beq	a0,a5,24bc <textwrite+0x64>
    exit(xstatus);
    2488:	00003097          	auipc	ra,0x3
    248c:	74c080e7          	jalr	1868(ra) # 5bd4 <exit>
    *addr = 10;
    2490:	47a9                	li	a5,10
    2492:	00f02023          	sw	a5,0(zero) # 0 <copyinstr1>
    exit(1);
    2496:	4505                	li	a0,1
    2498:	00003097          	auipc	ra,0x3
    249c:	73c080e7          	jalr	1852(ra) # 5bd4 <exit>
    printf("%s: fork failed\n", s);
    24a0:	85a6                	mv	a1,s1
    24a2:	00004517          	auipc	a0,0x4
    24a6:	53e50513          	addi	a0,a0,1342 # 69e0 <malloc+0x9ce>
    24aa:	00004097          	auipc	ra,0x4
    24ae:	aaa080e7          	jalr	-1366(ra) # 5f54 <printf>
    exit(1);
    24b2:	4505                	li	a0,1
    24b4:	00003097          	auipc	ra,0x3
    24b8:	720080e7          	jalr	1824(ra) # 5bd4 <exit>
    exit(0);
    24bc:	4501                	li	a0,0
    24be:	00003097          	auipc	ra,0x3
    24c2:	716080e7          	jalr	1814(ra) # 5bd4 <exit>

00000000000024c6 <manywrites>:
{
    24c6:	711d                	addi	sp,sp,-96
    24c8:	ec86                	sd	ra,88(sp)
    24ca:	e8a2                	sd	s0,80(sp)
    24cc:	e4a6                	sd	s1,72(sp)
    24ce:	e0ca                	sd	s2,64(sp)
    24d0:	fc4e                	sd	s3,56(sp)
    24d2:	f852                	sd	s4,48(sp)
    24d4:	f456                	sd	s5,40(sp)
    24d6:	f05a                	sd	s6,32(sp)
    24d8:	ec5e                	sd	s7,24(sp)
    24da:	1080                	addi	s0,sp,96
    24dc:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    24de:	4901                	li	s2,0
    24e0:	4991                	li	s3,4
    int pid = fork();
    24e2:	00003097          	auipc	ra,0x3
    24e6:	6ea080e7          	jalr	1770(ra) # 5bcc <fork>
    24ea:	84aa                	mv	s1,a0
    if(pid < 0){
    24ec:	02054963          	bltz	a0,251e <manywrites+0x58>
    if(pid == 0){
    24f0:	c521                	beqz	a0,2538 <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    24f2:	2905                	addiw	s2,s2,1
    24f4:	ff3917e3          	bne	s2,s3,24e2 <manywrites+0x1c>
    24f8:	4491                	li	s1,4
    int st = 0;
    24fa:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    24fe:	fa840513          	addi	a0,s0,-88
    2502:	00003097          	auipc	ra,0x3
    2506:	6da080e7          	jalr	1754(ra) # 5bdc <wait>
    if(st != 0)
    250a:	fa842503          	lw	a0,-88(s0)
    250e:	ed6d                	bnez	a0,2608 <manywrites+0x142>
  for(int ci = 0; ci < nchildren; ci++){
    2510:	34fd                	addiw	s1,s1,-1
    2512:	f4e5                	bnez	s1,24fa <manywrites+0x34>
  exit(0);
    2514:	4501                	li	a0,0
    2516:	00003097          	auipc	ra,0x3
    251a:	6be080e7          	jalr	1726(ra) # 5bd4 <exit>
      printf("fork failed\n");
    251e:	00005517          	auipc	a0,0x5
    2522:	8ca50513          	addi	a0,a0,-1846 # 6de8 <malloc+0xdd6>
    2526:	00004097          	auipc	ra,0x4
    252a:	a2e080e7          	jalr	-1490(ra) # 5f54 <printf>
      exit(1);
    252e:	4505                	li	a0,1
    2530:	00003097          	auipc	ra,0x3
    2534:	6a4080e7          	jalr	1700(ra) # 5bd4 <exit>
      name[0] = 'b';
    2538:	06200793          	li	a5,98
    253c:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    2540:	0619079b          	addiw	a5,s2,97
    2544:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    2548:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    254c:	fa840513          	addi	a0,s0,-88
    2550:	00003097          	auipc	ra,0x3
    2554:	6d4080e7          	jalr	1748(ra) # 5c24 <unlink>
    2558:	4b79                	li	s6,30
          int cc = write(fd, buf, sz);
    255a:	0000ab97          	auipc	s7,0xa
    255e:	71eb8b93          	addi	s7,s7,1822 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    2562:	8a26                	mv	s4,s1
    2564:	02094e63          	bltz	s2,25a0 <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    2568:	20200593          	li	a1,514
    256c:	fa840513          	addi	a0,s0,-88
    2570:	00003097          	auipc	ra,0x3
    2574:	6a4080e7          	jalr	1700(ra) # 5c14 <open>
    2578:	89aa                	mv	s3,a0
          if(fd < 0){
    257a:	04054763          	bltz	a0,25c8 <manywrites+0x102>
          int cc = write(fd, buf, sz);
    257e:	660d                	lui	a2,0x3
    2580:	85de                	mv	a1,s7
    2582:	00003097          	auipc	ra,0x3
    2586:	672080e7          	jalr	1650(ra) # 5bf4 <write>
          if(cc != sz){
    258a:	678d                	lui	a5,0x3
    258c:	04f51e63          	bne	a0,a5,25e8 <manywrites+0x122>
          close(fd);
    2590:	854e                	mv	a0,s3
    2592:	00003097          	auipc	ra,0x3
    2596:	66a080e7          	jalr	1642(ra) # 5bfc <close>
        for(int i = 0; i < ci+1; i++){
    259a:	2a05                	addiw	s4,s4,1
    259c:	fd4956e3          	bge	s2,s4,2568 <manywrites+0xa2>
        unlink(name);
    25a0:	fa840513          	addi	a0,s0,-88
    25a4:	00003097          	auipc	ra,0x3
    25a8:	680080e7          	jalr	1664(ra) # 5c24 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    25ac:	3b7d                	addiw	s6,s6,-1
    25ae:	fa0b1ae3          	bnez	s6,2562 <manywrites+0x9c>
      unlink(name);
    25b2:	fa840513          	addi	a0,s0,-88
    25b6:	00003097          	auipc	ra,0x3
    25ba:	66e080e7          	jalr	1646(ra) # 5c24 <unlink>
      exit(0);
    25be:	4501                	li	a0,0
    25c0:	00003097          	auipc	ra,0x3
    25c4:	614080e7          	jalr	1556(ra) # 5bd4 <exit>
            printf("%s: cannot create %s\n", s, name);
    25c8:	fa840613          	addi	a2,s0,-88
    25cc:	85d6                	mv	a1,s5
    25ce:	00005517          	auipc	a0,0x5
    25d2:	87250513          	addi	a0,a0,-1934 # 6e40 <malloc+0xe2e>
    25d6:	00004097          	auipc	ra,0x4
    25da:	97e080e7          	jalr	-1666(ra) # 5f54 <printf>
            exit(1);
    25de:	4505                	li	a0,1
    25e0:	00003097          	auipc	ra,0x3
    25e4:	5f4080e7          	jalr	1524(ra) # 5bd4 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    25e8:	86aa                	mv	a3,a0
    25ea:	660d                	lui	a2,0x3
    25ec:	85d6                	mv	a1,s5
    25ee:	00004517          	auipc	a0,0x4
    25f2:	c3a50513          	addi	a0,a0,-966 # 6228 <malloc+0x216>
    25f6:	00004097          	auipc	ra,0x4
    25fa:	95e080e7          	jalr	-1698(ra) # 5f54 <printf>
            exit(1);
    25fe:	4505                	li	a0,1
    2600:	00003097          	auipc	ra,0x3
    2604:	5d4080e7          	jalr	1492(ra) # 5bd4 <exit>
      exit(st);
    2608:	00003097          	auipc	ra,0x3
    260c:	5cc080e7          	jalr	1484(ra) # 5bd4 <exit>

0000000000002610 <copyinstr3>:
{
    2610:	7179                	addi	sp,sp,-48
    2612:	f406                	sd	ra,40(sp)
    2614:	f022                	sd	s0,32(sp)
    2616:	ec26                	sd	s1,24(sp)
    2618:	1800                	addi	s0,sp,48
  sbrk(8192);
    261a:	6509                	lui	a0,0x2
    261c:	00003097          	auipc	ra,0x3
    2620:	640080e7          	jalr	1600(ra) # 5c5c <sbrk>
  uint64 top = (uint64) sbrk(0);
    2624:	4501                	li	a0,0
    2626:	00003097          	auipc	ra,0x3
    262a:	636080e7          	jalr	1590(ra) # 5c5c <sbrk>
  if((top % PGSIZE) != 0){
    262e:	03451793          	slli	a5,a0,0x34
    2632:	e3c9                	bnez	a5,26b4 <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    2634:	4501                	li	a0,0
    2636:	00003097          	auipc	ra,0x3
    263a:	626080e7          	jalr	1574(ra) # 5c5c <sbrk>
  if(top % PGSIZE){
    263e:	03451793          	slli	a5,a0,0x34
    2642:	e3d9                	bnez	a5,26c8 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    2644:	fff50493          	addi	s1,a0,-1 # 1fff <linkunlink+0x6d>
  *b = 'x';
    2648:	07800793          	li	a5,120
    264c:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    2650:	8526                	mv	a0,s1
    2652:	00003097          	auipc	ra,0x3
    2656:	5d2080e7          	jalr	1490(ra) # 5c24 <unlink>
  if(ret != -1){
    265a:	57fd                	li	a5,-1
    265c:	08f51363          	bne	a0,a5,26e2 <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    2660:	20100593          	li	a1,513
    2664:	8526                	mv	a0,s1
    2666:	00003097          	auipc	ra,0x3
    266a:	5ae080e7          	jalr	1454(ra) # 5c14 <open>
  if(fd != -1){
    266e:	57fd                	li	a5,-1
    2670:	08f51863          	bne	a0,a5,2700 <copyinstr3+0xf0>
  ret = link(b, b);
    2674:	85a6                	mv	a1,s1
    2676:	8526                	mv	a0,s1
    2678:	00003097          	auipc	ra,0x3
    267c:	5bc080e7          	jalr	1468(ra) # 5c34 <link>
  if(ret != -1){
    2680:	57fd                	li	a5,-1
    2682:	08f51e63          	bne	a0,a5,271e <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    2686:	00005797          	auipc	a5,0x5
    268a:	4b278793          	addi	a5,a5,1202 # 7b38 <malloc+0x1b26>
    268e:	fcf43823          	sd	a5,-48(s0)
    2692:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2696:	fd040593          	addi	a1,s0,-48
    269a:	8526                	mv	a0,s1
    269c:	00003097          	auipc	ra,0x3
    26a0:	570080e7          	jalr	1392(ra) # 5c0c <exec>
  if(ret != -1){
    26a4:	57fd                	li	a5,-1
    26a6:	08f51c63          	bne	a0,a5,273e <copyinstr3+0x12e>
}
    26aa:	70a2                	ld	ra,40(sp)
    26ac:	7402                	ld	s0,32(sp)
    26ae:	64e2                	ld	s1,24(sp)
    26b0:	6145                	addi	sp,sp,48
    26b2:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    26b4:	0347d513          	srli	a0,a5,0x34
    26b8:	6785                	lui	a5,0x1
    26ba:	40a7853b          	subw	a0,a5,a0
    26be:	00003097          	auipc	ra,0x3
    26c2:	59e080e7          	jalr	1438(ra) # 5c5c <sbrk>
    26c6:	b7bd                	j	2634 <copyinstr3+0x24>
    printf("oops\n");
    26c8:	00004517          	auipc	a0,0x4
    26cc:	79050513          	addi	a0,a0,1936 # 6e58 <malloc+0xe46>
    26d0:	00004097          	auipc	ra,0x4
    26d4:	884080e7          	jalr	-1916(ra) # 5f54 <printf>
    exit(1);
    26d8:	4505                	li	a0,1
    26da:	00003097          	auipc	ra,0x3
    26de:	4fa080e7          	jalr	1274(ra) # 5bd4 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    26e2:	862a                	mv	a2,a0
    26e4:	85a6                	mv	a1,s1
    26e6:	00004517          	auipc	a0,0x4
    26ea:	21a50513          	addi	a0,a0,538 # 6900 <malloc+0x8ee>
    26ee:	00004097          	auipc	ra,0x4
    26f2:	866080e7          	jalr	-1946(ra) # 5f54 <printf>
    exit(1);
    26f6:	4505                	li	a0,1
    26f8:	00003097          	auipc	ra,0x3
    26fc:	4dc080e7          	jalr	1244(ra) # 5bd4 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    2700:	862a                	mv	a2,a0
    2702:	85a6                	mv	a1,s1
    2704:	00004517          	auipc	a0,0x4
    2708:	21c50513          	addi	a0,a0,540 # 6920 <malloc+0x90e>
    270c:	00004097          	auipc	ra,0x4
    2710:	848080e7          	jalr	-1976(ra) # 5f54 <printf>
    exit(1);
    2714:	4505                	li	a0,1
    2716:	00003097          	auipc	ra,0x3
    271a:	4be080e7          	jalr	1214(ra) # 5bd4 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    271e:	86aa                	mv	a3,a0
    2720:	8626                	mv	a2,s1
    2722:	85a6                	mv	a1,s1
    2724:	00004517          	auipc	a0,0x4
    2728:	21c50513          	addi	a0,a0,540 # 6940 <malloc+0x92e>
    272c:	00004097          	auipc	ra,0x4
    2730:	828080e7          	jalr	-2008(ra) # 5f54 <printf>
    exit(1);
    2734:	4505                	li	a0,1
    2736:	00003097          	auipc	ra,0x3
    273a:	49e080e7          	jalr	1182(ra) # 5bd4 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    273e:	567d                	li	a2,-1
    2740:	85a6                	mv	a1,s1
    2742:	00004517          	auipc	a0,0x4
    2746:	22650513          	addi	a0,a0,550 # 6968 <malloc+0x956>
    274a:	00004097          	auipc	ra,0x4
    274e:	80a080e7          	jalr	-2038(ra) # 5f54 <printf>
    exit(1);
    2752:	4505                	li	a0,1
    2754:	00003097          	auipc	ra,0x3
    2758:	480080e7          	jalr	1152(ra) # 5bd4 <exit>

000000000000275c <rwsbrk>:
{
    275c:	1101                	addi	sp,sp,-32
    275e:	ec06                	sd	ra,24(sp)
    2760:	e822                	sd	s0,16(sp)
    2762:	e426                	sd	s1,8(sp)
    2764:	e04a                	sd	s2,0(sp)
    2766:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    2768:	6509                	lui	a0,0x2
    276a:	00003097          	auipc	ra,0x3
    276e:	4f2080e7          	jalr	1266(ra) # 5c5c <sbrk>
  if(a == 0xffffffffffffffffLL) {
    2772:	57fd                	li	a5,-1
    2774:	06f50363          	beq	a0,a5,27da <rwsbrk+0x7e>
    2778:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    277a:	7579                	lui	a0,0xffffe
    277c:	00003097          	auipc	ra,0x3
    2780:	4e0080e7          	jalr	1248(ra) # 5c5c <sbrk>
    2784:	57fd                	li	a5,-1
    2786:	06f50763          	beq	a0,a5,27f4 <rwsbrk+0x98>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    278a:	20100593          	li	a1,513
    278e:	00004517          	auipc	a0,0x4
    2792:	70a50513          	addi	a0,a0,1802 # 6e98 <malloc+0xe86>
    2796:	00003097          	auipc	ra,0x3
    279a:	47e080e7          	jalr	1150(ra) # 5c14 <open>
    279e:	892a                	mv	s2,a0
  if(fd < 0){
    27a0:	06054763          	bltz	a0,280e <rwsbrk+0xb2>
  n = write(fd, (void*)(a+4096), 1024);
    27a4:	6505                	lui	a0,0x1
    27a6:	94aa                	add	s1,s1,a0
    27a8:	40000613          	li	a2,1024
    27ac:	85a6                	mv	a1,s1
    27ae:	854a                	mv	a0,s2
    27b0:	00003097          	auipc	ra,0x3
    27b4:	444080e7          	jalr	1092(ra) # 5bf4 <write>
    27b8:	862a                	mv	a2,a0
  if(n >= 0){
    27ba:	06054763          	bltz	a0,2828 <rwsbrk+0xcc>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    27be:	85a6                	mv	a1,s1
    27c0:	00004517          	auipc	a0,0x4
    27c4:	6f850513          	addi	a0,a0,1784 # 6eb8 <malloc+0xea6>
    27c8:	00003097          	auipc	ra,0x3
    27cc:	78c080e7          	jalr	1932(ra) # 5f54 <printf>
    exit(1);
    27d0:	4505                	li	a0,1
    27d2:	00003097          	auipc	ra,0x3
    27d6:	402080e7          	jalr	1026(ra) # 5bd4 <exit>
    printf("sbrk(rwsbrk) failed\n");
    27da:	00004517          	auipc	a0,0x4
    27de:	68650513          	addi	a0,a0,1670 # 6e60 <malloc+0xe4e>
    27e2:	00003097          	auipc	ra,0x3
    27e6:	772080e7          	jalr	1906(ra) # 5f54 <printf>
    exit(1);
    27ea:	4505                	li	a0,1
    27ec:	00003097          	auipc	ra,0x3
    27f0:	3e8080e7          	jalr	1000(ra) # 5bd4 <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    27f4:	00004517          	auipc	a0,0x4
    27f8:	68450513          	addi	a0,a0,1668 # 6e78 <malloc+0xe66>
    27fc:	00003097          	auipc	ra,0x3
    2800:	758080e7          	jalr	1880(ra) # 5f54 <printf>
    exit(1);
    2804:	4505                	li	a0,1
    2806:	00003097          	auipc	ra,0x3
    280a:	3ce080e7          	jalr	974(ra) # 5bd4 <exit>
    printf("open(rwsbrk) failed\n");
    280e:	00004517          	auipc	a0,0x4
    2812:	69250513          	addi	a0,a0,1682 # 6ea0 <malloc+0xe8e>
    2816:	00003097          	auipc	ra,0x3
    281a:	73e080e7          	jalr	1854(ra) # 5f54 <printf>
    exit(1);
    281e:	4505                	li	a0,1
    2820:	00003097          	auipc	ra,0x3
    2824:	3b4080e7          	jalr	948(ra) # 5bd4 <exit>
  close(fd);
    2828:	854a                	mv	a0,s2
    282a:	00003097          	auipc	ra,0x3
    282e:	3d2080e7          	jalr	978(ra) # 5bfc <close>
  unlink("rwsbrk");
    2832:	00004517          	auipc	a0,0x4
    2836:	66650513          	addi	a0,a0,1638 # 6e98 <malloc+0xe86>
    283a:	00003097          	auipc	ra,0x3
    283e:	3ea080e7          	jalr	1002(ra) # 5c24 <unlink>
  fd = open("README", O_RDONLY);
    2842:	4581                	li	a1,0
    2844:	00004517          	auipc	a0,0x4
    2848:	aec50513          	addi	a0,a0,-1300 # 6330 <malloc+0x31e>
    284c:	00003097          	auipc	ra,0x3
    2850:	3c8080e7          	jalr	968(ra) # 5c14 <open>
    2854:	892a                	mv	s2,a0
  if(fd < 0){
    2856:	02054963          	bltz	a0,2888 <rwsbrk+0x12c>
  n = read(fd, (void*)(a+4096), 10);
    285a:	4629                	li	a2,10
    285c:	85a6                	mv	a1,s1
    285e:	00003097          	auipc	ra,0x3
    2862:	38e080e7          	jalr	910(ra) # 5bec <read>
    2866:	862a                	mv	a2,a0
  if(n >= 0){
    2868:	02054d63          	bltz	a0,28a2 <rwsbrk+0x146>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    286c:	85a6                	mv	a1,s1
    286e:	00004517          	auipc	a0,0x4
    2872:	67a50513          	addi	a0,a0,1658 # 6ee8 <malloc+0xed6>
    2876:	00003097          	auipc	ra,0x3
    287a:	6de080e7          	jalr	1758(ra) # 5f54 <printf>
    exit(1);
    287e:	4505                	li	a0,1
    2880:	00003097          	auipc	ra,0x3
    2884:	354080e7          	jalr	852(ra) # 5bd4 <exit>
    printf("open(rwsbrk) failed\n");
    2888:	00004517          	auipc	a0,0x4
    288c:	61850513          	addi	a0,a0,1560 # 6ea0 <malloc+0xe8e>
    2890:	00003097          	auipc	ra,0x3
    2894:	6c4080e7          	jalr	1732(ra) # 5f54 <printf>
    exit(1);
    2898:	4505                	li	a0,1
    289a:	00003097          	auipc	ra,0x3
    289e:	33a080e7          	jalr	826(ra) # 5bd4 <exit>
  close(fd);
    28a2:	854a                	mv	a0,s2
    28a4:	00003097          	auipc	ra,0x3
    28a8:	358080e7          	jalr	856(ra) # 5bfc <close>
  exit(0);
    28ac:	4501                	li	a0,0
    28ae:	00003097          	auipc	ra,0x3
    28b2:	326080e7          	jalr	806(ra) # 5bd4 <exit>

00000000000028b6 <sbrkbasic>:
{
    28b6:	715d                	addi	sp,sp,-80
    28b8:	e486                	sd	ra,72(sp)
    28ba:	e0a2                	sd	s0,64(sp)
    28bc:	fc26                	sd	s1,56(sp)
    28be:	f84a                	sd	s2,48(sp)
    28c0:	f44e                	sd	s3,40(sp)
    28c2:	f052                	sd	s4,32(sp)
    28c4:	ec56                	sd	s5,24(sp)
    28c6:	0880                	addi	s0,sp,80
    28c8:	8a2a                	mv	s4,a0
  pid = fork();
    28ca:	00003097          	auipc	ra,0x3
    28ce:	302080e7          	jalr	770(ra) # 5bcc <fork>
  if(pid < 0){
    28d2:	02054c63          	bltz	a0,290a <sbrkbasic+0x54>
  if(pid == 0){
    28d6:	ed21                	bnez	a0,292e <sbrkbasic+0x78>
    a = sbrk(TOOMUCH);
    28d8:	40000537          	lui	a0,0x40000
    28dc:	00003097          	auipc	ra,0x3
    28e0:	380080e7          	jalr	896(ra) # 5c5c <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    28e4:	57fd                	li	a5,-1
    28e6:	02f50f63          	beq	a0,a5,2924 <sbrkbasic+0x6e>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28ea:	400007b7          	lui	a5,0x40000
    28ee:	97aa                	add	a5,a5,a0
      *b = 99;
    28f0:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    28f4:	6705                	lui	a4,0x1
      *b = 99;
    28f6:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28fa:	953a                	add	a0,a0,a4
    28fc:	fef51de3          	bne	a0,a5,28f6 <sbrkbasic+0x40>
    exit(1);
    2900:	4505                	li	a0,1
    2902:	00003097          	auipc	ra,0x3
    2906:	2d2080e7          	jalr	722(ra) # 5bd4 <exit>
    printf("fork failed in sbrkbasic\n");
    290a:	00004517          	auipc	a0,0x4
    290e:	60650513          	addi	a0,a0,1542 # 6f10 <malloc+0xefe>
    2912:	00003097          	auipc	ra,0x3
    2916:	642080e7          	jalr	1602(ra) # 5f54 <printf>
    exit(1);
    291a:	4505                	li	a0,1
    291c:	00003097          	auipc	ra,0x3
    2920:	2b8080e7          	jalr	696(ra) # 5bd4 <exit>
      exit(0);
    2924:	4501                	li	a0,0
    2926:	00003097          	auipc	ra,0x3
    292a:	2ae080e7          	jalr	686(ra) # 5bd4 <exit>
  wait(&xstatus);
    292e:	fbc40513          	addi	a0,s0,-68
    2932:	00003097          	auipc	ra,0x3
    2936:	2aa080e7          	jalr	682(ra) # 5bdc <wait>
  if(xstatus == 1){
    293a:	fbc42703          	lw	a4,-68(s0)
    293e:	4785                	li	a5,1
    2940:	00f70e63          	beq	a4,a5,295c <sbrkbasic+0xa6>
  a = sbrk(0);
    2944:	4501                	li	a0,0
    2946:	00003097          	auipc	ra,0x3
    294a:	316080e7          	jalr	790(ra) # 5c5c <sbrk>
    294e:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2950:	4901                	li	s2,0
    *b = 1;
    2952:	4a85                	li	s5,1
  for(i = 0; i < 5000; i++){
    2954:	6985                	lui	s3,0x1
    2956:	38898993          	addi	s3,s3,904 # 1388 <badarg+0x3a>
    295a:	a005                	j	297a <sbrkbasic+0xc4>
    printf("%s: too much memory allocated!\n", s);
    295c:	85d2                	mv	a1,s4
    295e:	00004517          	auipc	a0,0x4
    2962:	5d250513          	addi	a0,a0,1490 # 6f30 <malloc+0xf1e>
    2966:	00003097          	auipc	ra,0x3
    296a:	5ee080e7          	jalr	1518(ra) # 5f54 <printf>
    exit(1);
    296e:	4505                	li	a0,1
    2970:	00003097          	auipc	ra,0x3
    2974:	264080e7          	jalr	612(ra) # 5bd4 <exit>
    a = b + 1;
    2978:	84be                	mv	s1,a5
    b = sbrk(1);
    297a:	4505                	li	a0,1
    297c:	00003097          	auipc	ra,0x3
    2980:	2e0080e7          	jalr	736(ra) # 5c5c <sbrk>
    if(b != a){
    2984:	04951b63          	bne	a0,s1,29da <sbrkbasic+0x124>
    *b = 1;
    2988:	01548023          	sb	s5,0(s1)
    a = b + 1;
    298c:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    2990:	2905                	addiw	s2,s2,1
    2992:	ff3913e3          	bne	s2,s3,2978 <sbrkbasic+0xc2>
  pid = fork();
    2996:	00003097          	auipc	ra,0x3
    299a:	236080e7          	jalr	566(ra) # 5bcc <fork>
    299e:	892a                	mv	s2,a0
  if(pid < 0){
    29a0:	04054e63          	bltz	a0,29fc <sbrkbasic+0x146>
  c = sbrk(1);
    29a4:	4505                	li	a0,1
    29a6:	00003097          	auipc	ra,0x3
    29aa:	2b6080e7          	jalr	694(ra) # 5c5c <sbrk>
  c = sbrk(1);
    29ae:	4505                	li	a0,1
    29b0:	00003097          	auipc	ra,0x3
    29b4:	2ac080e7          	jalr	684(ra) # 5c5c <sbrk>
  if(c != a + 1){
    29b8:	0489                	addi	s1,s1,2
    29ba:	04a48f63          	beq	s1,a0,2a18 <sbrkbasic+0x162>
    printf("%s: sbrk test failed post-fork\n", s);
    29be:	85d2                	mv	a1,s4
    29c0:	00004517          	auipc	a0,0x4
    29c4:	5d050513          	addi	a0,a0,1488 # 6f90 <malloc+0xf7e>
    29c8:	00003097          	auipc	ra,0x3
    29cc:	58c080e7          	jalr	1420(ra) # 5f54 <printf>
    exit(1);
    29d0:	4505                	li	a0,1
    29d2:	00003097          	auipc	ra,0x3
    29d6:	202080e7          	jalr	514(ra) # 5bd4 <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    29da:	872a                	mv	a4,a0
    29dc:	86a6                	mv	a3,s1
    29de:	864a                	mv	a2,s2
    29e0:	85d2                	mv	a1,s4
    29e2:	00004517          	auipc	a0,0x4
    29e6:	56e50513          	addi	a0,a0,1390 # 6f50 <malloc+0xf3e>
    29ea:	00003097          	auipc	ra,0x3
    29ee:	56a080e7          	jalr	1386(ra) # 5f54 <printf>
      exit(1);
    29f2:	4505                	li	a0,1
    29f4:	00003097          	auipc	ra,0x3
    29f8:	1e0080e7          	jalr	480(ra) # 5bd4 <exit>
    printf("%s: sbrk test fork failed\n", s);
    29fc:	85d2                	mv	a1,s4
    29fe:	00004517          	auipc	a0,0x4
    2a02:	57250513          	addi	a0,a0,1394 # 6f70 <malloc+0xf5e>
    2a06:	00003097          	auipc	ra,0x3
    2a0a:	54e080e7          	jalr	1358(ra) # 5f54 <printf>
    exit(1);
    2a0e:	4505                	li	a0,1
    2a10:	00003097          	auipc	ra,0x3
    2a14:	1c4080e7          	jalr	452(ra) # 5bd4 <exit>
  if(pid == 0)
    2a18:	00091763          	bnez	s2,2a26 <sbrkbasic+0x170>
    exit(0);
    2a1c:	4501                	li	a0,0
    2a1e:	00003097          	auipc	ra,0x3
    2a22:	1b6080e7          	jalr	438(ra) # 5bd4 <exit>
  wait(&xstatus);
    2a26:	fbc40513          	addi	a0,s0,-68
    2a2a:	00003097          	auipc	ra,0x3
    2a2e:	1b2080e7          	jalr	434(ra) # 5bdc <wait>
  exit(xstatus);
    2a32:	fbc42503          	lw	a0,-68(s0)
    2a36:	00003097          	auipc	ra,0x3
    2a3a:	19e080e7          	jalr	414(ra) # 5bd4 <exit>

0000000000002a3e <sbrkmuch>:
{
    2a3e:	7179                	addi	sp,sp,-48
    2a40:	f406                	sd	ra,40(sp)
    2a42:	f022                	sd	s0,32(sp)
    2a44:	ec26                	sd	s1,24(sp)
    2a46:	e84a                	sd	s2,16(sp)
    2a48:	e44e                	sd	s3,8(sp)
    2a4a:	e052                	sd	s4,0(sp)
    2a4c:	1800                	addi	s0,sp,48
    2a4e:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2a50:	4501                	li	a0,0
    2a52:	00003097          	auipc	ra,0x3
    2a56:	20a080e7          	jalr	522(ra) # 5c5c <sbrk>
    2a5a:	892a                	mv	s2,a0
  a = sbrk(0);
    2a5c:	4501                	li	a0,0
    2a5e:	00003097          	auipc	ra,0x3
    2a62:	1fe080e7          	jalr	510(ra) # 5c5c <sbrk>
    2a66:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2a68:	06400537          	lui	a0,0x6400
    2a6c:	9d05                	subw	a0,a0,s1
    2a6e:	00003097          	auipc	ra,0x3
    2a72:	1ee080e7          	jalr	494(ra) # 5c5c <sbrk>
  if (p != a) {
    2a76:	0ca49863          	bne	s1,a0,2b46 <sbrkmuch+0x108>
  char *eee = sbrk(0);
    2a7a:	4501                	li	a0,0
    2a7c:	00003097          	auipc	ra,0x3
    2a80:	1e0080e7          	jalr	480(ra) # 5c5c <sbrk>
    2a84:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    2a86:	00a4f963          	bgeu	s1,a0,2a98 <sbrkmuch+0x5a>
    *pp = 1;
    2a8a:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2a8c:	6705                	lui	a4,0x1
    *pp = 1;
    2a8e:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    2a92:	94ba                	add	s1,s1,a4
    2a94:	fef4ede3          	bltu	s1,a5,2a8e <sbrkmuch+0x50>
  *lastaddr = 99;
    2a98:	064007b7          	lui	a5,0x6400
    2a9c:	06300713          	li	a4,99
    2aa0:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    2aa4:	4501                	li	a0,0
    2aa6:	00003097          	auipc	ra,0x3
    2aaa:	1b6080e7          	jalr	438(ra) # 5c5c <sbrk>
    2aae:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2ab0:	757d                	lui	a0,0xfffff
    2ab2:	00003097          	auipc	ra,0x3
    2ab6:	1aa080e7          	jalr	426(ra) # 5c5c <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2aba:	57fd                	li	a5,-1
    2abc:	0af50363          	beq	a0,a5,2b62 <sbrkmuch+0x124>
  c = sbrk(0);
    2ac0:	4501                	li	a0,0
    2ac2:	00003097          	auipc	ra,0x3
    2ac6:	19a080e7          	jalr	410(ra) # 5c5c <sbrk>
  if(c != a - PGSIZE){
    2aca:	77fd                	lui	a5,0xfffff
    2acc:	97a6                	add	a5,a5,s1
    2ace:	0af51863          	bne	a0,a5,2b7e <sbrkmuch+0x140>
  a = sbrk(0);
    2ad2:	4501                	li	a0,0
    2ad4:	00003097          	auipc	ra,0x3
    2ad8:	188080e7          	jalr	392(ra) # 5c5c <sbrk>
    2adc:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2ade:	6505                	lui	a0,0x1
    2ae0:	00003097          	auipc	ra,0x3
    2ae4:	17c080e7          	jalr	380(ra) # 5c5c <sbrk>
    2ae8:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2aea:	0aa49a63          	bne	s1,a0,2b9e <sbrkmuch+0x160>
    2aee:	4501                	li	a0,0
    2af0:	00003097          	auipc	ra,0x3
    2af4:	16c080e7          	jalr	364(ra) # 5c5c <sbrk>
    2af8:	6785                	lui	a5,0x1
    2afa:	97a6                	add	a5,a5,s1
    2afc:	0af51163          	bne	a0,a5,2b9e <sbrkmuch+0x160>
  if(*lastaddr == 99){
    2b00:	064007b7          	lui	a5,0x6400
    2b04:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    2b08:	06300793          	li	a5,99
    2b0c:	0af70963          	beq	a4,a5,2bbe <sbrkmuch+0x180>
  a = sbrk(0);
    2b10:	4501                	li	a0,0
    2b12:	00003097          	auipc	ra,0x3
    2b16:	14a080e7          	jalr	330(ra) # 5c5c <sbrk>
    2b1a:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2b1c:	4501                	li	a0,0
    2b1e:	00003097          	auipc	ra,0x3
    2b22:	13e080e7          	jalr	318(ra) # 5c5c <sbrk>
    2b26:	40a9053b          	subw	a0,s2,a0
    2b2a:	00003097          	auipc	ra,0x3
    2b2e:	132080e7          	jalr	306(ra) # 5c5c <sbrk>
  if(c != a){
    2b32:	0aa49463          	bne	s1,a0,2bda <sbrkmuch+0x19c>
}
    2b36:	70a2                	ld	ra,40(sp)
    2b38:	7402                	ld	s0,32(sp)
    2b3a:	64e2                	ld	s1,24(sp)
    2b3c:	6942                	ld	s2,16(sp)
    2b3e:	69a2                	ld	s3,8(sp)
    2b40:	6a02                	ld	s4,0(sp)
    2b42:	6145                	addi	sp,sp,48
    2b44:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    2b46:	85ce                	mv	a1,s3
    2b48:	00004517          	auipc	a0,0x4
    2b4c:	46850513          	addi	a0,a0,1128 # 6fb0 <malloc+0xf9e>
    2b50:	00003097          	auipc	ra,0x3
    2b54:	404080e7          	jalr	1028(ra) # 5f54 <printf>
    exit(1);
    2b58:	4505                	li	a0,1
    2b5a:	00003097          	auipc	ra,0x3
    2b5e:	07a080e7          	jalr	122(ra) # 5bd4 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2b62:	85ce                	mv	a1,s3
    2b64:	00004517          	auipc	a0,0x4
    2b68:	49450513          	addi	a0,a0,1172 # 6ff8 <malloc+0xfe6>
    2b6c:	00003097          	auipc	ra,0x3
    2b70:	3e8080e7          	jalr	1000(ra) # 5f54 <printf>
    exit(1);
    2b74:	4505                	li	a0,1
    2b76:	00003097          	auipc	ra,0x3
    2b7a:	05e080e7          	jalr	94(ra) # 5bd4 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    2b7e:	86aa                	mv	a3,a0
    2b80:	8626                	mv	a2,s1
    2b82:	85ce                	mv	a1,s3
    2b84:	00004517          	auipc	a0,0x4
    2b88:	49450513          	addi	a0,a0,1172 # 7018 <malloc+0x1006>
    2b8c:	00003097          	auipc	ra,0x3
    2b90:	3c8080e7          	jalr	968(ra) # 5f54 <printf>
    exit(1);
    2b94:	4505                	li	a0,1
    2b96:	00003097          	auipc	ra,0x3
    2b9a:	03e080e7          	jalr	62(ra) # 5bd4 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2b9e:	86d2                	mv	a3,s4
    2ba0:	8626                	mv	a2,s1
    2ba2:	85ce                	mv	a1,s3
    2ba4:	00004517          	auipc	a0,0x4
    2ba8:	4b450513          	addi	a0,a0,1204 # 7058 <malloc+0x1046>
    2bac:	00003097          	auipc	ra,0x3
    2bb0:	3a8080e7          	jalr	936(ra) # 5f54 <printf>
    exit(1);
    2bb4:	4505                	li	a0,1
    2bb6:	00003097          	auipc	ra,0x3
    2bba:	01e080e7          	jalr	30(ra) # 5bd4 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2bbe:	85ce                	mv	a1,s3
    2bc0:	00004517          	auipc	a0,0x4
    2bc4:	4c850513          	addi	a0,a0,1224 # 7088 <malloc+0x1076>
    2bc8:	00003097          	auipc	ra,0x3
    2bcc:	38c080e7          	jalr	908(ra) # 5f54 <printf>
    exit(1);
    2bd0:	4505                	li	a0,1
    2bd2:	00003097          	auipc	ra,0x3
    2bd6:	002080e7          	jalr	2(ra) # 5bd4 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2bda:	86aa                	mv	a3,a0
    2bdc:	8626                	mv	a2,s1
    2bde:	85ce                	mv	a1,s3
    2be0:	00004517          	auipc	a0,0x4
    2be4:	4e050513          	addi	a0,a0,1248 # 70c0 <malloc+0x10ae>
    2be8:	00003097          	auipc	ra,0x3
    2bec:	36c080e7          	jalr	876(ra) # 5f54 <printf>
    exit(1);
    2bf0:	4505                	li	a0,1
    2bf2:	00003097          	auipc	ra,0x3
    2bf6:	fe2080e7          	jalr	-30(ra) # 5bd4 <exit>

0000000000002bfa <sbrkarg>:
{
    2bfa:	7179                	addi	sp,sp,-48
    2bfc:	f406                	sd	ra,40(sp)
    2bfe:	f022                	sd	s0,32(sp)
    2c00:	ec26                	sd	s1,24(sp)
    2c02:	e84a                	sd	s2,16(sp)
    2c04:	e44e                	sd	s3,8(sp)
    2c06:	1800                	addi	s0,sp,48
    2c08:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2c0a:	6505                	lui	a0,0x1
    2c0c:	00003097          	auipc	ra,0x3
    2c10:	050080e7          	jalr	80(ra) # 5c5c <sbrk>
    2c14:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2c16:	20100593          	li	a1,513
    2c1a:	00004517          	auipc	a0,0x4
    2c1e:	4ce50513          	addi	a0,a0,1230 # 70e8 <malloc+0x10d6>
    2c22:	00003097          	auipc	ra,0x3
    2c26:	ff2080e7          	jalr	-14(ra) # 5c14 <open>
    2c2a:	84aa                	mv	s1,a0
  unlink("sbrk");
    2c2c:	00004517          	auipc	a0,0x4
    2c30:	4bc50513          	addi	a0,a0,1212 # 70e8 <malloc+0x10d6>
    2c34:	00003097          	auipc	ra,0x3
    2c38:	ff0080e7          	jalr	-16(ra) # 5c24 <unlink>
  if(fd < 0)  {
    2c3c:	0404c163          	bltz	s1,2c7e <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2c40:	6605                	lui	a2,0x1
    2c42:	85ca                	mv	a1,s2
    2c44:	8526                	mv	a0,s1
    2c46:	00003097          	auipc	ra,0x3
    2c4a:	fae080e7          	jalr	-82(ra) # 5bf4 <write>
    2c4e:	04054663          	bltz	a0,2c9a <sbrkarg+0xa0>
  close(fd);
    2c52:	8526                	mv	a0,s1
    2c54:	00003097          	auipc	ra,0x3
    2c58:	fa8080e7          	jalr	-88(ra) # 5bfc <close>
  a = sbrk(PGSIZE);
    2c5c:	6505                	lui	a0,0x1
    2c5e:	00003097          	auipc	ra,0x3
    2c62:	ffe080e7          	jalr	-2(ra) # 5c5c <sbrk>
  if(pipe((int *) a) != 0){
    2c66:	00003097          	auipc	ra,0x3
    2c6a:	f7e080e7          	jalr	-130(ra) # 5be4 <pipe>
    2c6e:	e521                	bnez	a0,2cb6 <sbrkarg+0xbc>
}
    2c70:	70a2                	ld	ra,40(sp)
    2c72:	7402                	ld	s0,32(sp)
    2c74:	64e2                	ld	s1,24(sp)
    2c76:	6942                	ld	s2,16(sp)
    2c78:	69a2                	ld	s3,8(sp)
    2c7a:	6145                	addi	sp,sp,48
    2c7c:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2c7e:	85ce                	mv	a1,s3
    2c80:	00004517          	auipc	a0,0x4
    2c84:	47050513          	addi	a0,a0,1136 # 70f0 <malloc+0x10de>
    2c88:	00003097          	auipc	ra,0x3
    2c8c:	2cc080e7          	jalr	716(ra) # 5f54 <printf>
    exit(1);
    2c90:	4505                	li	a0,1
    2c92:	00003097          	auipc	ra,0x3
    2c96:	f42080e7          	jalr	-190(ra) # 5bd4 <exit>
    printf("%s: write sbrk failed\n", s);
    2c9a:	85ce                	mv	a1,s3
    2c9c:	00004517          	auipc	a0,0x4
    2ca0:	46c50513          	addi	a0,a0,1132 # 7108 <malloc+0x10f6>
    2ca4:	00003097          	auipc	ra,0x3
    2ca8:	2b0080e7          	jalr	688(ra) # 5f54 <printf>
    exit(1);
    2cac:	4505                	li	a0,1
    2cae:	00003097          	auipc	ra,0x3
    2cb2:	f26080e7          	jalr	-218(ra) # 5bd4 <exit>
    printf("%s: pipe() failed\n", s);
    2cb6:	85ce                	mv	a1,s3
    2cb8:	00004517          	auipc	a0,0x4
    2cbc:	e3050513          	addi	a0,a0,-464 # 6ae8 <malloc+0xad6>
    2cc0:	00003097          	auipc	ra,0x3
    2cc4:	294080e7          	jalr	660(ra) # 5f54 <printf>
    exit(1);
    2cc8:	4505                	li	a0,1
    2cca:	00003097          	auipc	ra,0x3
    2cce:	f0a080e7          	jalr	-246(ra) # 5bd4 <exit>

0000000000002cd2 <argptest>:
{
    2cd2:	1101                	addi	sp,sp,-32
    2cd4:	ec06                	sd	ra,24(sp)
    2cd6:	e822                	sd	s0,16(sp)
    2cd8:	e426                	sd	s1,8(sp)
    2cda:	e04a                	sd	s2,0(sp)
    2cdc:	1000                	addi	s0,sp,32
    2cde:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2ce0:	4581                	li	a1,0
    2ce2:	00004517          	auipc	a0,0x4
    2ce6:	43e50513          	addi	a0,a0,1086 # 7120 <malloc+0x110e>
    2cea:	00003097          	auipc	ra,0x3
    2cee:	f2a080e7          	jalr	-214(ra) # 5c14 <open>
  if (fd < 0) {
    2cf2:	02054b63          	bltz	a0,2d28 <argptest+0x56>
    2cf6:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2cf8:	4501                	li	a0,0
    2cfa:	00003097          	auipc	ra,0x3
    2cfe:	f62080e7          	jalr	-158(ra) # 5c5c <sbrk>
    2d02:	567d                	li	a2,-1
    2d04:	fff50593          	addi	a1,a0,-1
    2d08:	8526                	mv	a0,s1
    2d0a:	00003097          	auipc	ra,0x3
    2d0e:	ee2080e7          	jalr	-286(ra) # 5bec <read>
  close(fd);
    2d12:	8526                	mv	a0,s1
    2d14:	00003097          	auipc	ra,0x3
    2d18:	ee8080e7          	jalr	-280(ra) # 5bfc <close>
}
    2d1c:	60e2                	ld	ra,24(sp)
    2d1e:	6442                	ld	s0,16(sp)
    2d20:	64a2                	ld	s1,8(sp)
    2d22:	6902                	ld	s2,0(sp)
    2d24:	6105                	addi	sp,sp,32
    2d26:	8082                	ret
    printf("%s: open failed\n", s);
    2d28:	85ca                	mv	a1,s2
    2d2a:	00004517          	auipc	a0,0x4
    2d2e:	cce50513          	addi	a0,a0,-818 # 69f8 <malloc+0x9e6>
    2d32:	00003097          	auipc	ra,0x3
    2d36:	222080e7          	jalr	546(ra) # 5f54 <printf>
    exit(1);
    2d3a:	4505                	li	a0,1
    2d3c:	00003097          	auipc	ra,0x3
    2d40:	e98080e7          	jalr	-360(ra) # 5bd4 <exit>

0000000000002d44 <sbrkbugs>:
{
    2d44:	1141                	addi	sp,sp,-16
    2d46:	e406                	sd	ra,8(sp)
    2d48:	e022                	sd	s0,0(sp)
    2d4a:	0800                	addi	s0,sp,16
  int pid = fork();
    2d4c:	00003097          	auipc	ra,0x3
    2d50:	e80080e7          	jalr	-384(ra) # 5bcc <fork>
  if(pid < 0){
    2d54:	02054263          	bltz	a0,2d78 <sbrkbugs+0x34>
  if(pid == 0){
    2d58:	ed0d                	bnez	a0,2d92 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2d5a:	00003097          	auipc	ra,0x3
    2d5e:	f02080e7          	jalr	-254(ra) # 5c5c <sbrk>
    sbrk(-sz);
    2d62:	40a0053b          	negw	a0,a0
    2d66:	00003097          	auipc	ra,0x3
    2d6a:	ef6080e7          	jalr	-266(ra) # 5c5c <sbrk>
    exit(0);
    2d6e:	4501                	li	a0,0
    2d70:	00003097          	auipc	ra,0x3
    2d74:	e64080e7          	jalr	-412(ra) # 5bd4 <exit>
    printf("fork failed\n");
    2d78:	00004517          	auipc	a0,0x4
    2d7c:	07050513          	addi	a0,a0,112 # 6de8 <malloc+0xdd6>
    2d80:	00003097          	auipc	ra,0x3
    2d84:	1d4080e7          	jalr	468(ra) # 5f54 <printf>
    exit(1);
    2d88:	4505                	li	a0,1
    2d8a:	00003097          	auipc	ra,0x3
    2d8e:	e4a080e7          	jalr	-438(ra) # 5bd4 <exit>
  wait(0);
    2d92:	4501                	li	a0,0
    2d94:	00003097          	auipc	ra,0x3
    2d98:	e48080e7          	jalr	-440(ra) # 5bdc <wait>
  pid = fork();
    2d9c:	00003097          	auipc	ra,0x3
    2da0:	e30080e7          	jalr	-464(ra) # 5bcc <fork>
  if(pid < 0){
    2da4:	02054563          	bltz	a0,2dce <sbrkbugs+0x8a>
  if(pid == 0){
    2da8:	e121                	bnez	a0,2de8 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2daa:	00003097          	auipc	ra,0x3
    2dae:	eb2080e7          	jalr	-334(ra) # 5c5c <sbrk>
    sbrk(-(sz - 3500));
    2db2:	6785                	lui	a5,0x1
    2db4:	dac7879b          	addiw	a5,a5,-596
    2db8:	40a7853b          	subw	a0,a5,a0
    2dbc:	00003097          	auipc	ra,0x3
    2dc0:	ea0080e7          	jalr	-352(ra) # 5c5c <sbrk>
    exit(0);
    2dc4:	4501                	li	a0,0
    2dc6:	00003097          	auipc	ra,0x3
    2dca:	e0e080e7          	jalr	-498(ra) # 5bd4 <exit>
    printf("fork failed\n");
    2dce:	00004517          	auipc	a0,0x4
    2dd2:	01a50513          	addi	a0,a0,26 # 6de8 <malloc+0xdd6>
    2dd6:	00003097          	auipc	ra,0x3
    2dda:	17e080e7          	jalr	382(ra) # 5f54 <printf>
    exit(1);
    2dde:	4505                	li	a0,1
    2de0:	00003097          	auipc	ra,0x3
    2de4:	df4080e7          	jalr	-524(ra) # 5bd4 <exit>
  wait(0);
    2de8:	4501                	li	a0,0
    2dea:	00003097          	auipc	ra,0x3
    2dee:	df2080e7          	jalr	-526(ra) # 5bdc <wait>
  pid = fork();
    2df2:	00003097          	auipc	ra,0x3
    2df6:	dda080e7          	jalr	-550(ra) # 5bcc <fork>
  if(pid < 0){
    2dfa:	02054a63          	bltz	a0,2e2e <sbrkbugs+0xea>
  if(pid == 0){
    2dfe:	e529                	bnez	a0,2e48 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2e00:	00003097          	auipc	ra,0x3
    2e04:	e5c080e7          	jalr	-420(ra) # 5c5c <sbrk>
    2e08:	67ad                	lui	a5,0xb
    2e0a:	8007879b          	addiw	a5,a5,-2048
    2e0e:	40a7853b          	subw	a0,a5,a0
    2e12:	00003097          	auipc	ra,0x3
    2e16:	e4a080e7          	jalr	-438(ra) # 5c5c <sbrk>
    sbrk(-10);
    2e1a:	5559                	li	a0,-10
    2e1c:	00003097          	auipc	ra,0x3
    2e20:	e40080e7          	jalr	-448(ra) # 5c5c <sbrk>
    exit(0);
    2e24:	4501                	li	a0,0
    2e26:	00003097          	auipc	ra,0x3
    2e2a:	dae080e7          	jalr	-594(ra) # 5bd4 <exit>
    printf("fork failed\n");
    2e2e:	00004517          	auipc	a0,0x4
    2e32:	fba50513          	addi	a0,a0,-70 # 6de8 <malloc+0xdd6>
    2e36:	00003097          	auipc	ra,0x3
    2e3a:	11e080e7          	jalr	286(ra) # 5f54 <printf>
    exit(1);
    2e3e:	4505                	li	a0,1
    2e40:	00003097          	auipc	ra,0x3
    2e44:	d94080e7          	jalr	-620(ra) # 5bd4 <exit>
  wait(0);
    2e48:	4501                	li	a0,0
    2e4a:	00003097          	auipc	ra,0x3
    2e4e:	d92080e7          	jalr	-622(ra) # 5bdc <wait>
  exit(0);
    2e52:	4501                	li	a0,0
    2e54:	00003097          	auipc	ra,0x3
    2e58:	d80080e7          	jalr	-640(ra) # 5bd4 <exit>

0000000000002e5c <sbrklast>:
{
    2e5c:	7179                	addi	sp,sp,-48
    2e5e:	f406                	sd	ra,40(sp)
    2e60:	f022                	sd	s0,32(sp)
    2e62:	ec26                	sd	s1,24(sp)
    2e64:	e84a                	sd	s2,16(sp)
    2e66:	e44e                	sd	s3,8(sp)
    2e68:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2e6a:	4501                	li	a0,0
    2e6c:	00003097          	auipc	ra,0x3
    2e70:	df0080e7          	jalr	-528(ra) # 5c5c <sbrk>
  if((top % 4096) != 0)
    2e74:	03451793          	slli	a5,a0,0x34
    2e78:	efc1                	bnez	a5,2f10 <sbrklast+0xb4>
  sbrk(4096);
    2e7a:	6505                	lui	a0,0x1
    2e7c:	00003097          	auipc	ra,0x3
    2e80:	de0080e7          	jalr	-544(ra) # 5c5c <sbrk>
  sbrk(10);
    2e84:	4529                	li	a0,10
    2e86:	00003097          	auipc	ra,0x3
    2e8a:	dd6080e7          	jalr	-554(ra) # 5c5c <sbrk>
  sbrk(-20);
    2e8e:	5531                	li	a0,-20
    2e90:	00003097          	auipc	ra,0x3
    2e94:	dcc080e7          	jalr	-564(ra) # 5c5c <sbrk>
  top = (uint64) sbrk(0);
    2e98:	4501                	li	a0,0
    2e9a:	00003097          	auipc	ra,0x3
    2e9e:	dc2080e7          	jalr	-574(ra) # 5c5c <sbrk>
    2ea2:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2ea4:	fc050913          	addi	s2,a0,-64 # fc0 <linktest+0xc8>
  p[0] = 'x';
    2ea8:	07800793          	li	a5,120
    2eac:	fcf50023          	sb	a5,-64(a0)
  p[1] = '\0';
    2eb0:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2eb4:	20200593          	li	a1,514
    2eb8:	854a                	mv	a0,s2
    2eba:	00003097          	auipc	ra,0x3
    2ebe:	d5a080e7          	jalr	-678(ra) # 5c14 <open>
    2ec2:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2ec4:	4605                	li	a2,1
    2ec6:	85ca                	mv	a1,s2
    2ec8:	00003097          	auipc	ra,0x3
    2ecc:	d2c080e7          	jalr	-724(ra) # 5bf4 <write>
  close(fd);
    2ed0:	854e                	mv	a0,s3
    2ed2:	00003097          	auipc	ra,0x3
    2ed6:	d2a080e7          	jalr	-726(ra) # 5bfc <close>
  fd = open(p, O_RDWR);
    2eda:	4589                	li	a1,2
    2edc:	854a                	mv	a0,s2
    2ede:	00003097          	auipc	ra,0x3
    2ee2:	d36080e7          	jalr	-714(ra) # 5c14 <open>
  p[0] = '\0';
    2ee6:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2eea:	4605                	li	a2,1
    2eec:	85ca                	mv	a1,s2
    2eee:	00003097          	auipc	ra,0x3
    2ef2:	cfe080e7          	jalr	-770(ra) # 5bec <read>
  if(p[0] != 'x')
    2ef6:	fc04c703          	lbu	a4,-64(s1)
    2efa:	07800793          	li	a5,120
    2efe:	02f71363          	bne	a4,a5,2f24 <sbrklast+0xc8>
}
    2f02:	70a2                	ld	ra,40(sp)
    2f04:	7402                	ld	s0,32(sp)
    2f06:	64e2                	ld	s1,24(sp)
    2f08:	6942                	ld	s2,16(sp)
    2f0a:	69a2                	ld	s3,8(sp)
    2f0c:	6145                	addi	sp,sp,48
    2f0e:	8082                	ret
    sbrk(4096 - (top % 4096));
    2f10:	0347d513          	srli	a0,a5,0x34
    2f14:	6785                	lui	a5,0x1
    2f16:	40a7853b          	subw	a0,a5,a0
    2f1a:	00003097          	auipc	ra,0x3
    2f1e:	d42080e7          	jalr	-702(ra) # 5c5c <sbrk>
    2f22:	bfa1                	j	2e7a <sbrklast+0x1e>
    exit(1);
    2f24:	4505                	li	a0,1
    2f26:	00003097          	auipc	ra,0x3
    2f2a:	cae080e7          	jalr	-850(ra) # 5bd4 <exit>

0000000000002f2e <sbrk8000>:
{
    2f2e:	1141                	addi	sp,sp,-16
    2f30:	e406                	sd	ra,8(sp)
    2f32:	e022                	sd	s0,0(sp)
    2f34:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2f36:	80000537          	lui	a0,0x80000
    2f3a:	0511                	addi	a0,a0,4
    2f3c:	00003097          	auipc	ra,0x3
    2f40:	d20080e7          	jalr	-736(ra) # 5c5c <sbrk>
  volatile char *top = sbrk(0);
    2f44:	4501                	li	a0,0
    2f46:	00003097          	auipc	ra,0x3
    2f4a:	d16080e7          	jalr	-746(ra) # 5c5c <sbrk>
  *(top-1) = *(top-1) + 1;
    2f4e:	fff54783          	lbu	a5,-1(a0) # ffffffff7fffffff <base+0xffffffff7fff0387>
    2f52:	0785                	addi	a5,a5,1
    2f54:	0ff7f793          	andi	a5,a5,255
    2f58:	fef50fa3          	sb	a5,-1(a0)
}
    2f5c:	60a2                	ld	ra,8(sp)
    2f5e:	6402                	ld	s0,0(sp)
    2f60:	0141                	addi	sp,sp,16
    2f62:	8082                	ret

0000000000002f64 <execout>:
{
    2f64:	715d                	addi	sp,sp,-80
    2f66:	e486                	sd	ra,72(sp)
    2f68:	e0a2                	sd	s0,64(sp)
    2f6a:	fc26                	sd	s1,56(sp)
    2f6c:	f84a                	sd	s2,48(sp)
    2f6e:	f44e                	sd	s3,40(sp)
    2f70:	f052                	sd	s4,32(sp)
    2f72:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2f74:	4901                	li	s2,0
    2f76:	49bd                	li	s3,15
    int pid = fork();
    2f78:	00003097          	auipc	ra,0x3
    2f7c:	c54080e7          	jalr	-940(ra) # 5bcc <fork>
    2f80:	84aa                	mv	s1,a0
    if(pid < 0){
    2f82:	02054063          	bltz	a0,2fa2 <execout+0x3e>
    } else if(pid == 0){
    2f86:	c91d                	beqz	a0,2fbc <execout+0x58>
      wait((int*)0);
    2f88:	4501                	li	a0,0
    2f8a:	00003097          	auipc	ra,0x3
    2f8e:	c52080e7          	jalr	-942(ra) # 5bdc <wait>
  for(int avail = 0; avail < 15; avail++){
    2f92:	2905                	addiw	s2,s2,1
    2f94:	ff3912e3          	bne	s2,s3,2f78 <execout+0x14>
  exit(0);
    2f98:	4501                	li	a0,0
    2f9a:	00003097          	auipc	ra,0x3
    2f9e:	c3a080e7          	jalr	-966(ra) # 5bd4 <exit>
      printf("fork failed\n");
    2fa2:	00004517          	auipc	a0,0x4
    2fa6:	e4650513          	addi	a0,a0,-442 # 6de8 <malloc+0xdd6>
    2faa:	00003097          	auipc	ra,0x3
    2fae:	faa080e7          	jalr	-86(ra) # 5f54 <printf>
      exit(1);
    2fb2:	4505                	li	a0,1
    2fb4:	00003097          	auipc	ra,0x3
    2fb8:	c20080e7          	jalr	-992(ra) # 5bd4 <exit>
        if(a == 0xffffffffffffffffLL)
    2fbc:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2fbe:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2fc0:	6505                	lui	a0,0x1
    2fc2:	00003097          	auipc	ra,0x3
    2fc6:	c9a080e7          	jalr	-870(ra) # 5c5c <sbrk>
        if(a == 0xffffffffffffffffLL)
    2fca:	01350763          	beq	a0,s3,2fd8 <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2fce:	6785                	lui	a5,0x1
    2fd0:	953e                	add	a0,a0,a5
    2fd2:	ff450fa3          	sb	s4,-1(a0) # fff <linktest+0x107>
      while(1){
    2fd6:	b7ed                	j	2fc0 <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2fd8:	01205a63          	blez	s2,2fec <execout+0x88>
        sbrk(-4096);
    2fdc:	757d                	lui	a0,0xfffff
    2fde:	00003097          	auipc	ra,0x3
    2fe2:	c7e080e7          	jalr	-898(ra) # 5c5c <sbrk>
      for(int i = 0; i < avail; i++)
    2fe6:	2485                	addiw	s1,s1,1
    2fe8:	ff249ae3          	bne	s1,s2,2fdc <execout+0x78>
      close(1);
    2fec:	4505                	li	a0,1
    2fee:	00003097          	auipc	ra,0x3
    2ff2:	c0e080e7          	jalr	-1010(ra) # 5bfc <close>
      char *args[] = { "echo", "x", 0 };
    2ff6:	00003517          	auipc	a0,0x3
    2ffa:	16250513          	addi	a0,a0,354 # 6158 <malloc+0x146>
    2ffe:	faa43c23          	sd	a0,-72(s0)
    3002:	00003797          	auipc	a5,0x3
    3006:	1c678793          	addi	a5,a5,454 # 61c8 <malloc+0x1b6>
    300a:	fcf43023          	sd	a5,-64(s0)
    300e:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    3012:	fb840593          	addi	a1,s0,-72
    3016:	00003097          	auipc	ra,0x3
    301a:	bf6080e7          	jalr	-1034(ra) # 5c0c <exec>
      exit(0);
    301e:	4501                	li	a0,0
    3020:	00003097          	auipc	ra,0x3
    3024:	bb4080e7          	jalr	-1100(ra) # 5bd4 <exit>

0000000000003028 <fourteen>:
{
    3028:	1101                	addi	sp,sp,-32
    302a:	ec06                	sd	ra,24(sp)
    302c:	e822                	sd	s0,16(sp)
    302e:	e426                	sd	s1,8(sp)
    3030:	1000                	addi	s0,sp,32
    3032:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    3034:	00004517          	auipc	a0,0x4
    3038:	2c450513          	addi	a0,a0,708 # 72f8 <malloc+0x12e6>
    303c:	00003097          	auipc	ra,0x3
    3040:	c00080e7          	jalr	-1024(ra) # 5c3c <mkdir>
    3044:	e165                	bnez	a0,3124 <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    3046:	00004517          	auipc	a0,0x4
    304a:	10a50513          	addi	a0,a0,266 # 7150 <malloc+0x113e>
    304e:	00003097          	auipc	ra,0x3
    3052:	bee080e7          	jalr	-1042(ra) # 5c3c <mkdir>
    3056:	e56d                	bnez	a0,3140 <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    3058:	20000593          	li	a1,512
    305c:	00004517          	auipc	a0,0x4
    3060:	14c50513          	addi	a0,a0,332 # 71a8 <malloc+0x1196>
    3064:	00003097          	auipc	ra,0x3
    3068:	bb0080e7          	jalr	-1104(ra) # 5c14 <open>
  if(fd < 0){
    306c:	0e054863          	bltz	a0,315c <fourteen+0x134>
  close(fd);
    3070:	00003097          	auipc	ra,0x3
    3074:	b8c080e7          	jalr	-1140(ra) # 5bfc <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    3078:	4581                	li	a1,0
    307a:	00004517          	auipc	a0,0x4
    307e:	1a650513          	addi	a0,a0,422 # 7220 <malloc+0x120e>
    3082:	00003097          	auipc	ra,0x3
    3086:	b92080e7          	jalr	-1134(ra) # 5c14 <open>
  if(fd < 0){
    308a:	0e054763          	bltz	a0,3178 <fourteen+0x150>
  close(fd);
    308e:	00003097          	auipc	ra,0x3
    3092:	b6e080e7          	jalr	-1170(ra) # 5bfc <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    3096:	00004517          	auipc	a0,0x4
    309a:	1fa50513          	addi	a0,a0,506 # 7290 <malloc+0x127e>
    309e:	00003097          	auipc	ra,0x3
    30a2:	b9e080e7          	jalr	-1122(ra) # 5c3c <mkdir>
    30a6:	c57d                	beqz	a0,3194 <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    30a8:	00004517          	auipc	a0,0x4
    30ac:	24050513          	addi	a0,a0,576 # 72e8 <malloc+0x12d6>
    30b0:	00003097          	auipc	ra,0x3
    30b4:	b8c080e7          	jalr	-1140(ra) # 5c3c <mkdir>
    30b8:	cd65                	beqz	a0,31b0 <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    30ba:	00004517          	auipc	a0,0x4
    30be:	22e50513          	addi	a0,a0,558 # 72e8 <malloc+0x12d6>
    30c2:	00003097          	auipc	ra,0x3
    30c6:	b62080e7          	jalr	-1182(ra) # 5c24 <unlink>
  unlink("12345678901234/12345678901234");
    30ca:	00004517          	auipc	a0,0x4
    30ce:	1c650513          	addi	a0,a0,454 # 7290 <malloc+0x127e>
    30d2:	00003097          	auipc	ra,0x3
    30d6:	b52080e7          	jalr	-1198(ra) # 5c24 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    30da:	00004517          	auipc	a0,0x4
    30de:	14650513          	addi	a0,a0,326 # 7220 <malloc+0x120e>
    30e2:	00003097          	auipc	ra,0x3
    30e6:	b42080e7          	jalr	-1214(ra) # 5c24 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    30ea:	00004517          	auipc	a0,0x4
    30ee:	0be50513          	addi	a0,a0,190 # 71a8 <malloc+0x1196>
    30f2:	00003097          	auipc	ra,0x3
    30f6:	b32080e7          	jalr	-1230(ra) # 5c24 <unlink>
  unlink("12345678901234/123456789012345");
    30fa:	00004517          	auipc	a0,0x4
    30fe:	05650513          	addi	a0,a0,86 # 7150 <malloc+0x113e>
    3102:	00003097          	auipc	ra,0x3
    3106:	b22080e7          	jalr	-1246(ra) # 5c24 <unlink>
  unlink("12345678901234");
    310a:	00004517          	auipc	a0,0x4
    310e:	1ee50513          	addi	a0,a0,494 # 72f8 <malloc+0x12e6>
    3112:	00003097          	auipc	ra,0x3
    3116:	b12080e7          	jalr	-1262(ra) # 5c24 <unlink>
}
    311a:	60e2                	ld	ra,24(sp)
    311c:	6442                	ld	s0,16(sp)
    311e:	64a2                	ld	s1,8(sp)
    3120:	6105                	addi	sp,sp,32
    3122:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    3124:	85a6                	mv	a1,s1
    3126:	00004517          	auipc	a0,0x4
    312a:	00250513          	addi	a0,a0,2 # 7128 <malloc+0x1116>
    312e:	00003097          	auipc	ra,0x3
    3132:	e26080e7          	jalr	-474(ra) # 5f54 <printf>
    exit(1);
    3136:	4505                	li	a0,1
    3138:	00003097          	auipc	ra,0x3
    313c:	a9c080e7          	jalr	-1380(ra) # 5bd4 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    3140:	85a6                	mv	a1,s1
    3142:	00004517          	auipc	a0,0x4
    3146:	02e50513          	addi	a0,a0,46 # 7170 <malloc+0x115e>
    314a:	00003097          	auipc	ra,0x3
    314e:	e0a080e7          	jalr	-502(ra) # 5f54 <printf>
    exit(1);
    3152:	4505                	li	a0,1
    3154:	00003097          	auipc	ra,0x3
    3158:	a80080e7          	jalr	-1408(ra) # 5bd4 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    315c:	85a6                	mv	a1,s1
    315e:	00004517          	auipc	a0,0x4
    3162:	07a50513          	addi	a0,a0,122 # 71d8 <malloc+0x11c6>
    3166:	00003097          	auipc	ra,0x3
    316a:	dee080e7          	jalr	-530(ra) # 5f54 <printf>
    exit(1);
    316e:	4505                	li	a0,1
    3170:	00003097          	auipc	ra,0x3
    3174:	a64080e7          	jalr	-1436(ra) # 5bd4 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    3178:	85a6                	mv	a1,s1
    317a:	00004517          	auipc	a0,0x4
    317e:	0d650513          	addi	a0,a0,214 # 7250 <malloc+0x123e>
    3182:	00003097          	auipc	ra,0x3
    3186:	dd2080e7          	jalr	-558(ra) # 5f54 <printf>
    exit(1);
    318a:	4505                	li	a0,1
    318c:	00003097          	auipc	ra,0x3
    3190:	a48080e7          	jalr	-1464(ra) # 5bd4 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    3194:	85a6                	mv	a1,s1
    3196:	00004517          	auipc	a0,0x4
    319a:	11a50513          	addi	a0,a0,282 # 72b0 <malloc+0x129e>
    319e:	00003097          	auipc	ra,0x3
    31a2:	db6080e7          	jalr	-586(ra) # 5f54 <printf>
    exit(1);
    31a6:	4505                	li	a0,1
    31a8:	00003097          	auipc	ra,0x3
    31ac:	a2c080e7          	jalr	-1492(ra) # 5bd4 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    31b0:	85a6                	mv	a1,s1
    31b2:	00004517          	auipc	a0,0x4
    31b6:	15650513          	addi	a0,a0,342 # 7308 <malloc+0x12f6>
    31ba:	00003097          	auipc	ra,0x3
    31be:	d9a080e7          	jalr	-614(ra) # 5f54 <printf>
    exit(1);
    31c2:	4505                	li	a0,1
    31c4:	00003097          	auipc	ra,0x3
    31c8:	a10080e7          	jalr	-1520(ra) # 5bd4 <exit>

00000000000031cc <diskfull>:
{
    31cc:	b9010113          	addi	sp,sp,-1136
    31d0:	46113423          	sd	ra,1128(sp)
    31d4:	46813023          	sd	s0,1120(sp)
    31d8:	44913c23          	sd	s1,1112(sp)
    31dc:	45213823          	sd	s2,1104(sp)
    31e0:	45313423          	sd	s3,1096(sp)
    31e4:	45413023          	sd	s4,1088(sp)
    31e8:	43513c23          	sd	s5,1080(sp)
    31ec:	43613823          	sd	s6,1072(sp)
    31f0:	43713423          	sd	s7,1064(sp)
    31f4:	43813023          	sd	s8,1056(sp)
    31f8:	47010413          	addi	s0,sp,1136
    31fc:	8c2a                	mv	s8,a0
  unlink("diskfulldir");
    31fe:	00004517          	auipc	a0,0x4
    3202:	14250513          	addi	a0,a0,322 # 7340 <malloc+0x132e>
    3206:	00003097          	auipc	ra,0x3
    320a:	a1e080e7          	jalr	-1506(ra) # 5c24 <unlink>
  for(fi = 0; done == 0; fi++){
    320e:	4a01                	li	s4,0
    name[0] = 'b';
    3210:	06200b93          	li	s7,98
    name[1] = 'i';
    3214:	06900b13          	li	s6,105
    name[2] = 'g';
    3218:	06700a93          	li	s5,103
    321c:	69c1                	lui	s3,0x10
    321e:	10b98993          	addi	s3,s3,267 # 1010b <base+0x493>
    3222:	aabd                	j	33a0 <diskfull+0x1d4>
      printf("%s: could not create file %s\n", s, name);
    3224:	b9040613          	addi	a2,s0,-1136
    3228:	85e2                	mv	a1,s8
    322a:	00004517          	auipc	a0,0x4
    322e:	12650513          	addi	a0,a0,294 # 7350 <malloc+0x133e>
    3232:	00003097          	auipc	ra,0x3
    3236:	d22080e7          	jalr	-734(ra) # 5f54 <printf>
      break;
    323a:	a821                	j	3252 <diskfull+0x86>
        close(fd);
    323c:	854a                	mv	a0,s2
    323e:	00003097          	auipc	ra,0x3
    3242:	9be080e7          	jalr	-1602(ra) # 5bfc <close>
    close(fd);
    3246:	854a                	mv	a0,s2
    3248:	00003097          	auipc	ra,0x3
    324c:	9b4080e7          	jalr	-1612(ra) # 5bfc <close>
  for(fi = 0; done == 0; fi++){
    3250:	2a05                	addiw	s4,s4,1
  for(int i = 0; i < nzz; i++){
    3252:	4481                	li	s1,0
    name[0] = 'z';
    3254:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    3258:	08000993          	li	s3,128
    name[0] = 'z';
    325c:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    3260:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    3264:	41f4d79b          	sraiw	a5,s1,0x1f
    3268:	01b7d71b          	srliw	a4,a5,0x1b
    326c:	009707bb          	addw	a5,a4,s1
    3270:	4057d69b          	sraiw	a3,a5,0x5
    3274:	0306869b          	addiw	a3,a3,48
    3278:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    327c:	8bfd                	andi	a5,a5,31
    327e:	9f99                	subw	a5,a5,a4
    3280:	0307879b          	addiw	a5,a5,48
    3284:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3288:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    328c:	bb040513          	addi	a0,s0,-1104
    3290:	00003097          	auipc	ra,0x3
    3294:	994080e7          	jalr	-1644(ra) # 5c24 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    3298:	60200593          	li	a1,1538
    329c:	bb040513          	addi	a0,s0,-1104
    32a0:	00003097          	auipc	ra,0x3
    32a4:	974080e7          	jalr	-1676(ra) # 5c14 <open>
    if(fd < 0)
    32a8:	00054963          	bltz	a0,32ba <diskfull+0xee>
    close(fd);
    32ac:	00003097          	auipc	ra,0x3
    32b0:	950080e7          	jalr	-1712(ra) # 5bfc <close>
  for(int i = 0; i < nzz; i++){
    32b4:	2485                	addiw	s1,s1,1
    32b6:	fb3493e3          	bne	s1,s3,325c <diskfull+0x90>
  if(mkdir("diskfulldir") == 0)
    32ba:	00004517          	auipc	a0,0x4
    32be:	08650513          	addi	a0,a0,134 # 7340 <malloc+0x132e>
    32c2:	00003097          	auipc	ra,0x3
    32c6:	97a080e7          	jalr	-1670(ra) # 5c3c <mkdir>
    32ca:	12050963          	beqz	a0,33fc <diskfull+0x230>
  unlink("diskfulldir");
    32ce:	00004517          	auipc	a0,0x4
    32d2:	07250513          	addi	a0,a0,114 # 7340 <malloc+0x132e>
    32d6:	00003097          	auipc	ra,0x3
    32da:	94e080e7          	jalr	-1714(ra) # 5c24 <unlink>
  for(int i = 0; i < nzz; i++){
    32de:	4481                	li	s1,0
    name[0] = 'z';
    32e0:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    32e4:	08000993          	li	s3,128
    name[0] = 'z';
    32e8:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    32ec:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    32f0:	41f4d79b          	sraiw	a5,s1,0x1f
    32f4:	01b7d71b          	srliw	a4,a5,0x1b
    32f8:	009707bb          	addw	a5,a4,s1
    32fc:	4057d69b          	sraiw	a3,a5,0x5
    3300:	0306869b          	addiw	a3,a3,48
    3304:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    3308:	8bfd                	andi	a5,a5,31
    330a:	9f99                	subw	a5,a5,a4
    330c:	0307879b          	addiw	a5,a5,48
    3310:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3314:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3318:	bb040513          	addi	a0,s0,-1104
    331c:	00003097          	auipc	ra,0x3
    3320:	908080e7          	jalr	-1784(ra) # 5c24 <unlink>
  for(int i = 0; i < nzz; i++){
    3324:	2485                	addiw	s1,s1,1
    3326:	fd3491e3          	bne	s1,s3,32e8 <diskfull+0x11c>
  for(int i = 0; i < fi; i++){
    332a:	03405e63          	blez	s4,3366 <diskfull+0x19a>
    332e:	4481                	li	s1,0
    name[0] = 'b';
    3330:	06200a93          	li	s5,98
    name[1] = 'i';
    3334:	06900993          	li	s3,105
    name[2] = 'g';
    3338:	06700913          	li	s2,103
    name[0] = 'b';
    333c:	bb540823          	sb	s5,-1104(s0)
    name[1] = 'i';
    3340:	bb3408a3          	sb	s3,-1103(s0)
    name[2] = 'g';
    3344:	bb240923          	sb	s2,-1102(s0)
    name[3] = '0' + i;
    3348:	0304879b          	addiw	a5,s1,48
    334c:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3350:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3354:	bb040513          	addi	a0,s0,-1104
    3358:	00003097          	auipc	ra,0x3
    335c:	8cc080e7          	jalr	-1844(ra) # 5c24 <unlink>
  for(int i = 0; i < fi; i++){
    3360:	2485                	addiw	s1,s1,1
    3362:	fd449de3          	bne	s1,s4,333c <diskfull+0x170>
}
    3366:	46813083          	ld	ra,1128(sp)
    336a:	46013403          	ld	s0,1120(sp)
    336e:	45813483          	ld	s1,1112(sp)
    3372:	45013903          	ld	s2,1104(sp)
    3376:	44813983          	ld	s3,1096(sp)
    337a:	44013a03          	ld	s4,1088(sp)
    337e:	43813a83          	ld	s5,1080(sp)
    3382:	43013b03          	ld	s6,1072(sp)
    3386:	42813b83          	ld	s7,1064(sp)
    338a:	42013c03          	ld	s8,1056(sp)
    338e:	47010113          	addi	sp,sp,1136
    3392:	8082                	ret
    close(fd);
    3394:	854a                	mv	a0,s2
    3396:	00003097          	auipc	ra,0x3
    339a:	866080e7          	jalr	-1946(ra) # 5bfc <close>
  for(fi = 0; done == 0; fi++){
    339e:	2a05                	addiw	s4,s4,1
    name[0] = 'b';
    33a0:	b9740823          	sb	s7,-1136(s0)
    name[1] = 'i';
    33a4:	b96408a3          	sb	s6,-1135(s0)
    name[2] = 'g';
    33a8:	b9540923          	sb	s5,-1134(s0)
    name[3] = '0' + fi;
    33ac:	030a079b          	addiw	a5,s4,48
    33b0:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    33b4:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    33b8:	b9040513          	addi	a0,s0,-1136
    33bc:	00003097          	auipc	ra,0x3
    33c0:	868080e7          	jalr	-1944(ra) # 5c24 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    33c4:	60200593          	li	a1,1538
    33c8:	b9040513          	addi	a0,s0,-1136
    33cc:	00003097          	auipc	ra,0x3
    33d0:	848080e7          	jalr	-1976(ra) # 5c14 <open>
    33d4:	892a                	mv	s2,a0
    if(fd < 0){
    33d6:	e40547e3          	bltz	a0,3224 <diskfull+0x58>
    33da:	84ce                	mv	s1,s3
      if(write(fd, buf, BSIZE) != BSIZE){
    33dc:	40000613          	li	a2,1024
    33e0:	bb040593          	addi	a1,s0,-1104
    33e4:	854a                	mv	a0,s2
    33e6:	00003097          	auipc	ra,0x3
    33ea:	80e080e7          	jalr	-2034(ra) # 5bf4 <write>
    33ee:	40000793          	li	a5,1024
    33f2:	e4f515e3          	bne	a0,a5,323c <diskfull+0x70>
    for(int i = 0; i < MAXFILE; i++){
    33f6:	34fd                	addiw	s1,s1,-1
    33f8:	f0f5                	bnez	s1,33dc <diskfull+0x210>
    33fa:	bf69                	j	3394 <diskfull+0x1c8>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    33fc:	00004517          	auipc	a0,0x4
    3400:	f7450513          	addi	a0,a0,-140 # 7370 <malloc+0x135e>
    3404:	00003097          	auipc	ra,0x3
    3408:	b50080e7          	jalr	-1200(ra) # 5f54 <printf>
    340c:	b5c9                	j	32ce <diskfull+0x102>

000000000000340e <iputtest>:
{
    340e:	1101                	addi	sp,sp,-32
    3410:	ec06                	sd	ra,24(sp)
    3412:	e822                	sd	s0,16(sp)
    3414:	e426                	sd	s1,8(sp)
    3416:	1000                	addi	s0,sp,32
    3418:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    341a:	00004517          	auipc	a0,0x4
    341e:	f8650513          	addi	a0,a0,-122 # 73a0 <malloc+0x138e>
    3422:	00003097          	auipc	ra,0x3
    3426:	81a080e7          	jalr	-2022(ra) # 5c3c <mkdir>
    342a:	04054563          	bltz	a0,3474 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    342e:	00004517          	auipc	a0,0x4
    3432:	f7250513          	addi	a0,a0,-142 # 73a0 <malloc+0x138e>
    3436:	00003097          	auipc	ra,0x3
    343a:	80e080e7          	jalr	-2034(ra) # 5c44 <chdir>
    343e:	04054963          	bltz	a0,3490 <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    3442:	00004517          	auipc	a0,0x4
    3446:	f9e50513          	addi	a0,a0,-98 # 73e0 <malloc+0x13ce>
    344a:	00002097          	auipc	ra,0x2
    344e:	7da080e7          	jalr	2010(ra) # 5c24 <unlink>
    3452:	04054d63          	bltz	a0,34ac <iputtest+0x9e>
  if(chdir("/") < 0){
    3456:	00004517          	auipc	a0,0x4
    345a:	fba50513          	addi	a0,a0,-70 # 7410 <malloc+0x13fe>
    345e:	00002097          	auipc	ra,0x2
    3462:	7e6080e7          	jalr	2022(ra) # 5c44 <chdir>
    3466:	06054163          	bltz	a0,34c8 <iputtest+0xba>
}
    346a:	60e2                	ld	ra,24(sp)
    346c:	6442                	ld	s0,16(sp)
    346e:	64a2                	ld	s1,8(sp)
    3470:	6105                	addi	sp,sp,32
    3472:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3474:	85a6                	mv	a1,s1
    3476:	00004517          	auipc	a0,0x4
    347a:	f3250513          	addi	a0,a0,-206 # 73a8 <malloc+0x1396>
    347e:	00003097          	auipc	ra,0x3
    3482:	ad6080e7          	jalr	-1322(ra) # 5f54 <printf>
    exit(1);
    3486:	4505                	li	a0,1
    3488:	00002097          	auipc	ra,0x2
    348c:	74c080e7          	jalr	1868(ra) # 5bd4 <exit>
    printf("%s: chdir iputdir failed\n", s);
    3490:	85a6                	mv	a1,s1
    3492:	00004517          	auipc	a0,0x4
    3496:	f2e50513          	addi	a0,a0,-210 # 73c0 <malloc+0x13ae>
    349a:	00003097          	auipc	ra,0x3
    349e:	aba080e7          	jalr	-1350(ra) # 5f54 <printf>
    exit(1);
    34a2:	4505                	li	a0,1
    34a4:	00002097          	auipc	ra,0x2
    34a8:	730080e7          	jalr	1840(ra) # 5bd4 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    34ac:	85a6                	mv	a1,s1
    34ae:	00004517          	auipc	a0,0x4
    34b2:	f4250513          	addi	a0,a0,-190 # 73f0 <malloc+0x13de>
    34b6:	00003097          	auipc	ra,0x3
    34ba:	a9e080e7          	jalr	-1378(ra) # 5f54 <printf>
    exit(1);
    34be:	4505                	li	a0,1
    34c0:	00002097          	auipc	ra,0x2
    34c4:	714080e7          	jalr	1812(ra) # 5bd4 <exit>
    printf("%s: chdir / failed\n", s);
    34c8:	85a6                	mv	a1,s1
    34ca:	00004517          	auipc	a0,0x4
    34ce:	f4e50513          	addi	a0,a0,-178 # 7418 <malloc+0x1406>
    34d2:	00003097          	auipc	ra,0x3
    34d6:	a82080e7          	jalr	-1406(ra) # 5f54 <printf>
    exit(1);
    34da:	4505                	li	a0,1
    34dc:	00002097          	auipc	ra,0x2
    34e0:	6f8080e7          	jalr	1784(ra) # 5bd4 <exit>

00000000000034e4 <exitiputtest>:
{
    34e4:	7179                	addi	sp,sp,-48
    34e6:	f406                	sd	ra,40(sp)
    34e8:	f022                	sd	s0,32(sp)
    34ea:	ec26                	sd	s1,24(sp)
    34ec:	1800                	addi	s0,sp,48
    34ee:	84aa                	mv	s1,a0
  pid = fork();
    34f0:	00002097          	auipc	ra,0x2
    34f4:	6dc080e7          	jalr	1756(ra) # 5bcc <fork>
  if(pid < 0){
    34f8:	04054663          	bltz	a0,3544 <exitiputtest+0x60>
  if(pid == 0){
    34fc:	ed45                	bnez	a0,35b4 <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    34fe:	00004517          	auipc	a0,0x4
    3502:	ea250513          	addi	a0,a0,-350 # 73a0 <malloc+0x138e>
    3506:	00002097          	auipc	ra,0x2
    350a:	736080e7          	jalr	1846(ra) # 5c3c <mkdir>
    350e:	04054963          	bltz	a0,3560 <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    3512:	00004517          	auipc	a0,0x4
    3516:	e8e50513          	addi	a0,a0,-370 # 73a0 <malloc+0x138e>
    351a:	00002097          	auipc	ra,0x2
    351e:	72a080e7          	jalr	1834(ra) # 5c44 <chdir>
    3522:	04054d63          	bltz	a0,357c <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    3526:	00004517          	auipc	a0,0x4
    352a:	eba50513          	addi	a0,a0,-326 # 73e0 <malloc+0x13ce>
    352e:	00002097          	auipc	ra,0x2
    3532:	6f6080e7          	jalr	1782(ra) # 5c24 <unlink>
    3536:	06054163          	bltz	a0,3598 <exitiputtest+0xb4>
    exit(0);
    353a:	4501                	li	a0,0
    353c:	00002097          	auipc	ra,0x2
    3540:	698080e7          	jalr	1688(ra) # 5bd4 <exit>
    printf("%s: fork failed\n", s);
    3544:	85a6                	mv	a1,s1
    3546:	00003517          	auipc	a0,0x3
    354a:	49a50513          	addi	a0,a0,1178 # 69e0 <malloc+0x9ce>
    354e:	00003097          	auipc	ra,0x3
    3552:	a06080e7          	jalr	-1530(ra) # 5f54 <printf>
    exit(1);
    3556:	4505                	li	a0,1
    3558:	00002097          	auipc	ra,0x2
    355c:	67c080e7          	jalr	1660(ra) # 5bd4 <exit>
      printf("%s: mkdir failed\n", s);
    3560:	85a6                	mv	a1,s1
    3562:	00004517          	auipc	a0,0x4
    3566:	e4650513          	addi	a0,a0,-442 # 73a8 <malloc+0x1396>
    356a:	00003097          	auipc	ra,0x3
    356e:	9ea080e7          	jalr	-1558(ra) # 5f54 <printf>
      exit(1);
    3572:	4505                	li	a0,1
    3574:	00002097          	auipc	ra,0x2
    3578:	660080e7          	jalr	1632(ra) # 5bd4 <exit>
      printf("%s: child chdir failed\n", s);
    357c:	85a6                	mv	a1,s1
    357e:	00004517          	auipc	a0,0x4
    3582:	eb250513          	addi	a0,a0,-334 # 7430 <malloc+0x141e>
    3586:	00003097          	auipc	ra,0x3
    358a:	9ce080e7          	jalr	-1586(ra) # 5f54 <printf>
      exit(1);
    358e:	4505                	li	a0,1
    3590:	00002097          	auipc	ra,0x2
    3594:	644080e7          	jalr	1604(ra) # 5bd4 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    3598:	85a6                	mv	a1,s1
    359a:	00004517          	auipc	a0,0x4
    359e:	e5650513          	addi	a0,a0,-426 # 73f0 <malloc+0x13de>
    35a2:	00003097          	auipc	ra,0x3
    35a6:	9b2080e7          	jalr	-1614(ra) # 5f54 <printf>
      exit(1);
    35aa:	4505                	li	a0,1
    35ac:	00002097          	auipc	ra,0x2
    35b0:	628080e7          	jalr	1576(ra) # 5bd4 <exit>
  wait(&xstatus);
    35b4:	fdc40513          	addi	a0,s0,-36
    35b8:	00002097          	auipc	ra,0x2
    35bc:	624080e7          	jalr	1572(ra) # 5bdc <wait>
  exit(xstatus);
    35c0:	fdc42503          	lw	a0,-36(s0)
    35c4:	00002097          	auipc	ra,0x2
    35c8:	610080e7          	jalr	1552(ra) # 5bd4 <exit>

00000000000035cc <dirtest>:
{
    35cc:	1101                	addi	sp,sp,-32
    35ce:	ec06                	sd	ra,24(sp)
    35d0:	e822                	sd	s0,16(sp)
    35d2:	e426                	sd	s1,8(sp)
    35d4:	1000                	addi	s0,sp,32
    35d6:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    35d8:	00004517          	auipc	a0,0x4
    35dc:	e7050513          	addi	a0,a0,-400 # 7448 <malloc+0x1436>
    35e0:	00002097          	auipc	ra,0x2
    35e4:	65c080e7          	jalr	1628(ra) # 5c3c <mkdir>
    35e8:	04054563          	bltz	a0,3632 <dirtest+0x66>
  if(chdir("dir0") < 0){
    35ec:	00004517          	auipc	a0,0x4
    35f0:	e5c50513          	addi	a0,a0,-420 # 7448 <malloc+0x1436>
    35f4:	00002097          	auipc	ra,0x2
    35f8:	650080e7          	jalr	1616(ra) # 5c44 <chdir>
    35fc:	04054963          	bltz	a0,364e <dirtest+0x82>
  if(chdir("..") < 0){
    3600:	00004517          	auipc	a0,0x4
    3604:	e6850513          	addi	a0,a0,-408 # 7468 <malloc+0x1456>
    3608:	00002097          	auipc	ra,0x2
    360c:	63c080e7          	jalr	1596(ra) # 5c44 <chdir>
    3610:	04054d63          	bltz	a0,366a <dirtest+0x9e>
  if(unlink("dir0") < 0){
    3614:	00004517          	auipc	a0,0x4
    3618:	e3450513          	addi	a0,a0,-460 # 7448 <malloc+0x1436>
    361c:	00002097          	auipc	ra,0x2
    3620:	608080e7          	jalr	1544(ra) # 5c24 <unlink>
    3624:	06054163          	bltz	a0,3686 <dirtest+0xba>
}
    3628:	60e2                	ld	ra,24(sp)
    362a:	6442                	ld	s0,16(sp)
    362c:	64a2                	ld	s1,8(sp)
    362e:	6105                	addi	sp,sp,32
    3630:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3632:	85a6                	mv	a1,s1
    3634:	00004517          	auipc	a0,0x4
    3638:	d7450513          	addi	a0,a0,-652 # 73a8 <malloc+0x1396>
    363c:	00003097          	auipc	ra,0x3
    3640:	918080e7          	jalr	-1768(ra) # 5f54 <printf>
    exit(1);
    3644:	4505                	li	a0,1
    3646:	00002097          	auipc	ra,0x2
    364a:	58e080e7          	jalr	1422(ra) # 5bd4 <exit>
    printf("%s: chdir dir0 failed\n", s);
    364e:	85a6                	mv	a1,s1
    3650:	00004517          	auipc	a0,0x4
    3654:	e0050513          	addi	a0,a0,-512 # 7450 <malloc+0x143e>
    3658:	00003097          	auipc	ra,0x3
    365c:	8fc080e7          	jalr	-1796(ra) # 5f54 <printf>
    exit(1);
    3660:	4505                	li	a0,1
    3662:	00002097          	auipc	ra,0x2
    3666:	572080e7          	jalr	1394(ra) # 5bd4 <exit>
    printf("%s: chdir .. failed\n", s);
    366a:	85a6                	mv	a1,s1
    366c:	00004517          	auipc	a0,0x4
    3670:	e0450513          	addi	a0,a0,-508 # 7470 <malloc+0x145e>
    3674:	00003097          	auipc	ra,0x3
    3678:	8e0080e7          	jalr	-1824(ra) # 5f54 <printf>
    exit(1);
    367c:	4505                	li	a0,1
    367e:	00002097          	auipc	ra,0x2
    3682:	556080e7          	jalr	1366(ra) # 5bd4 <exit>
    printf("%s: unlink dir0 failed\n", s);
    3686:	85a6                	mv	a1,s1
    3688:	00004517          	auipc	a0,0x4
    368c:	e0050513          	addi	a0,a0,-512 # 7488 <malloc+0x1476>
    3690:	00003097          	auipc	ra,0x3
    3694:	8c4080e7          	jalr	-1852(ra) # 5f54 <printf>
    exit(1);
    3698:	4505                	li	a0,1
    369a:	00002097          	auipc	ra,0x2
    369e:	53a080e7          	jalr	1338(ra) # 5bd4 <exit>

00000000000036a2 <subdir>:
{
    36a2:	1101                	addi	sp,sp,-32
    36a4:	ec06                	sd	ra,24(sp)
    36a6:	e822                	sd	s0,16(sp)
    36a8:	e426                	sd	s1,8(sp)
    36aa:	e04a                	sd	s2,0(sp)
    36ac:	1000                	addi	s0,sp,32
    36ae:	892a                	mv	s2,a0
  unlink("ff");
    36b0:	00004517          	auipc	a0,0x4
    36b4:	f2050513          	addi	a0,a0,-224 # 75d0 <malloc+0x15be>
    36b8:	00002097          	auipc	ra,0x2
    36bc:	56c080e7          	jalr	1388(ra) # 5c24 <unlink>
  if(mkdir("dd") != 0){
    36c0:	00004517          	auipc	a0,0x4
    36c4:	de050513          	addi	a0,a0,-544 # 74a0 <malloc+0x148e>
    36c8:	00002097          	auipc	ra,0x2
    36cc:	574080e7          	jalr	1396(ra) # 5c3c <mkdir>
    36d0:	38051663          	bnez	a0,3a5c <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    36d4:	20200593          	li	a1,514
    36d8:	00004517          	auipc	a0,0x4
    36dc:	de850513          	addi	a0,a0,-536 # 74c0 <malloc+0x14ae>
    36e0:	00002097          	auipc	ra,0x2
    36e4:	534080e7          	jalr	1332(ra) # 5c14 <open>
    36e8:	84aa                	mv	s1,a0
  if(fd < 0){
    36ea:	38054763          	bltz	a0,3a78 <subdir+0x3d6>
  write(fd, "ff", 2);
    36ee:	4609                	li	a2,2
    36f0:	00004597          	auipc	a1,0x4
    36f4:	ee058593          	addi	a1,a1,-288 # 75d0 <malloc+0x15be>
    36f8:	00002097          	auipc	ra,0x2
    36fc:	4fc080e7          	jalr	1276(ra) # 5bf4 <write>
  close(fd);
    3700:	8526                	mv	a0,s1
    3702:	00002097          	auipc	ra,0x2
    3706:	4fa080e7          	jalr	1274(ra) # 5bfc <close>
  if(unlink("dd") >= 0){
    370a:	00004517          	auipc	a0,0x4
    370e:	d9650513          	addi	a0,a0,-618 # 74a0 <malloc+0x148e>
    3712:	00002097          	auipc	ra,0x2
    3716:	512080e7          	jalr	1298(ra) # 5c24 <unlink>
    371a:	36055d63          	bgez	a0,3a94 <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    371e:	00004517          	auipc	a0,0x4
    3722:	dfa50513          	addi	a0,a0,-518 # 7518 <malloc+0x1506>
    3726:	00002097          	auipc	ra,0x2
    372a:	516080e7          	jalr	1302(ra) # 5c3c <mkdir>
    372e:	38051163          	bnez	a0,3ab0 <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3732:	20200593          	li	a1,514
    3736:	00004517          	auipc	a0,0x4
    373a:	e0a50513          	addi	a0,a0,-502 # 7540 <malloc+0x152e>
    373e:	00002097          	auipc	ra,0x2
    3742:	4d6080e7          	jalr	1238(ra) # 5c14 <open>
    3746:	84aa                	mv	s1,a0
  if(fd < 0){
    3748:	38054263          	bltz	a0,3acc <subdir+0x42a>
  write(fd, "FF", 2);
    374c:	4609                	li	a2,2
    374e:	00004597          	auipc	a1,0x4
    3752:	e2258593          	addi	a1,a1,-478 # 7570 <malloc+0x155e>
    3756:	00002097          	auipc	ra,0x2
    375a:	49e080e7          	jalr	1182(ra) # 5bf4 <write>
  close(fd);
    375e:	8526                	mv	a0,s1
    3760:	00002097          	auipc	ra,0x2
    3764:	49c080e7          	jalr	1180(ra) # 5bfc <close>
  fd = open("dd/dd/../ff", 0);
    3768:	4581                	li	a1,0
    376a:	00004517          	auipc	a0,0x4
    376e:	e0e50513          	addi	a0,a0,-498 # 7578 <malloc+0x1566>
    3772:	00002097          	auipc	ra,0x2
    3776:	4a2080e7          	jalr	1186(ra) # 5c14 <open>
    377a:	84aa                	mv	s1,a0
  if(fd < 0){
    377c:	36054663          	bltz	a0,3ae8 <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    3780:	660d                	lui	a2,0x3
    3782:	00009597          	auipc	a1,0x9
    3786:	4f658593          	addi	a1,a1,1270 # cc78 <buf>
    378a:	00002097          	auipc	ra,0x2
    378e:	462080e7          	jalr	1122(ra) # 5bec <read>
  if(cc != 2 || buf[0] != 'f'){
    3792:	4789                	li	a5,2
    3794:	36f51863          	bne	a0,a5,3b04 <subdir+0x462>
    3798:	00009717          	auipc	a4,0x9
    379c:	4e074703          	lbu	a4,1248(a4) # cc78 <buf>
    37a0:	06600793          	li	a5,102
    37a4:	36f71063          	bne	a4,a5,3b04 <subdir+0x462>
  close(fd);
    37a8:	8526                	mv	a0,s1
    37aa:	00002097          	auipc	ra,0x2
    37ae:	452080e7          	jalr	1106(ra) # 5bfc <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    37b2:	00004597          	auipc	a1,0x4
    37b6:	e1658593          	addi	a1,a1,-490 # 75c8 <malloc+0x15b6>
    37ba:	00004517          	auipc	a0,0x4
    37be:	d8650513          	addi	a0,a0,-634 # 7540 <malloc+0x152e>
    37c2:	00002097          	auipc	ra,0x2
    37c6:	472080e7          	jalr	1138(ra) # 5c34 <link>
    37ca:	34051b63          	bnez	a0,3b20 <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    37ce:	00004517          	auipc	a0,0x4
    37d2:	d7250513          	addi	a0,a0,-654 # 7540 <malloc+0x152e>
    37d6:	00002097          	auipc	ra,0x2
    37da:	44e080e7          	jalr	1102(ra) # 5c24 <unlink>
    37de:	34051f63          	bnez	a0,3b3c <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    37e2:	4581                	li	a1,0
    37e4:	00004517          	auipc	a0,0x4
    37e8:	d5c50513          	addi	a0,a0,-676 # 7540 <malloc+0x152e>
    37ec:	00002097          	auipc	ra,0x2
    37f0:	428080e7          	jalr	1064(ra) # 5c14 <open>
    37f4:	36055263          	bgez	a0,3b58 <subdir+0x4b6>
  if(chdir("dd") != 0){
    37f8:	00004517          	auipc	a0,0x4
    37fc:	ca850513          	addi	a0,a0,-856 # 74a0 <malloc+0x148e>
    3800:	00002097          	auipc	ra,0x2
    3804:	444080e7          	jalr	1092(ra) # 5c44 <chdir>
    3808:	36051663          	bnez	a0,3b74 <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    380c:	00004517          	auipc	a0,0x4
    3810:	e5450513          	addi	a0,a0,-428 # 7660 <malloc+0x164e>
    3814:	00002097          	auipc	ra,0x2
    3818:	430080e7          	jalr	1072(ra) # 5c44 <chdir>
    381c:	36051a63          	bnez	a0,3b90 <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    3820:	00004517          	auipc	a0,0x4
    3824:	e7050513          	addi	a0,a0,-400 # 7690 <malloc+0x167e>
    3828:	00002097          	auipc	ra,0x2
    382c:	41c080e7          	jalr	1052(ra) # 5c44 <chdir>
    3830:	36051e63          	bnez	a0,3bac <subdir+0x50a>
  if(chdir("./..") != 0){
    3834:	00004517          	auipc	a0,0x4
    3838:	e8c50513          	addi	a0,a0,-372 # 76c0 <malloc+0x16ae>
    383c:	00002097          	auipc	ra,0x2
    3840:	408080e7          	jalr	1032(ra) # 5c44 <chdir>
    3844:	38051263          	bnez	a0,3bc8 <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    3848:	4581                	li	a1,0
    384a:	00004517          	auipc	a0,0x4
    384e:	d7e50513          	addi	a0,a0,-642 # 75c8 <malloc+0x15b6>
    3852:	00002097          	auipc	ra,0x2
    3856:	3c2080e7          	jalr	962(ra) # 5c14 <open>
    385a:	84aa                	mv	s1,a0
  if(fd < 0){
    385c:	38054463          	bltz	a0,3be4 <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    3860:	660d                	lui	a2,0x3
    3862:	00009597          	auipc	a1,0x9
    3866:	41658593          	addi	a1,a1,1046 # cc78 <buf>
    386a:	00002097          	auipc	ra,0x2
    386e:	382080e7          	jalr	898(ra) # 5bec <read>
    3872:	4789                	li	a5,2
    3874:	38f51663          	bne	a0,a5,3c00 <subdir+0x55e>
  close(fd);
    3878:	8526                	mv	a0,s1
    387a:	00002097          	auipc	ra,0x2
    387e:	382080e7          	jalr	898(ra) # 5bfc <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3882:	4581                	li	a1,0
    3884:	00004517          	auipc	a0,0x4
    3888:	cbc50513          	addi	a0,a0,-836 # 7540 <malloc+0x152e>
    388c:	00002097          	auipc	ra,0x2
    3890:	388080e7          	jalr	904(ra) # 5c14 <open>
    3894:	38055463          	bgez	a0,3c1c <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    3898:	20200593          	li	a1,514
    389c:	00004517          	auipc	a0,0x4
    38a0:	eb450513          	addi	a0,a0,-332 # 7750 <malloc+0x173e>
    38a4:	00002097          	auipc	ra,0x2
    38a8:	370080e7          	jalr	880(ra) # 5c14 <open>
    38ac:	38055663          	bgez	a0,3c38 <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    38b0:	20200593          	li	a1,514
    38b4:	00004517          	auipc	a0,0x4
    38b8:	ecc50513          	addi	a0,a0,-308 # 7780 <malloc+0x176e>
    38bc:	00002097          	auipc	ra,0x2
    38c0:	358080e7          	jalr	856(ra) # 5c14 <open>
    38c4:	38055863          	bgez	a0,3c54 <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    38c8:	20000593          	li	a1,512
    38cc:	00004517          	auipc	a0,0x4
    38d0:	bd450513          	addi	a0,a0,-1068 # 74a0 <malloc+0x148e>
    38d4:	00002097          	auipc	ra,0x2
    38d8:	340080e7          	jalr	832(ra) # 5c14 <open>
    38dc:	38055a63          	bgez	a0,3c70 <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    38e0:	4589                	li	a1,2
    38e2:	00004517          	auipc	a0,0x4
    38e6:	bbe50513          	addi	a0,a0,-1090 # 74a0 <malloc+0x148e>
    38ea:	00002097          	auipc	ra,0x2
    38ee:	32a080e7          	jalr	810(ra) # 5c14 <open>
    38f2:	38055d63          	bgez	a0,3c8c <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    38f6:	4585                	li	a1,1
    38f8:	00004517          	auipc	a0,0x4
    38fc:	ba850513          	addi	a0,a0,-1112 # 74a0 <malloc+0x148e>
    3900:	00002097          	auipc	ra,0x2
    3904:	314080e7          	jalr	788(ra) # 5c14 <open>
    3908:	3a055063          	bgez	a0,3ca8 <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    390c:	00004597          	auipc	a1,0x4
    3910:	f0458593          	addi	a1,a1,-252 # 7810 <malloc+0x17fe>
    3914:	00004517          	auipc	a0,0x4
    3918:	e3c50513          	addi	a0,a0,-452 # 7750 <malloc+0x173e>
    391c:	00002097          	auipc	ra,0x2
    3920:	318080e7          	jalr	792(ra) # 5c34 <link>
    3924:	3a050063          	beqz	a0,3cc4 <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    3928:	00004597          	auipc	a1,0x4
    392c:	ee858593          	addi	a1,a1,-280 # 7810 <malloc+0x17fe>
    3930:	00004517          	auipc	a0,0x4
    3934:	e5050513          	addi	a0,a0,-432 # 7780 <malloc+0x176e>
    3938:	00002097          	auipc	ra,0x2
    393c:	2fc080e7          	jalr	764(ra) # 5c34 <link>
    3940:	3a050063          	beqz	a0,3ce0 <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    3944:	00004597          	auipc	a1,0x4
    3948:	c8458593          	addi	a1,a1,-892 # 75c8 <malloc+0x15b6>
    394c:	00004517          	auipc	a0,0x4
    3950:	b7450513          	addi	a0,a0,-1164 # 74c0 <malloc+0x14ae>
    3954:	00002097          	auipc	ra,0x2
    3958:	2e0080e7          	jalr	736(ra) # 5c34 <link>
    395c:	3a050063          	beqz	a0,3cfc <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    3960:	00004517          	auipc	a0,0x4
    3964:	df050513          	addi	a0,a0,-528 # 7750 <malloc+0x173e>
    3968:	00002097          	auipc	ra,0x2
    396c:	2d4080e7          	jalr	724(ra) # 5c3c <mkdir>
    3970:	3a050463          	beqz	a0,3d18 <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    3974:	00004517          	auipc	a0,0x4
    3978:	e0c50513          	addi	a0,a0,-500 # 7780 <malloc+0x176e>
    397c:	00002097          	auipc	ra,0x2
    3980:	2c0080e7          	jalr	704(ra) # 5c3c <mkdir>
    3984:	3a050863          	beqz	a0,3d34 <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    3988:	00004517          	auipc	a0,0x4
    398c:	c4050513          	addi	a0,a0,-960 # 75c8 <malloc+0x15b6>
    3990:	00002097          	auipc	ra,0x2
    3994:	2ac080e7          	jalr	684(ra) # 5c3c <mkdir>
    3998:	3a050c63          	beqz	a0,3d50 <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    399c:	00004517          	auipc	a0,0x4
    39a0:	de450513          	addi	a0,a0,-540 # 7780 <malloc+0x176e>
    39a4:	00002097          	auipc	ra,0x2
    39a8:	280080e7          	jalr	640(ra) # 5c24 <unlink>
    39ac:	3c050063          	beqz	a0,3d6c <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    39b0:	00004517          	auipc	a0,0x4
    39b4:	da050513          	addi	a0,a0,-608 # 7750 <malloc+0x173e>
    39b8:	00002097          	auipc	ra,0x2
    39bc:	26c080e7          	jalr	620(ra) # 5c24 <unlink>
    39c0:	3c050463          	beqz	a0,3d88 <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    39c4:	00004517          	auipc	a0,0x4
    39c8:	afc50513          	addi	a0,a0,-1284 # 74c0 <malloc+0x14ae>
    39cc:	00002097          	auipc	ra,0x2
    39d0:	278080e7          	jalr	632(ra) # 5c44 <chdir>
    39d4:	3c050863          	beqz	a0,3da4 <subdir+0x702>
  if(chdir("dd/xx") == 0){
    39d8:	00004517          	auipc	a0,0x4
    39dc:	f8850513          	addi	a0,a0,-120 # 7960 <malloc+0x194e>
    39e0:	00002097          	auipc	ra,0x2
    39e4:	264080e7          	jalr	612(ra) # 5c44 <chdir>
    39e8:	3c050c63          	beqz	a0,3dc0 <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    39ec:	00004517          	auipc	a0,0x4
    39f0:	bdc50513          	addi	a0,a0,-1060 # 75c8 <malloc+0x15b6>
    39f4:	00002097          	auipc	ra,0x2
    39f8:	230080e7          	jalr	560(ra) # 5c24 <unlink>
    39fc:	3e051063          	bnez	a0,3ddc <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    3a00:	00004517          	auipc	a0,0x4
    3a04:	ac050513          	addi	a0,a0,-1344 # 74c0 <malloc+0x14ae>
    3a08:	00002097          	auipc	ra,0x2
    3a0c:	21c080e7          	jalr	540(ra) # 5c24 <unlink>
    3a10:	3e051463          	bnez	a0,3df8 <subdir+0x756>
  if(unlink("dd") == 0){
    3a14:	00004517          	auipc	a0,0x4
    3a18:	a8c50513          	addi	a0,a0,-1396 # 74a0 <malloc+0x148e>
    3a1c:	00002097          	auipc	ra,0x2
    3a20:	208080e7          	jalr	520(ra) # 5c24 <unlink>
    3a24:	3e050863          	beqz	a0,3e14 <subdir+0x772>
  if(unlink("dd/dd") < 0){
    3a28:	00004517          	auipc	a0,0x4
    3a2c:	fa850513          	addi	a0,a0,-88 # 79d0 <malloc+0x19be>
    3a30:	00002097          	auipc	ra,0x2
    3a34:	1f4080e7          	jalr	500(ra) # 5c24 <unlink>
    3a38:	3e054c63          	bltz	a0,3e30 <subdir+0x78e>
  if(unlink("dd") < 0){
    3a3c:	00004517          	auipc	a0,0x4
    3a40:	a6450513          	addi	a0,a0,-1436 # 74a0 <malloc+0x148e>
    3a44:	00002097          	auipc	ra,0x2
    3a48:	1e0080e7          	jalr	480(ra) # 5c24 <unlink>
    3a4c:	40054063          	bltz	a0,3e4c <subdir+0x7aa>
}
    3a50:	60e2                	ld	ra,24(sp)
    3a52:	6442                	ld	s0,16(sp)
    3a54:	64a2                	ld	s1,8(sp)
    3a56:	6902                	ld	s2,0(sp)
    3a58:	6105                	addi	sp,sp,32
    3a5a:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3a5c:	85ca                	mv	a1,s2
    3a5e:	00004517          	auipc	a0,0x4
    3a62:	a4a50513          	addi	a0,a0,-1462 # 74a8 <malloc+0x1496>
    3a66:	00002097          	auipc	ra,0x2
    3a6a:	4ee080e7          	jalr	1262(ra) # 5f54 <printf>
    exit(1);
    3a6e:	4505                	li	a0,1
    3a70:	00002097          	auipc	ra,0x2
    3a74:	164080e7          	jalr	356(ra) # 5bd4 <exit>
    printf("%s: create dd/ff failed\n", s);
    3a78:	85ca                	mv	a1,s2
    3a7a:	00004517          	auipc	a0,0x4
    3a7e:	a4e50513          	addi	a0,a0,-1458 # 74c8 <malloc+0x14b6>
    3a82:	00002097          	auipc	ra,0x2
    3a86:	4d2080e7          	jalr	1234(ra) # 5f54 <printf>
    exit(1);
    3a8a:	4505                	li	a0,1
    3a8c:	00002097          	auipc	ra,0x2
    3a90:	148080e7          	jalr	328(ra) # 5bd4 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3a94:	85ca                	mv	a1,s2
    3a96:	00004517          	auipc	a0,0x4
    3a9a:	a5250513          	addi	a0,a0,-1454 # 74e8 <malloc+0x14d6>
    3a9e:	00002097          	auipc	ra,0x2
    3aa2:	4b6080e7          	jalr	1206(ra) # 5f54 <printf>
    exit(1);
    3aa6:	4505                	li	a0,1
    3aa8:	00002097          	auipc	ra,0x2
    3aac:	12c080e7          	jalr	300(ra) # 5bd4 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    3ab0:	85ca                	mv	a1,s2
    3ab2:	00004517          	auipc	a0,0x4
    3ab6:	a6e50513          	addi	a0,a0,-1426 # 7520 <malloc+0x150e>
    3aba:	00002097          	auipc	ra,0x2
    3abe:	49a080e7          	jalr	1178(ra) # 5f54 <printf>
    exit(1);
    3ac2:	4505                	li	a0,1
    3ac4:	00002097          	auipc	ra,0x2
    3ac8:	110080e7          	jalr	272(ra) # 5bd4 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3acc:	85ca                	mv	a1,s2
    3ace:	00004517          	auipc	a0,0x4
    3ad2:	a8250513          	addi	a0,a0,-1406 # 7550 <malloc+0x153e>
    3ad6:	00002097          	auipc	ra,0x2
    3ada:	47e080e7          	jalr	1150(ra) # 5f54 <printf>
    exit(1);
    3ade:	4505                	li	a0,1
    3ae0:	00002097          	auipc	ra,0x2
    3ae4:	0f4080e7          	jalr	244(ra) # 5bd4 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3ae8:	85ca                	mv	a1,s2
    3aea:	00004517          	auipc	a0,0x4
    3aee:	a9e50513          	addi	a0,a0,-1378 # 7588 <malloc+0x1576>
    3af2:	00002097          	auipc	ra,0x2
    3af6:	462080e7          	jalr	1122(ra) # 5f54 <printf>
    exit(1);
    3afa:	4505                	li	a0,1
    3afc:	00002097          	auipc	ra,0x2
    3b00:	0d8080e7          	jalr	216(ra) # 5bd4 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3b04:	85ca                	mv	a1,s2
    3b06:	00004517          	auipc	a0,0x4
    3b0a:	aa250513          	addi	a0,a0,-1374 # 75a8 <malloc+0x1596>
    3b0e:	00002097          	auipc	ra,0x2
    3b12:	446080e7          	jalr	1094(ra) # 5f54 <printf>
    exit(1);
    3b16:	4505                	li	a0,1
    3b18:	00002097          	auipc	ra,0x2
    3b1c:	0bc080e7          	jalr	188(ra) # 5bd4 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3b20:	85ca                	mv	a1,s2
    3b22:	00004517          	auipc	a0,0x4
    3b26:	ab650513          	addi	a0,a0,-1354 # 75d8 <malloc+0x15c6>
    3b2a:	00002097          	auipc	ra,0x2
    3b2e:	42a080e7          	jalr	1066(ra) # 5f54 <printf>
    exit(1);
    3b32:	4505                	li	a0,1
    3b34:	00002097          	auipc	ra,0x2
    3b38:	0a0080e7          	jalr	160(ra) # 5bd4 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3b3c:	85ca                	mv	a1,s2
    3b3e:	00004517          	auipc	a0,0x4
    3b42:	ac250513          	addi	a0,a0,-1342 # 7600 <malloc+0x15ee>
    3b46:	00002097          	auipc	ra,0x2
    3b4a:	40e080e7          	jalr	1038(ra) # 5f54 <printf>
    exit(1);
    3b4e:	4505                	li	a0,1
    3b50:	00002097          	auipc	ra,0x2
    3b54:	084080e7          	jalr	132(ra) # 5bd4 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3b58:	85ca                	mv	a1,s2
    3b5a:	00004517          	auipc	a0,0x4
    3b5e:	ac650513          	addi	a0,a0,-1338 # 7620 <malloc+0x160e>
    3b62:	00002097          	auipc	ra,0x2
    3b66:	3f2080e7          	jalr	1010(ra) # 5f54 <printf>
    exit(1);
    3b6a:	4505                	li	a0,1
    3b6c:	00002097          	auipc	ra,0x2
    3b70:	068080e7          	jalr	104(ra) # 5bd4 <exit>
    printf("%s: chdir dd failed\n", s);
    3b74:	85ca                	mv	a1,s2
    3b76:	00004517          	auipc	a0,0x4
    3b7a:	ad250513          	addi	a0,a0,-1326 # 7648 <malloc+0x1636>
    3b7e:	00002097          	auipc	ra,0x2
    3b82:	3d6080e7          	jalr	982(ra) # 5f54 <printf>
    exit(1);
    3b86:	4505                	li	a0,1
    3b88:	00002097          	auipc	ra,0x2
    3b8c:	04c080e7          	jalr	76(ra) # 5bd4 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    3b90:	85ca                	mv	a1,s2
    3b92:	00004517          	auipc	a0,0x4
    3b96:	ade50513          	addi	a0,a0,-1314 # 7670 <malloc+0x165e>
    3b9a:	00002097          	auipc	ra,0x2
    3b9e:	3ba080e7          	jalr	954(ra) # 5f54 <printf>
    exit(1);
    3ba2:	4505                	li	a0,1
    3ba4:	00002097          	auipc	ra,0x2
    3ba8:	030080e7          	jalr	48(ra) # 5bd4 <exit>
    printf("chdir dd/../../dd failed\n", s);
    3bac:	85ca                	mv	a1,s2
    3bae:	00004517          	auipc	a0,0x4
    3bb2:	af250513          	addi	a0,a0,-1294 # 76a0 <malloc+0x168e>
    3bb6:	00002097          	auipc	ra,0x2
    3bba:	39e080e7          	jalr	926(ra) # 5f54 <printf>
    exit(1);
    3bbe:	4505                	li	a0,1
    3bc0:	00002097          	auipc	ra,0x2
    3bc4:	014080e7          	jalr	20(ra) # 5bd4 <exit>
    printf("%s: chdir ./.. failed\n", s);
    3bc8:	85ca                	mv	a1,s2
    3bca:	00004517          	auipc	a0,0x4
    3bce:	afe50513          	addi	a0,a0,-1282 # 76c8 <malloc+0x16b6>
    3bd2:	00002097          	auipc	ra,0x2
    3bd6:	382080e7          	jalr	898(ra) # 5f54 <printf>
    exit(1);
    3bda:	4505                	li	a0,1
    3bdc:	00002097          	auipc	ra,0x2
    3be0:	ff8080e7          	jalr	-8(ra) # 5bd4 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    3be4:	85ca                	mv	a1,s2
    3be6:	00004517          	auipc	a0,0x4
    3bea:	afa50513          	addi	a0,a0,-1286 # 76e0 <malloc+0x16ce>
    3bee:	00002097          	auipc	ra,0x2
    3bf2:	366080e7          	jalr	870(ra) # 5f54 <printf>
    exit(1);
    3bf6:	4505                	li	a0,1
    3bf8:	00002097          	auipc	ra,0x2
    3bfc:	fdc080e7          	jalr	-36(ra) # 5bd4 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3c00:	85ca                	mv	a1,s2
    3c02:	00004517          	auipc	a0,0x4
    3c06:	afe50513          	addi	a0,a0,-1282 # 7700 <malloc+0x16ee>
    3c0a:	00002097          	auipc	ra,0x2
    3c0e:	34a080e7          	jalr	842(ra) # 5f54 <printf>
    exit(1);
    3c12:	4505                	li	a0,1
    3c14:	00002097          	auipc	ra,0x2
    3c18:	fc0080e7          	jalr	-64(ra) # 5bd4 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3c1c:	85ca                	mv	a1,s2
    3c1e:	00004517          	auipc	a0,0x4
    3c22:	b0250513          	addi	a0,a0,-1278 # 7720 <malloc+0x170e>
    3c26:	00002097          	auipc	ra,0x2
    3c2a:	32e080e7          	jalr	814(ra) # 5f54 <printf>
    exit(1);
    3c2e:	4505                	li	a0,1
    3c30:	00002097          	auipc	ra,0x2
    3c34:	fa4080e7          	jalr	-92(ra) # 5bd4 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3c38:	85ca                	mv	a1,s2
    3c3a:	00004517          	auipc	a0,0x4
    3c3e:	b2650513          	addi	a0,a0,-1242 # 7760 <malloc+0x174e>
    3c42:	00002097          	auipc	ra,0x2
    3c46:	312080e7          	jalr	786(ra) # 5f54 <printf>
    exit(1);
    3c4a:	4505                	li	a0,1
    3c4c:	00002097          	auipc	ra,0x2
    3c50:	f88080e7          	jalr	-120(ra) # 5bd4 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3c54:	85ca                	mv	a1,s2
    3c56:	00004517          	auipc	a0,0x4
    3c5a:	b3a50513          	addi	a0,a0,-1222 # 7790 <malloc+0x177e>
    3c5e:	00002097          	auipc	ra,0x2
    3c62:	2f6080e7          	jalr	758(ra) # 5f54 <printf>
    exit(1);
    3c66:	4505                	li	a0,1
    3c68:	00002097          	auipc	ra,0x2
    3c6c:	f6c080e7          	jalr	-148(ra) # 5bd4 <exit>
    printf("%s: create dd succeeded!\n", s);
    3c70:	85ca                	mv	a1,s2
    3c72:	00004517          	auipc	a0,0x4
    3c76:	b3e50513          	addi	a0,a0,-1218 # 77b0 <malloc+0x179e>
    3c7a:	00002097          	auipc	ra,0x2
    3c7e:	2da080e7          	jalr	730(ra) # 5f54 <printf>
    exit(1);
    3c82:	4505                	li	a0,1
    3c84:	00002097          	auipc	ra,0x2
    3c88:	f50080e7          	jalr	-176(ra) # 5bd4 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3c8c:	85ca                	mv	a1,s2
    3c8e:	00004517          	auipc	a0,0x4
    3c92:	b4250513          	addi	a0,a0,-1214 # 77d0 <malloc+0x17be>
    3c96:	00002097          	auipc	ra,0x2
    3c9a:	2be080e7          	jalr	702(ra) # 5f54 <printf>
    exit(1);
    3c9e:	4505                	li	a0,1
    3ca0:	00002097          	auipc	ra,0x2
    3ca4:	f34080e7          	jalr	-204(ra) # 5bd4 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3ca8:	85ca                	mv	a1,s2
    3caa:	00004517          	auipc	a0,0x4
    3cae:	b4650513          	addi	a0,a0,-1210 # 77f0 <malloc+0x17de>
    3cb2:	00002097          	auipc	ra,0x2
    3cb6:	2a2080e7          	jalr	674(ra) # 5f54 <printf>
    exit(1);
    3cba:	4505                	li	a0,1
    3cbc:	00002097          	auipc	ra,0x2
    3cc0:	f18080e7          	jalr	-232(ra) # 5bd4 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3cc4:	85ca                	mv	a1,s2
    3cc6:	00004517          	auipc	a0,0x4
    3cca:	b5a50513          	addi	a0,a0,-1190 # 7820 <malloc+0x180e>
    3cce:	00002097          	auipc	ra,0x2
    3cd2:	286080e7          	jalr	646(ra) # 5f54 <printf>
    exit(1);
    3cd6:	4505                	li	a0,1
    3cd8:	00002097          	auipc	ra,0x2
    3cdc:	efc080e7          	jalr	-260(ra) # 5bd4 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3ce0:	85ca                	mv	a1,s2
    3ce2:	00004517          	auipc	a0,0x4
    3ce6:	b6650513          	addi	a0,a0,-1178 # 7848 <malloc+0x1836>
    3cea:	00002097          	auipc	ra,0x2
    3cee:	26a080e7          	jalr	618(ra) # 5f54 <printf>
    exit(1);
    3cf2:	4505                	li	a0,1
    3cf4:	00002097          	auipc	ra,0x2
    3cf8:	ee0080e7          	jalr	-288(ra) # 5bd4 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3cfc:	85ca                	mv	a1,s2
    3cfe:	00004517          	auipc	a0,0x4
    3d02:	b7250513          	addi	a0,a0,-1166 # 7870 <malloc+0x185e>
    3d06:	00002097          	auipc	ra,0x2
    3d0a:	24e080e7          	jalr	590(ra) # 5f54 <printf>
    exit(1);
    3d0e:	4505                	li	a0,1
    3d10:	00002097          	auipc	ra,0x2
    3d14:	ec4080e7          	jalr	-316(ra) # 5bd4 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3d18:	85ca                	mv	a1,s2
    3d1a:	00004517          	auipc	a0,0x4
    3d1e:	b7e50513          	addi	a0,a0,-1154 # 7898 <malloc+0x1886>
    3d22:	00002097          	auipc	ra,0x2
    3d26:	232080e7          	jalr	562(ra) # 5f54 <printf>
    exit(1);
    3d2a:	4505                	li	a0,1
    3d2c:	00002097          	auipc	ra,0x2
    3d30:	ea8080e7          	jalr	-344(ra) # 5bd4 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3d34:	85ca                	mv	a1,s2
    3d36:	00004517          	auipc	a0,0x4
    3d3a:	b8250513          	addi	a0,a0,-1150 # 78b8 <malloc+0x18a6>
    3d3e:	00002097          	auipc	ra,0x2
    3d42:	216080e7          	jalr	534(ra) # 5f54 <printf>
    exit(1);
    3d46:	4505                	li	a0,1
    3d48:	00002097          	auipc	ra,0x2
    3d4c:	e8c080e7          	jalr	-372(ra) # 5bd4 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3d50:	85ca                	mv	a1,s2
    3d52:	00004517          	auipc	a0,0x4
    3d56:	b8650513          	addi	a0,a0,-1146 # 78d8 <malloc+0x18c6>
    3d5a:	00002097          	auipc	ra,0x2
    3d5e:	1fa080e7          	jalr	506(ra) # 5f54 <printf>
    exit(1);
    3d62:	4505                	li	a0,1
    3d64:	00002097          	auipc	ra,0x2
    3d68:	e70080e7          	jalr	-400(ra) # 5bd4 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3d6c:	85ca                	mv	a1,s2
    3d6e:	00004517          	auipc	a0,0x4
    3d72:	b9250513          	addi	a0,a0,-1134 # 7900 <malloc+0x18ee>
    3d76:	00002097          	auipc	ra,0x2
    3d7a:	1de080e7          	jalr	478(ra) # 5f54 <printf>
    exit(1);
    3d7e:	4505                	li	a0,1
    3d80:	00002097          	auipc	ra,0x2
    3d84:	e54080e7          	jalr	-428(ra) # 5bd4 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3d88:	85ca                	mv	a1,s2
    3d8a:	00004517          	auipc	a0,0x4
    3d8e:	b9650513          	addi	a0,a0,-1130 # 7920 <malloc+0x190e>
    3d92:	00002097          	auipc	ra,0x2
    3d96:	1c2080e7          	jalr	450(ra) # 5f54 <printf>
    exit(1);
    3d9a:	4505                	li	a0,1
    3d9c:	00002097          	auipc	ra,0x2
    3da0:	e38080e7          	jalr	-456(ra) # 5bd4 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3da4:	85ca                	mv	a1,s2
    3da6:	00004517          	auipc	a0,0x4
    3daa:	b9a50513          	addi	a0,a0,-1126 # 7940 <malloc+0x192e>
    3dae:	00002097          	auipc	ra,0x2
    3db2:	1a6080e7          	jalr	422(ra) # 5f54 <printf>
    exit(1);
    3db6:	4505                	li	a0,1
    3db8:	00002097          	auipc	ra,0x2
    3dbc:	e1c080e7          	jalr	-484(ra) # 5bd4 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3dc0:	85ca                	mv	a1,s2
    3dc2:	00004517          	auipc	a0,0x4
    3dc6:	ba650513          	addi	a0,a0,-1114 # 7968 <malloc+0x1956>
    3dca:	00002097          	auipc	ra,0x2
    3dce:	18a080e7          	jalr	394(ra) # 5f54 <printf>
    exit(1);
    3dd2:	4505                	li	a0,1
    3dd4:	00002097          	auipc	ra,0x2
    3dd8:	e00080e7          	jalr	-512(ra) # 5bd4 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3ddc:	85ca                	mv	a1,s2
    3dde:	00004517          	auipc	a0,0x4
    3de2:	82250513          	addi	a0,a0,-2014 # 7600 <malloc+0x15ee>
    3de6:	00002097          	auipc	ra,0x2
    3dea:	16e080e7          	jalr	366(ra) # 5f54 <printf>
    exit(1);
    3dee:	4505                	li	a0,1
    3df0:	00002097          	auipc	ra,0x2
    3df4:	de4080e7          	jalr	-540(ra) # 5bd4 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3df8:	85ca                	mv	a1,s2
    3dfa:	00004517          	auipc	a0,0x4
    3dfe:	b8e50513          	addi	a0,a0,-1138 # 7988 <malloc+0x1976>
    3e02:	00002097          	auipc	ra,0x2
    3e06:	152080e7          	jalr	338(ra) # 5f54 <printf>
    exit(1);
    3e0a:	4505                	li	a0,1
    3e0c:	00002097          	auipc	ra,0x2
    3e10:	dc8080e7          	jalr	-568(ra) # 5bd4 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3e14:	85ca                	mv	a1,s2
    3e16:	00004517          	auipc	a0,0x4
    3e1a:	b9250513          	addi	a0,a0,-1134 # 79a8 <malloc+0x1996>
    3e1e:	00002097          	auipc	ra,0x2
    3e22:	136080e7          	jalr	310(ra) # 5f54 <printf>
    exit(1);
    3e26:	4505                	li	a0,1
    3e28:	00002097          	auipc	ra,0x2
    3e2c:	dac080e7          	jalr	-596(ra) # 5bd4 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3e30:	85ca                	mv	a1,s2
    3e32:	00004517          	auipc	a0,0x4
    3e36:	ba650513          	addi	a0,a0,-1114 # 79d8 <malloc+0x19c6>
    3e3a:	00002097          	auipc	ra,0x2
    3e3e:	11a080e7          	jalr	282(ra) # 5f54 <printf>
    exit(1);
    3e42:	4505                	li	a0,1
    3e44:	00002097          	auipc	ra,0x2
    3e48:	d90080e7          	jalr	-624(ra) # 5bd4 <exit>
    printf("%s: unlink dd failed\n", s);
    3e4c:	85ca                	mv	a1,s2
    3e4e:	00004517          	auipc	a0,0x4
    3e52:	baa50513          	addi	a0,a0,-1110 # 79f8 <malloc+0x19e6>
    3e56:	00002097          	auipc	ra,0x2
    3e5a:	0fe080e7          	jalr	254(ra) # 5f54 <printf>
    exit(1);
    3e5e:	4505                	li	a0,1
    3e60:	00002097          	auipc	ra,0x2
    3e64:	d74080e7          	jalr	-652(ra) # 5bd4 <exit>

0000000000003e68 <rmdot>:
{
    3e68:	1101                	addi	sp,sp,-32
    3e6a:	ec06                	sd	ra,24(sp)
    3e6c:	e822                	sd	s0,16(sp)
    3e6e:	e426                	sd	s1,8(sp)
    3e70:	1000                	addi	s0,sp,32
    3e72:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    3e74:	00004517          	auipc	a0,0x4
    3e78:	b9c50513          	addi	a0,a0,-1124 # 7a10 <malloc+0x19fe>
    3e7c:	00002097          	auipc	ra,0x2
    3e80:	dc0080e7          	jalr	-576(ra) # 5c3c <mkdir>
    3e84:	e549                	bnez	a0,3f0e <rmdot+0xa6>
  if(chdir("dots") != 0){
    3e86:	00004517          	auipc	a0,0x4
    3e8a:	b8a50513          	addi	a0,a0,-1142 # 7a10 <malloc+0x19fe>
    3e8e:	00002097          	auipc	ra,0x2
    3e92:	db6080e7          	jalr	-586(ra) # 5c44 <chdir>
    3e96:	e951                	bnez	a0,3f2a <rmdot+0xc2>
  if(unlink(".") == 0){
    3e98:	00003517          	auipc	a0,0x3
    3e9c:	9a850513          	addi	a0,a0,-1624 # 6840 <malloc+0x82e>
    3ea0:	00002097          	auipc	ra,0x2
    3ea4:	d84080e7          	jalr	-636(ra) # 5c24 <unlink>
    3ea8:	cd59                	beqz	a0,3f46 <rmdot+0xde>
  if(unlink("..") == 0){
    3eaa:	00003517          	auipc	a0,0x3
    3eae:	5be50513          	addi	a0,a0,1470 # 7468 <malloc+0x1456>
    3eb2:	00002097          	auipc	ra,0x2
    3eb6:	d72080e7          	jalr	-654(ra) # 5c24 <unlink>
    3eba:	c545                	beqz	a0,3f62 <rmdot+0xfa>
  if(chdir("/") != 0){
    3ebc:	00003517          	auipc	a0,0x3
    3ec0:	55450513          	addi	a0,a0,1364 # 7410 <malloc+0x13fe>
    3ec4:	00002097          	auipc	ra,0x2
    3ec8:	d80080e7          	jalr	-640(ra) # 5c44 <chdir>
    3ecc:	e94d                	bnez	a0,3f7e <rmdot+0x116>
  if(unlink("dots/.") == 0){
    3ece:	00004517          	auipc	a0,0x4
    3ed2:	baa50513          	addi	a0,a0,-1110 # 7a78 <malloc+0x1a66>
    3ed6:	00002097          	auipc	ra,0x2
    3eda:	d4e080e7          	jalr	-690(ra) # 5c24 <unlink>
    3ede:	cd55                	beqz	a0,3f9a <rmdot+0x132>
  if(unlink("dots/..") == 0){
    3ee0:	00004517          	auipc	a0,0x4
    3ee4:	bc050513          	addi	a0,a0,-1088 # 7aa0 <malloc+0x1a8e>
    3ee8:	00002097          	auipc	ra,0x2
    3eec:	d3c080e7          	jalr	-708(ra) # 5c24 <unlink>
    3ef0:	c179                	beqz	a0,3fb6 <rmdot+0x14e>
  if(unlink("dots") != 0){
    3ef2:	00004517          	auipc	a0,0x4
    3ef6:	b1e50513          	addi	a0,a0,-1250 # 7a10 <malloc+0x19fe>
    3efa:	00002097          	auipc	ra,0x2
    3efe:	d2a080e7          	jalr	-726(ra) # 5c24 <unlink>
    3f02:	e961                	bnez	a0,3fd2 <rmdot+0x16a>
}
    3f04:	60e2                	ld	ra,24(sp)
    3f06:	6442                	ld	s0,16(sp)
    3f08:	64a2                	ld	s1,8(sp)
    3f0a:	6105                	addi	sp,sp,32
    3f0c:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3f0e:	85a6                	mv	a1,s1
    3f10:	00004517          	auipc	a0,0x4
    3f14:	b0850513          	addi	a0,a0,-1272 # 7a18 <malloc+0x1a06>
    3f18:	00002097          	auipc	ra,0x2
    3f1c:	03c080e7          	jalr	60(ra) # 5f54 <printf>
    exit(1);
    3f20:	4505                	li	a0,1
    3f22:	00002097          	auipc	ra,0x2
    3f26:	cb2080e7          	jalr	-846(ra) # 5bd4 <exit>
    printf("%s: chdir dots failed\n", s);
    3f2a:	85a6                	mv	a1,s1
    3f2c:	00004517          	auipc	a0,0x4
    3f30:	b0450513          	addi	a0,a0,-1276 # 7a30 <malloc+0x1a1e>
    3f34:	00002097          	auipc	ra,0x2
    3f38:	020080e7          	jalr	32(ra) # 5f54 <printf>
    exit(1);
    3f3c:	4505                	li	a0,1
    3f3e:	00002097          	auipc	ra,0x2
    3f42:	c96080e7          	jalr	-874(ra) # 5bd4 <exit>
    printf("%s: rm . worked!\n", s);
    3f46:	85a6                	mv	a1,s1
    3f48:	00004517          	auipc	a0,0x4
    3f4c:	b0050513          	addi	a0,a0,-1280 # 7a48 <malloc+0x1a36>
    3f50:	00002097          	auipc	ra,0x2
    3f54:	004080e7          	jalr	4(ra) # 5f54 <printf>
    exit(1);
    3f58:	4505                	li	a0,1
    3f5a:	00002097          	auipc	ra,0x2
    3f5e:	c7a080e7          	jalr	-902(ra) # 5bd4 <exit>
    printf("%s: rm .. worked!\n", s);
    3f62:	85a6                	mv	a1,s1
    3f64:	00004517          	auipc	a0,0x4
    3f68:	afc50513          	addi	a0,a0,-1284 # 7a60 <malloc+0x1a4e>
    3f6c:	00002097          	auipc	ra,0x2
    3f70:	fe8080e7          	jalr	-24(ra) # 5f54 <printf>
    exit(1);
    3f74:	4505                	li	a0,1
    3f76:	00002097          	auipc	ra,0x2
    3f7a:	c5e080e7          	jalr	-930(ra) # 5bd4 <exit>
    printf("%s: chdir / failed\n", s);
    3f7e:	85a6                	mv	a1,s1
    3f80:	00003517          	auipc	a0,0x3
    3f84:	49850513          	addi	a0,a0,1176 # 7418 <malloc+0x1406>
    3f88:	00002097          	auipc	ra,0x2
    3f8c:	fcc080e7          	jalr	-52(ra) # 5f54 <printf>
    exit(1);
    3f90:	4505                	li	a0,1
    3f92:	00002097          	auipc	ra,0x2
    3f96:	c42080e7          	jalr	-958(ra) # 5bd4 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3f9a:	85a6                	mv	a1,s1
    3f9c:	00004517          	auipc	a0,0x4
    3fa0:	ae450513          	addi	a0,a0,-1308 # 7a80 <malloc+0x1a6e>
    3fa4:	00002097          	auipc	ra,0x2
    3fa8:	fb0080e7          	jalr	-80(ra) # 5f54 <printf>
    exit(1);
    3fac:	4505                	li	a0,1
    3fae:	00002097          	auipc	ra,0x2
    3fb2:	c26080e7          	jalr	-986(ra) # 5bd4 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3fb6:	85a6                	mv	a1,s1
    3fb8:	00004517          	auipc	a0,0x4
    3fbc:	af050513          	addi	a0,a0,-1296 # 7aa8 <malloc+0x1a96>
    3fc0:	00002097          	auipc	ra,0x2
    3fc4:	f94080e7          	jalr	-108(ra) # 5f54 <printf>
    exit(1);
    3fc8:	4505                	li	a0,1
    3fca:	00002097          	auipc	ra,0x2
    3fce:	c0a080e7          	jalr	-1014(ra) # 5bd4 <exit>
    printf("%s: unlink dots failed!\n", s);
    3fd2:	85a6                	mv	a1,s1
    3fd4:	00004517          	auipc	a0,0x4
    3fd8:	af450513          	addi	a0,a0,-1292 # 7ac8 <malloc+0x1ab6>
    3fdc:	00002097          	auipc	ra,0x2
    3fe0:	f78080e7          	jalr	-136(ra) # 5f54 <printf>
    exit(1);
    3fe4:	4505                	li	a0,1
    3fe6:	00002097          	auipc	ra,0x2
    3fea:	bee080e7          	jalr	-1042(ra) # 5bd4 <exit>

0000000000003fee <dirfile>:
{
    3fee:	1101                	addi	sp,sp,-32
    3ff0:	ec06                	sd	ra,24(sp)
    3ff2:	e822                	sd	s0,16(sp)
    3ff4:	e426                	sd	s1,8(sp)
    3ff6:	e04a                	sd	s2,0(sp)
    3ff8:	1000                	addi	s0,sp,32
    3ffa:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3ffc:	20000593          	li	a1,512
    4000:	00004517          	auipc	a0,0x4
    4004:	ae850513          	addi	a0,a0,-1304 # 7ae8 <malloc+0x1ad6>
    4008:	00002097          	auipc	ra,0x2
    400c:	c0c080e7          	jalr	-1012(ra) # 5c14 <open>
  if(fd < 0){
    4010:	0e054d63          	bltz	a0,410a <dirfile+0x11c>
  close(fd);
    4014:	00002097          	auipc	ra,0x2
    4018:	be8080e7          	jalr	-1048(ra) # 5bfc <close>
  if(chdir("dirfile") == 0){
    401c:	00004517          	auipc	a0,0x4
    4020:	acc50513          	addi	a0,a0,-1332 # 7ae8 <malloc+0x1ad6>
    4024:	00002097          	auipc	ra,0x2
    4028:	c20080e7          	jalr	-992(ra) # 5c44 <chdir>
    402c:	cd6d                	beqz	a0,4126 <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    402e:	4581                	li	a1,0
    4030:	00004517          	auipc	a0,0x4
    4034:	b0050513          	addi	a0,a0,-1280 # 7b30 <malloc+0x1b1e>
    4038:	00002097          	auipc	ra,0x2
    403c:	bdc080e7          	jalr	-1060(ra) # 5c14 <open>
  if(fd >= 0){
    4040:	10055163          	bgez	a0,4142 <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    4044:	20000593          	li	a1,512
    4048:	00004517          	auipc	a0,0x4
    404c:	ae850513          	addi	a0,a0,-1304 # 7b30 <malloc+0x1b1e>
    4050:	00002097          	auipc	ra,0x2
    4054:	bc4080e7          	jalr	-1084(ra) # 5c14 <open>
  if(fd >= 0){
    4058:	10055363          	bgez	a0,415e <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    405c:	00004517          	auipc	a0,0x4
    4060:	ad450513          	addi	a0,a0,-1324 # 7b30 <malloc+0x1b1e>
    4064:	00002097          	auipc	ra,0x2
    4068:	bd8080e7          	jalr	-1064(ra) # 5c3c <mkdir>
    406c:	10050763          	beqz	a0,417a <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    4070:	00004517          	auipc	a0,0x4
    4074:	ac050513          	addi	a0,a0,-1344 # 7b30 <malloc+0x1b1e>
    4078:	00002097          	auipc	ra,0x2
    407c:	bac080e7          	jalr	-1108(ra) # 5c24 <unlink>
    4080:	10050b63          	beqz	a0,4196 <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    4084:	00004597          	auipc	a1,0x4
    4088:	aac58593          	addi	a1,a1,-1364 # 7b30 <malloc+0x1b1e>
    408c:	00002517          	auipc	a0,0x2
    4090:	2a450513          	addi	a0,a0,676 # 6330 <malloc+0x31e>
    4094:	00002097          	auipc	ra,0x2
    4098:	ba0080e7          	jalr	-1120(ra) # 5c34 <link>
    409c:	10050b63          	beqz	a0,41b2 <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    40a0:	00004517          	auipc	a0,0x4
    40a4:	a4850513          	addi	a0,a0,-1464 # 7ae8 <malloc+0x1ad6>
    40a8:	00002097          	auipc	ra,0x2
    40ac:	b7c080e7          	jalr	-1156(ra) # 5c24 <unlink>
    40b0:	10051f63          	bnez	a0,41ce <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    40b4:	4589                	li	a1,2
    40b6:	00002517          	auipc	a0,0x2
    40ba:	78a50513          	addi	a0,a0,1930 # 6840 <malloc+0x82e>
    40be:	00002097          	auipc	ra,0x2
    40c2:	b56080e7          	jalr	-1194(ra) # 5c14 <open>
  if(fd >= 0){
    40c6:	12055263          	bgez	a0,41ea <dirfile+0x1fc>
  fd = open(".", 0);
    40ca:	4581                	li	a1,0
    40cc:	00002517          	auipc	a0,0x2
    40d0:	77450513          	addi	a0,a0,1908 # 6840 <malloc+0x82e>
    40d4:	00002097          	auipc	ra,0x2
    40d8:	b40080e7          	jalr	-1216(ra) # 5c14 <open>
    40dc:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    40de:	4605                	li	a2,1
    40e0:	00002597          	auipc	a1,0x2
    40e4:	0e858593          	addi	a1,a1,232 # 61c8 <malloc+0x1b6>
    40e8:	00002097          	auipc	ra,0x2
    40ec:	b0c080e7          	jalr	-1268(ra) # 5bf4 <write>
    40f0:	10a04b63          	bgtz	a0,4206 <dirfile+0x218>
  close(fd);
    40f4:	8526                	mv	a0,s1
    40f6:	00002097          	auipc	ra,0x2
    40fa:	b06080e7          	jalr	-1274(ra) # 5bfc <close>
}
    40fe:	60e2                	ld	ra,24(sp)
    4100:	6442                	ld	s0,16(sp)
    4102:	64a2                	ld	s1,8(sp)
    4104:	6902                	ld	s2,0(sp)
    4106:	6105                	addi	sp,sp,32
    4108:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    410a:	85ca                	mv	a1,s2
    410c:	00004517          	auipc	a0,0x4
    4110:	9e450513          	addi	a0,a0,-1564 # 7af0 <malloc+0x1ade>
    4114:	00002097          	auipc	ra,0x2
    4118:	e40080e7          	jalr	-448(ra) # 5f54 <printf>
    exit(1);
    411c:	4505                	li	a0,1
    411e:	00002097          	auipc	ra,0x2
    4122:	ab6080e7          	jalr	-1354(ra) # 5bd4 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    4126:	85ca                	mv	a1,s2
    4128:	00004517          	auipc	a0,0x4
    412c:	9e850513          	addi	a0,a0,-1560 # 7b10 <malloc+0x1afe>
    4130:	00002097          	auipc	ra,0x2
    4134:	e24080e7          	jalr	-476(ra) # 5f54 <printf>
    exit(1);
    4138:	4505                	li	a0,1
    413a:	00002097          	auipc	ra,0x2
    413e:	a9a080e7          	jalr	-1382(ra) # 5bd4 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4142:	85ca                	mv	a1,s2
    4144:	00004517          	auipc	a0,0x4
    4148:	9fc50513          	addi	a0,a0,-1540 # 7b40 <malloc+0x1b2e>
    414c:	00002097          	auipc	ra,0x2
    4150:	e08080e7          	jalr	-504(ra) # 5f54 <printf>
    exit(1);
    4154:	4505                	li	a0,1
    4156:	00002097          	auipc	ra,0x2
    415a:	a7e080e7          	jalr	-1410(ra) # 5bd4 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    415e:	85ca                	mv	a1,s2
    4160:	00004517          	auipc	a0,0x4
    4164:	9e050513          	addi	a0,a0,-1568 # 7b40 <malloc+0x1b2e>
    4168:	00002097          	auipc	ra,0x2
    416c:	dec080e7          	jalr	-532(ra) # 5f54 <printf>
    exit(1);
    4170:	4505                	li	a0,1
    4172:	00002097          	auipc	ra,0x2
    4176:	a62080e7          	jalr	-1438(ra) # 5bd4 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    417a:	85ca                	mv	a1,s2
    417c:	00004517          	auipc	a0,0x4
    4180:	9ec50513          	addi	a0,a0,-1556 # 7b68 <malloc+0x1b56>
    4184:	00002097          	auipc	ra,0x2
    4188:	dd0080e7          	jalr	-560(ra) # 5f54 <printf>
    exit(1);
    418c:	4505                	li	a0,1
    418e:	00002097          	auipc	ra,0x2
    4192:	a46080e7          	jalr	-1466(ra) # 5bd4 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    4196:	85ca                	mv	a1,s2
    4198:	00004517          	auipc	a0,0x4
    419c:	9f850513          	addi	a0,a0,-1544 # 7b90 <malloc+0x1b7e>
    41a0:	00002097          	auipc	ra,0x2
    41a4:	db4080e7          	jalr	-588(ra) # 5f54 <printf>
    exit(1);
    41a8:	4505                	li	a0,1
    41aa:	00002097          	auipc	ra,0x2
    41ae:	a2a080e7          	jalr	-1494(ra) # 5bd4 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    41b2:	85ca                	mv	a1,s2
    41b4:	00004517          	auipc	a0,0x4
    41b8:	a0450513          	addi	a0,a0,-1532 # 7bb8 <malloc+0x1ba6>
    41bc:	00002097          	auipc	ra,0x2
    41c0:	d98080e7          	jalr	-616(ra) # 5f54 <printf>
    exit(1);
    41c4:	4505                	li	a0,1
    41c6:	00002097          	auipc	ra,0x2
    41ca:	a0e080e7          	jalr	-1522(ra) # 5bd4 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    41ce:	85ca                	mv	a1,s2
    41d0:	00004517          	auipc	a0,0x4
    41d4:	a1050513          	addi	a0,a0,-1520 # 7be0 <malloc+0x1bce>
    41d8:	00002097          	auipc	ra,0x2
    41dc:	d7c080e7          	jalr	-644(ra) # 5f54 <printf>
    exit(1);
    41e0:	4505                	li	a0,1
    41e2:	00002097          	auipc	ra,0x2
    41e6:	9f2080e7          	jalr	-1550(ra) # 5bd4 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    41ea:	85ca                	mv	a1,s2
    41ec:	00004517          	auipc	a0,0x4
    41f0:	a1450513          	addi	a0,a0,-1516 # 7c00 <malloc+0x1bee>
    41f4:	00002097          	auipc	ra,0x2
    41f8:	d60080e7          	jalr	-672(ra) # 5f54 <printf>
    exit(1);
    41fc:	4505                	li	a0,1
    41fe:	00002097          	auipc	ra,0x2
    4202:	9d6080e7          	jalr	-1578(ra) # 5bd4 <exit>
    printf("%s: write . succeeded!\n", s);
    4206:	85ca                	mv	a1,s2
    4208:	00004517          	auipc	a0,0x4
    420c:	a2050513          	addi	a0,a0,-1504 # 7c28 <malloc+0x1c16>
    4210:	00002097          	auipc	ra,0x2
    4214:	d44080e7          	jalr	-700(ra) # 5f54 <printf>
    exit(1);
    4218:	4505                	li	a0,1
    421a:	00002097          	auipc	ra,0x2
    421e:	9ba080e7          	jalr	-1606(ra) # 5bd4 <exit>

0000000000004222 <iref>:
{
    4222:	7139                	addi	sp,sp,-64
    4224:	fc06                	sd	ra,56(sp)
    4226:	f822                	sd	s0,48(sp)
    4228:	f426                	sd	s1,40(sp)
    422a:	f04a                	sd	s2,32(sp)
    422c:	ec4e                	sd	s3,24(sp)
    422e:	e852                	sd	s4,16(sp)
    4230:	e456                	sd	s5,8(sp)
    4232:	e05a                	sd	s6,0(sp)
    4234:	0080                	addi	s0,sp,64
    4236:	8b2a                	mv	s6,a0
    4238:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    423c:	00004a17          	auipc	s4,0x4
    4240:	a04a0a13          	addi	s4,s4,-1532 # 7c40 <malloc+0x1c2e>
    mkdir("");
    4244:	00003497          	auipc	s1,0x3
    4248:	50448493          	addi	s1,s1,1284 # 7748 <malloc+0x1736>
    link("README", "");
    424c:	00002a97          	auipc	s5,0x2
    4250:	0e4a8a93          	addi	s5,s5,228 # 6330 <malloc+0x31e>
    fd = open("xx", O_CREATE);
    4254:	00004997          	auipc	s3,0x4
    4258:	8e498993          	addi	s3,s3,-1820 # 7b38 <malloc+0x1b26>
    425c:	a891                	j	42b0 <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    425e:	85da                	mv	a1,s6
    4260:	00004517          	auipc	a0,0x4
    4264:	9e850513          	addi	a0,a0,-1560 # 7c48 <malloc+0x1c36>
    4268:	00002097          	auipc	ra,0x2
    426c:	cec080e7          	jalr	-788(ra) # 5f54 <printf>
      exit(1);
    4270:	4505                	li	a0,1
    4272:	00002097          	auipc	ra,0x2
    4276:	962080e7          	jalr	-1694(ra) # 5bd4 <exit>
      printf("%s: chdir irefd failed\n", s);
    427a:	85da                	mv	a1,s6
    427c:	00004517          	auipc	a0,0x4
    4280:	9e450513          	addi	a0,a0,-1564 # 7c60 <malloc+0x1c4e>
    4284:	00002097          	auipc	ra,0x2
    4288:	cd0080e7          	jalr	-816(ra) # 5f54 <printf>
      exit(1);
    428c:	4505                	li	a0,1
    428e:	00002097          	auipc	ra,0x2
    4292:	946080e7          	jalr	-1722(ra) # 5bd4 <exit>
      close(fd);
    4296:	00002097          	auipc	ra,0x2
    429a:	966080e7          	jalr	-1690(ra) # 5bfc <close>
    429e:	a889                	j	42f0 <iref+0xce>
    unlink("xx");
    42a0:	854e                	mv	a0,s3
    42a2:	00002097          	auipc	ra,0x2
    42a6:	982080e7          	jalr	-1662(ra) # 5c24 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    42aa:	397d                	addiw	s2,s2,-1
    42ac:	06090063          	beqz	s2,430c <iref+0xea>
    if(mkdir("irefd") != 0){
    42b0:	8552                	mv	a0,s4
    42b2:	00002097          	auipc	ra,0x2
    42b6:	98a080e7          	jalr	-1654(ra) # 5c3c <mkdir>
    42ba:	f155                	bnez	a0,425e <iref+0x3c>
    if(chdir("irefd") != 0){
    42bc:	8552                	mv	a0,s4
    42be:	00002097          	auipc	ra,0x2
    42c2:	986080e7          	jalr	-1658(ra) # 5c44 <chdir>
    42c6:	f955                	bnez	a0,427a <iref+0x58>
    mkdir("");
    42c8:	8526                	mv	a0,s1
    42ca:	00002097          	auipc	ra,0x2
    42ce:	972080e7          	jalr	-1678(ra) # 5c3c <mkdir>
    link("README", "");
    42d2:	85a6                	mv	a1,s1
    42d4:	8556                	mv	a0,s5
    42d6:	00002097          	auipc	ra,0x2
    42da:	95e080e7          	jalr	-1698(ra) # 5c34 <link>
    fd = open("", O_CREATE);
    42de:	20000593          	li	a1,512
    42e2:	8526                	mv	a0,s1
    42e4:	00002097          	auipc	ra,0x2
    42e8:	930080e7          	jalr	-1744(ra) # 5c14 <open>
    if(fd >= 0)
    42ec:	fa0555e3          	bgez	a0,4296 <iref+0x74>
    fd = open("xx", O_CREATE);
    42f0:	20000593          	li	a1,512
    42f4:	854e                	mv	a0,s3
    42f6:	00002097          	auipc	ra,0x2
    42fa:	91e080e7          	jalr	-1762(ra) # 5c14 <open>
    if(fd >= 0)
    42fe:	fa0541e3          	bltz	a0,42a0 <iref+0x7e>
      close(fd);
    4302:	00002097          	auipc	ra,0x2
    4306:	8fa080e7          	jalr	-1798(ra) # 5bfc <close>
    430a:	bf59                	j	42a0 <iref+0x7e>
    430c:	03300493          	li	s1,51
    chdir("..");
    4310:	00003997          	auipc	s3,0x3
    4314:	15898993          	addi	s3,s3,344 # 7468 <malloc+0x1456>
    unlink("irefd");
    4318:	00004917          	auipc	s2,0x4
    431c:	92890913          	addi	s2,s2,-1752 # 7c40 <malloc+0x1c2e>
    chdir("..");
    4320:	854e                	mv	a0,s3
    4322:	00002097          	auipc	ra,0x2
    4326:	922080e7          	jalr	-1758(ra) # 5c44 <chdir>
    unlink("irefd");
    432a:	854a                	mv	a0,s2
    432c:	00002097          	auipc	ra,0x2
    4330:	8f8080e7          	jalr	-1800(ra) # 5c24 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4334:	34fd                	addiw	s1,s1,-1
    4336:	f4ed                	bnez	s1,4320 <iref+0xfe>
  chdir("/");
    4338:	00003517          	auipc	a0,0x3
    433c:	0d850513          	addi	a0,a0,216 # 7410 <malloc+0x13fe>
    4340:	00002097          	auipc	ra,0x2
    4344:	904080e7          	jalr	-1788(ra) # 5c44 <chdir>
}
    4348:	70e2                	ld	ra,56(sp)
    434a:	7442                	ld	s0,48(sp)
    434c:	74a2                	ld	s1,40(sp)
    434e:	7902                	ld	s2,32(sp)
    4350:	69e2                	ld	s3,24(sp)
    4352:	6a42                	ld	s4,16(sp)
    4354:	6aa2                	ld	s5,8(sp)
    4356:	6b02                	ld	s6,0(sp)
    4358:	6121                	addi	sp,sp,64
    435a:	8082                	ret

000000000000435c <openiputtest>:
{
    435c:	7179                	addi	sp,sp,-48
    435e:	f406                	sd	ra,40(sp)
    4360:	f022                	sd	s0,32(sp)
    4362:	ec26                	sd	s1,24(sp)
    4364:	1800                	addi	s0,sp,48
    4366:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    4368:	00004517          	auipc	a0,0x4
    436c:	91050513          	addi	a0,a0,-1776 # 7c78 <malloc+0x1c66>
    4370:	00002097          	auipc	ra,0x2
    4374:	8cc080e7          	jalr	-1844(ra) # 5c3c <mkdir>
    4378:	04054263          	bltz	a0,43bc <openiputtest+0x60>
  pid = fork();
    437c:	00002097          	auipc	ra,0x2
    4380:	850080e7          	jalr	-1968(ra) # 5bcc <fork>
  if(pid < 0){
    4384:	04054a63          	bltz	a0,43d8 <openiputtest+0x7c>
  if(pid == 0){
    4388:	e93d                	bnez	a0,43fe <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    438a:	4589                	li	a1,2
    438c:	00004517          	auipc	a0,0x4
    4390:	8ec50513          	addi	a0,a0,-1812 # 7c78 <malloc+0x1c66>
    4394:	00002097          	auipc	ra,0x2
    4398:	880080e7          	jalr	-1920(ra) # 5c14 <open>
    if(fd >= 0){
    439c:	04054c63          	bltz	a0,43f4 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    43a0:	85a6                	mv	a1,s1
    43a2:	00004517          	auipc	a0,0x4
    43a6:	8f650513          	addi	a0,a0,-1802 # 7c98 <malloc+0x1c86>
    43aa:	00002097          	auipc	ra,0x2
    43ae:	baa080e7          	jalr	-1110(ra) # 5f54 <printf>
      exit(1);
    43b2:	4505                	li	a0,1
    43b4:	00002097          	auipc	ra,0x2
    43b8:	820080e7          	jalr	-2016(ra) # 5bd4 <exit>
    printf("%s: mkdir oidir failed\n", s);
    43bc:	85a6                	mv	a1,s1
    43be:	00004517          	auipc	a0,0x4
    43c2:	8c250513          	addi	a0,a0,-1854 # 7c80 <malloc+0x1c6e>
    43c6:	00002097          	auipc	ra,0x2
    43ca:	b8e080e7          	jalr	-1138(ra) # 5f54 <printf>
    exit(1);
    43ce:	4505                	li	a0,1
    43d0:	00002097          	auipc	ra,0x2
    43d4:	804080e7          	jalr	-2044(ra) # 5bd4 <exit>
    printf("%s: fork failed\n", s);
    43d8:	85a6                	mv	a1,s1
    43da:	00002517          	auipc	a0,0x2
    43de:	60650513          	addi	a0,a0,1542 # 69e0 <malloc+0x9ce>
    43e2:	00002097          	auipc	ra,0x2
    43e6:	b72080e7          	jalr	-1166(ra) # 5f54 <printf>
    exit(1);
    43ea:	4505                	li	a0,1
    43ec:	00001097          	auipc	ra,0x1
    43f0:	7e8080e7          	jalr	2024(ra) # 5bd4 <exit>
    exit(0);
    43f4:	4501                	li	a0,0
    43f6:	00001097          	auipc	ra,0x1
    43fa:	7de080e7          	jalr	2014(ra) # 5bd4 <exit>
  sleep(1);
    43fe:	4505                	li	a0,1
    4400:	00002097          	auipc	ra,0x2
    4404:	864080e7          	jalr	-1948(ra) # 5c64 <sleep>
  if(unlink("oidir") != 0){
    4408:	00004517          	auipc	a0,0x4
    440c:	87050513          	addi	a0,a0,-1936 # 7c78 <malloc+0x1c66>
    4410:	00002097          	auipc	ra,0x2
    4414:	814080e7          	jalr	-2028(ra) # 5c24 <unlink>
    4418:	cd19                	beqz	a0,4436 <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    441a:	85a6                	mv	a1,s1
    441c:	00002517          	auipc	a0,0x2
    4420:	7b450513          	addi	a0,a0,1972 # 6bd0 <malloc+0xbbe>
    4424:	00002097          	auipc	ra,0x2
    4428:	b30080e7          	jalr	-1232(ra) # 5f54 <printf>
    exit(1);
    442c:	4505                	li	a0,1
    442e:	00001097          	auipc	ra,0x1
    4432:	7a6080e7          	jalr	1958(ra) # 5bd4 <exit>
  wait(&xstatus);
    4436:	fdc40513          	addi	a0,s0,-36
    443a:	00001097          	auipc	ra,0x1
    443e:	7a2080e7          	jalr	1954(ra) # 5bdc <wait>
  exit(xstatus);
    4442:	fdc42503          	lw	a0,-36(s0)
    4446:	00001097          	auipc	ra,0x1
    444a:	78e080e7          	jalr	1934(ra) # 5bd4 <exit>

000000000000444e <forkforkfork>:
{
    444e:	1101                	addi	sp,sp,-32
    4450:	ec06                	sd	ra,24(sp)
    4452:	e822                	sd	s0,16(sp)
    4454:	e426                	sd	s1,8(sp)
    4456:	1000                	addi	s0,sp,32
    4458:	84aa                	mv	s1,a0
  unlink("stopforking");
    445a:	00004517          	auipc	a0,0x4
    445e:	86650513          	addi	a0,a0,-1946 # 7cc0 <malloc+0x1cae>
    4462:	00001097          	auipc	ra,0x1
    4466:	7c2080e7          	jalr	1986(ra) # 5c24 <unlink>
  int pid = fork();
    446a:	00001097          	auipc	ra,0x1
    446e:	762080e7          	jalr	1890(ra) # 5bcc <fork>
  if(pid < 0){
    4472:	04054563          	bltz	a0,44bc <forkforkfork+0x6e>
  if(pid == 0){
    4476:	c12d                	beqz	a0,44d8 <forkforkfork+0x8a>
  sleep(20); // two seconds
    4478:	4551                	li	a0,20
    447a:	00001097          	auipc	ra,0x1
    447e:	7ea080e7          	jalr	2026(ra) # 5c64 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    4482:	20200593          	li	a1,514
    4486:	00004517          	auipc	a0,0x4
    448a:	83a50513          	addi	a0,a0,-1990 # 7cc0 <malloc+0x1cae>
    448e:	00001097          	auipc	ra,0x1
    4492:	786080e7          	jalr	1926(ra) # 5c14 <open>
    4496:	00001097          	auipc	ra,0x1
    449a:	766080e7          	jalr	1894(ra) # 5bfc <close>
  wait(0);
    449e:	4501                	li	a0,0
    44a0:	00001097          	auipc	ra,0x1
    44a4:	73c080e7          	jalr	1852(ra) # 5bdc <wait>
  sleep(10); // one second
    44a8:	4529                	li	a0,10
    44aa:	00001097          	auipc	ra,0x1
    44ae:	7ba080e7          	jalr	1978(ra) # 5c64 <sleep>
}
    44b2:	60e2                	ld	ra,24(sp)
    44b4:	6442                	ld	s0,16(sp)
    44b6:	64a2                	ld	s1,8(sp)
    44b8:	6105                	addi	sp,sp,32
    44ba:	8082                	ret
    printf("%s: fork failed", s);
    44bc:	85a6                	mv	a1,s1
    44be:	00002517          	auipc	a0,0x2
    44c2:	6e250513          	addi	a0,a0,1762 # 6ba0 <malloc+0xb8e>
    44c6:	00002097          	auipc	ra,0x2
    44ca:	a8e080e7          	jalr	-1394(ra) # 5f54 <printf>
    exit(1);
    44ce:	4505                	li	a0,1
    44d0:	00001097          	auipc	ra,0x1
    44d4:	704080e7          	jalr	1796(ra) # 5bd4 <exit>
      int fd = open("stopforking", 0);
    44d8:	00003497          	auipc	s1,0x3
    44dc:	7e848493          	addi	s1,s1,2024 # 7cc0 <malloc+0x1cae>
    44e0:	4581                	li	a1,0
    44e2:	8526                	mv	a0,s1
    44e4:	00001097          	auipc	ra,0x1
    44e8:	730080e7          	jalr	1840(ra) # 5c14 <open>
      if(fd >= 0){
    44ec:	02055463          	bgez	a0,4514 <forkforkfork+0xc6>
      if(fork() < 0){
    44f0:	00001097          	auipc	ra,0x1
    44f4:	6dc080e7          	jalr	1756(ra) # 5bcc <fork>
    44f8:	fe0554e3          	bgez	a0,44e0 <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    44fc:	20200593          	li	a1,514
    4500:	8526                	mv	a0,s1
    4502:	00001097          	auipc	ra,0x1
    4506:	712080e7          	jalr	1810(ra) # 5c14 <open>
    450a:	00001097          	auipc	ra,0x1
    450e:	6f2080e7          	jalr	1778(ra) # 5bfc <close>
    4512:	b7f9                	j	44e0 <forkforkfork+0x92>
        exit(0);
    4514:	4501                	li	a0,0
    4516:	00001097          	auipc	ra,0x1
    451a:	6be080e7          	jalr	1726(ra) # 5bd4 <exit>

000000000000451e <killstatus>:
{
    451e:	7139                	addi	sp,sp,-64
    4520:	fc06                	sd	ra,56(sp)
    4522:	f822                	sd	s0,48(sp)
    4524:	f426                	sd	s1,40(sp)
    4526:	f04a                	sd	s2,32(sp)
    4528:	ec4e                	sd	s3,24(sp)
    452a:	e852                	sd	s4,16(sp)
    452c:	0080                	addi	s0,sp,64
    452e:	8a2a                	mv	s4,a0
    4530:	06400913          	li	s2,100
    if(xst != -1) {
    4534:	59fd                	li	s3,-1
    int pid1 = fork();
    4536:	00001097          	auipc	ra,0x1
    453a:	696080e7          	jalr	1686(ra) # 5bcc <fork>
    453e:	84aa                	mv	s1,a0
    if(pid1 < 0){
    4540:	02054f63          	bltz	a0,457e <killstatus+0x60>
    if(pid1 == 0){
    4544:	c939                	beqz	a0,459a <killstatus+0x7c>
    sleep(1);
    4546:	4505                	li	a0,1
    4548:	00001097          	auipc	ra,0x1
    454c:	71c080e7          	jalr	1820(ra) # 5c64 <sleep>
    kill(pid1);
    4550:	8526                	mv	a0,s1
    4552:	00001097          	auipc	ra,0x1
    4556:	6b2080e7          	jalr	1714(ra) # 5c04 <kill>
    wait(&xst);
    455a:	fcc40513          	addi	a0,s0,-52
    455e:	00001097          	auipc	ra,0x1
    4562:	67e080e7          	jalr	1662(ra) # 5bdc <wait>
    if(xst != -1) {
    4566:	fcc42783          	lw	a5,-52(s0)
    456a:	03379d63          	bne	a5,s3,45a4 <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    456e:	397d                	addiw	s2,s2,-1
    4570:	fc0913e3          	bnez	s2,4536 <killstatus+0x18>
  exit(0);
    4574:	4501                	li	a0,0
    4576:	00001097          	auipc	ra,0x1
    457a:	65e080e7          	jalr	1630(ra) # 5bd4 <exit>
      printf("%s: fork failed\n", s);
    457e:	85d2                	mv	a1,s4
    4580:	00002517          	auipc	a0,0x2
    4584:	46050513          	addi	a0,a0,1120 # 69e0 <malloc+0x9ce>
    4588:	00002097          	auipc	ra,0x2
    458c:	9cc080e7          	jalr	-1588(ra) # 5f54 <printf>
      exit(1);
    4590:	4505                	li	a0,1
    4592:	00001097          	auipc	ra,0x1
    4596:	642080e7          	jalr	1602(ra) # 5bd4 <exit>
        getpid();
    459a:	00001097          	auipc	ra,0x1
    459e:	6ba080e7          	jalr	1722(ra) # 5c54 <getpid>
      while(1) {
    45a2:	bfe5                	j	459a <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    45a4:	85d2                	mv	a1,s4
    45a6:	00003517          	auipc	a0,0x3
    45aa:	72a50513          	addi	a0,a0,1834 # 7cd0 <malloc+0x1cbe>
    45ae:	00002097          	auipc	ra,0x2
    45b2:	9a6080e7          	jalr	-1626(ra) # 5f54 <printf>
       exit(1);
    45b6:	4505                	li	a0,1
    45b8:	00001097          	auipc	ra,0x1
    45bc:	61c080e7          	jalr	1564(ra) # 5bd4 <exit>

00000000000045c0 <preempt>:
{
    45c0:	7139                	addi	sp,sp,-64
    45c2:	fc06                	sd	ra,56(sp)
    45c4:	f822                	sd	s0,48(sp)
    45c6:	f426                	sd	s1,40(sp)
    45c8:	f04a                	sd	s2,32(sp)
    45ca:	ec4e                	sd	s3,24(sp)
    45cc:	e852                	sd	s4,16(sp)
    45ce:	0080                	addi	s0,sp,64
    45d0:	84aa                	mv	s1,a0
  pid1 = fork();
    45d2:	00001097          	auipc	ra,0x1
    45d6:	5fa080e7          	jalr	1530(ra) # 5bcc <fork>
  if(pid1 < 0) {
    45da:	00054563          	bltz	a0,45e4 <preempt+0x24>
    45de:	8a2a                	mv	s4,a0
  if(pid1 == 0)
    45e0:	e105                	bnez	a0,4600 <preempt+0x40>
    for(;;)
    45e2:	a001                	j	45e2 <preempt+0x22>
    printf("%s: fork failed", s);
    45e4:	85a6                	mv	a1,s1
    45e6:	00002517          	auipc	a0,0x2
    45ea:	5ba50513          	addi	a0,a0,1466 # 6ba0 <malloc+0xb8e>
    45ee:	00002097          	auipc	ra,0x2
    45f2:	966080e7          	jalr	-1690(ra) # 5f54 <printf>
    exit(1);
    45f6:	4505                	li	a0,1
    45f8:	00001097          	auipc	ra,0x1
    45fc:	5dc080e7          	jalr	1500(ra) # 5bd4 <exit>
  pid2 = fork();
    4600:	00001097          	auipc	ra,0x1
    4604:	5cc080e7          	jalr	1484(ra) # 5bcc <fork>
    4608:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    460a:	00054463          	bltz	a0,4612 <preempt+0x52>
  if(pid2 == 0)
    460e:	e105                	bnez	a0,462e <preempt+0x6e>
    for(;;)
    4610:	a001                	j	4610 <preempt+0x50>
    printf("%s: fork failed\n", s);
    4612:	85a6                	mv	a1,s1
    4614:	00002517          	auipc	a0,0x2
    4618:	3cc50513          	addi	a0,a0,972 # 69e0 <malloc+0x9ce>
    461c:	00002097          	auipc	ra,0x2
    4620:	938080e7          	jalr	-1736(ra) # 5f54 <printf>
    exit(1);
    4624:	4505                	li	a0,1
    4626:	00001097          	auipc	ra,0x1
    462a:	5ae080e7          	jalr	1454(ra) # 5bd4 <exit>
  pipe(pfds);
    462e:	fc840513          	addi	a0,s0,-56
    4632:	00001097          	auipc	ra,0x1
    4636:	5b2080e7          	jalr	1458(ra) # 5be4 <pipe>
  pid3 = fork();
    463a:	00001097          	auipc	ra,0x1
    463e:	592080e7          	jalr	1426(ra) # 5bcc <fork>
    4642:	892a                	mv	s2,a0
  if(pid3 < 0) {
    4644:	02054e63          	bltz	a0,4680 <preempt+0xc0>
  if(pid3 == 0){
    4648:	e525                	bnez	a0,46b0 <preempt+0xf0>
    close(pfds[0]);
    464a:	fc842503          	lw	a0,-56(s0)
    464e:	00001097          	auipc	ra,0x1
    4652:	5ae080e7          	jalr	1454(ra) # 5bfc <close>
    if(write(pfds[1], "x", 1) != 1)
    4656:	4605                	li	a2,1
    4658:	00002597          	auipc	a1,0x2
    465c:	b7058593          	addi	a1,a1,-1168 # 61c8 <malloc+0x1b6>
    4660:	fcc42503          	lw	a0,-52(s0)
    4664:	00001097          	auipc	ra,0x1
    4668:	590080e7          	jalr	1424(ra) # 5bf4 <write>
    466c:	4785                	li	a5,1
    466e:	02f51763          	bne	a0,a5,469c <preempt+0xdc>
    close(pfds[1]);
    4672:	fcc42503          	lw	a0,-52(s0)
    4676:	00001097          	auipc	ra,0x1
    467a:	586080e7          	jalr	1414(ra) # 5bfc <close>
    for(;;)
    467e:	a001                	j	467e <preempt+0xbe>
     printf("%s: fork failed\n", s);
    4680:	85a6                	mv	a1,s1
    4682:	00002517          	auipc	a0,0x2
    4686:	35e50513          	addi	a0,a0,862 # 69e0 <malloc+0x9ce>
    468a:	00002097          	auipc	ra,0x2
    468e:	8ca080e7          	jalr	-1846(ra) # 5f54 <printf>
     exit(1);
    4692:	4505                	li	a0,1
    4694:	00001097          	auipc	ra,0x1
    4698:	540080e7          	jalr	1344(ra) # 5bd4 <exit>
      printf("%s: preempt write error", s);
    469c:	85a6                	mv	a1,s1
    469e:	00003517          	auipc	a0,0x3
    46a2:	65250513          	addi	a0,a0,1618 # 7cf0 <malloc+0x1cde>
    46a6:	00002097          	auipc	ra,0x2
    46aa:	8ae080e7          	jalr	-1874(ra) # 5f54 <printf>
    46ae:	b7d1                	j	4672 <preempt+0xb2>
  close(pfds[1]);
    46b0:	fcc42503          	lw	a0,-52(s0)
    46b4:	00001097          	auipc	ra,0x1
    46b8:	548080e7          	jalr	1352(ra) # 5bfc <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    46bc:	660d                	lui	a2,0x3
    46be:	00008597          	auipc	a1,0x8
    46c2:	5ba58593          	addi	a1,a1,1466 # cc78 <buf>
    46c6:	fc842503          	lw	a0,-56(s0)
    46ca:	00001097          	auipc	ra,0x1
    46ce:	522080e7          	jalr	1314(ra) # 5bec <read>
    46d2:	4785                	li	a5,1
    46d4:	02f50363          	beq	a0,a5,46fa <preempt+0x13a>
    printf("%s: preempt read error", s);
    46d8:	85a6                	mv	a1,s1
    46da:	00003517          	auipc	a0,0x3
    46de:	62e50513          	addi	a0,a0,1582 # 7d08 <malloc+0x1cf6>
    46e2:	00002097          	auipc	ra,0x2
    46e6:	872080e7          	jalr	-1934(ra) # 5f54 <printf>
}
    46ea:	70e2                	ld	ra,56(sp)
    46ec:	7442                	ld	s0,48(sp)
    46ee:	74a2                	ld	s1,40(sp)
    46f0:	7902                	ld	s2,32(sp)
    46f2:	69e2                	ld	s3,24(sp)
    46f4:	6a42                	ld	s4,16(sp)
    46f6:	6121                	addi	sp,sp,64
    46f8:	8082                	ret
  close(pfds[0]);
    46fa:	fc842503          	lw	a0,-56(s0)
    46fe:	00001097          	auipc	ra,0x1
    4702:	4fe080e7          	jalr	1278(ra) # 5bfc <close>
  printf("kill... ");
    4706:	00003517          	auipc	a0,0x3
    470a:	61a50513          	addi	a0,a0,1562 # 7d20 <malloc+0x1d0e>
    470e:	00002097          	auipc	ra,0x2
    4712:	846080e7          	jalr	-1978(ra) # 5f54 <printf>
  kill(pid1);
    4716:	8552                	mv	a0,s4
    4718:	00001097          	auipc	ra,0x1
    471c:	4ec080e7          	jalr	1260(ra) # 5c04 <kill>
  kill(pid2);
    4720:	854e                	mv	a0,s3
    4722:	00001097          	auipc	ra,0x1
    4726:	4e2080e7          	jalr	1250(ra) # 5c04 <kill>
  kill(pid3);
    472a:	854a                	mv	a0,s2
    472c:	00001097          	auipc	ra,0x1
    4730:	4d8080e7          	jalr	1240(ra) # 5c04 <kill>
  printf("wait... ");
    4734:	00003517          	auipc	a0,0x3
    4738:	5fc50513          	addi	a0,a0,1532 # 7d30 <malloc+0x1d1e>
    473c:	00002097          	auipc	ra,0x2
    4740:	818080e7          	jalr	-2024(ra) # 5f54 <printf>
  wait(0);
    4744:	4501                	li	a0,0
    4746:	00001097          	auipc	ra,0x1
    474a:	496080e7          	jalr	1174(ra) # 5bdc <wait>
  wait(0);
    474e:	4501                	li	a0,0
    4750:	00001097          	auipc	ra,0x1
    4754:	48c080e7          	jalr	1164(ra) # 5bdc <wait>
  wait(0);
    4758:	4501                	li	a0,0
    475a:	00001097          	auipc	ra,0x1
    475e:	482080e7          	jalr	1154(ra) # 5bdc <wait>
    4762:	b761                	j	46ea <preempt+0x12a>

0000000000004764 <reparent>:
{
    4764:	7179                	addi	sp,sp,-48
    4766:	f406                	sd	ra,40(sp)
    4768:	f022                	sd	s0,32(sp)
    476a:	ec26                	sd	s1,24(sp)
    476c:	e84a                	sd	s2,16(sp)
    476e:	e44e                	sd	s3,8(sp)
    4770:	e052                	sd	s4,0(sp)
    4772:	1800                	addi	s0,sp,48
    4774:	89aa                	mv	s3,a0
  int master_pid = getpid();
    4776:	00001097          	auipc	ra,0x1
    477a:	4de080e7          	jalr	1246(ra) # 5c54 <getpid>
    477e:	8a2a                	mv	s4,a0
    4780:	0c800913          	li	s2,200
    int pid = fork();
    4784:	00001097          	auipc	ra,0x1
    4788:	448080e7          	jalr	1096(ra) # 5bcc <fork>
    478c:	84aa                	mv	s1,a0
    if(pid < 0){
    478e:	02054263          	bltz	a0,47b2 <reparent+0x4e>
    if(pid){
    4792:	cd21                	beqz	a0,47ea <reparent+0x86>
      if(wait(0) != pid){
    4794:	4501                	li	a0,0
    4796:	00001097          	auipc	ra,0x1
    479a:	446080e7          	jalr	1094(ra) # 5bdc <wait>
    479e:	02951863          	bne	a0,s1,47ce <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    47a2:	397d                	addiw	s2,s2,-1
    47a4:	fe0910e3          	bnez	s2,4784 <reparent+0x20>
  exit(0);
    47a8:	4501                	li	a0,0
    47aa:	00001097          	auipc	ra,0x1
    47ae:	42a080e7          	jalr	1066(ra) # 5bd4 <exit>
      printf("%s: fork failed\n", s);
    47b2:	85ce                	mv	a1,s3
    47b4:	00002517          	auipc	a0,0x2
    47b8:	22c50513          	addi	a0,a0,556 # 69e0 <malloc+0x9ce>
    47bc:	00001097          	auipc	ra,0x1
    47c0:	798080e7          	jalr	1944(ra) # 5f54 <printf>
      exit(1);
    47c4:	4505                	li	a0,1
    47c6:	00001097          	auipc	ra,0x1
    47ca:	40e080e7          	jalr	1038(ra) # 5bd4 <exit>
        printf("%s: wait wrong pid\n", s);
    47ce:	85ce                	mv	a1,s3
    47d0:	00002517          	auipc	a0,0x2
    47d4:	39850513          	addi	a0,a0,920 # 6b68 <malloc+0xb56>
    47d8:	00001097          	auipc	ra,0x1
    47dc:	77c080e7          	jalr	1916(ra) # 5f54 <printf>
        exit(1);
    47e0:	4505                	li	a0,1
    47e2:	00001097          	auipc	ra,0x1
    47e6:	3f2080e7          	jalr	1010(ra) # 5bd4 <exit>
      int pid2 = fork();
    47ea:	00001097          	auipc	ra,0x1
    47ee:	3e2080e7          	jalr	994(ra) # 5bcc <fork>
      if(pid2 < 0){
    47f2:	00054763          	bltz	a0,4800 <reparent+0x9c>
      exit(0);
    47f6:	4501                	li	a0,0
    47f8:	00001097          	auipc	ra,0x1
    47fc:	3dc080e7          	jalr	988(ra) # 5bd4 <exit>
        kill(master_pid);
    4800:	8552                	mv	a0,s4
    4802:	00001097          	auipc	ra,0x1
    4806:	402080e7          	jalr	1026(ra) # 5c04 <kill>
        exit(1);
    480a:	4505                	li	a0,1
    480c:	00001097          	auipc	ra,0x1
    4810:	3c8080e7          	jalr	968(ra) # 5bd4 <exit>

0000000000004814 <sbrkfail>:
{
    4814:	7119                	addi	sp,sp,-128
    4816:	fc86                	sd	ra,120(sp)
    4818:	f8a2                	sd	s0,112(sp)
    481a:	f4a6                	sd	s1,104(sp)
    481c:	f0ca                	sd	s2,96(sp)
    481e:	ecce                	sd	s3,88(sp)
    4820:	e8d2                	sd	s4,80(sp)
    4822:	e4d6                	sd	s5,72(sp)
    4824:	0100                	addi	s0,sp,128
    4826:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    4828:	fb040513          	addi	a0,s0,-80
    482c:	00001097          	auipc	ra,0x1
    4830:	3b8080e7          	jalr	952(ra) # 5be4 <pipe>
    4834:	e901                	bnez	a0,4844 <sbrkfail+0x30>
    4836:	f8040493          	addi	s1,s0,-128
    483a:	fa840a13          	addi	s4,s0,-88
    483e:	89a6                	mv	s3,s1
    if(pids[i] != -1)
    4840:	5afd                	li	s5,-1
    4842:	a08d                	j	48a4 <sbrkfail+0x90>
    printf("%s: pipe() failed\n", s);
    4844:	85ca                	mv	a1,s2
    4846:	00002517          	auipc	a0,0x2
    484a:	2a250513          	addi	a0,a0,674 # 6ae8 <malloc+0xad6>
    484e:	00001097          	auipc	ra,0x1
    4852:	706080e7          	jalr	1798(ra) # 5f54 <printf>
    exit(1);
    4856:	4505                	li	a0,1
    4858:	00001097          	auipc	ra,0x1
    485c:	37c080e7          	jalr	892(ra) # 5bd4 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    4860:	4501                	li	a0,0
    4862:	00001097          	auipc	ra,0x1
    4866:	3fa080e7          	jalr	1018(ra) # 5c5c <sbrk>
    486a:	064007b7          	lui	a5,0x6400
    486e:	40a7853b          	subw	a0,a5,a0
    4872:	00001097          	auipc	ra,0x1
    4876:	3ea080e7          	jalr	1002(ra) # 5c5c <sbrk>
      write(fds[1], "x", 1);
    487a:	4605                	li	a2,1
    487c:	00002597          	auipc	a1,0x2
    4880:	94c58593          	addi	a1,a1,-1716 # 61c8 <malloc+0x1b6>
    4884:	fb442503          	lw	a0,-76(s0)
    4888:	00001097          	auipc	ra,0x1
    488c:	36c080e7          	jalr	876(ra) # 5bf4 <write>
      for(;;) sleep(1000);
    4890:	3e800513          	li	a0,1000
    4894:	00001097          	auipc	ra,0x1
    4898:	3d0080e7          	jalr	976(ra) # 5c64 <sleep>
    489c:	bfd5                	j	4890 <sbrkfail+0x7c>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    489e:	0991                	addi	s3,s3,4
    48a0:	03498563          	beq	s3,s4,48ca <sbrkfail+0xb6>
    if((pids[i] = fork()) == 0){
    48a4:	00001097          	auipc	ra,0x1
    48a8:	328080e7          	jalr	808(ra) # 5bcc <fork>
    48ac:	00a9a023          	sw	a0,0(s3)
    48b0:	d945                	beqz	a0,4860 <sbrkfail+0x4c>
    if(pids[i] != -1)
    48b2:	ff5506e3          	beq	a0,s5,489e <sbrkfail+0x8a>
      read(fds[0], &scratch, 1);
    48b6:	4605                	li	a2,1
    48b8:	faf40593          	addi	a1,s0,-81
    48bc:	fb042503          	lw	a0,-80(s0)
    48c0:	00001097          	auipc	ra,0x1
    48c4:	32c080e7          	jalr	812(ra) # 5bec <read>
    48c8:	bfd9                	j	489e <sbrkfail+0x8a>
  c = sbrk(PGSIZE);
    48ca:	6505                	lui	a0,0x1
    48cc:	00001097          	auipc	ra,0x1
    48d0:	390080e7          	jalr	912(ra) # 5c5c <sbrk>
    48d4:	89aa                	mv	s3,a0
    if(pids[i] == -1)
    48d6:	5afd                	li	s5,-1
    48d8:	a021                	j	48e0 <sbrkfail+0xcc>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    48da:	0491                	addi	s1,s1,4
    48dc:	01448f63          	beq	s1,s4,48fa <sbrkfail+0xe6>
    if(pids[i] == -1)
    48e0:	4088                	lw	a0,0(s1)
    48e2:	ff550ce3          	beq	a0,s5,48da <sbrkfail+0xc6>
    kill(pids[i]);
    48e6:	00001097          	auipc	ra,0x1
    48ea:	31e080e7          	jalr	798(ra) # 5c04 <kill>
    wait(0);
    48ee:	4501                	li	a0,0
    48f0:	00001097          	auipc	ra,0x1
    48f4:	2ec080e7          	jalr	748(ra) # 5bdc <wait>
    48f8:	b7cd                	j	48da <sbrkfail+0xc6>
  if(c == (char*)0xffffffffffffffffL){
    48fa:	57fd                	li	a5,-1
    48fc:	04f98163          	beq	s3,a5,493e <sbrkfail+0x12a>
  pid = fork();
    4900:	00001097          	auipc	ra,0x1
    4904:	2cc080e7          	jalr	716(ra) # 5bcc <fork>
    4908:	84aa                	mv	s1,a0
  if(pid < 0){
    490a:	04054863          	bltz	a0,495a <sbrkfail+0x146>
  if(pid == 0){
    490e:	c525                	beqz	a0,4976 <sbrkfail+0x162>
  wait(&xstatus);
    4910:	fbc40513          	addi	a0,s0,-68
    4914:	00001097          	auipc	ra,0x1
    4918:	2c8080e7          	jalr	712(ra) # 5bdc <wait>
  if(xstatus != -1 && xstatus != 2)
    491c:	fbc42783          	lw	a5,-68(s0)
    4920:	577d                	li	a4,-1
    4922:	00e78563          	beq	a5,a4,492c <sbrkfail+0x118>
    4926:	4709                	li	a4,2
    4928:	08e79d63          	bne	a5,a4,49c2 <sbrkfail+0x1ae>
}
    492c:	70e6                	ld	ra,120(sp)
    492e:	7446                	ld	s0,112(sp)
    4930:	74a6                	ld	s1,104(sp)
    4932:	7906                	ld	s2,96(sp)
    4934:	69e6                	ld	s3,88(sp)
    4936:	6a46                	ld	s4,80(sp)
    4938:	6aa6                	ld	s5,72(sp)
    493a:	6109                	addi	sp,sp,128
    493c:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    493e:	85ca                	mv	a1,s2
    4940:	00003517          	auipc	a0,0x3
    4944:	40050513          	addi	a0,a0,1024 # 7d40 <malloc+0x1d2e>
    4948:	00001097          	auipc	ra,0x1
    494c:	60c080e7          	jalr	1548(ra) # 5f54 <printf>
    exit(1);
    4950:	4505                	li	a0,1
    4952:	00001097          	auipc	ra,0x1
    4956:	282080e7          	jalr	642(ra) # 5bd4 <exit>
    printf("%s: fork failed\n", s);
    495a:	85ca                	mv	a1,s2
    495c:	00002517          	auipc	a0,0x2
    4960:	08450513          	addi	a0,a0,132 # 69e0 <malloc+0x9ce>
    4964:	00001097          	auipc	ra,0x1
    4968:	5f0080e7          	jalr	1520(ra) # 5f54 <printf>
    exit(1);
    496c:	4505                	li	a0,1
    496e:	00001097          	auipc	ra,0x1
    4972:	266080e7          	jalr	614(ra) # 5bd4 <exit>
    a = sbrk(0);
    4976:	4501                	li	a0,0
    4978:	00001097          	auipc	ra,0x1
    497c:	2e4080e7          	jalr	740(ra) # 5c5c <sbrk>
    4980:	89aa                	mv	s3,a0
    sbrk(10*BIG);
    4982:	3e800537          	lui	a0,0x3e800
    4986:	00001097          	auipc	ra,0x1
    498a:	2d6080e7          	jalr	726(ra) # 5c5c <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    498e:	874e                	mv	a4,s3
    4990:	3e8007b7          	lui	a5,0x3e800
    4994:	97ce                	add	a5,a5,s3
    4996:	6685                	lui	a3,0x1
      n += *(a+i);
    4998:	00074603          	lbu	a2,0(a4)
    499c:	9cb1                	addw	s1,s1,a2
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    499e:	9736                	add	a4,a4,a3
    49a0:	fef71ce3          	bne	a4,a5,4998 <sbrkfail+0x184>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    49a4:	8626                	mv	a2,s1
    49a6:	85ca                	mv	a1,s2
    49a8:	00003517          	auipc	a0,0x3
    49ac:	3b850513          	addi	a0,a0,952 # 7d60 <malloc+0x1d4e>
    49b0:	00001097          	auipc	ra,0x1
    49b4:	5a4080e7          	jalr	1444(ra) # 5f54 <printf>
    exit(1);
    49b8:	4505                	li	a0,1
    49ba:	00001097          	auipc	ra,0x1
    49be:	21a080e7          	jalr	538(ra) # 5bd4 <exit>
    exit(1);
    49c2:	4505                	li	a0,1
    49c4:	00001097          	auipc	ra,0x1
    49c8:	210080e7          	jalr	528(ra) # 5bd4 <exit>

00000000000049cc <mem>:
{
    49cc:	7139                	addi	sp,sp,-64
    49ce:	fc06                	sd	ra,56(sp)
    49d0:	f822                	sd	s0,48(sp)
    49d2:	f426                	sd	s1,40(sp)
    49d4:	f04a                	sd	s2,32(sp)
    49d6:	ec4e                	sd	s3,24(sp)
    49d8:	0080                	addi	s0,sp,64
    49da:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    49dc:	00001097          	auipc	ra,0x1
    49e0:	1f0080e7          	jalr	496(ra) # 5bcc <fork>
    m1 = 0;
    49e4:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    49e6:	6909                	lui	s2,0x2
    49e8:	71190913          	addi	s2,s2,1809 # 2711 <copyinstr3+0x101>
  if((pid = fork()) == 0){
    49ec:	ed39                	bnez	a0,4a4a <mem+0x7e>
    while((m2 = malloc(10001)) != 0){
    49ee:	854a                	mv	a0,s2
    49f0:	00001097          	auipc	ra,0x1
    49f4:	622080e7          	jalr	1570(ra) # 6012 <malloc>
    49f8:	c501                	beqz	a0,4a00 <mem+0x34>
      *(char**)m2 = m1;
    49fa:	e104                	sd	s1,0(a0)
      m1 = m2;
    49fc:	84aa                	mv	s1,a0
    49fe:	bfc5                	j	49ee <mem+0x22>
    while(m1){
    4a00:	c881                	beqz	s1,4a10 <mem+0x44>
      m2 = *(char**)m1;
    4a02:	8526                	mv	a0,s1
    4a04:	6084                	ld	s1,0(s1)
      free(m1);
    4a06:	00001097          	auipc	ra,0x1
    4a0a:	584080e7          	jalr	1412(ra) # 5f8a <free>
    while(m1){
    4a0e:	f8f5                	bnez	s1,4a02 <mem+0x36>
    m1 = malloc(1024*20);
    4a10:	6515                	lui	a0,0x5
    4a12:	00001097          	auipc	ra,0x1
    4a16:	600080e7          	jalr	1536(ra) # 6012 <malloc>
    if(m1 == 0){
    4a1a:	c911                	beqz	a0,4a2e <mem+0x62>
    free(m1);
    4a1c:	00001097          	auipc	ra,0x1
    4a20:	56e080e7          	jalr	1390(ra) # 5f8a <free>
    exit(0);
    4a24:	4501                	li	a0,0
    4a26:	00001097          	auipc	ra,0x1
    4a2a:	1ae080e7          	jalr	430(ra) # 5bd4 <exit>
      printf("couldn't allocate mem?!!\n", s);
    4a2e:	85ce                	mv	a1,s3
    4a30:	00003517          	auipc	a0,0x3
    4a34:	36050513          	addi	a0,a0,864 # 7d90 <malloc+0x1d7e>
    4a38:	00001097          	auipc	ra,0x1
    4a3c:	51c080e7          	jalr	1308(ra) # 5f54 <printf>
      exit(1);
    4a40:	4505                	li	a0,1
    4a42:	00001097          	auipc	ra,0x1
    4a46:	192080e7          	jalr	402(ra) # 5bd4 <exit>
    wait(&xstatus);
    4a4a:	fcc40513          	addi	a0,s0,-52
    4a4e:	00001097          	auipc	ra,0x1
    4a52:	18e080e7          	jalr	398(ra) # 5bdc <wait>
    if(xstatus == -1){
    4a56:	fcc42503          	lw	a0,-52(s0)
    4a5a:	57fd                	li	a5,-1
    4a5c:	00f50663          	beq	a0,a5,4a68 <mem+0x9c>
    exit(xstatus);
    4a60:	00001097          	auipc	ra,0x1
    4a64:	174080e7          	jalr	372(ra) # 5bd4 <exit>
      exit(0);
    4a68:	4501                	li	a0,0
    4a6a:	00001097          	auipc	ra,0x1
    4a6e:	16a080e7          	jalr	362(ra) # 5bd4 <exit>

0000000000004a72 <sharedfd>:
{
    4a72:	7159                	addi	sp,sp,-112
    4a74:	f486                	sd	ra,104(sp)
    4a76:	f0a2                	sd	s0,96(sp)
    4a78:	eca6                	sd	s1,88(sp)
    4a7a:	e8ca                	sd	s2,80(sp)
    4a7c:	e4ce                	sd	s3,72(sp)
    4a7e:	e0d2                	sd	s4,64(sp)
    4a80:	fc56                	sd	s5,56(sp)
    4a82:	f85a                	sd	s6,48(sp)
    4a84:	f45e                	sd	s7,40(sp)
    4a86:	1880                	addi	s0,sp,112
    4a88:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    4a8a:	00003517          	auipc	a0,0x3
    4a8e:	32650513          	addi	a0,a0,806 # 7db0 <malloc+0x1d9e>
    4a92:	00001097          	auipc	ra,0x1
    4a96:	192080e7          	jalr	402(ra) # 5c24 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    4a9a:	20200593          	li	a1,514
    4a9e:	00003517          	auipc	a0,0x3
    4aa2:	31250513          	addi	a0,a0,786 # 7db0 <malloc+0x1d9e>
    4aa6:	00001097          	auipc	ra,0x1
    4aaa:	16e080e7          	jalr	366(ra) # 5c14 <open>
  if(fd < 0){
    4aae:	04054a63          	bltz	a0,4b02 <sharedfd+0x90>
    4ab2:	892a                	mv	s2,a0
  pid = fork();
    4ab4:	00001097          	auipc	ra,0x1
    4ab8:	118080e7          	jalr	280(ra) # 5bcc <fork>
    4abc:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    4abe:	06300593          	li	a1,99
    4ac2:	c119                	beqz	a0,4ac8 <sharedfd+0x56>
    4ac4:	07000593          	li	a1,112
    4ac8:	4629                	li	a2,10
    4aca:	fa040513          	addi	a0,s0,-96
    4ace:	00001097          	auipc	ra,0x1
    4ad2:	f02080e7          	jalr	-254(ra) # 59d0 <memset>
    4ad6:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4ada:	4629                	li	a2,10
    4adc:	fa040593          	addi	a1,s0,-96
    4ae0:	854a                	mv	a0,s2
    4ae2:	00001097          	auipc	ra,0x1
    4ae6:	112080e7          	jalr	274(ra) # 5bf4 <write>
    4aea:	47a9                	li	a5,10
    4aec:	02f51963          	bne	a0,a5,4b1e <sharedfd+0xac>
  for(i = 0; i < N; i++){
    4af0:	34fd                	addiw	s1,s1,-1
    4af2:	f4e5                	bnez	s1,4ada <sharedfd+0x68>
  if(pid == 0) {
    4af4:	04099363          	bnez	s3,4b3a <sharedfd+0xc8>
    exit(0);
    4af8:	4501                	li	a0,0
    4afa:	00001097          	auipc	ra,0x1
    4afe:	0da080e7          	jalr	218(ra) # 5bd4 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    4b02:	85d2                	mv	a1,s4
    4b04:	00003517          	auipc	a0,0x3
    4b08:	2bc50513          	addi	a0,a0,700 # 7dc0 <malloc+0x1dae>
    4b0c:	00001097          	auipc	ra,0x1
    4b10:	448080e7          	jalr	1096(ra) # 5f54 <printf>
    exit(1);
    4b14:	4505                	li	a0,1
    4b16:	00001097          	auipc	ra,0x1
    4b1a:	0be080e7          	jalr	190(ra) # 5bd4 <exit>
      printf("%s: write sharedfd failed\n", s);
    4b1e:	85d2                	mv	a1,s4
    4b20:	00003517          	auipc	a0,0x3
    4b24:	2c850513          	addi	a0,a0,712 # 7de8 <malloc+0x1dd6>
    4b28:	00001097          	auipc	ra,0x1
    4b2c:	42c080e7          	jalr	1068(ra) # 5f54 <printf>
      exit(1);
    4b30:	4505                	li	a0,1
    4b32:	00001097          	auipc	ra,0x1
    4b36:	0a2080e7          	jalr	162(ra) # 5bd4 <exit>
    wait(&xstatus);
    4b3a:	f9c40513          	addi	a0,s0,-100
    4b3e:	00001097          	auipc	ra,0x1
    4b42:	09e080e7          	jalr	158(ra) # 5bdc <wait>
    if(xstatus != 0)
    4b46:	f9c42983          	lw	s3,-100(s0)
    4b4a:	00098763          	beqz	s3,4b58 <sharedfd+0xe6>
      exit(xstatus);
    4b4e:	854e                	mv	a0,s3
    4b50:	00001097          	auipc	ra,0x1
    4b54:	084080e7          	jalr	132(ra) # 5bd4 <exit>
  close(fd);
    4b58:	854a                	mv	a0,s2
    4b5a:	00001097          	auipc	ra,0x1
    4b5e:	0a2080e7          	jalr	162(ra) # 5bfc <close>
  fd = open("sharedfd", 0);
    4b62:	4581                	li	a1,0
    4b64:	00003517          	auipc	a0,0x3
    4b68:	24c50513          	addi	a0,a0,588 # 7db0 <malloc+0x1d9e>
    4b6c:	00001097          	auipc	ra,0x1
    4b70:	0a8080e7          	jalr	168(ra) # 5c14 <open>
    4b74:	8baa                	mv	s7,a0
  nc = np = 0;
    4b76:	8ace                	mv	s5,s3
  if(fd < 0){
    4b78:	02054563          	bltz	a0,4ba2 <sharedfd+0x130>
    4b7c:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    4b80:	06300493          	li	s1,99
      if(buf[i] == 'p')
    4b84:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    4b88:	4629                	li	a2,10
    4b8a:	fa040593          	addi	a1,s0,-96
    4b8e:	855e                	mv	a0,s7
    4b90:	00001097          	auipc	ra,0x1
    4b94:	05c080e7          	jalr	92(ra) # 5bec <read>
    4b98:	02a05f63          	blez	a0,4bd6 <sharedfd+0x164>
    4b9c:	fa040793          	addi	a5,s0,-96
    4ba0:	a01d                	j	4bc6 <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    4ba2:	85d2                	mv	a1,s4
    4ba4:	00003517          	auipc	a0,0x3
    4ba8:	26450513          	addi	a0,a0,612 # 7e08 <malloc+0x1df6>
    4bac:	00001097          	auipc	ra,0x1
    4bb0:	3a8080e7          	jalr	936(ra) # 5f54 <printf>
    exit(1);
    4bb4:	4505                	li	a0,1
    4bb6:	00001097          	auipc	ra,0x1
    4bba:	01e080e7          	jalr	30(ra) # 5bd4 <exit>
        nc++;
    4bbe:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    4bc0:	0785                	addi	a5,a5,1
    4bc2:	fd2783e3          	beq	a5,s2,4b88 <sharedfd+0x116>
      if(buf[i] == 'c')
    4bc6:	0007c703          	lbu	a4,0(a5) # 3e800000 <base+0x3e7f0388>
    4bca:	fe970ae3          	beq	a4,s1,4bbe <sharedfd+0x14c>
      if(buf[i] == 'p')
    4bce:	ff6719e3          	bne	a4,s6,4bc0 <sharedfd+0x14e>
        np++;
    4bd2:	2a85                	addiw	s5,s5,1
    4bd4:	b7f5                	j	4bc0 <sharedfd+0x14e>
  close(fd);
    4bd6:	855e                	mv	a0,s7
    4bd8:	00001097          	auipc	ra,0x1
    4bdc:	024080e7          	jalr	36(ra) # 5bfc <close>
  unlink("sharedfd");
    4be0:	00003517          	auipc	a0,0x3
    4be4:	1d050513          	addi	a0,a0,464 # 7db0 <malloc+0x1d9e>
    4be8:	00001097          	auipc	ra,0x1
    4bec:	03c080e7          	jalr	60(ra) # 5c24 <unlink>
  if(nc == N*SZ && np == N*SZ){
    4bf0:	6789                	lui	a5,0x2
    4bf2:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0x100>
    4bf6:	00f99763          	bne	s3,a5,4c04 <sharedfd+0x192>
    4bfa:	6789                	lui	a5,0x2
    4bfc:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0x100>
    4c00:	02fa8063          	beq	s5,a5,4c20 <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    4c04:	85d2                	mv	a1,s4
    4c06:	00003517          	auipc	a0,0x3
    4c0a:	22a50513          	addi	a0,a0,554 # 7e30 <malloc+0x1e1e>
    4c0e:	00001097          	auipc	ra,0x1
    4c12:	346080e7          	jalr	838(ra) # 5f54 <printf>
    exit(1);
    4c16:	4505                	li	a0,1
    4c18:	00001097          	auipc	ra,0x1
    4c1c:	fbc080e7          	jalr	-68(ra) # 5bd4 <exit>
    exit(0);
    4c20:	4501                	li	a0,0
    4c22:	00001097          	auipc	ra,0x1
    4c26:	fb2080e7          	jalr	-78(ra) # 5bd4 <exit>

0000000000004c2a <fourfiles>:
{
    4c2a:	7171                	addi	sp,sp,-176
    4c2c:	f506                	sd	ra,168(sp)
    4c2e:	f122                	sd	s0,160(sp)
    4c30:	ed26                	sd	s1,152(sp)
    4c32:	e94a                	sd	s2,144(sp)
    4c34:	e54e                	sd	s3,136(sp)
    4c36:	e152                	sd	s4,128(sp)
    4c38:	fcd6                	sd	s5,120(sp)
    4c3a:	f8da                	sd	s6,112(sp)
    4c3c:	f4de                	sd	s7,104(sp)
    4c3e:	f0e2                	sd	s8,96(sp)
    4c40:	ece6                	sd	s9,88(sp)
    4c42:	e8ea                	sd	s10,80(sp)
    4c44:	e4ee                	sd	s11,72(sp)
    4c46:	1900                	addi	s0,sp,176
    4c48:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c4a:	00001797          	auipc	a5,0x1
    4c4e:	4b678793          	addi	a5,a5,1206 # 6100 <malloc+0xee>
    4c52:	f6f43823          	sd	a5,-144(s0)
    4c56:	00001797          	auipc	a5,0x1
    4c5a:	4b278793          	addi	a5,a5,1202 # 6108 <malloc+0xf6>
    4c5e:	f6f43c23          	sd	a5,-136(s0)
    4c62:	00001797          	auipc	a5,0x1
    4c66:	4ae78793          	addi	a5,a5,1198 # 6110 <malloc+0xfe>
    4c6a:	f8f43023          	sd	a5,-128(s0)
    4c6e:	00001797          	auipc	a5,0x1
    4c72:	4aa78793          	addi	a5,a5,1194 # 6118 <malloc+0x106>
    4c76:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    4c7a:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c7e:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    4c80:	4481                	li	s1,0
    4c82:	4a11                	li	s4,4
    fname = names[pi];
    4c84:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4c88:	854e                	mv	a0,s3
    4c8a:	00001097          	auipc	ra,0x1
    4c8e:	f9a080e7          	jalr	-102(ra) # 5c24 <unlink>
    pid = fork();
    4c92:	00001097          	auipc	ra,0x1
    4c96:	f3a080e7          	jalr	-198(ra) # 5bcc <fork>
    if(pid < 0){
    4c9a:	04054563          	bltz	a0,4ce4 <fourfiles+0xba>
    if(pid == 0){
    4c9e:	c12d                	beqz	a0,4d00 <fourfiles+0xd6>
  for(pi = 0; pi < NCHILD; pi++){
    4ca0:	2485                	addiw	s1,s1,1
    4ca2:	0921                	addi	s2,s2,8
    4ca4:	ff4490e3          	bne	s1,s4,4c84 <fourfiles+0x5a>
    4ca8:	4491                	li	s1,4
    wait(&xstatus);
    4caa:	f6c40513          	addi	a0,s0,-148
    4cae:	00001097          	auipc	ra,0x1
    4cb2:	f2e080e7          	jalr	-210(ra) # 5bdc <wait>
    if(xstatus != 0)
    4cb6:	f6c42503          	lw	a0,-148(s0)
    4cba:	ed69                	bnez	a0,4d94 <fourfiles+0x16a>
  for(pi = 0; pi < NCHILD; pi++){
    4cbc:	34fd                	addiw	s1,s1,-1
    4cbe:	f4f5                	bnez	s1,4caa <fourfiles+0x80>
    4cc0:	03000b13          	li	s6,48
    total = 0;
    4cc4:	f4a43c23          	sd	a0,-168(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4cc8:	00008a17          	auipc	s4,0x8
    4ccc:	fb0a0a13          	addi	s4,s4,-80 # cc78 <buf>
    4cd0:	00008a97          	auipc	s5,0x8
    4cd4:	fa9a8a93          	addi	s5,s5,-87 # cc79 <buf+0x1>
    if(total != N*SZ){
    4cd8:	6d05                	lui	s10,0x1
    4cda:	770d0d13          	addi	s10,s10,1904 # 1770 <exectest+0x2c>
  for(i = 0; i < NCHILD; i++){
    4cde:	03400d93          	li	s11,52
    4ce2:	a23d                	j	4e10 <fourfiles+0x1e6>
      printf("fork failed\n", s);
    4ce4:	85e6                	mv	a1,s9
    4ce6:	00002517          	auipc	a0,0x2
    4cea:	10250513          	addi	a0,a0,258 # 6de8 <malloc+0xdd6>
    4cee:	00001097          	auipc	ra,0x1
    4cf2:	266080e7          	jalr	614(ra) # 5f54 <printf>
      exit(1);
    4cf6:	4505                	li	a0,1
    4cf8:	00001097          	auipc	ra,0x1
    4cfc:	edc080e7          	jalr	-292(ra) # 5bd4 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    4d00:	20200593          	li	a1,514
    4d04:	854e                	mv	a0,s3
    4d06:	00001097          	auipc	ra,0x1
    4d0a:	f0e080e7          	jalr	-242(ra) # 5c14 <open>
    4d0e:	892a                	mv	s2,a0
      if(fd < 0){
    4d10:	04054763          	bltz	a0,4d5e <fourfiles+0x134>
      memset(buf, '0'+pi, SZ);
    4d14:	1f400613          	li	a2,500
    4d18:	0304859b          	addiw	a1,s1,48
    4d1c:	00008517          	auipc	a0,0x8
    4d20:	f5c50513          	addi	a0,a0,-164 # cc78 <buf>
    4d24:	00001097          	auipc	ra,0x1
    4d28:	cac080e7          	jalr	-852(ra) # 59d0 <memset>
    4d2c:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    4d2e:	00008997          	auipc	s3,0x8
    4d32:	f4a98993          	addi	s3,s3,-182 # cc78 <buf>
    4d36:	1f400613          	li	a2,500
    4d3a:	85ce                	mv	a1,s3
    4d3c:	854a                	mv	a0,s2
    4d3e:	00001097          	auipc	ra,0x1
    4d42:	eb6080e7          	jalr	-330(ra) # 5bf4 <write>
    4d46:	85aa                	mv	a1,a0
    4d48:	1f400793          	li	a5,500
    4d4c:	02f51763          	bne	a0,a5,4d7a <fourfiles+0x150>
      for(i = 0; i < N; i++){
    4d50:	34fd                	addiw	s1,s1,-1
    4d52:	f0f5                	bnez	s1,4d36 <fourfiles+0x10c>
      exit(0);
    4d54:	4501                	li	a0,0
    4d56:	00001097          	auipc	ra,0x1
    4d5a:	e7e080e7          	jalr	-386(ra) # 5bd4 <exit>
        printf("create failed\n", s);
    4d5e:	85e6                	mv	a1,s9
    4d60:	00003517          	auipc	a0,0x3
    4d64:	0e850513          	addi	a0,a0,232 # 7e48 <malloc+0x1e36>
    4d68:	00001097          	auipc	ra,0x1
    4d6c:	1ec080e7          	jalr	492(ra) # 5f54 <printf>
        exit(1);
    4d70:	4505                	li	a0,1
    4d72:	00001097          	auipc	ra,0x1
    4d76:	e62080e7          	jalr	-414(ra) # 5bd4 <exit>
          printf("write failed %d\n", n);
    4d7a:	00003517          	auipc	a0,0x3
    4d7e:	0de50513          	addi	a0,a0,222 # 7e58 <malloc+0x1e46>
    4d82:	00001097          	auipc	ra,0x1
    4d86:	1d2080e7          	jalr	466(ra) # 5f54 <printf>
          exit(1);
    4d8a:	4505                	li	a0,1
    4d8c:	00001097          	auipc	ra,0x1
    4d90:	e48080e7          	jalr	-440(ra) # 5bd4 <exit>
      exit(xstatus);
    4d94:	00001097          	auipc	ra,0x1
    4d98:	e40080e7          	jalr	-448(ra) # 5bd4 <exit>
          printf("wrong char\n", s);
    4d9c:	85e6                	mv	a1,s9
    4d9e:	00003517          	auipc	a0,0x3
    4da2:	0d250513          	addi	a0,a0,210 # 7e70 <malloc+0x1e5e>
    4da6:	00001097          	auipc	ra,0x1
    4daa:	1ae080e7          	jalr	430(ra) # 5f54 <printf>
          exit(1);
    4dae:	4505                	li	a0,1
    4db0:	00001097          	auipc	ra,0x1
    4db4:	e24080e7          	jalr	-476(ra) # 5bd4 <exit>
      total += n;
    4db8:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4dbc:	660d                	lui	a2,0x3
    4dbe:	85d2                	mv	a1,s4
    4dc0:	854e                	mv	a0,s3
    4dc2:	00001097          	auipc	ra,0x1
    4dc6:	e2a080e7          	jalr	-470(ra) # 5bec <read>
    4dca:	02a05363          	blez	a0,4df0 <fourfiles+0x1c6>
    4dce:	00008797          	auipc	a5,0x8
    4dd2:	eaa78793          	addi	a5,a5,-342 # cc78 <buf>
    4dd6:	fff5069b          	addiw	a3,a0,-1
    4dda:	1682                	slli	a3,a3,0x20
    4ddc:	9281                	srli	a3,a3,0x20
    4dde:	96d6                	add	a3,a3,s5
        if(buf[j] != '0'+i){
    4de0:	0007c703          	lbu	a4,0(a5)
    4de4:	fa971ce3          	bne	a4,s1,4d9c <fourfiles+0x172>
      for(j = 0; j < n; j++){
    4de8:	0785                	addi	a5,a5,1
    4dea:	fed79be3          	bne	a5,a3,4de0 <fourfiles+0x1b6>
    4dee:	b7e9                	j	4db8 <fourfiles+0x18e>
    close(fd);
    4df0:	854e                	mv	a0,s3
    4df2:	00001097          	auipc	ra,0x1
    4df6:	e0a080e7          	jalr	-502(ra) # 5bfc <close>
    if(total != N*SZ){
    4dfa:	03a91963          	bne	s2,s10,4e2c <fourfiles+0x202>
    unlink(fname);
    4dfe:	8562                	mv	a0,s8
    4e00:	00001097          	auipc	ra,0x1
    4e04:	e24080e7          	jalr	-476(ra) # 5c24 <unlink>
  for(i = 0; i < NCHILD; i++){
    4e08:	0ba1                	addi	s7,s7,8
    4e0a:	2b05                	addiw	s6,s6,1
    4e0c:	03bb0e63          	beq	s6,s11,4e48 <fourfiles+0x21e>
    fname = names[i];
    4e10:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    4e14:	4581                	li	a1,0
    4e16:	8562                	mv	a0,s8
    4e18:	00001097          	auipc	ra,0x1
    4e1c:	dfc080e7          	jalr	-516(ra) # 5c14 <open>
    4e20:	89aa                	mv	s3,a0
    total = 0;
    4e22:	f5843903          	ld	s2,-168(s0)
        if(buf[j] != '0'+i){
    4e26:	000b049b          	sext.w	s1,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4e2a:	bf49                	j	4dbc <fourfiles+0x192>
      printf("wrong length %d\n", total);
    4e2c:	85ca                	mv	a1,s2
    4e2e:	00003517          	auipc	a0,0x3
    4e32:	05250513          	addi	a0,a0,82 # 7e80 <malloc+0x1e6e>
    4e36:	00001097          	auipc	ra,0x1
    4e3a:	11e080e7          	jalr	286(ra) # 5f54 <printf>
      exit(1);
    4e3e:	4505                	li	a0,1
    4e40:	00001097          	auipc	ra,0x1
    4e44:	d94080e7          	jalr	-620(ra) # 5bd4 <exit>
}
    4e48:	70aa                	ld	ra,168(sp)
    4e4a:	740a                	ld	s0,160(sp)
    4e4c:	64ea                	ld	s1,152(sp)
    4e4e:	694a                	ld	s2,144(sp)
    4e50:	69aa                	ld	s3,136(sp)
    4e52:	6a0a                	ld	s4,128(sp)
    4e54:	7ae6                	ld	s5,120(sp)
    4e56:	7b46                	ld	s6,112(sp)
    4e58:	7ba6                	ld	s7,104(sp)
    4e5a:	7c06                	ld	s8,96(sp)
    4e5c:	6ce6                	ld	s9,88(sp)
    4e5e:	6d46                	ld	s10,80(sp)
    4e60:	6da6                	ld	s11,72(sp)
    4e62:	614d                	addi	sp,sp,176
    4e64:	8082                	ret

0000000000004e66 <concreate>:
{
    4e66:	7135                	addi	sp,sp,-160
    4e68:	ed06                	sd	ra,152(sp)
    4e6a:	e922                	sd	s0,144(sp)
    4e6c:	e526                	sd	s1,136(sp)
    4e6e:	e14a                	sd	s2,128(sp)
    4e70:	fcce                	sd	s3,120(sp)
    4e72:	f8d2                	sd	s4,112(sp)
    4e74:	f4d6                	sd	s5,104(sp)
    4e76:	f0da                	sd	s6,96(sp)
    4e78:	ecde                	sd	s7,88(sp)
    4e7a:	1100                	addi	s0,sp,160
    4e7c:	89aa                	mv	s3,a0
  file[0] = 'C';
    4e7e:	04300793          	li	a5,67
    4e82:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    4e86:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    4e8a:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    4e8c:	4b0d                	li	s6,3
    4e8e:	4a85                	li	s5,1
      link("C0", file);
    4e90:	00003b97          	auipc	s7,0x3
    4e94:	008b8b93          	addi	s7,s7,8 # 7e98 <malloc+0x1e86>
  for(i = 0; i < N; i++){
    4e98:	02800a13          	li	s4,40
    4e9c:	acc1                	j	516c <concreate+0x306>
      link("C0", file);
    4e9e:	fa840593          	addi	a1,s0,-88
    4ea2:	855e                	mv	a0,s7
    4ea4:	00001097          	auipc	ra,0x1
    4ea8:	d90080e7          	jalr	-624(ra) # 5c34 <link>
    if(pid == 0) {
    4eac:	a45d                	j	5152 <concreate+0x2ec>
    } else if(pid == 0 && (i % 5) == 1){
    4eae:	4795                	li	a5,5
    4eb0:	02f9693b          	remw	s2,s2,a5
    4eb4:	4785                	li	a5,1
    4eb6:	02f90b63          	beq	s2,a5,4eec <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4eba:	20200593          	li	a1,514
    4ebe:	fa840513          	addi	a0,s0,-88
    4ec2:	00001097          	auipc	ra,0x1
    4ec6:	d52080e7          	jalr	-686(ra) # 5c14 <open>
      if(fd < 0){
    4eca:	26055b63          	bgez	a0,5140 <concreate+0x2da>
        printf("concreate create %s failed\n", file);
    4ece:	fa840593          	addi	a1,s0,-88
    4ed2:	00003517          	auipc	a0,0x3
    4ed6:	fce50513          	addi	a0,a0,-50 # 7ea0 <malloc+0x1e8e>
    4eda:	00001097          	auipc	ra,0x1
    4ede:	07a080e7          	jalr	122(ra) # 5f54 <printf>
        exit(1);
    4ee2:	4505                	li	a0,1
    4ee4:	00001097          	auipc	ra,0x1
    4ee8:	cf0080e7          	jalr	-784(ra) # 5bd4 <exit>
      link("C0", file);
    4eec:	fa840593          	addi	a1,s0,-88
    4ef0:	00003517          	auipc	a0,0x3
    4ef4:	fa850513          	addi	a0,a0,-88 # 7e98 <malloc+0x1e86>
    4ef8:	00001097          	auipc	ra,0x1
    4efc:	d3c080e7          	jalr	-708(ra) # 5c34 <link>
      exit(0);
    4f00:	4501                	li	a0,0
    4f02:	00001097          	auipc	ra,0x1
    4f06:	cd2080e7          	jalr	-814(ra) # 5bd4 <exit>
        exit(1);
    4f0a:	4505                	li	a0,1
    4f0c:	00001097          	auipc	ra,0x1
    4f10:	cc8080e7          	jalr	-824(ra) # 5bd4 <exit>
  memset(fa, 0, sizeof(fa));
    4f14:	02800613          	li	a2,40
    4f18:	4581                	li	a1,0
    4f1a:	f8040513          	addi	a0,s0,-128
    4f1e:	00001097          	auipc	ra,0x1
    4f22:	ab2080e7          	jalr	-1358(ra) # 59d0 <memset>
  fd = open(".", 0);
    4f26:	4581                	li	a1,0
    4f28:	00002517          	auipc	a0,0x2
    4f2c:	91850513          	addi	a0,a0,-1768 # 6840 <malloc+0x82e>
    4f30:	00001097          	auipc	ra,0x1
    4f34:	ce4080e7          	jalr	-796(ra) # 5c14 <open>
    4f38:	892a                	mv	s2,a0
  n = 0;
    4f3a:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f3c:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4f40:	02700b13          	li	s6,39
      fa[i] = 1;
    4f44:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4f46:	a03d                	j	4f74 <concreate+0x10e>
        printf("%s: concreate weird file %s\n", s, de.name);
    4f48:	f7240613          	addi	a2,s0,-142
    4f4c:	85ce                	mv	a1,s3
    4f4e:	00003517          	auipc	a0,0x3
    4f52:	f7250513          	addi	a0,a0,-142 # 7ec0 <malloc+0x1eae>
    4f56:	00001097          	auipc	ra,0x1
    4f5a:	ffe080e7          	jalr	-2(ra) # 5f54 <printf>
        exit(1);
    4f5e:	4505                	li	a0,1
    4f60:	00001097          	auipc	ra,0x1
    4f64:	c74080e7          	jalr	-908(ra) # 5bd4 <exit>
      fa[i] = 1;
    4f68:	fb040793          	addi	a5,s0,-80
    4f6c:	973e                	add	a4,a4,a5
    4f6e:	fd770823          	sb	s7,-48(a4)
      n++;
    4f72:	2a85                	addiw	s5,s5,1
  while(read(fd, &de, sizeof(de)) > 0){
    4f74:	4641                	li	a2,16
    4f76:	f7040593          	addi	a1,s0,-144
    4f7a:	854a                	mv	a0,s2
    4f7c:	00001097          	auipc	ra,0x1
    4f80:	c70080e7          	jalr	-912(ra) # 5bec <read>
    4f84:	04a05a63          	blez	a0,4fd8 <concreate+0x172>
    if(de.inum == 0)
    4f88:	f7045783          	lhu	a5,-144(s0)
    4f8c:	d7e5                	beqz	a5,4f74 <concreate+0x10e>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f8e:	f7244783          	lbu	a5,-142(s0)
    4f92:	ff4791e3          	bne	a5,s4,4f74 <concreate+0x10e>
    4f96:	f7444783          	lbu	a5,-140(s0)
    4f9a:	ffe9                	bnez	a5,4f74 <concreate+0x10e>
      i = de.name[1] - '0';
    4f9c:	f7344783          	lbu	a5,-141(s0)
    4fa0:	fd07879b          	addiw	a5,a5,-48
    4fa4:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    4fa8:	faeb60e3          	bltu	s6,a4,4f48 <concreate+0xe2>
      if(fa[i]){
    4fac:	fb040793          	addi	a5,s0,-80
    4fb0:	97ba                	add	a5,a5,a4
    4fb2:	fd07c783          	lbu	a5,-48(a5)
    4fb6:	dbcd                	beqz	a5,4f68 <concreate+0x102>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4fb8:	f7240613          	addi	a2,s0,-142
    4fbc:	85ce                	mv	a1,s3
    4fbe:	00003517          	auipc	a0,0x3
    4fc2:	f2250513          	addi	a0,a0,-222 # 7ee0 <malloc+0x1ece>
    4fc6:	00001097          	auipc	ra,0x1
    4fca:	f8e080e7          	jalr	-114(ra) # 5f54 <printf>
        exit(1);
    4fce:	4505                	li	a0,1
    4fd0:	00001097          	auipc	ra,0x1
    4fd4:	c04080e7          	jalr	-1020(ra) # 5bd4 <exit>
  close(fd);
    4fd8:	854a                	mv	a0,s2
    4fda:	00001097          	auipc	ra,0x1
    4fde:	c22080e7          	jalr	-990(ra) # 5bfc <close>
  if(n != N){
    4fe2:	02800793          	li	a5,40
    4fe6:	00fa9763          	bne	s5,a5,4ff4 <concreate+0x18e>
    if(((i % 3) == 0 && pid == 0) ||
    4fea:	4a8d                	li	s5,3
    4fec:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4fee:	02800a13          	li	s4,40
    4ff2:	a8c9                	j	50c4 <concreate+0x25e>
    printf("%s: concreate not enough files in directory listing\n", s);
    4ff4:	85ce                	mv	a1,s3
    4ff6:	00003517          	auipc	a0,0x3
    4ffa:	f1250513          	addi	a0,a0,-238 # 7f08 <malloc+0x1ef6>
    4ffe:	00001097          	auipc	ra,0x1
    5002:	f56080e7          	jalr	-170(ra) # 5f54 <printf>
    exit(1);
    5006:	4505                	li	a0,1
    5008:	00001097          	auipc	ra,0x1
    500c:	bcc080e7          	jalr	-1076(ra) # 5bd4 <exit>
      printf("%s: fork failed\n", s);
    5010:	85ce                	mv	a1,s3
    5012:	00002517          	auipc	a0,0x2
    5016:	9ce50513          	addi	a0,a0,-1586 # 69e0 <malloc+0x9ce>
    501a:	00001097          	auipc	ra,0x1
    501e:	f3a080e7          	jalr	-198(ra) # 5f54 <printf>
      exit(1);
    5022:	4505                	li	a0,1
    5024:	00001097          	auipc	ra,0x1
    5028:	bb0080e7          	jalr	-1104(ra) # 5bd4 <exit>
      close(open(file, 0));
    502c:	4581                	li	a1,0
    502e:	fa840513          	addi	a0,s0,-88
    5032:	00001097          	auipc	ra,0x1
    5036:	be2080e7          	jalr	-1054(ra) # 5c14 <open>
    503a:	00001097          	auipc	ra,0x1
    503e:	bc2080e7          	jalr	-1086(ra) # 5bfc <close>
      close(open(file, 0));
    5042:	4581                	li	a1,0
    5044:	fa840513          	addi	a0,s0,-88
    5048:	00001097          	auipc	ra,0x1
    504c:	bcc080e7          	jalr	-1076(ra) # 5c14 <open>
    5050:	00001097          	auipc	ra,0x1
    5054:	bac080e7          	jalr	-1108(ra) # 5bfc <close>
      close(open(file, 0));
    5058:	4581                	li	a1,0
    505a:	fa840513          	addi	a0,s0,-88
    505e:	00001097          	auipc	ra,0x1
    5062:	bb6080e7          	jalr	-1098(ra) # 5c14 <open>
    5066:	00001097          	auipc	ra,0x1
    506a:	b96080e7          	jalr	-1130(ra) # 5bfc <close>
      close(open(file, 0));
    506e:	4581                	li	a1,0
    5070:	fa840513          	addi	a0,s0,-88
    5074:	00001097          	auipc	ra,0x1
    5078:	ba0080e7          	jalr	-1120(ra) # 5c14 <open>
    507c:	00001097          	auipc	ra,0x1
    5080:	b80080e7          	jalr	-1152(ra) # 5bfc <close>
      close(open(file, 0));
    5084:	4581                	li	a1,0
    5086:	fa840513          	addi	a0,s0,-88
    508a:	00001097          	auipc	ra,0x1
    508e:	b8a080e7          	jalr	-1142(ra) # 5c14 <open>
    5092:	00001097          	auipc	ra,0x1
    5096:	b6a080e7          	jalr	-1174(ra) # 5bfc <close>
      close(open(file, 0));
    509a:	4581                	li	a1,0
    509c:	fa840513          	addi	a0,s0,-88
    50a0:	00001097          	auipc	ra,0x1
    50a4:	b74080e7          	jalr	-1164(ra) # 5c14 <open>
    50a8:	00001097          	auipc	ra,0x1
    50ac:	b54080e7          	jalr	-1196(ra) # 5bfc <close>
    if(pid == 0)
    50b0:	08090363          	beqz	s2,5136 <concreate+0x2d0>
      wait(0);
    50b4:	4501                	li	a0,0
    50b6:	00001097          	auipc	ra,0x1
    50ba:	b26080e7          	jalr	-1242(ra) # 5bdc <wait>
  for(i = 0; i < N; i++){
    50be:	2485                	addiw	s1,s1,1
    50c0:	0f448563          	beq	s1,s4,51aa <concreate+0x344>
    file[1] = '0' + i;
    50c4:	0304879b          	addiw	a5,s1,48
    50c8:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    50cc:	00001097          	auipc	ra,0x1
    50d0:	b00080e7          	jalr	-1280(ra) # 5bcc <fork>
    50d4:	892a                	mv	s2,a0
    if(pid < 0){
    50d6:	f2054de3          	bltz	a0,5010 <concreate+0x1aa>
    if(((i % 3) == 0 && pid == 0) ||
    50da:	0354e73b          	remw	a4,s1,s5
    50de:	00a767b3          	or	a5,a4,a0
    50e2:	2781                	sext.w	a5,a5
    50e4:	d7a1                	beqz	a5,502c <concreate+0x1c6>
    50e6:	01671363          	bne	a4,s6,50ec <concreate+0x286>
       ((i % 3) == 1 && pid != 0)){
    50ea:	f129                	bnez	a0,502c <concreate+0x1c6>
      unlink(file);
    50ec:	fa840513          	addi	a0,s0,-88
    50f0:	00001097          	auipc	ra,0x1
    50f4:	b34080e7          	jalr	-1228(ra) # 5c24 <unlink>
      unlink(file);
    50f8:	fa840513          	addi	a0,s0,-88
    50fc:	00001097          	auipc	ra,0x1
    5100:	b28080e7          	jalr	-1240(ra) # 5c24 <unlink>
      unlink(file);
    5104:	fa840513          	addi	a0,s0,-88
    5108:	00001097          	auipc	ra,0x1
    510c:	b1c080e7          	jalr	-1252(ra) # 5c24 <unlink>
      unlink(file);
    5110:	fa840513          	addi	a0,s0,-88
    5114:	00001097          	auipc	ra,0x1
    5118:	b10080e7          	jalr	-1264(ra) # 5c24 <unlink>
      unlink(file);
    511c:	fa840513          	addi	a0,s0,-88
    5120:	00001097          	auipc	ra,0x1
    5124:	b04080e7          	jalr	-1276(ra) # 5c24 <unlink>
      unlink(file);
    5128:	fa840513          	addi	a0,s0,-88
    512c:	00001097          	auipc	ra,0x1
    5130:	af8080e7          	jalr	-1288(ra) # 5c24 <unlink>
    5134:	bfb5                	j	50b0 <concreate+0x24a>
      exit(0);
    5136:	4501                	li	a0,0
    5138:	00001097          	auipc	ra,0x1
    513c:	a9c080e7          	jalr	-1380(ra) # 5bd4 <exit>
      close(fd);
    5140:	00001097          	auipc	ra,0x1
    5144:	abc080e7          	jalr	-1348(ra) # 5bfc <close>
    if(pid == 0) {
    5148:	bb65                	j	4f00 <concreate+0x9a>
      close(fd);
    514a:	00001097          	auipc	ra,0x1
    514e:	ab2080e7          	jalr	-1358(ra) # 5bfc <close>
      wait(&xstatus);
    5152:	f6c40513          	addi	a0,s0,-148
    5156:	00001097          	auipc	ra,0x1
    515a:	a86080e7          	jalr	-1402(ra) # 5bdc <wait>
      if(xstatus != 0)
    515e:	f6c42483          	lw	s1,-148(s0)
    5162:	da0494e3          	bnez	s1,4f0a <concreate+0xa4>
  for(i = 0; i < N; i++){
    5166:	2905                	addiw	s2,s2,1
    5168:	db4906e3          	beq	s2,s4,4f14 <concreate+0xae>
    file[1] = '0' + i;
    516c:	0309079b          	addiw	a5,s2,48
    5170:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    5174:	fa840513          	addi	a0,s0,-88
    5178:	00001097          	auipc	ra,0x1
    517c:	aac080e7          	jalr	-1364(ra) # 5c24 <unlink>
    pid = fork();
    5180:	00001097          	auipc	ra,0x1
    5184:	a4c080e7          	jalr	-1460(ra) # 5bcc <fork>
    if(pid && (i % 3) == 1){
    5188:	d20503e3          	beqz	a0,4eae <concreate+0x48>
    518c:	036967bb          	remw	a5,s2,s6
    5190:	d15787e3          	beq	a5,s5,4e9e <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    5194:	20200593          	li	a1,514
    5198:	fa840513          	addi	a0,s0,-88
    519c:	00001097          	auipc	ra,0x1
    51a0:	a78080e7          	jalr	-1416(ra) # 5c14 <open>
      if(fd < 0){
    51a4:	fa0553e3          	bgez	a0,514a <concreate+0x2e4>
    51a8:	b31d                	j	4ece <concreate+0x68>
}
    51aa:	60ea                	ld	ra,152(sp)
    51ac:	644a                	ld	s0,144(sp)
    51ae:	64aa                	ld	s1,136(sp)
    51b0:	690a                	ld	s2,128(sp)
    51b2:	79e6                	ld	s3,120(sp)
    51b4:	7a46                	ld	s4,112(sp)
    51b6:	7aa6                	ld	s5,104(sp)
    51b8:	7b06                	ld	s6,96(sp)
    51ba:	6be6                	ld	s7,88(sp)
    51bc:	610d                	addi	sp,sp,160
    51be:	8082                	ret

00000000000051c0 <bigfile>:
{
    51c0:	7139                	addi	sp,sp,-64
    51c2:	fc06                	sd	ra,56(sp)
    51c4:	f822                	sd	s0,48(sp)
    51c6:	f426                	sd	s1,40(sp)
    51c8:	f04a                	sd	s2,32(sp)
    51ca:	ec4e                	sd	s3,24(sp)
    51cc:	e852                	sd	s4,16(sp)
    51ce:	e456                	sd	s5,8(sp)
    51d0:	0080                	addi	s0,sp,64
    51d2:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    51d4:	00003517          	auipc	a0,0x3
    51d8:	d6c50513          	addi	a0,a0,-660 # 7f40 <malloc+0x1f2e>
    51dc:	00001097          	auipc	ra,0x1
    51e0:	a48080e7          	jalr	-1464(ra) # 5c24 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    51e4:	20200593          	li	a1,514
    51e8:	00003517          	auipc	a0,0x3
    51ec:	d5850513          	addi	a0,a0,-680 # 7f40 <malloc+0x1f2e>
    51f0:	00001097          	auipc	ra,0x1
    51f4:	a24080e7          	jalr	-1500(ra) # 5c14 <open>
    51f8:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    51fa:	4481                	li	s1,0
    memset(buf, i, SZ);
    51fc:	00008917          	auipc	s2,0x8
    5200:	a7c90913          	addi	s2,s2,-1412 # cc78 <buf>
  for(i = 0; i < N; i++){
    5204:	4a51                	li	s4,20
  if(fd < 0){
    5206:	0a054063          	bltz	a0,52a6 <bigfile+0xe6>
    memset(buf, i, SZ);
    520a:	25800613          	li	a2,600
    520e:	85a6                	mv	a1,s1
    5210:	854a                	mv	a0,s2
    5212:	00000097          	auipc	ra,0x0
    5216:	7be080e7          	jalr	1982(ra) # 59d0 <memset>
    if(write(fd, buf, SZ) != SZ){
    521a:	25800613          	li	a2,600
    521e:	85ca                	mv	a1,s2
    5220:	854e                	mv	a0,s3
    5222:	00001097          	auipc	ra,0x1
    5226:	9d2080e7          	jalr	-1582(ra) # 5bf4 <write>
    522a:	25800793          	li	a5,600
    522e:	08f51a63          	bne	a0,a5,52c2 <bigfile+0x102>
  for(i = 0; i < N; i++){
    5232:	2485                	addiw	s1,s1,1
    5234:	fd449be3          	bne	s1,s4,520a <bigfile+0x4a>
  close(fd);
    5238:	854e                	mv	a0,s3
    523a:	00001097          	auipc	ra,0x1
    523e:	9c2080e7          	jalr	-1598(ra) # 5bfc <close>
  fd = open("bigfile.dat", 0);
    5242:	4581                	li	a1,0
    5244:	00003517          	auipc	a0,0x3
    5248:	cfc50513          	addi	a0,a0,-772 # 7f40 <malloc+0x1f2e>
    524c:	00001097          	auipc	ra,0x1
    5250:	9c8080e7          	jalr	-1592(ra) # 5c14 <open>
    5254:	8a2a                	mv	s4,a0
  total = 0;
    5256:	4981                	li	s3,0
  for(i = 0; ; i++){
    5258:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    525a:	00008917          	auipc	s2,0x8
    525e:	a1e90913          	addi	s2,s2,-1506 # cc78 <buf>
  if(fd < 0){
    5262:	06054e63          	bltz	a0,52de <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    5266:	12c00613          	li	a2,300
    526a:	85ca                	mv	a1,s2
    526c:	8552                	mv	a0,s4
    526e:	00001097          	auipc	ra,0x1
    5272:	97e080e7          	jalr	-1666(ra) # 5bec <read>
    if(cc < 0){
    5276:	08054263          	bltz	a0,52fa <bigfile+0x13a>
    if(cc == 0)
    527a:	c971                	beqz	a0,534e <bigfile+0x18e>
    if(cc != SZ/2){
    527c:	12c00793          	li	a5,300
    5280:	08f51b63          	bne	a0,a5,5316 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    5284:	01f4d79b          	srliw	a5,s1,0x1f
    5288:	9fa5                	addw	a5,a5,s1
    528a:	4017d79b          	sraiw	a5,a5,0x1
    528e:	00094703          	lbu	a4,0(s2)
    5292:	0af71063          	bne	a4,a5,5332 <bigfile+0x172>
    5296:	12b94703          	lbu	a4,299(s2)
    529a:	08f71c63          	bne	a4,a5,5332 <bigfile+0x172>
    total += cc;
    529e:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    52a2:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    52a4:	b7c9                	j	5266 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    52a6:	85d6                	mv	a1,s5
    52a8:	00003517          	auipc	a0,0x3
    52ac:	ca850513          	addi	a0,a0,-856 # 7f50 <malloc+0x1f3e>
    52b0:	00001097          	auipc	ra,0x1
    52b4:	ca4080e7          	jalr	-860(ra) # 5f54 <printf>
    exit(1);
    52b8:	4505                	li	a0,1
    52ba:	00001097          	auipc	ra,0x1
    52be:	91a080e7          	jalr	-1766(ra) # 5bd4 <exit>
      printf("%s: write bigfile failed\n", s);
    52c2:	85d6                	mv	a1,s5
    52c4:	00003517          	auipc	a0,0x3
    52c8:	cac50513          	addi	a0,a0,-852 # 7f70 <malloc+0x1f5e>
    52cc:	00001097          	auipc	ra,0x1
    52d0:	c88080e7          	jalr	-888(ra) # 5f54 <printf>
      exit(1);
    52d4:	4505                	li	a0,1
    52d6:	00001097          	auipc	ra,0x1
    52da:	8fe080e7          	jalr	-1794(ra) # 5bd4 <exit>
    printf("%s: cannot open bigfile\n", s);
    52de:	85d6                	mv	a1,s5
    52e0:	00003517          	auipc	a0,0x3
    52e4:	cb050513          	addi	a0,a0,-848 # 7f90 <malloc+0x1f7e>
    52e8:	00001097          	auipc	ra,0x1
    52ec:	c6c080e7          	jalr	-916(ra) # 5f54 <printf>
    exit(1);
    52f0:	4505                	li	a0,1
    52f2:	00001097          	auipc	ra,0x1
    52f6:	8e2080e7          	jalr	-1822(ra) # 5bd4 <exit>
      printf("%s: read bigfile failed\n", s);
    52fa:	85d6                	mv	a1,s5
    52fc:	00003517          	auipc	a0,0x3
    5300:	cb450513          	addi	a0,a0,-844 # 7fb0 <malloc+0x1f9e>
    5304:	00001097          	auipc	ra,0x1
    5308:	c50080e7          	jalr	-944(ra) # 5f54 <printf>
      exit(1);
    530c:	4505                	li	a0,1
    530e:	00001097          	auipc	ra,0x1
    5312:	8c6080e7          	jalr	-1850(ra) # 5bd4 <exit>
      printf("%s: short read bigfile\n", s);
    5316:	85d6                	mv	a1,s5
    5318:	00003517          	auipc	a0,0x3
    531c:	cb850513          	addi	a0,a0,-840 # 7fd0 <malloc+0x1fbe>
    5320:	00001097          	auipc	ra,0x1
    5324:	c34080e7          	jalr	-972(ra) # 5f54 <printf>
      exit(1);
    5328:	4505                	li	a0,1
    532a:	00001097          	auipc	ra,0x1
    532e:	8aa080e7          	jalr	-1878(ra) # 5bd4 <exit>
      printf("%s: read bigfile wrong data\n", s);
    5332:	85d6                	mv	a1,s5
    5334:	00003517          	auipc	a0,0x3
    5338:	cb450513          	addi	a0,a0,-844 # 7fe8 <malloc+0x1fd6>
    533c:	00001097          	auipc	ra,0x1
    5340:	c18080e7          	jalr	-1000(ra) # 5f54 <printf>
      exit(1);
    5344:	4505                	li	a0,1
    5346:	00001097          	auipc	ra,0x1
    534a:	88e080e7          	jalr	-1906(ra) # 5bd4 <exit>
  close(fd);
    534e:	8552                	mv	a0,s4
    5350:	00001097          	auipc	ra,0x1
    5354:	8ac080e7          	jalr	-1876(ra) # 5bfc <close>
  if(total != N*SZ){
    5358:	678d                	lui	a5,0x3
    535a:	ee078793          	addi	a5,a5,-288 # 2ee0 <sbrklast+0x84>
    535e:	02f99363          	bne	s3,a5,5384 <bigfile+0x1c4>
  unlink("bigfile.dat");
    5362:	00003517          	auipc	a0,0x3
    5366:	bde50513          	addi	a0,a0,-1058 # 7f40 <malloc+0x1f2e>
    536a:	00001097          	auipc	ra,0x1
    536e:	8ba080e7          	jalr	-1862(ra) # 5c24 <unlink>
}
    5372:	70e2                	ld	ra,56(sp)
    5374:	7442                	ld	s0,48(sp)
    5376:	74a2                	ld	s1,40(sp)
    5378:	7902                	ld	s2,32(sp)
    537a:	69e2                	ld	s3,24(sp)
    537c:	6a42                	ld	s4,16(sp)
    537e:	6aa2                	ld	s5,8(sp)
    5380:	6121                	addi	sp,sp,64
    5382:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    5384:	85d6                	mv	a1,s5
    5386:	00003517          	auipc	a0,0x3
    538a:	c8250513          	addi	a0,a0,-894 # 8008 <malloc+0x1ff6>
    538e:	00001097          	auipc	ra,0x1
    5392:	bc6080e7          	jalr	-1082(ra) # 5f54 <printf>
    exit(1);
    5396:	4505                	li	a0,1
    5398:	00001097          	auipc	ra,0x1
    539c:	83c080e7          	jalr	-1988(ra) # 5bd4 <exit>

00000000000053a0 <fsfull>:
{
    53a0:	7171                	addi	sp,sp,-176
    53a2:	f506                	sd	ra,168(sp)
    53a4:	f122                	sd	s0,160(sp)
    53a6:	ed26                	sd	s1,152(sp)
    53a8:	e94a                	sd	s2,144(sp)
    53aa:	e54e                	sd	s3,136(sp)
    53ac:	e152                	sd	s4,128(sp)
    53ae:	fcd6                	sd	s5,120(sp)
    53b0:	f8da                	sd	s6,112(sp)
    53b2:	f4de                	sd	s7,104(sp)
    53b4:	f0e2                	sd	s8,96(sp)
    53b6:	ece6                	sd	s9,88(sp)
    53b8:	e8ea                	sd	s10,80(sp)
    53ba:	e4ee                	sd	s11,72(sp)
    53bc:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    53be:	00003517          	auipc	a0,0x3
    53c2:	c6a50513          	addi	a0,a0,-918 # 8028 <malloc+0x2016>
    53c6:	00001097          	auipc	ra,0x1
    53ca:	b8e080e7          	jalr	-1138(ra) # 5f54 <printf>
  for(nfiles = 0; ; nfiles++){
    53ce:	4481                	li	s1,0
    name[0] = 'f';
    53d0:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    53d4:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    53d8:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    53dc:	4b29                	li	s6,10
    printf("writing %s\n", name);
    53de:	00003c97          	auipc	s9,0x3
    53e2:	c5ac8c93          	addi	s9,s9,-934 # 8038 <malloc+0x2026>
    int total = 0;
    53e6:	4d81                	li	s11,0
      int cc = write(fd, buf, BSIZE);
    53e8:	00008a17          	auipc	s4,0x8
    53ec:	890a0a13          	addi	s4,s4,-1904 # cc78 <buf>
    name[0] = 'f';
    53f0:	f5a40823          	sb	s10,-176(s0)
    name[1] = '0' + nfiles / 1000;
    53f4:	0384c7bb          	divw	a5,s1,s8
    53f8:	0307879b          	addiw	a5,a5,48
    53fc:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5400:	0384e7bb          	remw	a5,s1,s8
    5404:	0377c7bb          	divw	a5,a5,s7
    5408:	0307879b          	addiw	a5,a5,48
    540c:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5410:	0374e7bb          	remw	a5,s1,s7
    5414:	0367c7bb          	divw	a5,a5,s6
    5418:	0307879b          	addiw	a5,a5,48
    541c:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    5420:	0364e7bb          	remw	a5,s1,s6
    5424:	0307879b          	addiw	a5,a5,48
    5428:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    542c:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    5430:	f5040593          	addi	a1,s0,-176
    5434:	8566                	mv	a0,s9
    5436:	00001097          	auipc	ra,0x1
    543a:	b1e080e7          	jalr	-1250(ra) # 5f54 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    543e:	20200593          	li	a1,514
    5442:	f5040513          	addi	a0,s0,-176
    5446:	00000097          	auipc	ra,0x0
    544a:	7ce080e7          	jalr	1998(ra) # 5c14 <open>
    544e:	892a                	mv	s2,a0
    if(fd < 0){
    5450:	0a055663          	bgez	a0,54fc <fsfull+0x15c>
      printf("open %s failed\n", name);
    5454:	f5040593          	addi	a1,s0,-176
    5458:	00003517          	auipc	a0,0x3
    545c:	bf050513          	addi	a0,a0,-1040 # 8048 <malloc+0x2036>
    5460:	00001097          	auipc	ra,0x1
    5464:	af4080e7          	jalr	-1292(ra) # 5f54 <printf>
  while(nfiles >= 0){
    5468:	0604c363          	bltz	s1,54ce <fsfull+0x12e>
    name[0] = 'f';
    546c:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    5470:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    5474:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    5478:	4929                	li	s2,10
  while(nfiles >= 0){
    547a:	5afd                	li	s5,-1
    name[0] = 'f';
    547c:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    5480:	0344c7bb          	divw	a5,s1,s4
    5484:	0307879b          	addiw	a5,a5,48
    5488:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    548c:	0344e7bb          	remw	a5,s1,s4
    5490:	0337c7bb          	divw	a5,a5,s3
    5494:	0307879b          	addiw	a5,a5,48
    5498:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    549c:	0334e7bb          	remw	a5,s1,s3
    54a0:	0327c7bb          	divw	a5,a5,s2
    54a4:	0307879b          	addiw	a5,a5,48
    54a8:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    54ac:	0324e7bb          	remw	a5,s1,s2
    54b0:	0307879b          	addiw	a5,a5,48
    54b4:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    54b8:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    54bc:	f5040513          	addi	a0,s0,-176
    54c0:	00000097          	auipc	ra,0x0
    54c4:	764080e7          	jalr	1892(ra) # 5c24 <unlink>
    nfiles--;
    54c8:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    54ca:	fb5499e3          	bne	s1,s5,547c <fsfull+0xdc>
  printf("fsfull test finished\n");
    54ce:	00003517          	auipc	a0,0x3
    54d2:	b9a50513          	addi	a0,a0,-1126 # 8068 <malloc+0x2056>
    54d6:	00001097          	auipc	ra,0x1
    54da:	a7e080e7          	jalr	-1410(ra) # 5f54 <printf>
}
    54de:	70aa                	ld	ra,168(sp)
    54e0:	740a                	ld	s0,160(sp)
    54e2:	64ea                	ld	s1,152(sp)
    54e4:	694a                	ld	s2,144(sp)
    54e6:	69aa                	ld	s3,136(sp)
    54e8:	6a0a                	ld	s4,128(sp)
    54ea:	7ae6                	ld	s5,120(sp)
    54ec:	7b46                	ld	s6,112(sp)
    54ee:	7ba6                	ld	s7,104(sp)
    54f0:	7c06                	ld	s8,96(sp)
    54f2:	6ce6                	ld	s9,88(sp)
    54f4:	6d46                	ld	s10,80(sp)
    54f6:	6da6                	ld	s11,72(sp)
    54f8:	614d                	addi	sp,sp,176
    54fa:	8082                	ret
    int total = 0;
    54fc:	89ee                	mv	s3,s11
      if(cc < BSIZE)
    54fe:	3ff00a93          	li	s5,1023
      int cc = write(fd, buf, BSIZE);
    5502:	40000613          	li	a2,1024
    5506:	85d2                	mv	a1,s4
    5508:	854a                	mv	a0,s2
    550a:	00000097          	auipc	ra,0x0
    550e:	6ea080e7          	jalr	1770(ra) # 5bf4 <write>
      if(cc < BSIZE)
    5512:	00aad563          	bge	s5,a0,551c <fsfull+0x17c>
      total += cc;
    5516:	00a989bb          	addw	s3,s3,a0
    while(1){
    551a:	b7e5                	j	5502 <fsfull+0x162>
    printf("wrote %d bytes\n", total);
    551c:	85ce                	mv	a1,s3
    551e:	00003517          	auipc	a0,0x3
    5522:	b3a50513          	addi	a0,a0,-1222 # 8058 <malloc+0x2046>
    5526:	00001097          	auipc	ra,0x1
    552a:	a2e080e7          	jalr	-1490(ra) # 5f54 <printf>
    close(fd);
    552e:	854a                	mv	a0,s2
    5530:	00000097          	auipc	ra,0x0
    5534:	6cc080e7          	jalr	1740(ra) # 5bfc <close>
    if(total == 0)
    5538:	f20988e3          	beqz	s3,5468 <fsfull+0xc8>
  for(nfiles = 0; ; nfiles++){
    553c:	2485                	addiw	s1,s1,1
    553e:	bd4d                	j	53f0 <fsfull+0x50>

0000000000005540 <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    5540:	7179                	addi	sp,sp,-48
    5542:	f406                	sd	ra,40(sp)
    5544:	f022                	sd	s0,32(sp)
    5546:	ec26                	sd	s1,24(sp)
    5548:	e84a                	sd	s2,16(sp)
    554a:	1800                	addi	s0,sp,48
    554c:	84aa                	mv	s1,a0
    554e:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5550:	00003517          	auipc	a0,0x3
    5554:	b3050513          	addi	a0,a0,-1232 # 8080 <malloc+0x206e>
    5558:	00001097          	auipc	ra,0x1
    555c:	9fc080e7          	jalr	-1540(ra) # 5f54 <printf>
  if((pid = fork()) < 0) {
    5560:	00000097          	auipc	ra,0x0
    5564:	66c080e7          	jalr	1644(ra) # 5bcc <fork>
    5568:	02054e63          	bltz	a0,55a4 <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    556c:	c929                	beqz	a0,55be <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    556e:	fdc40513          	addi	a0,s0,-36
    5572:	00000097          	auipc	ra,0x0
    5576:	66a080e7          	jalr	1642(ra) # 5bdc <wait>
    if(xstatus != 0) 
    557a:	fdc42783          	lw	a5,-36(s0)
    557e:	c7b9                	beqz	a5,55cc <run+0x8c>
      printf("FAILED\n");
    5580:	00003517          	auipc	a0,0x3
    5584:	b2850513          	addi	a0,a0,-1240 # 80a8 <malloc+0x2096>
    5588:	00001097          	auipc	ra,0x1
    558c:	9cc080e7          	jalr	-1588(ra) # 5f54 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    5590:	fdc42503          	lw	a0,-36(s0)
  }
}
    5594:	00153513          	seqz	a0,a0
    5598:	70a2                	ld	ra,40(sp)
    559a:	7402                	ld	s0,32(sp)
    559c:	64e2                	ld	s1,24(sp)
    559e:	6942                	ld	s2,16(sp)
    55a0:	6145                	addi	sp,sp,48
    55a2:	8082                	ret
    printf("runtest: fork error\n");
    55a4:	00003517          	auipc	a0,0x3
    55a8:	aec50513          	addi	a0,a0,-1300 # 8090 <malloc+0x207e>
    55ac:	00001097          	auipc	ra,0x1
    55b0:	9a8080e7          	jalr	-1624(ra) # 5f54 <printf>
    exit(1);
    55b4:	4505                	li	a0,1
    55b6:	00000097          	auipc	ra,0x0
    55ba:	61e080e7          	jalr	1566(ra) # 5bd4 <exit>
    f(s);
    55be:	854a                	mv	a0,s2
    55c0:	9482                	jalr	s1
    exit(0);
    55c2:	4501                	li	a0,0
    55c4:	00000097          	auipc	ra,0x0
    55c8:	610080e7          	jalr	1552(ra) # 5bd4 <exit>
      printf("OK\n");
    55cc:	00003517          	auipc	a0,0x3
    55d0:	ae450513          	addi	a0,a0,-1308 # 80b0 <malloc+0x209e>
    55d4:	00001097          	auipc	ra,0x1
    55d8:	980080e7          	jalr	-1664(ra) # 5f54 <printf>
    55dc:	bf55                	j	5590 <run+0x50>

00000000000055de <runtests>:

int
runtests(struct test *tests, char *justone) {
    55de:	1101                	addi	sp,sp,-32
    55e0:	ec06                	sd	ra,24(sp)
    55e2:	e822                	sd	s0,16(sp)
    55e4:	e426                	sd	s1,8(sp)
    55e6:	e04a                	sd	s2,0(sp)
    55e8:	1000                	addi	s0,sp,32
    55ea:	84aa                	mv	s1,a0
    55ec:	892e                	mv	s2,a1
  for (struct test *t = tests; t->s != 0; t++) {
    55ee:	6508                	ld	a0,8(a0)
    55f0:	ed09                	bnez	a0,560a <runtests+0x2c>
        printf("SOME TESTS FAILED\n");
        return 1;
      }
    }
  }
  return 0;
    55f2:	4501                	li	a0,0
    55f4:	a82d                	j	562e <runtests+0x50>
      if(!run(t->f, t->s)){
    55f6:	648c                	ld	a1,8(s1)
    55f8:	6088                	ld	a0,0(s1)
    55fa:	00000097          	auipc	ra,0x0
    55fe:	f46080e7          	jalr	-186(ra) # 5540 <run>
    5602:	cd09                	beqz	a0,561c <runtests+0x3e>
  for (struct test *t = tests; t->s != 0; t++) {
    5604:	04c1                	addi	s1,s1,16
    5606:	6488                	ld	a0,8(s1)
    5608:	c11d                	beqz	a0,562e <runtests+0x50>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    560a:	fe0906e3          	beqz	s2,55f6 <runtests+0x18>
    560e:	85ca                	mv	a1,s2
    5610:	00000097          	auipc	ra,0x0
    5614:	36a080e7          	jalr	874(ra) # 597a <strcmp>
    5618:	f575                	bnez	a0,5604 <runtests+0x26>
    561a:	bff1                	j	55f6 <runtests+0x18>
        printf("SOME TESTS FAILED\n");
    561c:	00003517          	auipc	a0,0x3
    5620:	a9c50513          	addi	a0,a0,-1380 # 80b8 <malloc+0x20a6>
    5624:	00001097          	auipc	ra,0x1
    5628:	930080e7          	jalr	-1744(ra) # 5f54 <printf>
        return 1;
    562c:	4505                	li	a0,1
}
    562e:	60e2                	ld	ra,24(sp)
    5630:	6442                	ld	s0,16(sp)
    5632:	64a2                	ld	s1,8(sp)
    5634:	6902                	ld	s2,0(sp)
    5636:	6105                	addi	sp,sp,32
    5638:	8082                	ret

000000000000563a <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    563a:	7139                	addi	sp,sp,-64
    563c:	fc06                	sd	ra,56(sp)
    563e:	f822                	sd	s0,48(sp)
    5640:	f426                	sd	s1,40(sp)
    5642:	f04a                	sd	s2,32(sp)
    5644:	ec4e                	sd	s3,24(sp)
    5646:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    5648:	fc840513          	addi	a0,s0,-56
    564c:	00000097          	auipc	ra,0x0
    5650:	598080e7          	jalr	1432(ra) # 5be4 <pipe>
    5654:	06054863          	bltz	a0,56c4 <countfree+0x8a>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    5658:	00000097          	auipc	ra,0x0
    565c:	574080e7          	jalr	1396(ra) # 5bcc <fork>

  if(pid < 0){
    5660:	06054f63          	bltz	a0,56de <countfree+0xa4>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    5664:	ed59                	bnez	a0,5702 <countfree+0xc8>
    close(fds[0]);
    5666:	fc842503          	lw	a0,-56(s0)
    566a:	00000097          	auipc	ra,0x0
    566e:	592080e7          	jalr	1426(ra) # 5bfc <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    5672:	54fd                	li	s1,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    5674:	4985                	li	s3,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    5676:	00001917          	auipc	s2,0x1
    567a:	b5290913          	addi	s2,s2,-1198 # 61c8 <malloc+0x1b6>
      uint64 a = (uint64) sbrk(4096);
    567e:	6505                	lui	a0,0x1
    5680:	00000097          	auipc	ra,0x0
    5684:	5dc080e7          	jalr	1500(ra) # 5c5c <sbrk>
      if(a == 0xffffffffffffffff){
    5688:	06950863          	beq	a0,s1,56f8 <countfree+0xbe>
      *(char *)(a + 4096 - 1) = 1;
    568c:	6785                	lui	a5,0x1
    568e:	953e                	add	a0,a0,a5
    5690:	ff350fa3          	sb	s3,-1(a0) # fff <linktest+0x107>
      if(write(fds[1], "x", 1) != 1){
    5694:	4605                	li	a2,1
    5696:	85ca                	mv	a1,s2
    5698:	fcc42503          	lw	a0,-52(s0)
    569c:	00000097          	auipc	ra,0x0
    56a0:	558080e7          	jalr	1368(ra) # 5bf4 <write>
    56a4:	4785                	li	a5,1
    56a6:	fcf50ce3          	beq	a0,a5,567e <countfree+0x44>
        printf("write() failed in countfree()\n");
    56aa:	00003517          	auipc	a0,0x3
    56ae:	a6650513          	addi	a0,a0,-1434 # 8110 <malloc+0x20fe>
    56b2:	00001097          	auipc	ra,0x1
    56b6:	8a2080e7          	jalr	-1886(ra) # 5f54 <printf>
        exit(1);
    56ba:	4505                	li	a0,1
    56bc:	00000097          	auipc	ra,0x0
    56c0:	518080e7          	jalr	1304(ra) # 5bd4 <exit>
    printf("pipe() failed in countfree()\n");
    56c4:	00003517          	auipc	a0,0x3
    56c8:	a0c50513          	addi	a0,a0,-1524 # 80d0 <malloc+0x20be>
    56cc:	00001097          	auipc	ra,0x1
    56d0:	888080e7          	jalr	-1912(ra) # 5f54 <printf>
    exit(1);
    56d4:	4505                	li	a0,1
    56d6:	00000097          	auipc	ra,0x0
    56da:	4fe080e7          	jalr	1278(ra) # 5bd4 <exit>
    printf("fork failed in countfree()\n");
    56de:	00003517          	auipc	a0,0x3
    56e2:	a1250513          	addi	a0,a0,-1518 # 80f0 <malloc+0x20de>
    56e6:	00001097          	auipc	ra,0x1
    56ea:	86e080e7          	jalr	-1938(ra) # 5f54 <printf>
    exit(1);
    56ee:	4505                	li	a0,1
    56f0:	00000097          	auipc	ra,0x0
    56f4:	4e4080e7          	jalr	1252(ra) # 5bd4 <exit>
      }
    }

    exit(0);
    56f8:	4501                	li	a0,0
    56fa:	00000097          	auipc	ra,0x0
    56fe:	4da080e7          	jalr	1242(ra) # 5bd4 <exit>
  }

  close(fds[1]);
    5702:	fcc42503          	lw	a0,-52(s0)
    5706:	00000097          	auipc	ra,0x0
    570a:	4f6080e7          	jalr	1270(ra) # 5bfc <close>

  int n = 0;
    570e:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    5710:	4605                	li	a2,1
    5712:	fc740593          	addi	a1,s0,-57
    5716:	fc842503          	lw	a0,-56(s0)
    571a:	00000097          	auipc	ra,0x0
    571e:	4d2080e7          	jalr	1234(ra) # 5bec <read>
    if(cc < 0){
    5722:	00054563          	bltz	a0,572c <countfree+0xf2>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    5726:	c105                	beqz	a0,5746 <countfree+0x10c>
      break;
    n += 1;
    5728:	2485                	addiw	s1,s1,1
  while(1){
    572a:	b7dd                	j	5710 <countfree+0xd6>
      printf("read() failed in countfree()\n");
    572c:	00003517          	auipc	a0,0x3
    5730:	a0450513          	addi	a0,a0,-1532 # 8130 <malloc+0x211e>
    5734:	00001097          	auipc	ra,0x1
    5738:	820080e7          	jalr	-2016(ra) # 5f54 <printf>
      exit(1);
    573c:	4505                	li	a0,1
    573e:	00000097          	auipc	ra,0x0
    5742:	496080e7          	jalr	1174(ra) # 5bd4 <exit>
  }

  close(fds[0]);
    5746:	fc842503          	lw	a0,-56(s0)
    574a:	00000097          	auipc	ra,0x0
    574e:	4b2080e7          	jalr	1202(ra) # 5bfc <close>
  wait((int*)0);
    5752:	4501                	li	a0,0
    5754:	00000097          	auipc	ra,0x0
    5758:	488080e7          	jalr	1160(ra) # 5bdc <wait>
  
  return n;
}
    575c:	8526                	mv	a0,s1
    575e:	70e2                	ld	ra,56(sp)
    5760:	7442                	ld	s0,48(sp)
    5762:	74a2                	ld	s1,40(sp)
    5764:	7902                	ld	s2,32(sp)
    5766:	69e2                	ld	s3,24(sp)
    5768:	6121                	addi	sp,sp,64
    576a:	8082                	ret

000000000000576c <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    576c:	711d                	addi	sp,sp,-96
    576e:	ec86                	sd	ra,88(sp)
    5770:	e8a2                	sd	s0,80(sp)
    5772:	e4a6                	sd	s1,72(sp)
    5774:	e0ca                	sd	s2,64(sp)
    5776:	fc4e                	sd	s3,56(sp)
    5778:	f852                	sd	s4,48(sp)
    577a:	f456                	sd	s5,40(sp)
    577c:	f05a                	sd	s6,32(sp)
    577e:	ec5e                	sd	s7,24(sp)
    5780:	e862                	sd	s8,16(sp)
    5782:	e466                	sd	s9,8(sp)
    5784:	e06a                	sd	s10,0(sp)
    5786:	1080                	addi	s0,sp,96
    5788:	8a2a                	mv	s4,a0
    578a:	89ae                	mv	s3,a1
    578c:	8932                	mv	s2,a2
  do {
    printf("usertests starting\n");
    578e:	00003b97          	auipc	s7,0x3
    5792:	9c2b8b93          	addi	s7,s7,-1598 # 8150 <malloc+0x213e>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone)) {
    5796:	00004b17          	auipc	s6,0x4
    579a:	87ab0b13          	addi	s6,s6,-1926 # 9010 <quicktests>
      if(continuous != 2) {
    579e:	4a89                	li	s5,2
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    57a0:	00003c97          	auipc	s9,0x3
    57a4:	9e8c8c93          	addi	s9,s9,-1560 # 8188 <malloc+0x2176>
      if (runtests(slowtests, justone)) {
    57a8:	00004c17          	auipc	s8,0x4
    57ac:	c38c0c13          	addi	s8,s8,-968 # 93e0 <slowtests>
        printf("usertests slow tests starting\n");
    57b0:	00003d17          	auipc	s10,0x3
    57b4:	9b8d0d13          	addi	s10,s10,-1608 # 8168 <malloc+0x2156>
    57b8:	a839                	j	57d6 <drivetests+0x6a>
    57ba:	856a                	mv	a0,s10
    57bc:	00000097          	auipc	ra,0x0
    57c0:	798080e7          	jalr	1944(ra) # 5f54 <printf>
    57c4:	a081                	j	5804 <drivetests+0x98>
    if((free1 = countfree()) < free0) {
    57c6:	00000097          	auipc	ra,0x0
    57ca:	e74080e7          	jalr	-396(ra) # 563a <countfree>
    57ce:	06954263          	blt	a0,s1,5832 <drivetests+0xc6>
      if(continuous != 2) {
        return 1;
      }
    }
  } while(continuous);
    57d2:	06098f63          	beqz	s3,5850 <drivetests+0xe4>
    printf("usertests starting\n");
    57d6:	855e                	mv	a0,s7
    57d8:	00000097          	auipc	ra,0x0
    57dc:	77c080e7          	jalr	1916(ra) # 5f54 <printf>
    int free0 = countfree();
    57e0:	00000097          	auipc	ra,0x0
    57e4:	e5a080e7          	jalr	-422(ra) # 563a <countfree>
    57e8:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone)) {
    57ea:	85ca                	mv	a1,s2
    57ec:	855a                	mv	a0,s6
    57ee:	00000097          	auipc	ra,0x0
    57f2:	df0080e7          	jalr	-528(ra) # 55de <runtests>
    57f6:	c119                	beqz	a0,57fc <drivetests+0x90>
      if(continuous != 2) {
    57f8:	05599863          	bne	s3,s5,5848 <drivetests+0xdc>
    if(!quick) {
    57fc:	fc0a15e3          	bnez	s4,57c6 <drivetests+0x5a>
      if (justone == 0)
    5800:	fa090de3          	beqz	s2,57ba <drivetests+0x4e>
      if (runtests(slowtests, justone)) {
    5804:	85ca                	mv	a1,s2
    5806:	8562                	mv	a0,s8
    5808:	00000097          	auipc	ra,0x0
    580c:	dd6080e7          	jalr	-554(ra) # 55de <runtests>
    5810:	d95d                	beqz	a0,57c6 <drivetests+0x5a>
        if(continuous != 2) {
    5812:	03599d63          	bne	s3,s5,584c <drivetests+0xe0>
    if((free1 = countfree()) < free0) {
    5816:	00000097          	auipc	ra,0x0
    581a:	e24080e7          	jalr	-476(ra) # 563a <countfree>
    581e:	fa955ae3          	bge	a0,s1,57d2 <drivetests+0x66>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5822:	8626                	mv	a2,s1
    5824:	85aa                	mv	a1,a0
    5826:	8566                	mv	a0,s9
    5828:	00000097          	auipc	ra,0x0
    582c:	72c080e7          	jalr	1836(ra) # 5f54 <printf>
      if(continuous != 2) {
    5830:	b75d                	j	57d6 <drivetests+0x6a>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5832:	8626                	mv	a2,s1
    5834:	85aa                	mv	a1,a0
    5836:	8566                	mv	a0,s9
    5838:	00000097          	auipc	ra,0x0
    583c:	71c080e7          	jalr	1820(ra) # 5f54 <printf>
      if(continuous != 2) {
    5840:	f9598be3          	beq	s3,s5,57d6 <drivetests+0x6a>
        return 1;
    5844:	4505                	li	a0,1
    5846:	a031                	j	5852 <drivetests+0xe6>
        return 1;
    5848:	4505                	li	a0,1
    584a:	a021                	j	5852 <drivetests+0xe6>
          return 1;
    584c:	4505                	li	a0,1
    584e:	a011                	j	5852 <drivetests+0xe6>
  return 0;
    5850:	854e                	mv	a0,s3
}
    5852:	60e6                	ld	ra,88(sp)
    5854:	6446                	ld	s0,80(sp)
    5856:	64a6                	ld	s1,72(sp)
    5858:	6906                	ld	s2,64(sp)
    585a:	79e2                	ld	s3,56(sp)
    585c:	7a42                	ld	s4,48(sp)
    585e:	7aa2                	ld	s5,40(sp)
    5860:	7b02                	ld	s6,32(sp)
    5862:	6be2                	ld	s7,24(sp)
    5864:	6c42                	ld	s8,16(sp)
    5866:	6ca2                	ld	s9,8(sp)
    5868:	6d02                	ld	s10,0(sp)
    586a:	6125                	addi	sp,sp,96
    586c:	8082                	ret

000000000000586e <main>:

int
main(int argc, char *argv[])
{
    586e:	1101                	addi	sp,sp,-32
    5870:	ec06                	sd	ra,24(sp)
    5872:	e822                	sd	s0,16(sp)
    5874:	e426                	sd	s1,8(sp)
    5876:	e04a                	sd	s2,0(sp)
    5878:	1000                	addi	s0,sp,32
    587a:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    587c:	4789                	li	a5,2
    587e:	02f50363          	beq	a0,a5,58a4 <main+0x36>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    5882:	4785                	li	a5,1
    5884:	06a7cd63          	blt	a5,a0,58fe <main+0x90>
  char *justone = 0;
    5888:	4601                	li	a2,0
  int quick = 0;
    588a:	4501                	li	a0,0
  int continuous = 0;
    588c:	4481                	li	s1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    588e:	85a6                	mv	a1,s1
    5890:	00000097          	auipc	ra,0x0
    5894:	edc080e7          	jalr	-292(ra) # 576c <drivetests>
    5898:	c949                	beqz	a0,592a <main+0xbc>
    exit(1);
    589a:	4505                	li	a0,1
    589c:	00000097          	auipc	ra,0x0
    58a0:	338080e7          	jalr	824(ra) # 5bd4 <exit>
    58a4:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    58a6:	00003597          	auipc	a1,0x3
    58aa:	91258593          	addi	a1,a1,-1774 # 81b8 <malloc+0x21a6>
    58ae:	00893503          	ld	a0,8(s2)
    58b2:	00000097          	auipc	ra,0x0
    58b6:	0c8080e7          	jalr	200(ra) # 597a <strcmp>
    58ba:	cd39                	beqz	a0,5918 <main+0xaa>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    58bc:	00003597          	auipc	a1,0x3
    58c0:	95458593          	addi	a1,a1,-1708 # 8210 <malloc+0x21fe>
    58c4:	00893503          	ld	a0,8(s2)
    58c8:	00000097          	auipc	ra,0x0
    58cc:	0b2080e7          	jalr	178(ra) # 597a <strcmp>
    58d0:	c931                	beqz	a0,5924 <main+0xb6>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    58d2:	00003597          	auipc	a1,0x3
    58d6:	93658593          	addi	a1,a1,-1738 # 8208 <malloc+0x21f6>
    58da:	00893503          	ld	a0,8(s2)
    58de:	00000097          	auipc	ra,0x0
    58e2:	09c080e7          	jalr	156(ra) # 597a <strcmp>
    58e6:	cd0d                	beqz	a0,5920 <main+0xb2>
  } else if(argc == 2 && argv[1][0] != '-'){
    58e8:	00893603          	ld	a2,8(s2)
    58ec:	00064703          	lbu	a4,0(a2) # 3000 <execout+0x9c>
    58f0:	02d00793          	li	a5,45
    58f4:	00f70563          	beq	a4,a5,58fe <main+0x90>
  int quick = 0;
    58f8:	4501                	li	a0,0
  int continuous = 0;
    58fa:	4481                	li	s1,0
    58fc:	bf49                	j	588e <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    58fe:	00003517          	auipc	a0,0x3
    5902:	8c250513          	addi	a0,a0,-1854 # 81c0 <malloc+0x21ae>
    5906:	00000097          	auipc	ra,0x0
    590a:	64e080e7          	jalr	1614(ra) # 5f54 <printf>
    exit(1);
    590e:	4505                	li	a0,1
    5910:	00000097          	auipc	ra,0x0
    5914:	2c4080e7          	jalr	708(ra) # 5bd4 <exit>
  int continuous = 0;
    5918:	84aa                	mv	s1,a0
  char *justone = 0;
    591a:	4601                	li	a2,0
    quick = 1;
    591c:	4505                	li	a0,1
    591e:	bf85                	j	588e <main+0x20>
  char *justone = 0;
    5920:	4601                	li	a2,0
    5922:	b7b5                	j	588e <main+0x20>
    5924:	4601                	li	a2,0
    continuous = 1;
    5926:	4485                	li	s1,1
    5928:	b79d                	j	588e <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    592a:	00003517          	auipc	a0,0x3
    592e:	8c650513          	addi	a0,a0,-1850 # 81f0 <malloc+0x21de>
    5932:	00000097          	auipc	ra,0x0
    5936:	622080e7          	jalr	1570(ra) # 5f54 <printf>
  exit(0);
    593a:	4501                	li	a0,0
    593c:	00000097          	auipc	ra,0x0
    5940:	298080e7          	jalr	664(ra) # 5bd4 <exit>

0000000000005944 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    5944:	1141                	addi	sp,sp,-16
    5946:	e406                	sd	ra,8(sp)
    5948:	e022                	sd	s0,0(sp)
    594a:	0800                	addi	s0,sp,16
  extern int main();
  main();
    594c:	00000097          	auipc	ra,0x0
    5950:	f22080e7          	jalr	-222(ra) # 586e <main>
  exit(0);
    5954:	4501                	li	a0,0
    5956:	00000097          	auipc	ra,0x0
    595a:	27e080e7          	jalr	638(ra) # 5bd4 <exit>

000000000000595e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    595e:	1141                	addi	sp,sp,-16
    5960:	e422                	sd	s0,8(sp)
    5962:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    5964:	87aa                	mv	a5,a0
    5966:	0585                	addi	a1,a1,1
    5968:	0785                	addi	a5,a5,1
    596a:	fff5c703          	lbu	a4,-1(a1)
    596e:	fee78fa3          	sb	a4,-1(a5) # fff <linktest+0x107>
    5972:	fb75                	bnez	a4,5966 <strcpy+0x8>
    ;
  return os;
}
    5974:	6422                	ld	s0,8(sp)
    5976:	0141                	addi	sp,sp,16
    5978:	8082                	ret

000000000000597a <strcmp>:

int
strcmp(const char *p, const char *q)
{
    597a:	1141                	addi	sp,sp,-16
    597c:	e422                	sd	s0,8(sp)
    597e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    5980:	00054783          	lbu	a5,0(a0)
    5984:	cb91                	beqz	a5,5998 <strcmp+0x1e>
    5986:	0005c703          	lbu	a4,0(a1)
    598a:	00f71763          	bne	a4,a5,5998 <strcmp+0x1e>
    p++, q++;
    598e:	0505                	addi	a0,a0,1
    5990:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    5992:	00054783          	lbu	a5,0(a0)
    5996:	fbe5                	bnez	a5,5986 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    5998:	0005c503          	lbu	a0,0(a1)
}
    599c:	40a7853b          	subw	a0,a5,a0
    59a0:	6422                	ld	s0,8(sp)
    59a2:	0141                	addi	sp,sp,16
    59a4:	8082                	ret

00000000000059a6 <strlen>:

uint
strlen(const char *s)
{
    59a6:	1141                	addi	sp,sp,-16
    59a8:	e422                	sd	s0,8(sp)
    59aa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    59ac:	00054783          	lbu	a5,0(a0)
    59b0:	cf91                	beqz	a5,59cc <strlen+0x26>
    59b2:	0505                	addi	a0,a0,1
    59b4:	87aa                	mv	a5,a0
    59b6:	4685                	li	a3,1
    59b8:	9e89                	subw	a3,a3,a0
    59ba:	00f6853b          	addw	a0,a3,a5
    59be:	0785                	addi	a5,a5,1
    59c0:	fff7c703          	lbu	a4,-1(a5)
    59c4:	fb7d                	bnez	a4,59ba <strlen+0x14>
    ;
  return n;
}
    59c6:	6422                	ld	s0,8(sp)
    59c8:	0141                	addi	sp,sp,16
    59ca:	8082                	ret
  for(n = 0; s[n]; n++)
    59cc:	4501                	li	a0,0
    59ce:	bfe5                	j	59c6 <strlen+0x20>

00000000000059d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    59d0:	1141                	addi	sp,sp,-16
    59d2:	e422                	sd	s0,8(sp)
    59d4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    59d6:	ce09                	beqz	a2,59f0 <memset+0x20>
    59d8:	87aa                	mv	a5,a0
    59da:	fff6071b          	addiw	a4,a2,-1
    59de:	1702                	slli	a4,a4,0x20
    59e0:	9301                	srli	a4,a4,0x20
    59e2:	0705                	addi	a4,a4,1
    59e4:	972a                	add	a4,a4,a0
    cdst[i] = c;
    59e6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    59ea:	0785                	addi	a5,a5,1
    59ec:	fee79de3          	bne	a5,a4,59e6 <memset+0x16>
  }
  return dst;
}
    59f0:	6422                	ld	s0,8(sp)
    59f2:	0141                	addi	sp,sp,16
    59f4:	8082                	ret

00000000000059f6 <strchr>:

char*
strchr(const char *s, char c)
{
    59f6:	1141                	addi	sp,sp,-16
    59f8:	e422                	sd	s0,8(sp)
    59fa:	0800                	addi	s0,sp,16
  for(; *s; s++)
    59fc:	00054783          	lbu	a5,0(a0)
    5a00:	cb99                	beqz	a5,5a16 <strchr+0x20>
    if(*s == c)
    5a02:	00f58763          	beq	a1,a5,5a10 <strchr+0x1a>
  for(; *s; s++)
    5a06:	0505                	addi	a0,a0,1
    5a08:	00054783          	lbu	a5,0(a0)
    5a0c:	fbfd                	bnez	a5,5a02 <strchr+0xc>
      return (char*)s;
  return 0;
    5a0e:	4501                	li	a0,0
}
    5a10:	6422                	ld	s0,8(sp)
    5a12:	0141                	addi	sp,sp,16
    5a14:	8082                	ret
  return 0;
    5a16:	4501                	li	a0,0
    5a18:	bfe5                	j	5a10 <strchr+0x1a>

0000000000005a1a <gets>:

char*
gets(char *buf, int max)
{
    5a1a:	711d                	addi	sp,sp,-96
    5a1c:	ec86                	sd	ra,88(sp)
    5a1e:	e8a2                	sd	s0,80(sp)
    5a20:	e4a6                	sd	s1,72(sp)
    5a22:	e0ca                	sd	s2,64(sp)
    5a24:	fc4e                	sd	s3,56(sp)
    5a26:	f852                	sd	s4,48(sp)
    5a28:	f456                	sd	s5,40(sp)
    5a2a:	f05a                	sd	s6,32(sp)
    5a2c:	ec5e                	sd	s7,24(sp)
    5a2e:	1080                	addi	s0,sp,96
    5a30:	8baa                	mv	s7,a0
    5a32:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    5a34:	892a                	mv	s2,a0
    5a36:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    5a38:	4aa9                	li	s5,10
    5a3a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    5a3c:	89a6                	mv	s3,s1
    5a3e:	2485                	addiw	s1,s1,1
    5a40:	0344d863          	bge	s1,s4,5a70 <gets+0x56>
    cc = read(0, &c, 1);
    5a44:	4605                	li	a2,1
    5a46:	faf40593          	addi	a1,s0,-81
    5a4a:	4501                	li	a0,0
    5a4c:	00000097          	auipc	ra,0x0
    5a50:	1a0080e7          	jalr	416(ra) # 5bec <read>
    if(cc < 1)
    5a54:	00a05e63          	blez	a0,5a70 <gets+0x56>
    buf[i++] = c;
    5a58:	faf44783          	lbu	a5,-81(s0)
    5a5c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    5a60:	01578763          	beq	a5,s5,5a6e <gets+0x54>
    5a64:	0905                	addi	s2,s2,1
    5a66:	fd679be3          	bne	a5,s6,5a3c <gets+0x22>
  for(i=0; i+1 < max; ){
    5a6a:	89a6                	mv	s3,s1
    5a6c:	a011                	j	5a70 <gets+0x56>
    5a6e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    5a70:	99de                	add	s3,s3,s7
    5a72:	00098023          	sb	zero,0(s3)
  return buf;
}
    5a76:	855e                	mv	a0,s7
    5a78:	60e6                	ld	ra,88(sp)
    5a7a:	6446                	ld	s0,80(sp)
    5a7c:	64a6                	ld	s1,72(sp)
    5a7e:	6906                	ld	s2,64(sp)
    5a80:	79e2                	ld	s3,56(sp)
    5a82:	7a42                	ld	s4,48(sp)
    5a84:	7aa2                	ld	s5,40(sp)
    5a86:	7b02                	ld	s6,32(sp)
    5a88:	6be2                	ld	s7,24(sp)
    5a8a:	6125                	addi	sp,sp,96
    5a8c:	8082                	ret

0000000000005a8e <stat>:

int
stat(const char *n, struct stat *st)
{
    5a8e:	1101                	addi	sp,sp,-32
    5a90:	ec06                	sd	ra,24(sp)
    5a92:	e822                	sd	s0,16(sp)
    5a94:	e426                	sd	s1,8(sp)
    5a96:	e04a                	sd	s2,0(sp)
    5a98:	1000                	addi	s0,sp,32
    5a9a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5a9c:	4581                	li	a1,0
    5a9e:	00000097          	auipc	ra,0x0
    5aa2:	176080e7          	jalr	374(ra) # 5c14 <open>
  if(fd < 0)
    5aa6:	02054563          	bltz	a0,5ad0 <stat+0x42>
    5aaa:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    5aac:	85ca                	mv	a1,s2
    5aae:	00000097          	auipc	ra,0x0
    5ab2:	17e080e7          	jalr	382(ra) # 5c2c <fstat>
    5ab6:	892a                	mv	s2,a0
  close(fd);
    5ab8:	8526                	mv	a0,s1
    5aba:	00000097          	auipc	ra,0x0
    5abe:	142080e7          	jalr	322(ra) # 5bfc <close>
  return r;
}
    5ac2:	854a                	mv	a0,s2
    5ac4:	60e2                	ld	ra,24(sp)
    5ac6:	6442                	ld	s0,16(sp)
    5ac8:	64a2                	ld	s1,8(sp)
    5aca:	6902                	ld	s2,0(sp)
    5acc:	6105                	addi	sp,sp,32
    5ace:	8082                	ret
    return -1;
    5ad0:	597d                	li	s2,-1
    5ad2:	bfc5                	j	5ac2 <stat+0x34>

0000000000005ad4 <atoi>:

int
atoi(const char *s)
{
    5ad4:	1141                	addi	sp,sp,-16
    5ad6:	e422                	sd	s0,8(sp)
    5ad8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    5ada:	00054603          	lbu	a2,0(a0)
    5ade:	fd06079b          	addiw	a5,a2,-48
    5ae2:	0ff7f793          	andi	a5,a5,255
    5ae6:	4725                	li	a4,9
    5ae8:	02f76963          	bltu	a4,a5,5b1a <atoi+0x46>
    5aec:	86aa                	mv	a3,a0
  n = 0;
    5aee:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    5af0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    5af2:	0685                	addi	a3,a3,1
    5af4:	0025179b          	slliw	a5,a0,0x2
    5af8:	9fa9                	addw	a5,a5,a0
    5afa:	0017979b          	slliw	a5,a5,0x1
    5afe:	9fb1                	addw	a5,a5,a2
    5b00:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5b04:	0006c603          	lbu	a2,0(a3) # 1000 <linktest+0x108>
    5b08:	fd06071b          	addiw	a4,a2,-48
    5b0c:	0ff77713          	andi	a4,a4,255
    5b10:	fee5f1e3          	bgeu	a1,a4,5af2 <atoi+0x1e>
  return n;
}
    5b14:	6422                	ld	s0,8(sp)
    5b16:	0141                	addi	sp,sp,16
    5b18:	8082                	ret
  n = 0;
    5b1a:	4501                	li	a0,0
    5b1c:	bfe5                	j	5b14 <atoi+0x40>

0000000000005b1e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5b1e:	1141                	addi	sp,sp,-16
    5b20:	e422                	sd	s0,8(sp)
    5b22:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5b24:	02b57663          	bgeu	a0,a1,5b50 <memmove+0x32>
    while(n-- > 0)
    5b28:	02c05163          	blez	a2,5b4a <memmove+0x2c>
    5b2c:	fff6079b          	addiw	a5,a2,-1
    5b30:	1782                	slli	a5,a5,0x20
    5b32:	9381                	srli	a5,a5,0x20
    5b34:	0785                	addi	a5,a5,1
    5b36:	97aa                	add	a5,a5,a0
  dst = vdst;
    5b38:	872a                	mv	a4,a0
      *dst++ = *src++;
    5b3a:	0585                	addi	a1,a1,1
    5b3c:	0705                	addi	a4,a4,1
    5b3e:	fff5c683          	lbu	a3,-1(a1)
    5b42:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    5b46:	fee79ae3          	bne	a5,a4,5b3a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    5b4a:	6422                	ld	s0,8(sp)
    5b4c:	0141                	addi	sp,sp,16
    5b4e:	8082                	ret
    dst += n;
    5b50:	00c50733          	add	a4,a0,a2
    src += n;
    5b54:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    5b56:	fec05ae3          	blez	a2,5b4a <memmove+0x2c>
    5b5a:	fff6079b          	addiw	a5,a2,-1
    5b5e:	1782                	slli	a5,a5,0x20
    5b60:	9381                	srli	a5,a5,0x20
    5b62:	fff7c793          	not	a5,a5
    5b66:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    5b68:	15fd                	addi	a1,a1,-1
    5b6a:	177d                	addi	a4,a4,-1
    5b6c:	0005c683          	lbu	a3,0(a1)
    5b70:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    5b74:	fee79ae3          	bne	a5,a4,5b68 <memmove+0x4a>
    5b78:	bfc9                	j	5b4a <memmove+0x2c>

0000000000005b7a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5b7a:	1141                	addi	sp,sp,-16
    5b7c:	e422                	sd	s0,8(sp)
    5b7e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    5b80:	ca05                	beqz	a2,5bb0 <memcmp+0x36>
    5b82:	fff6069b          	addiw	a3,a2,-1
    5b86:	1682                	slli	a3,a3,0x20
    5b88:	9281                	srli	a3,a3,0x20
    5b8a:	0685                	addi	a3,a3,1
    5b8c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    5b8e:	00054783          	lbu	a5,0(a0)
    5b92:	0005c703          	lbu	a4,0(a1)
    5b96:	00e79863          	bne	a5,a4,5ba6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    5b9a:	0505                	addi	a0,a0,1
    p2++;
    5b9c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    5b9e:	fed518e3          	bne	a0,a3,5b8e <memcmp+0x14>
  }
  return 0;
    5ba2:	4501                	li	a0,0
    5ba4:	a019                	j	5baa <memcmp+0x30>
      return *p1 - *p2;
    5ba6:	40e7853b          	subw	a0,a5,a4
}
    5baa:	6422                	ld	s0,8(sp)
    5bac:	0141                	addi	sp,sp,16
    5bae:	8082                	ret
  return 0;
    5bb0:	4501                	li	a0,0
    5bb2:	bfe5                	j	5baa <memcmp+0x30>

0000000000005bb4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5bb4:	1141                	addi	sp,sp,-16
    5bb6:	e406                	sd	ra,8(sp)
    5bb8:	e022                	sd	s0,0(sp)
    5bba:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    5bbc:	00000097          	auipc	ra,0x0
    5bc0:	f62080e7          	jalr	-158(ra) # 5b1e <memmove>
}
    5bc4:	60a2                	ld	ra,8(sp)
    5bc6:	6402                	ld	s0,0(sp)
    5bc8:	0141                	addi	sp,sp,16
    5bca:	8082                	ret

0000000000005bcc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5bcc:	4885                	li	a7,1
 ecall
    5bce:	00000073          	ecall
 ret
    5bd2:	8082                	ret

0000000000005bd4 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5bd4:	4889                	li	a7,2
 ecall
    5bd6:	00000073          	ecall
 ret
    5bda:	8082                	ret

0000000000005bdc <wait>:
.global wait
wait:
 li a7, SYS_wait
    5bdc:	488d                	li	a7,3
 ecall
    5bde:	00000073          	ecall
 ret
    5be2:	8082                	ret

0000000000005be4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5be4:	4891                	li	a7,4
 ecall
    5be6:	00000073          	ecall
 ret
    5bea:	8082                	ret

0000000000005bec <read>:
.global read
read:
 li a7, SYS_read
    5bec:	4895                	li	a7,5
 ecall
    5bee:	00000073          	ecall
 ret
    5bf2:	8082                	ret

0000000000005bf4 <write>:
.global write
write:
 li a7, SYS_write
    5bf4:	48c1                	li	a7,16
 ecall
    5bf6:	00000073          	ecall
 ret
    5bfa:	8082                	ret

0000000000005bfc <close>:
.global close
close:
 li a7, SYS_close
    5bfc:	48d5                	li	a7,21
 ecall
    5bfe:	00000073          	ecall
 ret
    5c02:	8082                	ret

0000000000005c04 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5c04:	4899                	li	a7,6
 ecall
    5c06:	00000073          	ecall
 ret
    5c0a:	8082                	ret

0000000000005c0c <exec>:
.global exec
exec:
 li a7, SYS_exec
    5c0c:	489d                	li	a7,7
 ecall
    5c0e:	00000073          	ecall
 ret
    5c12:	8082                	ret

0000000000005c14 <open>:
.global open
open:
 li a7, SYS_open
    5c14:	48bd                	li	a7,15
 ecall
    5c16:	00000073          	ecall
 ret
    5c1a:	8082                	ret

0000000000005c1c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5c1c:	48c5                	li	a7,17
 ecall
    5c1e:	00000073          	ecall
 ret
    5c22:	8082                	ret

0000000000005c24 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5c24:	48c9                	li	a7,18
 ecall
    5c26:	00000073          	ecall
 ret
    5c2a:	8082                	ret

0000000000005c2c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5c2c:	48a1                	li	a7,8
 ecall
    5c2e:	00000073          	ecall
 ret
    5c32:	8082                	ret

0000000000005c34 <link>:
.global link
link:
 li a7, SYS_link
    5c34:	48cd                	li	a7,19
 ecall
    5c36:	00000073          	ecall
 ret
    5c3a:	8082                	ret

0000000000005c3c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5c3c:	48d1                	li	a7,20
 ecall
    5c3e:	00000073          	ecall
 ret
    5c42:	8082                	ret

0000000000005c44 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5c44:	48a5                	li	a7,9
 ecall
    5c46:	00000073          	ecall
 ret
    5c4a:	8082                	ret

0000000000005c4c <dup>:
.global dup
dup:
 li a7, SYS_dup
    5c4c:	48a9                	li	a7,10
 ecall
    5c4e:	00000073          	ecall
 ret
    5c52:	8082                	ret

0000000000005c54 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5c54:	48ad                	li	a7,11
 ecall
    5c56:	00000073          	ecall
 ret
    5c5a:	8082                	ret

0000000000005c5c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5c5c:	48b1                	li	a7,12
 ecall
    5c5e:	00000073          	ecall
 ret
    5c62:	8082                	ret

0000000000005c64 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5c64:	48b5                	li	a7,13
 ecall
    5c66:	00000073          	ecall
 ret
    5c6a:	8082                	ret

0000000000005c6c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5c6c:	48b9                	li	a7,14
 ecall
    5c6e:	00000073          	ecall
 ret
    5c72:	8082                	ret

0000000000005c74 <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
    5c74:	48d9                	li	a7,22
 ecall
    5c76:	00000073          	ecall
 ret
    5c7a:	8082                	ret

0000000000005c7c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5c7c:	1101                	addi	sp,sp,-32
    5c7e:	ec06                	sd	ra,24(sp)
    5c80:	e822                	sd	s0,16(sp)
    5c82:	1000                	addi	s0,sp,32
    5c84:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5c88:	4605                	li	a2,1
    5c8a:	fef40593          	addi	a1,s0,-17
    5c8e:	00000097          	auipc	ra,0x0
    5c92:	f66080e7          	jalr	-154(ra) # 5bf4 <write>
}
    5c96:	60e2                	ld	ra,24(sp)
    5c98:	6442                	ld	s0,16(sp)
    5c9a:	6105                	addi	sp,sp,32
    5c9c:	8082                	ret

0000000000005c9e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5c9e:	7139                	addi	sp,sp,-64
    5ca0:	fc06                	sd	ra,56(sp)
    5ca2:	f822                	sd	s0,48(sp)
    5ca4:	f426                	sd	s1,40(sp)
    5ca6:	f04a                	sd	s2,32(sp)
    5ca8:	ec4e                	sd	s3,24(sp)
    5caa:	0080                	addi	s0,sp,64
    5cac:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5cae:	c299                	beqz	a3,5cb4 <printint+0x16>
    5cb0:	0805c863          	bltz	a1,5d40 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5cb4:	2581                	sext.w	a1,a1
  neg = 0;
    5cb6:	4881                	li	a7,0
    5cb8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    5cbc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    5cbe:	2601                	sext.w	a2,a2
    5cc0:	00003517          	auipc	a0,0x3
    5cc4:	8c050513          	addi	a0,a0,-1856 # 8580 <digits>
    5cc8:	883a                	mv	a6,a4
    5cca:	2705                	addiw	a4,a4,1
    5ccc:	02c5f7bb          	remuw	a5,a1,a2
    5cd0:	1782                	slli	a5,a5,0x20
    5cd2:	9381                	srli	a5,a5,0x20
    5cd4:	97aa                	add	a5,a5,a0
    5cd6:	0007c783          	lbu	a5,0(a5)
    5cda:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    5cde:	0005879b          	sext.w	a5,a1
    5ce2:	02c5d5bb          	divuw	a1,a1,a2
    5ce6:	0685                	addi	a3,a3,1
    5ce8:	fec7f0e3          	bgeu	a5,a2,5cc8 <printint+0x2a>
  if(neg)
    5cec:	00088b63          	beqz	a7,5d02 <printint+0x64>
    buf[i++] = '-';
    5cf0:	fd040793          	addi	a5,s0,-48
    5cf4:	973e                	add	a4,a4,a5
    5cf6:	02d00793          	li	a5,45
    5cfa:	fef70823          	sb	a5,-16(a4)
    5cfe:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    5d02:	02e05863          	blez	a4,5d32 <printint+0x94>
    5d06:	fc040793          	addi	a5,s0,-64
    5d0a:	00e78933          	add	s2,a5,a4
    5d0e:	fff78993          	addi	s3,a5,-1
    5d12:	99ba                	add	s3,s3,a4
    5d14:	377d                	addiw	a4,a4,-1
    5d16:	1702                	slli	a4,a4,0x20
    5d18:	9301                	srli	a4,a4,0x20
    5d1a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    5d1e:	fff94583          	lbu	a1,-1(s2)
    5d22:	8526                	mv	a0,s1
    5d24:	00000097          	auipc	ra,0x0
    5d28:	f58080e7          	jalr	-168(ra) # 5c7c <putc>
  while(--i >= 0)
    5d2c:	197d                	addi	s2,s2,-1
    5d2e:	ff3918e3          	bne	s2,s3,5d1e <printint+0x80>
}
    5d32:	70e2                	ld	ra,56(sp)
    5d34:	7442                	ld	s0,48(sp)
    5d36:	74a2                	ld	s1,40(sp)
    5d38:	7902                	ld	s2,32(sp)
    5d3a:	69e2                	ld	s3,24(sp)
    5d3c:	6121                	addi	sp,sp,64
    5d3e:	8082                	ret
    x = -xx;
    5d40:	40b005bb          	negw	a1,a1
    neg = 1;
    5d44:	4885                	li	a7,1
    x = -xx;
    5d46:	bf8d                	j	5cb8 <printint+0x1a>

0000000000005d48 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5d48:	7119                	addi	sp,sp,-128
    5d4a:	fc86                	sd	ra,120(sp)
    5d4c:	f8a2                	sd	s0,112(sp)
    5d4e:	f4a6                	sd	s1,104(sp)
    5d50:	f0ca                	sd	s2,96(sp)
    5d52:	ecce                	sd	s3,88(sp)
    5d54:	e8d2                	sd	s4,80(sp)
    5d56:	e4d6                	sd	s5,72(sp)
    5d58:	e0da                	sd	s6,64(sp)
    5d5a:	fc5e                	sd	s7,56(sp)
    5d5c:	f862                	sd	s8,48(sp)
    5d5e:	f466                	sd	s9,40(sp)
    5d60:	f06a                	sd	s10,32(sp)
    5d62:	ec6e                	sd	s11,24(sp)
    5d64:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    5d66:	0005c903          	lbu	s2,0(a1)
    5d6a:	18090f63          	beqz	s2,5f08 <vprintf+0x1c0>
    5d6e:	8aaa                	mv	s5,a0
    5d70:	8b32                	mv	s6,a2
    5d72:	00158493          	addi	s1,a1,1
  state = 0;
    5d76:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    5d78:	02500a13          	li	s4,37
      if(c == 'd'){
    5d7c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    5d80:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    5d84:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    5d88:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5d8c:	00002b97          	auipc	s7,0x2
    5d90:	7f4b8b93          	addi	s7,s7,2036 # 8580 <digits>
    5d94:	a839                	j	5db2 <vprintf+0x6a>
        putc(fd, c);
    5d96:	85ca                	mv	a1,s2
    5d98:	8556                	mv	a0,s5
    5d9a:	00000097          	auipc	ra,0x0
    5d9e:	ee2080e7          	jalr	-286(ra) # 5c7c <putc>
    5da2:	a019                	j	5da8 <vprintf+0x60>
    } else if(state == '%'){
    5da4:	01498f63          	beq	s3,s4,5dc2 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    5da8:	0485                	addi	s1,s1,1
    5daa:	fff4c903          	lbu	s2,-1(s1)
    5dae:	14090d63          	beqz	s2,5f08 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    5db2:	0009079b          	sext.w	a5,s2
    if(state == 0){
    5db6:	fe0997e3          	bnez	s3,5da4 <vprintf+0x5c>
      if(c == '%'){
    5dba:	fd479ee3          	bne	a5,s4,5d96 <vprintf+0x4e>
        state = '%';
    5dbe:	89be                	mv	s3,a5
    5dc0:	b7e5                	j	5da8 <vprintf+0x60>
      if(c == 'd'){
    5dc2:	05878063          	beq	a5,s8,5e02 <vprintf+0xba>
      } else if(c == 'l') {
    5dc6:	05978c63          	beq	a5,s9,5e1e <vprintf+0xd6>
      } else if(c == 'x') {
    5dca:	07a78863          	beq	a5,s10,5e3a <vprintf+0xf2>
      } else if(c == 'p') {
    5dce:	09b78463          	beq	a5,s11,5e56 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    5dd2:	07300713          	li	a4,115
    5dd6:	0ce78663          	beq	a5,a4,5ea2 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    5dda:	06300713          	li	a4,99
    5dde:	0ee78e63          	beq	a5,a4,5eda <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    5de2:	11478863          	beq	a5,s4,5ef2 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    5de6:	85d2                	mv	a1,s4
    5de8:	8556                	mv	a0,s5
    5dea:	00000097          	auipc	ra,0x0
    5dee:	e92080e7          	jalr	-366(ra) # 5c7c <putc>
        putc(fd, c);
    5df2:	85ca                	mv	a1,s2
    5df4:	8556                	mv	a0,s5
    5df6:	00000097          	auipc	ra,0x0
    5dfa:	e86080e7          	jalr	-378(ra) # 5c7c <putc>
      }
      state = 0;
    5dfe:	4981                	li	s3,0
    5e00:	b765                	j	5da8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    5e02:	008b0913          	addi	s2,s6,8
    5e06:	4685                	li	a3,1
    5e08:	4629                	li	a2,10
    5e0a:	000b2583          	lw	a1,0(s6)
    5e0e:	8556                	mv	a0,s5
    5e10:	00000097          	auipc	ra,0x0
    5e14:	e8e080e7          	jalr	-370(ra) # 5c9e <printint>
    5e18:	8b4a                	mv	s6,s2
      state = 0;
    5e1a:	4981                	li	s3,0
    5e1c:	b771                	j	5da8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5e1e:	008b0913          	addi	s2,s6,8
    5e22:	4681                	li	a3,0
    5e24:	4629                	li	a2,10
    5e26:	000b2583          	lw	a1,0(s6)
    5e2a:	8556                	mv	a0,s5
    5e2c:	00000097          	auipc	ra,0x0
    5e30:	e72080e7          	jalr	-398(ra) # 5c9e <printint>
    5e34:	8b4a                	mv	s6,s2
      state = 0;
    5e36:	4981                	li	s3,0
    5e38:	bf85                	j	5da8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    5e3a:	008b0913          	addi	s2,s6,8
    5e3e:	4681                	li	a3,0
    5e40:	4641                	li	a2,16
    5e42:	000b2583          	lw	a1,0(s6)
    5e46:	8556                	mv	a0,s5
    5e48:	00000097          	auipc	ra,0x0
    5e4c:	e56080e7          	jalr	-426(ra) # 5c9e <printint>
    5e50:	8b4a                	mv	s6,s2
      state = 0;
    5e52:	4981                	li	s3,0
    5e54:	bf91                	j	5da8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    5e56:	008b0793          	addi	a5,s6,8
    5e5a:	f8f43423          	sd	a5,-120(s0)
    5e5e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    5e62:	03000593          	li	a1,48
    5e66:	8556                	mv	a0,s5
    5e68:	00000097          	auipc	ra,0x0
    5e6c:	e14080e7          	jalr	-492(ra) # 5c7c <putc>
  putc(fd, 'x');
    5e70:	85ea                	mv	a1,s10
    5e72:	8556                	mv	a0,s5
    5e74:	00000097          	auipc	ra,0x0
    5e78:	e08080e7          	jalr	-504(ra) # 5c7c <putc>
    5e7c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5e7e:	03c9d793          	srli	a5,s3,0x3c
    5e82:	97de                	add	a5,a5,s7
    5e84:	0007c583          	lbu	a1,0(a5)
    5e88:	8556                	mv	a0,s5
    5e8a:	00000097          	auipc	ra,0x0
    5e8e:	df2080e7          	jalr	-526(ra) # 5c7c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5e92:	0992                	slli	s3,s3,0x4
    5e94:	397d                	addiw	s2,s2,-1
    5e96:	fe0914e3          	bnez	s2,5e7e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    5e9a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    5e9e:	4981                	li	s3,0
    5ea0:	b721                	j	5da8 <vprintf+0x60>
        s = va_arg(ap, char*);
    5ea2:	008b0993          	addi	s3,s6,8
    5ea6:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    5eaa:	02090163          	beqz	s2,5ecc <vprintf+0x184>
        while(*s != 0){
    5eae:	00094583          	lbu	a1,0(s2)
    5eb2:	c9a1                	beqz	a1,5f02 <vprintf+0x1ba>
          putc(fd, *s);
    5eb4:	8556                	mv	a0,s5
    5eb6:	00000097          	auipc	ra,0x0
    5eba:	dc6080e7          	jalr	-570(ra) # 5c7c <putc>
          s++;
    5ebe:	0905                	addi	s2,s2,1
        while(*s != 0){
    5ec0:	00094583          	lbu	a1,0(s2)
    5ec4:	f9e5                	bnez	a1,5eb4 <vprintf+0x16c>
        s = va_arg(ap, char*);
    5ec6:	8b4e                	mv	s6,s3
      state = 0;
    5ec8:	4981                	li	s3,0
    5eca:	bdf9                	j	5da8 <vprintf+0x60>
          s = "(null)";
    5ecc:	00002917          	auipc	s2,0x2
    5ed0:	6ac90913          	addi	s2,s2,1708 # 8578 <malloc+0x2566>
        while(*s != 0){
    5ed4:	02800593          	li	a1,40
    5ed8:	bff1                	j	5eb4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    5eda:	008b0913          	addi	s2,s6,8
    5ede:	000b4583          	lbu	a1,0(s6)
    5ee2:	8556                	mv	a0,s5
    5ee4:	00000097          	auipc	ra,0x0
    5ee8:	d98080e7          	jalr	-616(ra) # 5c7c <putc>
    5eec:	8b4a                	mv	s6,s2
      state = 0;
    5eee:	4981                	li	s3,0
    5ef0:	bd65                	j	5da8 <vprintf+0x60>
        putc(fd, c);
    5ef2:	85d2                	mv	a1,s4
    5ef4:	8556                	mv	a0,s5
    5ef6:	00000097          	auipc	ra,0x0
    5efa:	d86080e7          	jalr	-634(ra) # 5c7c <putc>
      state = 0;
    5efe:	4981                	li	s3,0
    5f00:	b565                	j	5da8 <vprintf+0x60>
        s = va_arg(ap, char*);
    5f02:	8b4e                	mv	s6,s3
      state = 0;
    5f04:	4981                	li	s3,0
    5f06:	b54d                	j	5da8 <vprintf+0x60>
    }
  }
}
    5f08:	70e6                	ld	ra,120(sp)
    5f0a:	7446                	ld	s0,112(sp)
    5f0c:	74a6                	ld	s1,104(sp)
    5f0e:	7906                	ld	s2,96(sp)
    5f10:	69e6                	ld	s3,88(sp)
    5f12:	6a46                	ld	s4,80(sp)
    5f14:	6aa6                	ld	s5,72(sp)
    5f16:	6b06                	ld	s6,64(sp)
    5f18:	7be2                	ld	s7,56(sp)
    5f1a:	7c42                	ld	s8,48(sp)
    5f1c:	7ca2                	ld	s9,40(sp)
    5f1e:	7d02                	ld	s10,32(sp)
    5f20:	6de2                	ld	s11,24(sp)
    5f22:	6109                	addi	sp,sp,128
    5f24:	8082                	ret

0000000000005f26 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5f26:	715d                	addi	sp,sp,-80
    5f28:	ec06                	sd	ra,24(sp)
    5f2a:	e822                	sd	s0,16(sp)
    5f2c:	1000                	addi	s0,sp,32
    5f2e:	e010                	sd	a2,0(s0)
    5f30:	e414                	sd	a3,8(s0)
    5f32:	e818                	sd	a4,16(s0)
    5f34:	ec1c                	sd	a5,24(s0)
    5f36:	03043023          	sd	a6,32(s0)
    5f3a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5f3e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5f42:	8622                	mv	a2,s0
    5f44:	00000097          	auipc	ra,0x0
    5f48:	e04080e7          	jalr	-508(ra) # 5d48 <vprintf>
}
    5f4c:	60e2                	ld	ra,24(sp)
    5f4e:	6442                	ld	s0,16(sp)
    5f50:	6161                	addi	sp,sp,80
    5f52:	8082                	ret

0000000000005f54 <printf>:

void
printf(const char *fmt, ...)
{
    5f54:	711d                	addi	sp,sp,-96
    5f56:	ec06                	sd	ra,24(sp)
    5f58:	e822                	sd	s0,16(sp)
    5f5a:	1000                	addi	s0,sp,32
    5f5c:	e40c                	sd	a1,8(s0)
    5f5e:	e810                	sd	a2,16(s0)
    5f60:	ec14                	sd	a3,24(s0)
    5f62:	f018                	sd	a4,32(s0)
    5f64:	f41c                	sd	a5,40(s0)
    5f66:	03043823          	sd	a6,48(s0)
    5f6a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5f6e:	00840613          	addi	a2,s0,8
    5f72:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5f76:	85aa                	mv	a1,a0
    5f78:	4505                	li	a0,1
    5f7a:	00000097          	auipc	ra,0x0
    5f7e:	dce080e7          	jalr	-562(ra) # 5d48 <vprintf>
}
    5f82:	60e2                	ld	ra,24(sp)
    5f84:	6442                	ld	s0,16(sp)
    5f86:	6125                	addi	sp,sp,96
    5f88:	8082                	ret

0000000000005f8a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5f8a:	1141                	addi	sp,sp,-16
    5f8c:	e422                	sd	s0,8(sp)
    5f8e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5f90:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5f94:	00003797          	auipc	a5,0x3
    5f98:	4bc7b783          	ld	a5,1212(a5) # 9450 <freep>
    5f9c:	a805                	j	5fcc <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5f9e:	4618                	lw	a4,8(a2)
    5fa0:	9db9                	addw	a1,a1,a4
    5fa2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5fa6:	6398                	ld	a4,0(a5)
    5fa8:	6318                	ld	a4,0(a4)
    5faa:	fee53823          	sd	a4,-16(a0)
    5fae:	a091                	j	5ff2 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5fb0:	ff852703          	lw	a4,-8(a0)
    5fb4:	9e39                	addw	a2,a2,a4
    5fb6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    5fb8:	ff053703          	ld	a4,-16(a0)
    5fbc:	e398                	sd	a4,0(a5)
    5fbe:	a099                	j	6004 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5fc0:	6398                	ld	a4,0(a5)
    5fc2:	00e7e463          	bltu	a5,a4,5fca <free+0x40>
    5fc6:	00e6ea63          	bltu	a3,a4,5fda <free+0x50>
{
    5fca:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5fcc:	fed7fae3          	bgeu	a5,a3,5fc0 <free+0x36>
    5fd0:	6398                	ld	a4,0(a5)
    5fd2:	00e6e463          	bltu	a3,a4,5fda <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5fd6:	fee7eae3          	bltu	a5,a4,5fca <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    5fda:	ff852583          	lw	a1,-8(a0)
    5fde:	6390                	ld	a2,0(a5)
    5fe0:	02059713          	slli	a4,a1,0x20
    5fe4:	9301                	srli	a4,a4,0x20
    5fe6:	0712                	slli	a4,a4,0x4
    5fe8:	9736                	add	a4,a4,a3
    5fea:	fae60ae3          	beq	a2,a4,5f9e <free+0x14>
    bp->s.ptr = p->s.ptr;
    5fee:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    5ff2:	4790                	lw	a2,8(a5)
    5ff4:	02061713          	slli	a4,a2,0x20
    5ff8:	9301                	srli	a4,a4,0x20
    5ffa:	0712                	slli	a4,a4,0x4
    5ffc:	973e                	add	a4,a4,a5
    5ffe:	fae689e3          	beq	a3,a4,5fb0 <free+0x26>
  } else
    p->s.ptr = bp;
    6002:	e394                	sd	a3,0(a5)
  freep = p;
    6004:	00003717          	auipc	a4,0x3
    6008:	44f73623          	sd	a5,1100(a4) # 9450 <freep>
}
    600c:	6422                	ld	s0,8(sp)
    600e:	0141                	addi	sp,sp,16
    6010:	8082                	ret

0000000000006012 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    6012:	7139                	addi	sp,sp,-64
    6014:	fc06                	sd	ra,56(sp)
    6016:	f822                	sd	s0,48(sp)
    6018:	f426                	sd	s1,40(sp)
    601a:	f04a                	sd	s2,32(sp)
    601c:	ec4e                	sd	s3,24(sp)
    601e:	e852                	sd	s4,16(sp)
    6020:	e456                	sd	s5,8(sp)
    6022:	e05a                	sd	s6,0(sp)
    6024:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    6026:	02051493          	slli	s1,a0,0x20
    602a:	9081                	srli	s1,s1,0x20
    602c:	04bd                	addi	s1,s1,15
    602e:	8091                	srli	s1,s1,0x4
    6030:	0014899b          	addiw	s3,s1,1
    6034:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    6036:	00003517          	auipc	a0,0x3
    603a:	41a53503          	ld	a0,1050(a0) # 9450 <freep>
    603e:	c515                	beqz	a0,606a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    6040:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    6042:	4798                	lw	a4,8(a5)
    6044:	02977f63          	bgeu	a4,s1,6082 <malloc+0x70>
    6048:	8a4e                	mv	s4,s3
    604a:	0009871b          	sext.w	a4,s3
    604e:	6685                	lui	a3,0x1
    6050:	00d77363          	bgeu	a4,a3,6056 <malloc+0x44>
    6054:	6a05                	lui	s4,0x1
    6056:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    605a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    605e:	00003917          	auipc	s2,0x3
    6062:	3f290913          	addi	s2,s2,1010 # 9450 <freep>
  if(p == (char*)-1)
    6066:	5afd                	li	s5,-1
    6068:	a88d                	j	60da <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    606a:	0000a797          	auipc	a5,0xa
    606e:	c0e78793          	addi	a5,a5,-1010 # fc78 <base>
    6072:	00003717          	auipc	a4,0x3
    6076:	3cf73f23          	sd	a5,990(a4) # 9450 <freep>
    607a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    607c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    6080:	b7e1                	j	6048 <malloc+0x36>
      if(p->s.size == nunits)
    6082:	02e48b63          	beq	s1,a4,60b8 <malloc+0xa6>
        p->s.size -= nunits;
    6086:	4137073b          	subw	a4,a4,s3
    608a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    608c:	1702                	slli	a4,a4,0x20
    608e:	9301                	srli	a4,a4,0x20
    6090:	0712                	slli	a4,a4,0x4
    6092:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    6094:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    6098:	00003717          	auipc	a4,0x3
    609c:	3aa73c23          	sd	a0,952(a4) # 9450 <freep>
      return (void*)(p + 1);
    60a0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    60a4:	70e2                	ld	ra,56(sp)
    60a6:	7442                	ld	s0,48(sp)
    60a8:	74a2                	ld	s1,40(sp)
    60aa:	7902                	ld	s2,32(sp)
    60ac:	69e2                	ld	s3,24(sp)
    60ae:	6a42                	ld	s4,16(sp)
    60b0:	6aa2                	ld	s5,8(sp)
    60b2:	6b02                	ld	s6,0(sp)
    60b4:	6121                	addi	sp,sp,64
    60b6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    60b8:	6398                	ld	a4,0(a5)
    60ba:	e118                	sd	a4,0(a0)
    60bc:	bff1                	j	6098 <malloc+0x86>
  hp->s.size = nu;
    60be:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    60c2:	0541                	addi	a0,a0,16
    60c4:	00000097          	auipc	ra,0x0
    60c8:	ec6080e7          	jalr	-314(ra) # 5f8a <free>
  return freep;
    60cc:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    60d0:	d971                	beqz	a0,60a4 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    60d2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    60d4:	4798                	lw	a4,8(a5)
    60d6:	fa9776e3          	bgeu	a4,s1,6082 <malloc+0x70>
    if(p == freep)
    60da:	00093703          	ld	a4,0(s2)
    60de:	853e                	mv	a0,a5
    60e0:	fef719e3          	bne	a4,a5,60d2 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    60e4:	8552                	mv	a0,s4
    60e6:	00000097          	auipc	ra,0x0
    60ea:	b76080e7          	jalr	-1162(ra) # 5c5c <sbrk>
  if(p == (char*)-1)
    60ee:	fd5518e3          	bne	a0,s5,60be <malloc+0xac>
        return 0;
    60f2:	4501                	li	a0,0
    60f4:	bf45                	j	60a4 <malloc+0x92>

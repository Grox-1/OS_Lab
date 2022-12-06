
user/_symlinktest：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <stat_slink>:
}

// stat a symbolic link using O_NOFOLLOW
static int
stat_slink(char *pn, struct stat *st)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84ae                	mv	s1,a1
  int fd = open(pn, O_RDONLY | O_NOFOLLOW);
   c:	60000593          	li	a1,1536
  10:	00001097          	auipc	ra,0x1
  14:	994080e7          	jalr	-1644(ra) # 9a4 <open>
  if(fd < 0)
  18:	02054063          	bltz	a0,38 <stat_slink+0x38>
    return -1;
  if(fstat(fd, st) != 0)
  1c:	85a6                	mv	a1,s1
  1e:	00001097          	auipc	ra,0x1
  22:	99e080e7          	jalr	-1634(ra) # 9bc <fstat>
  26:	00a03533          	snez	a0,a0
  2a:	40a00533          	neg	a0,a0
    return -1;
  return 0;
}
  2e:	60e2                	ld	ra,24(sp)
  30:	6442                	ld	s0,16(sp)
  32:	64a2                	ld	s1,8(sp)
  34:	6105                	addi	sp,sp,32
  36:	8082                	ret
    return -1;
  38:	557d                	li	a0,-1
  3a:	bfd5                	j	2e <stat_slink+0x2e>

000000000000003c <main>:
{
  3c:	7119                	addi	sp,sp,-128
  3e:	fc86                	sd	ra,120(sp)
  40:	f8a2                	sd	s0,112(sp)
  42:	f4a6                	sd	s1,104(sp)
  44:	f0ca                	sd	s2,96(sp)
  46:	ecce                	sd	s3,88(sp)
  48:	e8d2                	sd	s4,80(sp)
  4a:	e4d6                	sd	s5,72(sp)
  4c:	e0da                	sd	s6,64(sp)
  4e:	fc5e                	sd	s7,56(sp)
  50:	f862                	sd	s8,48(sp)
  52:	0100                	addi	s0,sp,128
  unlink("/testsymlink/a");
  54:	00001517          	auipc	a0,0x1
  58:	e3c50513          	addi	a0,a0,-452 # e90 <malloc+0xee>
  5c:	00001097          	auipc	ra,0x1
  60:	958080e7          	jalr	-1704(ra) # 9b4 <unlink>
  unlink("/testsymlink/b");
  64:	00001517          	auipc	a0,0x1
  68:	e3c50513          	addi	a0,a0,-452 # ea0 <malloc+0xfe>
  6c:	00001097          	auipc	ra,0x1
  70:	948080e7          	jalr	-1720(ra) # 9b4 <unlink>
  unlink("/testsymlink/c");
  74:	00001517          	auipc	a0,0x1
  78:	e3c50513          	addi	a0,a0,-452 # eb0 <malloc+0x10e>
  7c:	00001097          	auipc	ra,0x1
  80:	938080e7          	jalr	-1736(ra) # 9b4 <unlink>
  unlink("/testsymlink/1");
  84:	00001517          	auipc	a0,0x1
  88:	e3c50513          	addi	a0,a0,-452 # ec0 <malloc+0x11e>
  8c:	00001097          	auipc	ra,0x1
  90:	928080e7          	jalr	-1752(ra) # 9b4 <unlink>
  unlink("/testsymlink/2");
  94:	00001517          	auipc	a0,0x1
  98:	e3c50513          	addi	a0,a0,-452 # ed0 <malloc+0x12e>
  9c:	00001097          	auipc	ra,0x1
  a0:	918080e7          	jalr	-1768(ra) # 9b4 <unlink>
  unlink("/testsymlink/3");
  a4:	00001517          	auipc	a0,0x1
  a8:	e3c50513          	addi	a0,a0,-452 # ee0 <malloc+0x13e>
  ac:	00001097          	auipc	ra,0x1
  b0:	908080e7          	jalr	-1784(ra) # 9b4 <unlink>
  unlink("/testsymlink/4");
  b4:	00001517          	auipc	a0,0x1
  b8:	e3c50513          	addi	a0,a0,-452 # ef0 <malloc+0x14e>
  bc:	00001097          	auipc	ra,0x1
  c0:	8f8080e7          	jalr	-1800(ra) # 9b4 <unlink>
  unlink("/testsymlink/z");
  c4:	00001517          	auipc	a0,0x1
  c8:	e3c50513          	addi	a0,a0,-452 # f00 <malloc+0x15e>
  cc:	00001097          	auipc	ra,0x1
  d0:	8e8080e7          	jalr	-1816(ra) # 9b4 <unlink>
  unlink("/testsymlink/y");
  d4:	00001517          	auipc	a0,0x1
  d8:	e3c50513          	addi	a0,a0,-452 # f10 <malloc+0x16e>
  dc:	00001097          	auipc	ra,0x1
  e0:	8d8080e7          	jalr	-1832(ra) # 9b4 <unlink>
  unlink("/testsymlink");
  e4:	00001517          	auipc	a0,0x1
  e8:	e3c50513          	addi	a0,a0,-452 # f20 <malloc+0x17e>
  ec:	00001097          	auipc	ra,0x1
  f0:	8c8080e7          	jalr	-1848(ra) # 9b4 <unlink>

static void
testsymlink(void)
{
  int r, fd1 = -1, fd2 = -1;
  char buf[4] = {'a', 'b', 'c', 'd'};
  f4:	646367b7          	lui	a5,0x64636
  f8:	2617879b          	addiw	a5,a5,609
  fc:	f8f42823          	sw	a5,-112(s0)
  char c = 0, c2 = 0;
 100:	f8040723          	sb	zero,-114(s0)
 104:	f80407a3          	sb	zero,-113(s0)
  struct stat st;
    
  printf("Start: test symlinks\n");
 108:	00001517          	auipc	a0,0x1
 10c:	e2850513          	addi	a0,a0,-472 # f30 <malloc+0x18e>
 110:	00001097          	auipc	ra,0x1
 114:	bd4080e7          	jalr	-1068(ra) # ce4 <printf>

  mkdir("/testsymlink");
 118:	00001517          	auipc	a0,0x1
 11c:	e0850513          	addi	a0,a0,-504 # f20 <malloc+0x17e>
 120:	00001097          	auipc	ra,0x1
 124:	8ac080e7          	jalr	-1876(ra) # 9cc <mkdir>

  fd1 = open("/testsymlink/a", O_CREATE | O_RDWR);
 128:	20200593          	li	a1,514
 12c:	00001517          	auipc	a0,0x1
 130:	d6450513          	addi	a0,a0,-668 # e90 <malloc+0xee>
 134:	00001097          	auipc	ra,0x1
 138:	870080e7          	jalr	-1936(ra) # 9a4 <open>
 13c:	84aa                	mv	s1,a0
  if(fd1 < 0) fail("failed to open a");
 13e:	0e054f63          	bltz	a0,23c <main+0x200>

  r = symlink("/testsymlink/a", "/testsymlink/b");
 142:	00001597          	auipc	a1,0x1
 146:	d5e58593          	addi	a1,a1,-674 # ea0 <malloc+0xfe>
 14a:	00001517          	auipc	a0,0x1
 14e:	d4650513          	addi	a0,a0,-698 # e90 <malloc+0xee>
 152:	00001097          	auipc	ra,0x1
 156:	8b2080e7          	jalr	-1870(ra) # a04 <symlink>
  if(r < 0)
 15a:	10054063          	bltz	a0,25a <main+0x21e>
    fail("symlink b -> a failed");

  if(write(fd1, buf, sizeof(buf)) != 4)
 15e:	4611                	li	a2,4
 160:	f9040593          	addi	a1,s0,-112
 164:	8526                	mv	a0,s1
 166:	00001097          	auipc	ra,0x1
 16a:	81e080e7          	jalr	-2018(ra) # 984 <write>
 16e:	4791                	li	a5,4
 170:	10f50463          	beq	a0,a5,278 <main+0x23c>
    fail("failed to write to a");
 174:	00001517          	auipc	a0,0x1
 178:	e1450513          	addi	a0,a0,-492 # f88 <malloc+0x1e6>
 17c:	00001097          	auipc	ra,0x1
 180:	b68080e7          	jalr	-1176(ra) # ce4 <printf>
 184:	4785                	li	a5,1
 186:	00002717          	auipc	a4,0x2
 18a:	e6f72d23          	sw	a5,-390(a4) # 2000 <failed>
  int r, fd1 = -1, fd2 = -1;
 18e:	597d                	li	s2,-1
  if(c!=c2)
    fail("Value read from 4 differed from value written to 1\n");

  printf("test symlinks: ok\n");
done:
  close(fd1);
 190:	8526                	mv	a0,s1
 192:	00000097          	auipc	ra,0x0
 196:	7fa080e7          	jalr	2042(ra) # 98c <close>
  close(fd2);
 19a:	854a                	mv	a0,s2
 19c:	00000097          	auipc	ra,0x0
 1a0:	7f0080e7          	jalr	2032(ra) # 98c <close>
  int pid, i;
  int fd;
  struct stat st;
  int nchild = 2;

  printf("Start: test concurrent symlinks\n");
 1a4:	00001517          	auipc	a0,0x1
 1a8:	0c450513          	addi	a0,a0,196 # 1268 <malloc+0x4c6>
 1ac:	00001097          	auipc	ra,0x1
 1b0:	b38080e7          	jalr	-1224(ra) # ce4 <printf>
    
  fd = open("/testsymlink/z", O_CREATE | O_RDWR);
 1b4:	20200593          	li	a1,514
 1b8:	00001517          	auipc	a0,0x1
 1bc:	d4850513          	addi	a0,a0,-696 # f00 <malloc+0x15e>
 1c0:	00000097          	auipc	ra,0x0
 1c4:	7e4080e7          	jalr	2020(ra) # 9a4 <open>
  if(fd < 0) {
 1c8:	42054263          	bltz	a0,5ec <main+0x5b0>
    printf("FAILED: open failed");
    exit(1);
  }
  close(fd);
 1cc:	00000097          	auipc	ra,0x0
 1d0:	7c0080e7          	jalr	1984(ra) # 98c <close>

  for(int j = 0; j < nchild; j++) {
    pid = fork();
 1d4:	00000097          	auipc	ra,0x0
 1d8:	788080e7          	jalr	1928(ra) # 95c <fork>
    if(pid < 0){
 1dc:	42054563          	bltz	a0,606 <main+0x5ca>
      printf("FAILED: fork failed\n");
      exit(1);
    }
    if(pid == 0) {
 1e0:	44050063          	beqz	a0,620 <main+0x5e4>
    pid = fork();
 1e4:	00000097          	auipc	ra,0x0
 1e8:	778080e7          	jalr	1912(ra) # 95c <fork>
    if(pid < 0){
 1ec:	40054d63          	bltz	a0,606 <main+0x5ca>
    if(pid == 0) {
 1f0:	42050863          	beqz	a0,620 <main+0x5e4>
    }
  }

  int r;
  for(int j = 0; j < nchild; j++) {
    wait(&r);
 1f4:	f9840513          	addi	a0,s0,-104
 1f8:	00000097          	auipc	ra,0x0
 1fc:	774080e7          	jalr	1908(ra) # 96c <wait>
    if(r != 0) {
 200:	f9842783          	lw	a5,-104(s0)
 204:	4a079b63          	bnez	a5,6ba <main+0x67e>
    wait(&r);
 208:	f9840513          	addi	a0,s0,-104
 20c:	00000097          	auipc	ra,0x0
 210:	760080e7          	jalr	1888(ra) # 96c <wait>
    if(r != 0) {
 214:	f9842783          	lw	a5,-104(s0)
 218:	4a079163          	bnez	a5,6ba <main+0x67e>
      printf("test concurrent symlinks: failed\n");
      exit(1);
    }
  }
  printf("test concurrent symlinks: ok\n");
 21c:	00001517          	auipc	a0,0x1
 220:	0ec50513          	addi	a0,a0,236 # 1308 <malloc+0x566>
 224:	00001097          	auipc	ra,0x1
 228:	ac0080e7          	jalr	-1344(ra) # ce4 <printf>
  exit(failed);
 22c:	00002517          	auipc	a0,0x2
 230:	dd452503          	lw	a0,-556(a0) # 2000 <failed>
 234:	00000097          	auipc	ra,0x0
 238:	730080e7          	jalr	1840(ra) # 964 <exit>
  if(fd1 < 0) fail("failed to open a");
 23c:	00001517          	auipc	a0,0x1
 240:	d0c50513          	addi	a0,a0,-756 # f48 <malloc+0x1a6>
 244:	00001097          	auipc	ra,0x1
 248:	aa0080e7          	jalr	-1376(ra) # ce4 <printf>
 24c:	4785                	li	a5,1
 24e:	00002717          	auipc	a4,0x2
 252:	daf72923          	sw	a5,-590(a4) # 2000 <failed>
  int r, fd1 = -1, fd2 = -1;
 256:	597d                	li	s2,-1
  if(fd1 < 0) fail("failed to open a");
 258:	bf25                	j	190 <main+0x154>
    fail("symlink b -> a failed");
 25a:	00001517          	auipc	a0,0x1
 25e:	d0e50513          	addi	a0,a0,-754 # f68 <malloc+0x1c6>
 262:	00001097          	auipc	ra,0x1
 266:	a82080e7          	jalr	-1406(ra) # ce4 <printf>
 26a:	4785                	li	a5,1
 26c:	00002717          	auipc	a4,0x2
 270:	d8f72a23          	sw	a5,-620(a4) # 2000 <failed>
  int r, fd1 = -1, fd2 = -1;
 274:	597d                	li	s2,-1
    fail("symlink b -> a failed");
 276:	bf29                	j	190 <main+0x154>
  if (stat_slink("/testsymlink/b", &st) != 0)
 278:	f9840593          	addi	a1,s0,-104
 27c:	00001517          	auipc	a0,0x1
 280:	c2450513          	addi	a0,a0,-988 # ea0 <malloc+0xfe>
 284:	00000097          	auipc	ra,0x0
 288:	d7c080e7          	jalr	-644(ra) # 0 <stat_slink>
 28c:	e50d                	bnez	a0,2b6 <main+0x27a>
  if(st.type != T_SYMLINK)
 28e:	fa041703          	lh	a4,-96(s0)
 292:	4791                	li	a5,4
 294:	04f70063          	beq	a4,a5,2d4 <main+0x298>
    fail("b isn't a symlink");
 298:	00001517          	auipc	a0,0x1
 29c:	d3050513          	addi	a0,a0,-720 # fc8 <malloc+0x226>
 2a0:	00001097          	auipc	ra,0x1
 2a4:	a44080e7          	jalr	-1468(ra) # ce4 <printf>
 2a8:	4785                	li	a5,1
 2aa:	00002717          	auipc	a4,0x2
 2ae:	d4f72b23          	sw	a5,-682(a4) # 2000 <failed>
  int r, fd1 = -1, fd2 = -1;
 2b2:	597d                	li	s2,-1
    fail("b isn't a symlink");
 2b4:	bdf1                	j	190 <main+0x154>
    fail("failed to stat b");
 2b6:	00001517          	auipc	a0,0x1
 2ba:	cf250513          	addi	a0,a0,-782 # fa8 <malloc+0x206>
 2be:	00001097          	auipc	ra,0x1
 2c2:	a26080e7          	jalr	-1498(ra) # ce4 <printf>
 2c6:	4785                	li	a5,1
 2c8:	00002717          	auipc	a4,0x2
 2cc:	d2f72c23          	sw	a5,-712(a4) # 2000 <failed>
  int r, fd1 = -1, fd2 = -1;
 2d0:	597d                	li	s2,-1
    fail("failed to stat b");
 2d2:	bd7d                	j	190 <main+0x154>
  fd2 = open("/testsymlink/b", O_RDWR);
 2d4:	4589                	li	a1,2
 2d6:	00001517          	auipc	a0,0x1
 2da:	bca50513          	addi	a0,a0,-1078 # ea0 <malloc+0xfe>
 2de:	00000097          	auipc	ra,0x0
 2e2:	6c6080e7          	jalr	1734(ra) # 9a4 <open>
 2e6:	892a                	mv	s2,a0
  if(fd2 < 0)
 2e8:	02054d63          	bltz	a0,322 <main+0x2e6>
  read(fd2, &c, 1);
 2ec:	4605                	li	a2,1
 2ee:	f8e40593          	addi	a1,s0,-114
 2f2:	00000097          	auipc	ra,0x0
 2f6:	68a080e7          	jalr	1674(ra) # 97c <read>
  if (c != 'a')
 2fa:	f8e44703          	lbu	a4,-114(s0)
 2fe:	06100793          	li	a5,97
 302:	02f70e63          	beq	a4,a5,33e <main+0x302>
    fail("failed to read bytes from b");
 306:	00001517          	auipc	a0,0x1
 30a:	d0250513          	addi	a0,a0,-766 # 1008 <malloc+0x266>
 30e:	00001097          	auipc	ra,0x1
 312:	9d6080e7          	jalr	-1578(ra) # ce4 <printf>
 316:	4785                	li	a5,1
 318:	00002717          	auipc	a4,0x2
 31c:	cef72423          	sw	a5,-792(a4) # 2000 <failed>
 320:	bd85                	j	190 <main+0x154>
    fail("failed to open b");
 322:	00001517          	auipc	a0,0x1
 326:	cc650513          	addi	a0,a0,-826 # fe8 <malloc+0x246>
 32a:	00001097          	auipc	ra,0x1
 32e:	9ba080e7          	jalr	-1606(ra) # ce4 <printf>
 332:	4785                	li	a5,1
 334:	00002717          	auipc	a4,0x2
 338:	ccf72623          	sw	a5,-820(a4) # 2000 <failed>
 33c:	bd91                	j	190 <main+0x154>
  unlink("/testsymlink/a");
 33e:	00001517          	auipc	a0,0x1
 342:	b5250513          	addi	a0,a0,-1198 # e90 <malloc+0xee>
 346:	00000097          	auipc	ra,0x0
 34a:	66e080e7          	jalr	1646(ra) # 9b4 <unlink>
  if(open("/testsymlink/b", O_RDWR) >= 0)
 34e:	4589                	li	a1,2
 350:	00001517          	auipc	a0,0x1
 354:	b5050513          	addi	a0,a0,-1200 # ea0 <malloc+0xfe>
 358:	00000097          	auipc	ra,0x0
 35c:	64c080e7          	jalr	1612(ra) # 9a4 <open>
 360:	12055263          	bgez	a0,484 <main+0x448>
  r = symlink("/testsymlink/b", "/testsymlink/a");
 364:	00001597          	auipc	a1,0x1
 368:	b2c58593          	addi	a1,a1,-1236 # e90 <malloc+0xee>
 36c:	00001517          	auipc	a0,0x1
 370:	b3450513          	addi	a0,a0,-1228 # ea0 <malloc+0xfe>
 374:	00000097          	auipc	ra,0x0
 378:	690080e7          	jalr	1680(ra) # a04 <symlink>
  if(r < 0)
 37c:	12054263          	bltz	a0,4a0 <main+0x464>
  r = open("/testsymlink/b", O_RDWR);
 380:	4589                	li	a1,2
 382:	00001517          	auipc	a0,0x1
 386:	b1e50513          	addi	a0,a0,-1250 # ea0 <malloc+0xfe>
 38a:	00000097          	auipc	ra,0x0
 38e:	61a080e7          	jalr	1562(ra) # 9a4 <open>
  if(r >= 0)
 392:	12055563          	bgez	a0,4bc <main+0x480>
  r = symlink("/testsymlink/nonexistent", "/testsymlink/c");
 396:	00001597          	auipc	a1,0x1
 39a:	b1a58593          	addi	a1,a1,-1254 # eb0 <malloc+0x10e>
 39e:	00001517          	auipc	a0,0x1
 3a2:	d2a50513          	addi	a0,a0,-726 # 10c8 <malloc+0x326>
 3a6:	00000097          	auipc	ra,0x0
 3aa:	65e080e7          	jalr	1630(ra) # a04 <symlink>
  if(r != 0)
 3ae:	12051563          	bnez	a0,4d8 <main+0x49c>
  r = symlink("/testsymlink/2", "/testsymlink/1");
 3b2:	00001597          	auipc	a1,0x1
 3b6:	b0e58593          	addi	a1,a1,-1266 # ec0 <malloc+0x11e>
 3ba:	00001517          	auipc	a0,0x1
 3be:	b1650513          	addi	a0,a0,-1258 # ed0 <malloc+0x12e>
 3c2:	00000097          	auipc	ra,0x0
 3c6:	642080e7          	jalr	1602(ra) # a04 <symlink>
  if(r) fail("Failed to link 1->2");
 3ca:	12051563          	bnez	a0,4f4 <main+0x4b8>
  r = symlink("/testsymlink/3", "/testsymlink/2");
 3ce:	00001597          	auipc	a1,0x1
 3d2:	b0258593          	addi	a1,a1,-1278 # ed0 <malloc+0x12e>
 3d6:	00001517          	auipc	a0,0x1
 3da:	b0a50513          	addi	a0,a0,-1270 # ee0 <malloc+0x13e>
 3de:	00000097          	auipc	ra,0x0
 3e2:	626080e7          	jalr	1574(ra) # a04 <symlink>
  if(r) fail("Failed to link 2->3");
 3e6:	12051563          	bnez	a0,510 <main+0x4d4>
  r = symlink("/testsymlink/4", "/testsymlink/3");
 3ea:	00001597          	auipc	a1,0x1
 3ee:	af658593          	addi	a1,a1,-1290 # ee0 <malloc+0x13e>
 3f2:	00001517          	auipc	a0,0x1
 3f6:	afe50513          	addi	a0,a0,-1282 # ef0 <malloc+0x14e>
 3fa:	00000097          	auipc	ra,0x0
 3fe:	60a080e7          	jalr	1546(ra) # a04 <symlink>
  if(r) fail("Failed to link 3->4");
 402:	12051563          	bnez	a0,52c <main+0x4f0>
  close(fd1);
 406:	8526                	mv	a0,s1
 408:	00000097          	auipc	ra,0x0
 40c:	584080e7          	jalr	1412(ra) # 98c <close>
  close(fd2);
 410:	854a                	mv	a0,s2
 412:	00000097          	auipc	ra,0x0
 416:	57a080e7          	jalr	1402(ra) # 98c <close>
  fd1 = open("/testsymlink/4", O_CREATE | O_RDWR);
 41a:	20200593          	li	a1,514
 41e:	00001517          	auipc	a0,0x1
 422:	ad250513          	addi	a0,a0,-1326 # ef0 <malloc+0x14e>
 426:	00000097          	auipc	ra,0x0
 42a:	57e080e7          	jalr	1406(ra) # 9a4 <open>
 42e:	84aa                	mv	s1,a0
  if(fd1<0) fail("Failed to create 4\n");
 430:	10054c63          	bltz	a0,548 <main+0x50c>
  fd2 = open("/testsymlink/1", O_RDWR);
 434:	4589                	li	a1,2
 436:	00001517          	auipc	a0,0x1
 43a:	a8a50513          	addi	a0,a0,-1398 # ec0 <malloc+0x11e>
 43e:	00000097          	auipc	ra,0x0
 442:	566080e7          	jalr	1382(ra) # 9a4 <open>
 446:	892a                	mv	s2,a0
  if(fd2<0) fail("Failed to open 1\n");
 448:	10054e63          	bltz	a0,564 <main+0x528>
  c = '#';
 44c:	02300793          	li	a5,35
 450:	f8f40723          	sb	a5,-114(s0)
  r = write(fd2, &c, 1);
 454:	4605                	li	a2,1
 456:	f8e40593          	addi	a1,s0,-114
 45a:	00000097          	auipc	ra,0x0
 45e:	52a080e7          	jalr	1322(ra) # 984 <write>
  if(r!=1) fail("Failed to write to 1\n");
 462:	4785                	li	a5,1
 464:	10f50e63          	beq	a0,a5,580 <main+0x544>
 468:	00001517          	auipc	a0,0x1
 46c:	d6050513          	addi	a0,a0,-672 # 11c8 <malloc+0x426>
 470:	00001097          	auipc	ra,0x1
 474:	874080e7          	jalr	-1932(ra) # ce4 <printf>
 478:	4785                	li	a5,1
 47a:	00002717          	auipc	a4,0x2
 47e:	b8f72323          	sw	a5,-1146(a4) # 2000 <failed>
 482:	b339                	j	190 <main+0x154>
    fail("Should not be able to open b after deleting a");
 484:	00001517          	auipc	a0,0x1
 488:	bac50513          	addi	a0,a0,-1108 # 1030 <malloc+0x28e>
 48c:	00001097          	auipc	ra,0x1
 490:	858080e7          	jalr	-1960(ra) # ce4 <printf>
 494:	4785                	li	a5,1
 496:	00002717          	auipc	a4,0x2
 49a:	b6f72523          	sw	a5,-1174(a4) # 2000 <failed>
 49e:	b9cd                	j	190 <main+0x154>
    fail("symlink a -> b failed");
 4a0:	00001517          	auipc	a0,0x1
 4a4:	bc850513          	addi	a0,a0,-1080 # 1068 <malloc+0x2c6>
 4a8:	00001097          	auipc	ra,0x1
 4ac:	83c080e7          	jalr	-1988(ra) # ce4 <printf>
 4b0:	4785                	li	a5,1
 4b2:	00002717          	auipc	a4,0x2
 4b6:	b4f72723          	sw	a5,-1202(a4) # 2000 <failed>
 4ba:	b9d9                	j	190 <main+0x154>
    fail("Should not be able to open b (cycle b->a->b->..)\n");
 4bc:	00001517          	auipc	a0,0x1
 4c0:	bcc50513          	addi	a0,a0,-1076 # 1088 <malloc+0x2e6>
 4c4:	00001097          	auipc	ra,0x1
 4c8:	820080e7          	jalr	-2016(ra) # ce4 <printf>
 4cc:	4785                	li	a5,1
 4ce:	00002717          	auipc	a4,0x2
 4d2:	b2f72923          	sw	a5,-1230(a4) # 2000 <failed>
 4d6:	b96d                	j	190 <main+0x154>
    fail("Symlinking to nonexistent file should succeed\n");
 4d8:	00001517          	auipc	a0,0x1
 4dc:	c1050513          	addi	a0,a0,-1008 # 10e8 <malloc+0x346>
 4e0:	00001097          	auipc	ra,0x1
 4e4:	804080e7          	jalr	-2044(ra) # ce4 <printf>
 4e8:	4785                	li	a5,1
 4ea:	00002717          	auipc	a4,0x2
 4ee:	b0f72b23          	sw	a5,-1258(a4) # 2000 <failed>
 4f2:	b979                	j	190 <main+0x154>
  if(r) fail("Failed to link 1->2");
 4f4:	00001517          	auipc	a0,0x1
 4f8:	c3450513          	addi	a0,a0,-972 # 1128 <malloc+0x386>
 4fc:	00000097          	auipc	ra,0x0
 500:	7e8080e7          	jalr	2024(ra) # ce4 <printf>
 504:	4785                	li	a5,1
 506:	00002717          	auipc	a4,0x2
 50a:	aef72d23          	sw	a5,-1286(a4) # 2000 <failed>
 50e:	b149                	j	190 <main+0x154>
  if(r) fail("Failed to link 2->3");
 510:	00001517          	auipc	a0,0x1
 514:	c3850513          	addi	a0,a0,-968 # 1148 <malloc+0x3a6>
 518:	00000097          	auipc	ra,0x0
 51c:	7cc080e7          	jalr	1996(ra) # ce4 <printf>
 520:	4785                	li	a5,1
 522:	00002717          	auipc	a4,0x2
 526:	acf72f23          	sw	a5,-1314(a4) # 2000 <failed>
 52a:	b19d                	j	190 <main+0x154>
  if(r) fail("Failed to link 3->4");
 52c:	00001517          	auipc	a0,0x1
 530:	c3c50513          	addi	a0,a0,-964 # 1168 <malloc+0x3c6>
 534:	00000097          	auipc	ra,0x0
 538:	7b0080e7          	jalr	1968(ra) # ce4 <printf>
 53c:	4785                	li	a5,1
 53e:	00002717          	auipc	a4,0x2
 542:	acf72123          	sw	a5,-1342(a4) # 2000 <failed>
 546:	b1a9                	j	190 <main+0x154>
  if(fd1<0) fail("Failed to create 4\n");
 548:	00001517          	auipc	a0,0x1
 54c:	c4050513          	addi	a0,a0,-960 # 1188 <malloc+0x3e6>
 550:	00000097          	auipc	ra,0x0
 554:	794080e7          	jalr	1940(ra) # ce4 <printf>
 558:	4785                	li	a5,1
 55a:	00002717          	auipc	a4,0x2
 55e:	aaf72323          	sw	a5,-1370(a4) # 2000 <failed>
 562:	b13d                	j	190 <main+0x154>
  if(fd2<0) fail("Failed to open 1\n");
 564:	00001517          	auipc	a0,0x1
 568:	c4450513          	addi	a0,a0,-956 # 11a8 <malloc+0x406>
 56c:	00000097          	auipc	ra,0x0
 570:	778080e7          	jalr	1912(ra) # ce4 <printf>
 574:	4785                	li	a5,1
 576:	00002717          	auipc	a4,0x2
 57a:	a8f72523          	sw	a5,-1398(a4) # 2000 <failed>
 57e:	b909                	j	190 <main+0x154>
  r = read(fd1, &c2, 1);
 580:	4605                	li	a2,1
 582:	f8f40593          	addi	a1,s0,-113
 586:	8526                	mv	a0,s1
 588:	00000097          	auipc	ra,0x0
 58c:	3f4080e7          	jalr	1012(ra) # 97c <read>
  if(r!=1) fail("Failed to read from 4\n");
 590:	4785                	li	a5,1
 592:	02f51663          	bne	a0,a5,5be <main+0x582>
  if(c!=c2)
 596:	f8e44703          	lbu	a4,-114(s0)
 59a:	f8f44783          	lbu	a5,-113(s0)
 59e:	02f70e63          	beq	a4,a5,5da <main+0x59e>
    fail("Value read from 4 differed from value written to 1\n");
 5a2:	00001517          	auipc	a0,0x1
 5a6:	c6e50513          	addi	a0,a0,-914 # 1210 <malloc+0x46e>
 5aa:	00000097          	auipc	ra,0x0
 5ae:	73a080e7          	jalr	1850(ra) # ce4 <printf>
 5b2:	4785                	li	a5,1
 5b4:	00002717          	auipc	a4,0x2
 5b8:	a4f72623          	sw	a5,-1460(a4) # 2000 <failed>
 5bc:	bed1                	j	190 <main+0x154>
  if(r!=1) fail("Failed to read from 4\n");
 5be:	00001517          	auipc	a0,0x1
 5c2:	c2a50513          	addi	a0,a0,-982 # 11e8 <malloc+0x446>
 5c6:	00000097          	auipc	ra,0x0
 5ca:	71e080e7          	jalr	1822(ra) # ce4 <printf>
 5ce:	4785                	li	a5,1
 5d0:	00002717          	auipc	a4,0x2
 5d4:	a2f72823          	sw	a5,-1488(a4) # 2000 <failed>
 5d8:	be65                	j	190 <main+0x154>
  printf("test symlinks: ok\n");
 5da:	00001517          	auipc	a0,0x1
 5de:	c7650513          	addi	a0,a0,-906 # 1250 <malloc+0x4ae>
 5e2:	00000097          	auipc	ra,0x0
 5e6:	702080e7          	jalr	1794(ra) # ce4 <printf>
 5ea:	b65d                	j	190 <main+0x154>
    printf("FAILED: open failed");
 5ec:	00001517          	auipc	a0,0x1
 5f0:	ca450513          	addi	a0,a0,-860 # 1290 <malloc+0x4ee>
 5f4:	00000097          	auipc	ra,0x0
 5f8:	6f0080e7          	jalr	1776(ra) # ce4 <printf>
    exit(1);
 5fc:	4505                	li	a0,1
 5fe:	00000097          	auipc	ra,0x0
 602:	366080e7          	jalr	870(ra) # 964 <exit>
      printf("FAILED: fork failed\n");
 606:	00001517          	auipc	a0,0x1
 60a:	ca250513          	addi	a0,a0,-862 # 12a8 <malloc+0x506>
 60e:	00000097          	auipc	ra,0x0
 612:	6d6080e7          	jalr	1750(ra) # ce4 <printf>
      exit(1);
 616:	4505                	li	a0,1
 618:	00000097          	auipc	ra,0x0
 61c:	34c080e7          	jalr	844(ra) # 964 <exit>
  int r, fd1 = -1, fd2 = -1;
 620:	06400913          	li	s2,100
      unsigned int x = (pid ? 1 : 97);
 624:	06100c13          	li	s8,97
        x = x * 1103515245 + 12345;
 628:	41c65a37          	lui	s4,0x41c65
 62c:	e6da0a1b          	addiw	s4,s4,-403
 630:	698d                	lui	s3,0x3
 632:	0399899b          	addiw	s3,s3,57
        if((x % 3) == 0) {
 636:	4b8d                	li	s7,3
          unlink("/testsymlink/y");
 638:	00001497          	auipc	s1,0x1
 63c:	8d848493          	addi	s1,s1,-1832 # f10 <malloc+0x16e>
          symlink("/testsymlink/z", "/testsymlink/y");
 640:	00001b17          	auipc	s6,0x1
 644:	8c0b0b13          	addi	s6,s6,-1856 # f00 <malloc+0x15e>
            if(st.type != T_SYMLINK) {
 648:	4a91                	li	s5,4
 64a:	a809                	j	65c <main+0x620>
          unlink("/testsymlink/y");
 64c:	8526                	mv	a0,s1
 64e:	00000097          	auipc	ra,0x0
 652:	366080e7          	jalr	870(ra) # 9b4 <unlink>
      for(i = 0; i < 100; i++){
 656:	397d                	addiw	s2,s2,-1
 658:	04090c63          	beqz	s2,6b0 <main+0x674>
        x = x * 1103515245 + 12345;
 65c:	034c07bb          	mulw	a5,s8,s4
 660:	013787bb          	addw	a5,a5,s3
 664:	00078c1b          	sext.w	s8,a5
        if((x % 3) == 0) {
 668:	0377f7bb          	remuw	a5,a5,s7
 66c:	f3e5                	bnez	a5,64c <main+0x610>
          symlink("/testsymlink/z", "/testsymlink/y");
 66e:	85a6                	mv	a1,s1
 670:	855a                	mv	a0,s6
 672:	00000097          	auipc	ra,0x0
 676:	392080e7          	jalr	914(ra) # a04 <symlink>
          if (stat_slink("/testsymlink/y", &st) == 0) {
 67a:	f9840593          	addi	a1,s0,-104
 67e:	8526                	mv	a0,s1
 680:	00000097          	auipc	ra,0x0
 684:	980080e7          	jalr	-1664(ra) # 0 <stat_slink>
 688:	f579                	bnez	a0,656 <main+0x61a>
            if(st.type != T_SYMLINK) {
 68a:	fa041583          	lh	a1,-96(s0)
 68e:	0005879b          	sext.w	a5,a1
 692:	fd5782e3          	beq	a5,s5,656 <main+0x61a>
              printf("FAILED: not a symbolic link\n", st.type);
 696:	00001517          	auipc	a0,0x1
 69a:	c2a50513          	addi	a0,a0,-982 # 12c0 <malloc+0x51e>
 69e:	00000097          	auipc	ra,0x0
 6a2:	646080e7          	jalr	1606(ra) # ce4 <printf>
              exit(1);
 6a6:	4505                	li	a0,1
 6a8:	00000097          	auipc	ra,0x0
 6ac:	2bc080e7          	jalr	700(ra) # 964 <exit>
      exit(0);
 6b0:	4501                	li	a0,0
 6b2:	00000097          	auipc	ra,0x0
 6b6:	2b2080e7          	jalr	690(ra) # 964 <exit>
      printf("test concurrent symlinks: failed\n");
 6ba:	00001517          	auipc	a0,0x1
 6be:	c2650513          	addi	a0,a0,-986 # 12e0 <malloc+0x53e>
 6c2:	00000097          	auipc	ra,0x0
 6c6:	622080e7          	jalr	1570(ra) # ce4 <printf>
      exit(1);
 6ca:	4505                	li	a0,1
 6cc:	00000097          	auipc	ra,0x0
 6d0:	298080e7          	jalr	664(ra) # 964 <exit>

00000000000006d4 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 6d4:	1141                	addi	sp,sp,-16
 6d6:	e406                	sd	ra,8(sp)
 6d8:	e022                	sd	s0,0(sp)
 6da:	0800                	addi	s0,sp,16
  extern int main();
  main();
 6dc:	00000097          	auipc	ra,0x0
 6e0:	960080e7          	jalr	-1696(ra) # 3c <main>
  exit(0);
 6e4:	4501                	li	a0,0
 6e6:	00000097          	auipc	ra,0x0
 6ea:	27e080e7          	jalr	638(ra) # 964 <exit>

00000000000006ee <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 6ee:	1141                	addi	sp,sp,-16
 6f0:	e422                	sd	s0,8(sp)
 6f2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 6f4:	87aa                	mv	a5,a0
 6f6:	0585                	addi	a1,a1,1
 6f8:	0785                	addi	a5,a5,1
 6fa:	fff5c703          	lbu	a4,-1(a1)
 6fe:	fee78fa3          	sb	a4,-1(a5) # 64635fff <base+0x64633fef>
 702:	fb75                	bnez	a4,6f6 <strcpy+0x8>
    ;
  return os;
}
 704:	6422                	ld	s0,8(sp)
 706:	0141                	addi	sp,sp,16
 708:	8082                	ret

000000000000070a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 70a:	1141                	addi	sp,sp,-16
 70c:	e422                	sd	s0,8(sp)
 70e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 710:	00054783          	lbu	a5,0(a0)
 714:	cb91                	beqz	a5,728 <strcmp+0x1e>
 716:	0005c703          	lbu	a4,0(a1)
 71a:	00f71763          	bne	a4,a5,728 <strcmp+0x1e>
    p++, q++;
 71e:	0505                	addi	a0,a0,1
 720:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 722:	00054783          	lbu	a5,0(a0)
 726:	fbe5                	bnez	a5,716 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 728:	0005c503          	lbu	a0,0(a1)
}
 72c:	40a7853b          	subw	a0,a5,a0
 730:	6422                	ld	s0,8(sp)
 732:	0141                	addi	sp,sp,16
 734:	8082                	ret

0000000000000736 <strlen>:

uint
strlen(const char *s)
{
 736:	1141                	addi	sp,sp,-16
 738:	e422                	sd	s0,8(sp)
 73a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 73c:	00054783          	lbu	a5,0(a0)
 740:	cf91                	beqz	a5,75c <strlen+0x26>
 742:	0505                	addi	a0,a0,1
 744:	87aa                	mv	a5,a0
 746:	4685                	li	a3,1
 748:	9e89                	subw	a3,a3,a0
 74a:	00f6853b          	addw	a0,a3,a5
 74e:	0785                	addi	a5,a5,1
 750:	fff7c703          	lbu	a4,-1(a5)
 754:	fb7d                	bnez	a4,74a <strlen+0x14>
    ;
  return n;
}
 756:	6422                	ld	s0,8(sp)
 758:	0141                	addi	sp,sp,16
 75a:	8082                	ret
  for(n = 0; s[n]; n++)
 75c:	4501                	li	a0,0
 75e:	bfe5                	j	756 <strlen+0x20>

0000000000000760 <memset>:

void*
memset(void *dst, int c, uint n)
{
 760:	1141                	addi	sp,sp,-16
 762:	e422                	sd	s0,8(sp)
 764:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 766:	ce09                	beqz	a2,780 <memset+0x20>
 768:	87aa                	mv	a5,a0
 76a:	fff6071b          	addiw	a4,a2,-1
 76e:	1702                	slli	a4,a4,0x20
 770:	9301                	srli	a4,a4,0x20
 772:	0705                	addi	a4,a4,1
 774:	972a                	add	a4,a4,a0
    cdst[i] = c;
 776:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 77a:	0785                	addi	a5,a5,1
 77c:	fee79de3          	bne	a5,a4,776 <memset+0x16>
  }
  return dst;
}
 780:	6422                	ld	s0,8(sp)
 782:	0141                	addi	sp,sp,16
 784:	8082                	ret

0000000000000786 <strchr>:

char*
strchr(const char *s, char c)
{
 786:	1141                	addi	sp,sp,-16
 788:	e422                	sd	s0,8(sp)
 78a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 78c:	00054783          	lbu	a5,0(a0)
 790:	cb99                	beqz	a5,7a6 <strchr+0x20>
    if(*s == c)
 792:	00f58763          	beq	a1,a5,7a0 <strchr+0x1a>
  for(; *s; s++)
 796:	0505                	addi	a0,a0,1
 798:	00054783          	lbu	a5,0(a0)
 79c:	fbfd                	bnez	a5,792 <strchr+0xc>
      return (char*)s;
  return 0;
 79e:	4501                	li	a0,0
}
 7a0:	6422                	ld	s0,8(sp)
 7a2:	0141                	addi	sp,sp,16
 7a4:	8082                	ret
  return 0;
 7a6:	4501                	li	a0,0
 7a8:	bfe5                	j	7a0 <strchr+0x1a>

00000000000007aa <gets>:

char*
gets(char *buf, int max)
{
 7aa:	711d                	addi	sp,sp,-96
 7ac:	ec86                	sd	ra,88(sp)
 7ae:	e8a2                	sd	s0,80(sp)
 7b0:	e4a6                	sd	s1,72(sp)
 7b2:	e0ca                	sd	s2,64(sp)
 7b4:	fc4e                	sd	s3,56(sp)
 7b6:	f852                	sd	s4,48(sp)
 7b8:	f456                	sd	s5,40(sp)
 7ba:	f05a                	sd	s6,32(sp)
 7bc:	ec5e                	sd	s7,24(sp)
 7be:	1080                	addi	s0,sp,96
 7c0:	8baa                	mv	s7,a0
 7c2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 7c4:	892a                	mv	s2,a0
 7c6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 7c8:	4aa9                	li	s5,10
 7ca:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 7cc:	89a6                	mv	s3,s1
 7ce:	2485                	addiw	s1,s1,1
 7d0:	0344d863          	bge	s1,s4,800 <gets+0x56>
    cc = read(0, &c, 1);
 7d4:	4605                	li	a2,1
 7d6:	faf40593          	addi	a1,s0,-81
 7da:	4501                	li	a0,0
 7dc:	00000097          	auipc	ra,0x0
 7e0:	1a0080e7          	jalr	416(ra) # 97c <read>
    if(cc < 1)
 7e4:	00a05e63          	blez	a0,800 <gets+0x56>
    buf[i++] = c;
 7e8:	faf44783          	lbu	a5,-81(s0)
 7ec:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 7f0:	01578763          	beq	a5,s5,7fe <gets+0x54>
 7f4:	0905                	addi	s2,s2,1
 7f6:	fd679be3          	bne	a5,s6,7cc <gets+0x22>
  for(i=0; i+1 < max; ){
 7fa:	89a6                	mv	s3,s1
 7fc:	a011                	j	800 <gets+0x56>
 7fe:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 800:	99de                	add	s3,s3,s7
 802:	00098023          	sb	zero,0(s3) # 3000 <base+0xff0>
  return buf;
}
 806:	855e                	mv	a0,s7
 808:	60e6                	ld	ra,88(sp)
 80a:	6446                	ld	s0,80(sp)
 80c:	64a6                	ld	s1,72(sp)
 80e:	6906                	ld	s2,64(sp)
 810:	79e2                	ld	s3,56(sp)
 812:	7a42                	ld	s4,48(sp)
 814:	7aa2                	ld	s5,40(sp)
 816:	7b02                	ld	s6,32(sp)
 818:	6be2                	ld	s7,24(sp)
 81a:	6125                	addi	sp,sp,96
 81c:	8082                	ret

000000000000081e <stat>:

int
stat(const char *n, struct stat *st)
{
 81e:	1101                	addi	sp,sp,-32
 820:	ec06                	sd	ra,24(sp)
 822:	e822                	sd	s0,16(sp)
 824:	e426                	sd	s1,8(sp)
 826:	e04a                	sd	s2,0(sp)
 828:	1000                	addi	s0,sp,32
 82a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 82c:	4581                	li	a1,0
 82e:	00000097          	auipc	ra,0x0
 832:	176080e7          	jalr	374(ra) # 9a4 <open>
  if(fd < 0)
 836:	02054563          	bltz	a0,860 <stat+0x42>
 83a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 83c:	85ca                	mv	a1,s2
 83e:	00000097          	auipc	ra,0x0
 842:	17e080e7          	jalr	382(ra) # 9bc <fstat>
 846:	892a                	mv	s2,a0
  close(fd);
 848:	8526                	mv	a0,s1
 84a:	00000097          	auipc	ra,0x0
 84e:	142080e7          	jalr	322(ra) # 98c <close>
  return r;
}
 852:	854a                	mv	a0,s2
 854:	60e2                	ld	ra,24(sp)
 856:	6442                	ld	s0,16(sp)
 858:	64a2                	ld	s1,8(sp)
 85a:	6902                	ld	s2,0(sp)
 85c:	6105                	addi	sp,sp,32
 85e:	8082                	ret
    return -1;
 860:	597d                	li	s2,-1
 862:	bfc5                	j	852 <stat+0x34>

0000000000000864 <atoi>:

int
atoi(const char *s)
{
 864:	1141                	addi	sp,sp,-16
 866:	e422                	sd	s0,8(sp)
 868:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 86a:	00054603          	lbu	a2,0(a0)
 86e:	fd06079b          	addiw	a5,a2,-48
 872:	0ff7f793          	andi	a5,a5,255
 876:	4725                	li	a4,9
 878:	02f76963          	bltu	a4,a5,8aa <atoi+0x46>
 87c:	86aa                	mv	a3,a0
  n = 0;
 87e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 880:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 882:	0685                	addi	a3,a3,1
 884:	0025179b          	slliw	a5,a0,0x2
 888:	9fa9                	addw	a5,a5,a0
 88a:	0017979b          	slliw	a5,a5,0x1
 88e:	9fb1                	addw	a5,a5,a2
 890:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 894:	0006c603          	lbu	a2,0(a3)
 898:	fd06071b          	addiw	a4,a2,-48
 89c:	0ff77713          	andi	a4,a4,255
 8a0:	fee5f1e3          	bgeu	a1,a4,882 <atoi+0x1e>
  return n;
}
 8a4:	6422                	ld	s0,8(sp)
 8a6:	0141                	addi	sp,sp,16
 8a8:	8082                	ret
  n = 0;
 8aa:	4501                	li	a0,0
 8ac:	bfe5                	j	8a4 <atoi+0x40>

00000000000008ae <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 8ae:	1141                	addi	sp,sp,-16
 8b0:	e422                	sd	s0,8(sp)
 8b2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 8b4:	02b57663          	bgeu	a0,a1,8e0 <memmove+0x32>
    while(n-- > 0)
 8b8:	02c05163          	blez	a2,8da <memmove+0x2c>
 8bc:	fff6079b          	addiw	a5,a2,-1
 8c0:	1782                	slli	a5,a5,0x20
 8c2:	9381                	srli	a5,a5,0x20
 8c4:	0785                	addi	a5,a5,1
 8c6:	97aa                	add	a5,a5,a0
  dst = vdst;
 8c8:	872a                	mv	a4,a0
      *dst++ = *src++;
 8ca:	0585                	addi	a1,a1,1
 8cc:	0705                	addi	a4,a4,1
 8ce:	fff5c683          	lbu	a3,-1(a1)
 8d2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 8d6:	fee79ae3          	bne	a5,a4,8ca <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 8da:	6422                	ld	s0,8(sp)
 8dc:	0141                	addi	sp,sp,16
 8de:	8082                	ret
    dst += n;
 8e0:	00c50733          	add	a4,a0,a2
    src += n;
 8e4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 8e6:	fec05ae3          	blez	a2,8da <memmove+0x2c>
 8ea:	fff6079b          	addiw	a5,a2,-1
 8ee:	1782                	slli	a5,a5,0x20
 8f0:	9381                	srli	a5,a5,0x20
 8f2:	fff7c793          	not	a5,a5
 8f6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 8f8:	15fd                	addi	a1,a1,-1
 8fa:	177d                	addi	a4,a4,-1
 8fc:	0005c683          	lbu	a3,0(a1)
 900:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 904:	fee79ae3          	bne	a5,a4,8f8 <memmove+0x4a>
 908:	bfc9                	j	8da <memmove+0x2c>

000000000000090a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 90a:	1141                	addi	sp,sp,-16
 90c:	e422                	sd	s0,8(sp)
 90e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 910:	ca05                	beqz	a2,940 <memcmp+0x36>
 912:	fff6069b          	addiw	a3,a2,-1
 916:	1682                	slli	a3,a3,0x20
 918:	9281                	srli	a3,a3,0x20
 91a:	0685                	addi	a3,a3,1
 91c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 91e:	00054783          	lbu	a5,0(a0)
 922:	0005c703          	lbu	a4,0(a1)
 926:	00e79863          	bne	a5,a4,936 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 92a:	0505                	addi	a0,a0,1
    p2++;
 92c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 92e:	fed518e3          	bne	a0,a3,91e <memcmp+0x14>
  }
  return 0;
 932:	4501                	li	a0,0
 934:	a019                	j	93a <memcmp+0x30>
      return *p1 - *p2;
 936:	40e7853b          	subw	a0,a5,a4
}
 93a:	6422                	ld	s0,8(sp)
 93c:	0141                	addi	sp,sp,16
 93e:	8082                	ret
  return 0;
 940:	4501                	li	a0,0
 942:	bfe5                	j	93a <memcmp+0x30>

0000000000000944 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 944:	1141                	addi	sp,sp,-16
 946:	e406                	sd	ra,8(sp)
 948:	e022                	sd	s0,0(sp)
 94a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 94c:	00000097          	auipc	ra,0x0
 950:	f62080e7          	jalr	-158(ra) # 8ae <memmove>
}
 954:	60a2                	ld	ra,8(sp)
 956:	6402                	ld	s0,0(sp)
 958:	0141                	addi	sp,sp,16
 95a:	8082                	ret

000000000000095c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 95c:	4885                	li	a7,1
 ecall
 95e:	00000073          	ecall
 ret
 962:	8082                	ret

0000000000000964 <exit>:
.global exit
exit:
 li a7, SYS_exit
 964:	4889                	li	a7,2
 ecall
 966:	00000073          	ecall
 ret
 96a:	8082                	ret

000000000000096c <wait>:
.global wait
wait:
 li a7, SYS_wait
 96c:	488d                	li	a7,3
 ecall
 96e:	00000073          	ecall
 ret
 972:	8082                	ret

0000000000000974 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 974:	4891                	li	a7,4
 ecall
 976:	00000073          	ecall
 ret
 97a:	8082                	ret

000000000000097c <read>:
.global read
read:
 li a7, SYS_read
 97c:	4895                	li	a7,5
 ecall
 97e:	00000073          	ecall
 ret
 982:	8082                	ret

0000000000000984 <write>:
.global write
write:
 li a7, SYS_write
 984:	48c1                	li	a7,16
 ecall
 986:	00000073          	ecall
 ret
 98a:	8082                	ret

000000000000098c <close>:
.global close
close:
 li a7, SYS_close
 98c:	48d5                	li	a7,21
 ecall
 98e:	00000073          	ecall
 ret
 992:	8082                	ret

0000000000000994 <kill>:
.global kill
kill:
 li a7, SYS_kill
 994:	4899                	li	a7,6
 ecall
 996:	00000073          	ecall
 ret
 99a:	8082                	ret

000000000000099c <exec>:
.global exec
exec:
 li a7, SYS_exec
 99c:	489d                	li	a7,7
 ecall
 99e:	00000073          	ecall
 ret
 9a2:	8082                	ret

00000000000009a4 <open>:
.global open
open:
 li a7, SYS_open
 9a4:	48bd                	li	a7,15
 ecall
 9a6:	00000073          	ecall
 ret
 9aa:	8082                	ret

00000000000009ac <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 9ac:	48c5                	li	a7,17
 ecall
 9ae:	00000073          	ecall
 ret
 9b2:	8082                	ret

00000000000009b4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 9b4:	48c9                	li	a7,18
 ecall
 9b6:	00000073          	ecall
 ret
 9ba:	8082                	ret

00000000000009bc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 9bc:	48a1                	li	a7,8
 ecall
 9be:	00000073          	ecall
 ret
 9c2:	8082                	ret

00000000000009c4 <link>:
.global link
link:
 li a7, SYS_link
 9c4:	48cd                	li	a7,19
 ecall
 9c6:	00000073          	ecall
 ret
 9ca:	8082                	ret

00000000000009cc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 9cc:	48d1                	li	a7,20
 ecall
 9ce:	00000073          	ecall
 ret
 9d2:	8082                	ret

00000000000009d4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 9d4:	48a5                	li	a7,9
 ecall
 9d6:	00000073          	ecall
 ret
 9da:	8082                	ret

00000000000009dc <dup>:
.global dup
dup:
 li a7, SYS_dup
 9dc:	48a9                	li	a7,10
 ecall
 9de:	00000073          	ecall
 ret
 9e2:	8082                	ret

00000000000009e4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 9e4:	48ad                	li	a7,11
 ecall
 9e6:	00000073          	ecall
 ret
 9ea:	8082                	ret

00000000000009ec <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 9ec:	48b1                	li	a7,12
 ecall
 9ee:	00000073          	ecall
 ret
 9f2:	8082                	ret

00000000000009f4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 9f4:	48b5                	li	a7,13
 ecall
 9f6:	00000073          	ecall
 ret
 9fa:	8082                	ret

00000000000009fc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 9fc:	48b9                	li	a7,14
 ecall
 9fe:	00000073          	ecall
 ret
 a02:	8082                	ret

0000000000000a04 <symlink>:
.global symlink
symlink:
 li a7, SYS_symlink
 a04:	48d9                	li	a7,22
 ecall
 a06:	00000073          	ecall
 ret
 a0a:	8082                	ret

0000000000000a0c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 a0c:	1101                	addi	sp,sp,-32
 a0e:	ec06                	sd	ra,24(sp)
 a10:	e822                	sd	s0,16(sp)
 a12:	1000                	addi	s0,sp,32
 a14:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 a18:	4605                	li	a2,1
 a1a:	fef40593          	addi	a1,s0,-17
 a1e:	00000097          	auipc	ra,0x0
 a22:	f66080e7          	jalr	-154(ra) # 984 <write>
}
 a26:	60e2                	ld	ra,24(sp)
 a28:	6442                	ld	s0,16(sp)
 a2a:	6105                	addi	sp,sp,32
 a2c:	8082                	ret

0000000000000a2e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 a2e:	7139                	addi	sp,sp,-64
 a30:	fc06                	sd	ra,56(sp)
 a32:	f822                	sd	s0,48(sp)
 a34:	f426                	sd	s1,40(sp)
 a36:	f04a                	sd	s2,32(sp)
 a38:	ec4e                	sd	s3,24(sp)
 a3a:	0080                	addi	s0,sp,64
 a3c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a3e:	c299                	beqz	a3,a44 <printint+0x16>
 a40:	0805c863          	bltz	a1,ad0 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 a44:	2581                	sext.w	a1,a1
  neg = 0;
 a46:	4881                	li	a7,0
 a48:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 a4c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 a4e:	2601                	sext.w	a2,a2
 a50:	00001517          	auipc	a0,0x1
 a54:	8e050513          	addi	a0,a0,-1824 # 1330 <digits>
 a58:	883a                	mv	a6,a4
 a5a:	2705                	addiw	a4,a4,1
 a5c:	02c5f7bb          	remuw	a5,a1,a2
 a60:	1782                	slli	a5,a5,0x20
 a62:	9381                	srli	a5,a5,0x20
 a64:	97aa                	add	a5,a5,a0
 a66:	0007c783          	lbu	a5,0(a5)
 a6a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 a6e:	0005879b          	sext.w	a5,a1
 a72:	02c5d5bb          	divuw	a1,a1,a2
 a76:	0685                	addi	a3,a3,1
 a78:	fec7f0e3          	bgeu	a5,a2,a58 <printint+0x2a>
  if(neg)
 a7c:	00088b63          	beqz	a7,a92 <printint+0x64>
    buf[i++] = '-';
 a80:	fd040793          	addi	a5,s0,-48
 a84:	973e                	add	a4,a4,a5
 a86:	02d00793          	li	a5,45
 a8a:	fef70823          	sb	a5,-16(a4)
 a8e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 a92:	02e05863          	blez	a4,ac2 <printint+0x94>
 a96:	fc040793          	addi	a5,s0,-64
 a9a:	00e78933          	add	s2,a5,a4
 a9e:	fff78993          	addi	s3,a5,-1
 aa2:	99ba                	add	s3,s3,a4
 aa4:	377d                	addiw	a4,a4,-1
 aa6:	1702                	slli	a4,a4,0x20
 aa8:	9301                	srli	a4,a4,0x20
 aaa:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 aae:	fff94583          	lbu	a1,-1(s2)
 ab2:	8526                	mv	a0,s1
 ab4:	00000097          	auipc	ra,0x0
 ab8:	f58080e7          	jalr	-168(ra) # a0c <putc>
  while(--i >= 0)
 abc:	197d                	addi	s2,s2,-1
 abe:	ff3918e3          	bne	s2,s3,aae <printint+0x80>
}
 ac2:	70e2                	ld	ra,56(sp)
 ac4:	7442                	ld	s0,48(sp)
 ac6:	74a2                	ld	s1,40(sp)
 ac8:	7902                	ld	s2,32(sp)
 aca:	69e2                	ld	s3,24(sp)
 acc:	6121                	addi	sp,sp,64
 ace:	8082                	ret
    x = -xx;
 ad0:	40b005bb          	negw	a1,a1
    neg = 1;
 ad4:	4885                	li	a7,1
    x = -xx;
 ad6:	bf8d                	j	a48 <printint+0x1a>

0000000000000ad8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 ad8:	7119                	addi	sp,sp,-128
 ada:	fc86                	sd	ra,120(sp)
 adc:	f8a2                	sd	s0,112(sp)
 ade:	f4a6                	sd	s1,104(sp)
 ae0:	f0ca                	sd	s2,96(sp)
 ae2:	ecce                	sd	s3,88(sp)
 ae4:	e8d2                	sd	s4,80(sp)
 ae6:	e4d6                	sd	s5,72(sp)
 ae8:	e0da                	sd	s6,64(sp)
 aea:	fc5e                	sd	s7,56(sp)
 aec:	f862                	sd	s8,48(sp)
 aee:	f466                	sd	s9,40(sp)
 af0:	f06a                	sd	s10,32(sp)
 af2:	ec6e                	sd	s11,24(sp)
 af4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 af6:	0005c903          	lbu	s2,0(a1)
 afa:	18090f63          	beqz	s2,c98 <vprintf+0x1c0>
 afe:	8aaa                	mv	s5,a0
 b00:	8b32                	mv	s6,a2
 b02:	00158493          	addi	s1,a1,1
  state = 0;
 b06:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 b08:	02500a13          	li	s4,37
      if(c == 'd'){
 b0c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 b10:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 b14:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 b18:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b1c:	00001b97          	auipc	s7,0x1
 b20:	814b8b93          	addi	s7,s7,-2028 # 1330 <digits>
 b24:	a839                	j	b42 <vprintf+0x6a>
        putc(fd, c);
 b26:	85ca                	mv	a1,s2
 b28:	8556                	mv	a0,s5
 b2a:	00000097          	auipc	ra,0x0
 b2e:	ee2080e7          	jalr	-286(ra) # a0c <putc>
 b32:	a019                	j	b38 <vprintf+0x60>
    } else if(state == '%'){
 b34:	01498f63          	beq	s3,s4,b52 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 b38:	0485                	addi	s1,s1,1
 b3a:	fff4c903          	lbu	s2,-1(s1)
 b3e:	14090d63          	beqz	s2,c98 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 b42:	0009079b          	sext.w	a5,s2
    if(state == 0){
 b46:	fe0997e3          	bnez	s3,b34 <vprintf+0x5c>
      if(c == '%'){
 b4a:	fd479ee3          	bne	a5,s4,b26 <vprintf+0x4e>
        state = '%';
 b4e:	89be                	mv	s3,a5
 b50:	b7e5                	j	b38 <vprintf+0x60>
      if(c == 'd'){
 b52:	05878063          	beq	a5,s8,b92 <vprintf+0xba>
      } else if(c == 'l') {
 b56:	05978c63          	beq	a5,s9,bae <vprintf+0xd6>
      } else if(c == 'x') {
 b5a:	07a78863          	beq	a5,s10,bca <vprintf+0xf2>
      } else if(c == 'p') {
 b5e:	09b78463          	beq	a5,s11,be6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 b62:	07300713          	li	a4,115
 b66:	0ce78663          	beq	a5,a4,c32 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 b6a:	06300713          	li	a4,99
 b6e:	0ee78e63          	beq	a5,a4,c6a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 b72:	11478863          	beq	a5,s4,c82 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b76:	85d2                	mv	a1,s4
 b78:	8556                	mv	a0,s5
 b7a:	00000097          	auipc	ra,0x0
 b7e:	e92080e7          	jalr	-366(ra) # a0c <putc>
        putc(fd, c);
 b82:	85ca                	mv	a1,s2
 b84:	8556                	mv	a0,s5
 b86:	00000097          	auipc	ra,0x0
 b8a:	e86080e7          	jalr	-378(ra) # a0c <putc>
      }
      state = 0;
 b8e:	4981                	li	s3,0
 b90:	b765                	j	b38 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 b92:	008b0913          	addi	s2,s6,8
 b96:	4685                	li	a3,1
 b98:	4629                	li	a2,10
 b9a:	000b2583          	lw	a1,0(s6)
 b9e:	8556                	mv	a0,s5
 ba0:	00000097          	auipc	ra,0x0
 ba4:	e8e080e7          	jalr	-370(ra) # a2e <printint>
 ba8:	8b4a                	mv	s6,s2
      state = 0;
 baa:	4981                	li	s3,0
 bac:	b771                	j	b38 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 bae:	008b0913          	addi	s2,s6,8
 bb2:	4681                	li	a3,0
 bb4:	4629                	li	a2,10
 bb6:	000b2583          	lw	a1,0(s6)
 bba:	8556                	mv	a0,s5
 bbc:	00000097          	auipc	ra,0x0
 bc0:	e72080e7          	jalr	-398(ra) # a2e <printint>
 bc4:	8b4a                	mv	s6,s2
      state = 0;
 bc6:	4981                	li	s3,0
 bc8:	bf85                	j	b38 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 bca:	008b0913          	addi	s2,s6,8
 bce:	4681                	li	a3,0
 bd0:	4641                	li	a2,16
 bd2:	000b2583          	lw	a1,0(s6)
 bd6:	8556                	mv	a0,s5
 bd8:	00000097          	auipc	ra,0x0
 bdc:	e56080e7          	jalr	-426(ra) # a2e <printint>
 be0:	8b4a                	mv	s6,s2
      state = 0;
 be2:	4981                	li	s3,0
 be4:	bf91                	j	b38 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 be6:	008b0793          	addi	a5,s6,8
 bea:	f8f43423          	sd	a5,-120(s0)
 bee:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 bf2:	03000593          	li	a1,48
 bf6:	8556                	mv	a0,s5
 bf8:	00000097          	auipc	ra,0x0
 bfc:	e14080e7          	jalr	-492(ra) # a0c <putc>
  putc(fd, 'x');
 c00:	85ea                	mv	a1,s10
 c02:	8556                	mv	a0,s5
 c04:	00000097          	auipc	ra,0x0
 c08:	e08080e7          	jalr	-504(ra) # a0c <putc>
 c0c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 c0e:	03c9d793          	srli	a5,s3,0x3c
 c12:	97de                	add	a5,a5,s7
 c14:	0007c583          	lbu	a1,0(a5)
 c18:	8556                	mv	a0,s5
 c1a:	00000097          	auipc	ra,0x0
 c1e:	df2080e7          	jalr	-526(ra) # a0c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 c22:	0992                	slli	s3,s3,0x4
 c24:	397d                	addiw	s2,s2,-1
 c26:	fe0914e3          	bnez	s2,c0e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 c2a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 c2e:	4981                	li	s3,0
 c30:	b721                	j	b38 <vprintf+0x60>
        s = va_arg(ap, char*);
 c32:	008b0993          	addi	s3,s6,8
 c36:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 c3a:	02090163          	beqz	s2,c5c <vprintf+0x184>
        while(*s != 0){
 c3e:	00094583          	lbu	a1,0(s2)
 c42:	c9a1                	beqz	a1,c92 <vprintf+0x1ba>
          putc(fd, *s);
 c44:	8556                	mv	a0,s5
 c46:	00000097          	auipc	ra,0x0
 c4a:	dc6080e7          	jalr	-570(ra) # a0c <putc>
          s++;
 c4e:	0905                	addi	s2,s2,1
        while(*s != 0){
 c50:	00094583          	lbu	a1,0(s2)
 c54:	f9e5                	bnez	a1,c44 <vprintf+0x16c>
        s = va_arg(ap, char*);
 c56:	8b4e                	mv	s6,s3
      state = 0;
 c58:	4981                	li	s3,0
 c5a:	bdf9                	j	b38 <vprintf+0x60>
          s = "(null)";
 c5c:	00000917          	auipc	s2,0x0
 c60:	6cc90913          	addi	s2,s2,1740 # 1328 <malloc+0x586>
        while(*s != 0){
 c64:	02800593          	li	a1,40
 c68:	bff1                	j	c44 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 c6a:	008b0913          	addi	s2,s6,8
 c6e:	000b4583          	lbu	a1,0(s6)
 c72:	8556                	mv	a0,s5
 c74:	00000097          	auipc	ra,0x0
 c78:	d98080e7          	jalr	-616(ra) # a0c <putc>
 c7c:	8b4a                	mv	s6,s2
      state = 0;
 c7e:	4981                	li	s3,0
 c80:	bd65                	j	b38 <vprintf+0x60>
        putc(fd, c);
 c82:	85d2                	mv	a1,s4
 c84:	8556                	mv	a0,s5
 c86:	00000097          	auipc	ra,0x0
 c8a:	d86080e7          	jalr	-634(ra) # a0c <putc>
      state = 0;
 c8e:	4981                	li	s3,0
 c90:	b565                	j	b38 <vprintf+0x60>
        s = va_arg(ap, char*);
 c92:	8b4e                	mv	s6,s3
      state = 0;
 c94:	4981                	li	s3,0
 c96:	b54d                	j	b38 <vprintf+0x60>
    }
  }
}
 c98:	70e6                	ld	ra,120(sp)
 c9a:	7446                	ld	s0,112(sp)
 c9c:	74a6                	ld	s1,104(sp)
 c9e:	7906                	ld	s2,96(sp)
 ca0:	69e6                	ld	s3,88(sp)
 ca2:	6a46                	ld	s4,80(sp)
 ca4:	6aa6                	ld	s5,72(sp)
 ca6:	6b06                	ld	s6,64(sp)
 ca8:	7be2                	ld	s7,56(sp)
 caa:	7c42                	ld	s8,48(sp)
 cac:	7ca2                	ld	s9,40(sp)
 cae:	7d02                	ld	s10,32(sp)
 cb0:	6de2                	ld	s11,24(sp)
 cb2:	6109                	addi	sp,sp,128
 cb4:	8082                	ret

0000000000000cb6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 cb6:	715d                	addi	sp,sp,-80
 cb8:	ec06                	sd	ra,24(sp)
 cba:	e822                	sd	s0,16(sp)
 cbc:	1000                	addi	s0,sp,32
 cbe:	e010                	sd	a2,0(s0)
 cc0:	e414                	sd	a3,8(s0)
 cc2:	e818                	sd	a4,16(s0)
 cc4:	ec1c                	sd	a5,24(s0)
 cc6:	03043023          	sd	a6,32(s0)
 cca:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 cce:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 cd2:	8622                	mv	a2,s0
 cd4:	00000097          	auipc	ra,0x0
 cd8:	e04080e7          	jalr	-508(ra) # ad8 <vprintf>
}
 cdc:	60e2                	ld	ra,24(sp)
 cde:	6442                	ld	s0,16(sp)
 ce0:	6161                	addi	sp,sp,80
 ce2:	8082                	ret

0000000000000ce4 <printf>:

void
printf(const char *fmt, ...)
{
 ce4:	711d                	addi	sp,sp,-96
 ce6:	ec06                	sd	ra,24(sp)
 ce8:	e822                	sd	s0,16(sp)
 cea:	1000                	addi	s0,sp,32
 cec:	e40c                	sd	a1,8(s0)
 cee:	e810                	sd	a2,16(s0)
 cf0:	ec14                	sd	a3,24(s0)
 cf2:	f018                	sd	a4,32(s0)
 cf4:	f41c                	sd	a5,40(s0)
 cf6:	03043823          	sd	a6,48(s0)
 cfa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 cfe:	00840613          	addi	a2,s0,8
 d02:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 d06:	85aa                	mv	a1,a0
 d08:	4505                	li	a0,1
 d0a:	00000097          	auipc	ra,0x0
 d0e:	dce080e7          	jalr	-562(ra) # ad8 <vprintf>
}
 d12:	60e2                	ld	ra,24(sp)
 d14:	6442                	ld	s0,16(sp)
 d16:	6125                	addi	sp,sp,96
 d18:	8082                	ret

0000000000000d1a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d1a:	1141                	addi	sp,sp,-16
 d1c:	e422                	sd	s0,8(sp)
 d1e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d20:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d24:	00001797          	auipc	a5,0x1
 d28:	2e47b783          	ld	a5,740(a5) # 2008 <freep>
 d2c:	a805                	j	d5c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 d2e:	4618                	lw	a4,8(a2)
 d30:	9db9                	addw	a1,a1,a4
 d32:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 d36:	6398                	ld	a4,0(a5)
 d38:	6318                	ld	a4,0(a4)
 d3a:	fee53823          	sd	a4,-16(a0)
 d3e:	a091                	j	d82 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 d40:	ff852703          	lw	a4,-8(a0)
 d44:	9e39                	addw	a2,a2,a4
 d46:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 d48:	ff053703          	ld	a4,-16(a0)
 d4c:	e398                	sd	a4,0(a5)
 d4e:	a099                	j	d94 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d50:	6398                	ld	a4,0(a5)
 d52:	00e7e463          	bltu	a5,a4,d5a <free+0x40>
 d56:	00e6ea63          	bltu	a3,a4,d6a <free+0x50>
{
 d5a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d5c:	fed7fae3          	bgeu	a5,a3,d50 <free+0x36>
 d60:	6398                	ld	a4,0(a5)
 d62:	00e6e463          	bltu	a3,a4,d6a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d66:	fee7eae3          	bltu	a5,a4,d5a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 d6a:	ff852583          	lw	a1,-8(a0)
 d6e:	6390                	ld	a2,0(a5)
 d70:	02059713          	slli	a4,a1,0x20
 d74:	9301                	srli	a4,a4,0x20
 d76:	0712                	slli	a4,a4,0x4
 d78:	9736                	add	a4,a4,a3
 d7a:	fae60ae3          	beq	a2,a4,d2e <free+0x14>
    bp->s.ptr = p->s.ptr;
 d7e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 d82:	4790                	lw	a2,8(a5)
 d84:	02061713          	slli	a4,a2,0x20
 d88:	9301                	srli	a4,a4,0x20
 d8a:	0712                	slli	a4,a4,0x4
 d8c:	973e                	add	a4,a4,a5
 d8e:	fae689e3          	beq	a3,a4,d40 <free+0x26>
  } else
    p->s.ptr = bp;
 d92:	e394                	sd	a3,0(a5)
  freep = p;
 d94:	00001717          	auipc	a4,0x1
 d98:	26f73a23          	sd	a5,628(a4) # 2008 <freep>
}
 d9c:	6422                	ld	s0,8(sp)
 d9e:	0141                	addi	sp,sp,16
 da0:	8082                	ret

0000000000000da2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 da2:	7139                	addi	sp,sp,-64
 da4:	fc06                	sd	ra,56(sp)
 da6:	f822                	sd	s0,48(sp)
 da8:	f426                	sd	s1,40(sp)
 daa:	f04a                	sd	s2,32(sp)
 dac:	ec4e                	sd	s3,24(sp)
 dae:	e852                	sd	s4,16(sp)
 db0:	e456                	sd	s5,8(sp)
 db2:	e05a                	sd	s6,0(sp)
 db4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 db6:	02051493          	slli	s1,a0,0x20
 dba:	9081                	srli	s1,s1,0x20
 dbc:	04bd                	addi	s1,s1,15
 dbe:	8091                	srli	s1,s1,0x4
 dc0:	0014899b          	addiw	s3,s1,1
 dc4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 dc6:	00001517          	auipc	a0,0x1
 dca:	24253503          	ld	a0,578(a0) # 2008 <freep>
 dce:	c515                	beqz	a0,dfa <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dd0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 dd2:	4798                	lw	a4,8(a5)
 dd4:	02977f63          	bgeu	a4,s1,e12 <malloc+0x70>
 dd8:	8a4e                	mv	s4,s3
 dda:	0009871b          	sext.w	a4,s3
 dde:	6685                	lui	a3,0x1
 de0:	00d77363          	bgeu	a4,a3,de6 <malloc+0x44>
 de4:	6a05                	lui	s4,0x1
 de6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 dea:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 dee:	00001917          	auipc	s2,0x1
 df2:	21a90913          	addi	s2,s2,538 # 2008 <freep>
  if(p == (char*)-1)
 df6:	5afd                	li	s5,-1
 df8:	a88d                	j	e6a <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 dfa:	00001797          	auipc	a5,0x1
 dfe:	21678793          	addi	a5,a5,534 # 2010 <base>
 e02:	00001717          	auipc	a4,0x1
 e06:	20f73323          	sd	a5,518(a4) # 2008 <freep>
 e0a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 e0c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 e10:	b7e1                	j	dd8 <malloc+0x36>
      if(p->s.size == nunits)
 e12:	02e48b63          	beq	s1,a4,e48 <malloc+0xa6>
        p->s.size -= nunits;
 e16:	4137073b          	subw	a4,a4,s3
 e1a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 e1c:	1702                	slli	a4,a4,0x20
 e1e:	9301                	srli	a4,a4,0x20
 e20:	0712                	slli	a4,a4,0x4
 e22:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 e24:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 e28:	00001717          	auipc	a4,0x1
 e2c:	1ea73023          	sd	a0,480(a4) # 2008 <freep>
      return (void*)(p + 1);
 e30:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 e34:	70e2                	ld	ra,56(sp)
 e36:	7442                	ld	s0,48(sp)
 e38:	74a2                	ld	s1,40(sp)
 e3a:	7902                	ld	s2,32(sp)
 e3c:	69e2                	ld	s3,24(sp)
 e3e:	6a42                	ld	s4,16(sp)
 e40:	6aa2                	ld	s5,8(sp)
 e42:	6b02                	ld	s6,0(sp)
 e44:	6121                	addi	sp,sp,64
 e46:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 e48:	6398                	ld	a4,0(a5)
 e4a:	e118                	sd	a4,0(a0)
 e4c:	bff1                	j	e28 <malloc+0x86>
  hp->s.size = nu;
 e4e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 e52:	0541                	addi	a0,a0,16
 e54:	00000097          	auipc	ra,0x0
 e58:	ec6080e7          	jalr	-314(ra) # d1a <free>
  return freep;
 e5c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 e60:	d971                	beqz	a0,e34 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e62:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 e64:	4798                	lw	a4,8(a5)
 e66:	fa9776e3          	bgeu	a4,s1,e12 <malloc+0x70>
    if(p == freep)
 e6a:	00093703          	ld	a4,0(s2)
 e6e:	853e                	mv	a0,a5
 e70:	fef719e3          	bne	a4,a5,e62 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 e74:	8552                	mv	a0,s4
 e76:	00000097          	auipc	ra,0x0
 e7a:	b76080e7          	jalr	-1162(ra) # 9ec <sbrk>
  if(p == (char*)-1)
 e7e:	fd5518e3          	bne	a0,s5,e4e <malloc+0xac>
        return 0;
 e82:	4501                	li	a0,0
 e84:	bf45                	j	e34 <malloc+0x92>

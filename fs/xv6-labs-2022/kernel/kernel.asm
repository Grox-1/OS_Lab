
kernel/kernel：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	8a013103          	ld	sp,-1888(sp) # 800088a0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	1b7050ef          	jal	ra,800059cc <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	0001d797          	auipc	a5,0x1d
    80000034:	14078793          	addi	a5,a5,320 # 8001d170 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	130080e7          	jalr	304(ra) # 80000178 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	00009917          	auipc	s2,0x9
    80000054:	8a090913          	addi	s2,s2,-1888 # 800088f0 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	372080e7          	jalr	882(ra) # 800063cc <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	412080e7          	jalr	1042(ra) # 80006480 <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f8e50513          	addi	a0,a0,-114 # 80008010 <etext+0x10>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	df8080e7          	jalr	-520(ra) # 80005e82 <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	e84a                	sd	s2,16(sp)
    8000009c:	e44e                	sd	s3,8(sp)
    8000009e:	e052                	sd	s4,0(sp)
    800000a0:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000a2:	6785                	lui	a5,0x1
    800000a4:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800000a8:	94aa                	add	s1,s1,a0
    800000aa:	757d                	lui	a0,0xfffff
    800000ac:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ae:	94be                	add	s1,s1,a5
    800000b0:	0095ee63          	bltu	a1,s1,800000cc <freerange+0x3a>
    800000b4:	892e                	mv	s2,a1
    kfree(p);
    800000b6:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b8:	6985                	lui	s3,0x1
    kfree(p);
    800000ba:	01448533          	add	a0,s1,s4
    800000be:	00000097          	auipc	ra,0x0
    800000c2:	f5e080e7          	jalr	-162(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c6:	94ce                	add	s1,s1,s3
    800000c8:	fe9979e3          	bgeu	s2,s1,800000ba <freerange+0x28>
}
    800000cc:	70a2                	ld	ra,40(sp)
    800000ce:	7402                	ld	s0,32(sp)
    800000d0:	64e2                	ld	s1,24(sp)
    800000d2:	6942                	ld	s2,16(sp)
    800000d4:	69a2                	ld	s3,8(sp)
    800000d6:	6a02                	ld	s4,0(sp)
    800000d8:	6145                	addi	sp,sp,48
    800000da:	8082                	ret

00000000800000dc <kinit>:
{
    800000dc:	1141                	addi	sp,sp,-16
    800000de:	e406                	sd	ra,8(sp)
    800000e0:	e022                	sd	s0,0(sp)
    800000e2:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e4:	00008597          	auipc	a1,0x8
    800000e8:	f3458593          	addi	a1,a1,-204 # 80008018 <etext+0x18>
    800000ec:	00009517          	auipc	a0,0x9
    800000f0:	80450513          	addi	a0,a0,-2044 # 800088f0 <kmem>
    800000f4:	00006097          	auipc	ra,0x6
    800000f8:	248080e7          	jalr	584(ra) # 8000633c <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fc:	45c5                	li	a1,17
    800000fe:	05ee                	slli	a1,a1,0x1b
    80000100:	0001d517          	auipc	a0,0x1d
    80000104:	07050513          	addi	a0,a0,112 # 8001d170 <end>
    80000108:	00000097          	auipc	ra,0x0
    8000010c:	f8a080e7          	jalr	-118(ra) # 80000092 <freerange>
}
    80000110:	60a2                	ld	ra,8(sp)
    80000112:	6402                	ld	s0,0(sp)
    80000114:	0141                	addi	sp,sp,16
    80000116:	8082                	ret

0000000080000118 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000118:	1101                	addi	sp,sp,-32
    8000011a:	ec06                	sd	ra,24(sp)
    8000011c:	e822                	sd	s0,16(sp)
    8000011e:	e426                	sd	s1,8(sp)
    80000120:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000122:	00008497          	auipc	s1,0x8
    80000126:	7ce48493          	addi	s1,s1,1998 # 800088f0 <kmem>
    8000012a:	8526                	mv	a0,s1
    8000012c:	00006097          	auipc	ra,0x6
    80000130:	2a0080e7          	jalr	672(ra) # 800063cc <acquire>
  r = kmem.freelist;
    80000134:	6c84                	ld	s1,24(s1)
  if(r)
    80000136:	c885                	beqz	s1,80000166 <kalloc+0x4e>
    kmem.freelist = r->next;
    80000138:	609c                	ld	a5,0(s1)
    8000013a:	00008517          	auipc	a0,0x8
    8000013e:	7b650513          	addi	a0,a0,1974 # 800088f0 <kmem>
    80000142:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000144:	00006097          	auipc	ra,0x6
    80000148:	33c080e7          	jalr	828(ra) # 80006480 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014c:	6605                	lui	a2,0x1
    8000014e:	4595                	li	a1,5
    80000150:	8526                	mv	a0,s1
    80000152:	00000097          	auipc	ra,0x0
    80000156:	026080e7          	jalr	38(ra) # 80000178 <memset>
  return (void*)r;
}
    8000015a:	8526                	mv	a0,s1
    8000015c:	60e2                	ld	ra,24(sp)
    8000015e:	6442                	ld	s0,16(sp)
    80000160:	64a2                	ld	s1,8(sp)
    80000162:	6105                	addi	sp,sp,32
    80000164:	8082                	ret
  release(&kmem.lock);
    80000166:	00008517          	auipc	a0,0x8
    8000016a:	78a50513          	addi	a0,a0,1930 # 800088f0 <kmem>
    8000016e:	00006097          	auipc	ra,0x6
    80000172:	312080e7          	jalr	786(ra) # 80006480 <release>
  if(r)
    80000176:	b7d5                	j	8000015a <kalloc+0x42>

0000000080000178 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000178:	1141                	addi	sp,sp,-16
    8000017a:	e422                	sd	s0,8(sp)
    8000017c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    8000017e:	ce09                	beqz	a2,80000198 <memset+0x20>
    80000180:	87aa                	mv	a5,a0
    80000182:	fff6071b          	addiw	a4,a2,-1
    80000186:	1702                	slli	a4,a4,0x20
    80000188:	9301                	srli	a4,a4,0x20
    8000018a:	0705                	addi	a4,a4,1
    8000018c:	972a                	add	a4,a4,a0
    cdst[i] = c;
    8000018e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000192:	0785                	addi	a5,a5,1
    80000194:	fee79de3          	bne	a5,a4,8000018e <memset+0x16>
  }
  return dst;
}
    80000198:	6422                	ld	s0,8(sp)
    8000019a:	0141                	addi	sp,sp,16
    8000019c:	8082                	ret

000000008000019e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000019e:	1141                	addi	sp,sp,-16
    800001a0:	e422                	sd	s0,8(sp)
    800001a2:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a4:	ca05                	beqz	a2,800001d4 <memcmp+0x36>
    800001a6:	fff6069b          	addiw	a3,a2,-1
    800001aa:	1682                	slli	a3,a3,0x20
    800001ac:	9281                	srli	a3,a3,0x20
    800001ae:	0685                	addi	a3,a3,1
    800001b0:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b2:	00054783          	lbu	a5,0(a0)
    800001b6:	0005c703          	lbu	a4,0(a1)
    800001ba:	00e79863          	bne	a5,a4,800001ca <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800001be:	0505                	addi	a0,a0,1
    800001c0:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001c2:	fed518e3          	bne	a0,a3,800001b2 <memcmp+0x14>
  }

  return 0;
    800001c6:	4501                	li	a0,0
    800001c8:	a019                	j	800001ce <memcmp+0x30>
      return *s1 - *s2;
    800001ca:	40e7853b          	subw	a0,a5,a4
}
    800001ce:	6422                	ld	s0,8(sp)
    800001d0:	0141                	addi	sp,sp,16
    800001d2:	8082                	ret
  return 0;
    800001d4:	4501                	li	a0,0
    800001d6:	bfe5                	j	800001ce <memcmp+0x30>

00000000800001d8 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001d8:	1141                	addi	sp,sp,-16
    800001da:	e422                	sd	s0,8(sp)
    800001dc:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001de:	ca0d                	beqz	a2,80000210 <memmove+0x38>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001e0:	00a5f963          	bgeu	a1,a0,800001f2 <memmove+0x1a>
    800001e4:	02061693          	slli	a3,a2,0x20
    800001e8:	9281                	srli	a3,a3,0x20
    800001ea:	00d58733          	add	a4,a1,a3
    800001ee:	02e56463          	bltu	a0,a4,80000216 <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001f2:	fff6079b          	addiw	a5,a2,-1
    800001f6:	1782                	slli	a5,a5,0x20
    800001f8:	9381                	srli	a5,a5,0x20
    800001fa:	0785                	addi	a5,a5,1
    800001fc:	97ae                	add	a5,a5,a1
    800001fe:	872a                	mv	a4,a0
      *d++ = *s++;
    80000200:	0585                	addi	a1,a1,1
    80000202:	0705                	addi	a4,a4,1
    80000204:	fff5c683          	lbu	a3,-1(a1)
    80000208:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    8000020c:	fef59ae3          	bne	a1,a5,80000200 <memmove+0x28>

  return dst;
}
    80000210:	6422                	ld	s0,8(sp)
    80000212:	0141                	addi	sp,sp,16
    80000214:	8082                	ret
    d += n;
    80000216:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000218:	fff6079b          	addiw	a5,a2,-1
    8000021c:	1782                	slli	a5,a5,0x20
    8000021e:	9381                	srli	a5,a5,0x20
    80000220:	fff7c793          	not	a5,a5
    80000224:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000226:	177d                	addi	a4,a4,-1
    80000228:	16fd                	addi	a3,a3,-1
    8000022a:	00074603          	lbu	a2,0(a4)
    8000022e:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000232:	fef71ae3          	bne	a4,a5,80000226 <memmove+0x4e>
    80000236:	bfe9                	j	80000210 <memmove+0x38>

0000000080000238 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000238:	1141                	addi	sp,sp,-16
    8000023a:	e406                	sd	ra,8(sp)
    8000023c:	e022                	sd	s0,0(sp)
    8000023e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000240:	00000097          	auipc	ra,0x0
    80000244:	f98080e7          	jalr	-104(ra) # 800001d8 <memmove>
}
    80000248:	60a2                	ld	ra,8(sp)
    8000024a:	6402                	ld	s0,0(sp)
    8000024c:	0141                	addi	sp,sp,16
    8000024e:	8082                	ret

0000000080000250 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000250:	1141                	addi	sp,sp,-16
    80000252:	e422                	sd	s0,8(sp)
    80000254:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000256:	ce11                	beqz	a2,80000272 <strncmp+0x22>
    80000258:	00054783          	lbu	a5,0(a0)
    8000025c:	cf89                	beqz	a5,80000276 <strncmp+0x26>
    8000025e:	0005c703          	lbu	a4,0(a1)
    80000262:	00f71a63          	bne	a4,a5,80000276 <strncmp+0x26>
    n--, p++, q++;
    80000266:	367d                	addiw	a2,a2,-1
    80000268:	0505                	addi	a0,a0,1
    8000026a:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    8000026c:	f675                	bnez	a2,80000258 <strncmp+0x8>
  if(n == 0)
    return 0;
    8000026e:	4501                	li	a0,0
    80000270:	a809                	j	80000282 <strncmp+0x32>
    80000272:	4501                	li	a0,0
    80000274:	a039                	j	80000282 <strncmp+0x32>
  if(n == 0)
    80000276:	ca09                	beqz	a2,80000288 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000278:	00054503          	lbu	a0,0(a0)
    8000027c:	0005c783          	lbu	a5,0(a1)
    80000280:	9d1d                	subw	a0,a0,a5
}
    80000282:	6422                	ld	s0,8(sp)
    80000284:	0141                	addi	sp,sp,16
    80000286:	8082                	ret
    return 0;
    80000288:	4501                	li	a0,0
    8000028a:	bfe5                	j	80000282 <strncmp+0x32>

000000008000028c <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    8000028c:	1141                	addi	sp,sp,-16
    8000028e:	e422                	sd	s0,8(sp)
    80000290:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000292:	872a                	mv	a4,a0
    80000294:	8832                	mv	a6,a2
    80000296:	367d                	addiw	a2,a2,-1
    80000298:	01005963          	blez	a6,800002aa <strncpy+0x1e>
    8000029c:	0705                	addi	a4,a4,1
    8000029e:	0005c783          	lbu	a5,0(a1)
    800002a2:	fef70fa3          	sb	a5,-1(a4)
    800002a6:	0585                	addi	a1,a1,1
    800002a8:	f7f5                	bnez	a5,80000294 <strncpy+0x8>
    ;
  while(n-- > 0)
    800002aa:	00c05d63          	blez	a2,800002c4 <strncpy+0x38>
    800002ae:	86ba                	mv	a3,a4
    *s++ = 0;
    800002b0:	0685                	addi	a3,a3,1
    800002b2:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    800002b6:	fff6c793          	not	a5,a3
    800002ba:	9fb9                	addw	a5,a5,a4
    800002bc:	010787bb          	addw	a5,a5,a6
    800002c0:	fef048e3          	bgtz	a5,800002b0 <strncpy+0x24>
  return os;
}
    800002c4:	6422                	ld	s0,8(sp)
    800002c6:	0141                	addi	sp,sp,16
    800002c8:	8082                	ret

00000000800002ca <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002ca:	1141                	addi	sp,sp,-16
    800002cc:	e422                	sd	s0,8(sp)
    800002ce:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002d0:	02c05363          	blez	a2,800002f6 <safestrcpy+0x2c>
    800002d4:	fff6069b          	addiw	a3,a2,-1
    800002d8:	1682                	slli	a3,a3,0x20
    800002da:	9281                	srli	a3,a3,0x20
    800002dc:	96ae                	add	a3,a3,a1
    800002de:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002e0:	00d58963          	beq	a1,a3,800002f2 <safestrcpy+0x28>
    800002e4:	0585                	addi	a1,a1,1
    800002e6:	0785                	addi	a5,a5,1
    800002e8:	fff5c703          	lbu	a4,-1(a1)
    800002ec:	fee78fa3          	sb	a4,-1(a5)
    800002f0:	fb65                	bnez	a4,800002e0 <safestrcpy+0x16>
    ;
  *s = 0;
    800002f2:	00078023          	sb	zero,0(a5)
  return os;
}
    800002f6:	6422                	ld	s0,8(sp)
    800002f8:	0141                	addi	sp,sp,16
    800002fa:	8082                	ret

00000000800002fc <strlen>:

int
strlen(const char *s)
{
    800002fc:	1141                	addi	sp,sp,-16
    800002fe:	e422                	sd	s0,8(sp)
    80000300:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000302:	00054783          	lbu	a5,0(a0)
    80000306:	cf91                	beqz	a5,80000322 <strlen+0x26>
    80000308:	0505                	addi	a0,a0,1
    8000030a:	87aa                	mv	a5,a0
    8000030c:	4685                	li	a3,1
    8000030e:	9e89                	subw	a3,a3,a0
    80000310:	00f6853b          	addw	a0,a3,a5
    80000314:	0785                	addi	a5,a5,1
    80000316:	fff7c703          	lbu	a4,-1(a5)
    8000031a:	fb7d                	bnez	a4,80000310 <strlen+0x14>
    ;
  return n;
}
    8000031c:	6422                	ld	s0,8(sp)
    8000031e:	0141                	addi	sp,sp,16
    80000320:	8082                	ret
  for(n = 0; s[n]; n++)
    80000322:	4501                	li	a0,0
    80000324:	bfe5                	j	8000031c <strlen+0x20>

0000000080000326 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000326:	1141                	addi	sp,sp,-16
    80000328:	e406                	sd	ra,8(sp)
    8000032a:	e022                	sd	s0,0(sp)
    8000032c:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000032e:	00001097          	auipc	ra,0x1
    80000332:	afe080e7          	jalr	-1282(ra) # 80000e2c <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000336:	00008717          	auipc	a4,0x8
    8000033a:	58a70713          	addi	a4,a4,1418 # 800088c0 <started>
  if(cpuid() == 0){
    8000033e:	c139                	beqz	a0,80000384 <main+0x5e>
    while(started == 0)
    80000340:	431c                	lw	a5,0(a4)
    80000342:	2781                	sext.w	a5,a5
    80000344:	dff5                	beqz	a5,80000340 <main+0x1a>
      ;
    __sync_synchronize();
    80000346:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    8000034a:	00001097          	auipc	ra,0x1
    8000034e:	ae2080e7          	jalr	-1310(ra) # 80000e2c <cpuid>
    80000352:	85aa                	mv	a1,a0
    80000354:	00008517          	auipc	a0,0x8
    80000358:	ce450513          	addi	a0,a0,-796 # 80008038 <etext+0x38>
    8000035c:	00006097          	auipc	ra,0x6
    80000360:	b70080e7          	jalr	-1168(ra) # 80005ecc <printf>
    kvminithart();    // turn on paging
    80000364:	00000097          	auipc	ra,0x0
    80000368:	0d8080e7          	jalr	216(ra) # 8000043c <kvminithart>
    trapinithart();   // install kernel trap vector
    8000036c:	00001097          	auipc	ra,0x1
    80000370:	784080e7          	jalr	1924(ra) # 80001af0 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000374:	00005097          	auipc	ra,0x5
    80000378:	fac080e7          	jalr	-84(ra) # 80005320 <plicinithart>
  }

  scheduler();        
    8000037c:	00001097          	auipc	ra,0x1
    80000380:	fce080e7          	jalr	-50(ra) # 8000134a <scheduler>
    consoleinit();
    80000384:	00006097          	auipc	ra,0x6
    80000388:	a10080e7          	jalr	-1520(ra) # 80005d94 <consoleinit>
    printfinit();
    8000038c:	00006097          	auipc	ra,0x6
    80000390:	d26080e7          	jalr	-730(ra) # 800060b2 <printfinit>
    printf("\n");
    80000394:	00008517          	auipc	a0,0x8
    80000398:	cb450513          	addi	a0,a0,-844 # 80008048 <etext+0x48>
    8000039c:	00006097          	auipc	ra,0x6
    800003a0:	b30080e7          	jalr	-1232(ra) # 80005ecc <printf>
    printf("xv6 kernel is booting\n");
    800003a4:	00008517          	auipc	a0,0x8
    800003a8:	c7c50513          	addi	a0,a0,-900 # 80008020 <etext+0x20>
    800003ac:	00006097          	auipc	ra,0x6
    800003b0:	b20080e7          	jalr	-1248(ra) # 80005ecc <printf>
    printf("\n");
    800003b4:	00008517          	auipc	a0,0x8
    800003b8:	c9450513          	addi	a0,a0,-876 # 80008048 <etext+0x48>
    800003bc:	00006097          	auipc	ra,0x6
    800003c0:	b10080e7          	jalr	-1264(ra) # 80005ecc <printf>
    kinit();         // physical page allocator
    800003c4:	00000097          	auipc	ra,0x0
    800003c8:	d18080e7          	jalr	-744(ra) # 800000dc <kinit>
    kvminit();       // create kernel page table
    800003cc:	00000097          	auipc	ra,0x0
    800003d0:	326080e7          	jalr	806(ra) # 800006f2 <kvminit>
    kvminithart();   // turn on paging
    800003d4:	00000097          	auipc	ra,0x0
    800003d8:	068080e7          	jalr	104(ra) # 8000043c <kvminithart>
    procinit();      // process table
    800003dc:	00001097          	auipc	ra,0x1
    800003e0:	99c080e7          	jalr	-1636(ra) # 80000d78 <procinit>
    trapinit();      // trap vectors
    800003e4:	00001097          	auipc	ra,0x1
    800003e8:	6e4080e7          	jalr	1764(ra) # 80001ac8 <trapinit>
    trapinithart();  // install kernel trap vector
    800003ec:	00001097          	auipc	ra,0x1
    800003f0:	704080e7          	jalr	1796(ra) # 80001af0 <trapinithart>
    plicinit();      // set up interrupt controller
    800003f4:	00005097          	auipc	ra,0x5
    800003f8:	f16080e7          	jalr	-234(ra) # 8000530a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800003fc:	00005097          	auipc	ra,0x5
    80000400:	f24080e7          	jalr	-220(ra) # 80005320 <plicinithart>
    binit();         // buffer cache
    80000404:	00002097          	auipc	ra,0x2
    80000408:	e36080e7          	jalr	-458(ra) # 8000223a <binit>
    iinit();         // inode table
    8000040c:	00002097          	auipc	ra,0x2
    80000410:	5aa080e7          	jalr	1450(ra) # 800029b6 <iinit>
    fileinit();      // file table
    80000414:	00003097          	auipc	ra,0x3
    80000418:	5f0080e7          	jalr	1520(ra) # 80003a04 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000041c:	00005097          	auipc	ra,0x5
    80000420:	00c080e7          	jalr	12(ra) # 80005428 <virtio_disk_init>
    userinit();      // first user process
    80000424:	00001097          	auipc	ra,0x1
    80000428:	d0c080e7          	jalr	-756(ra) # 80001130 <userinit>
    __sync_synchronize();
    8000042c:	0ff0000f          	fence
    started = 1;
    80000430:	4785                	li	a5,1
    80000432:	00008717          	auipc	a4,0x8
    80000436:	48f72723          	sw	a5,1166(a4) # 800088c0 <started>
    8000043a:	b789                	j	8000037c <main+0x56>

000000008000043c <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    8000043c:	1141                	addi	sp,sp,-16
    8000043e:	e422                	sd	s0,8(sp)
    80000440:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000442:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    80000446:	00008797          	auipc	a5,0x8
    8000044a:	4827b783          	ld	a5,1154(a5) # 800088c8 <kernel_pagetable>
    8000044e:	83b1                	srli	a5,a5,0xc
    80000450:	577d                	li	a4,-1
    80000452:	177e                	slli	a4,a4,0x3f
    80000454:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000456:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    8000045a:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    8000045e:	6422                	ld	s0,8(sp)
    80000460:	0141                	addi	sp,sp,16
    80000462:	8082                	ret

0000000080000464 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000464:	7139                	addi	sp,sp,-64
    80000466:	fc06                	sd	ra,56(sp)
    80000468:	f822                	sd	s0,48(sp)
    8000046a:	f426                	sd	s1,40(sp)
    8000046c:	f04a                	sd	s2,32(sp)
    8000046e:	ec4e                	sd	s3,24(sp)
    80000470:	e852                	sd	s4,16(sp)
    80000472:	e456                	sd	s5,8(sp)
    80000474:	e05a                	sd	s6,0(sp)
    80000476:	0080                	addi	s0,sp,64
    80000478:	84aa                	mv	s1,a0
    8000047a:	89ae                	mv	s3,a1
    8000047c:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    8000047e:	57fd                	li	a5,-1
    80000480:	83e9                	srli	a5,a5,0x1a
    80000482:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000484:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000486:	04b7f263          	bgeu	a5,a1,800004ca <walk+0x66>
    panic("walk");
    8000048a:	00008517          	auipc	a0,0x8
    8000048e:	bc650513          	addi	a0,a0,-1082 # 80008050 <etext+0x50>
    80000492:	00006097          	auipc	ra,0x6
    80000496:	9f0080e7          	jalr	-1552(ra) # 80005e82 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    8000049a:	060a8663          	beqz	s5,80000506 <walk+0xa2>
    8000049e:	00000097          	auipc	ra,0x0
    800004a2:	c7a080e7          	jalr	-902(ra) # 80000118 <kalloc>
    800004a6:	84aa                	mv	s1,a0
    800004a8:	c529                	beqz	a0,800004f2 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800004aa:	6605                	lui	a2,0x1
    800004ac:	4581                	li	a1,0
    800004ae:	00000097          	auipc	ra,0x0
    800004b2:	cca080e7          	jalr	-822(ra) # 80000178 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800004b6:	00c4d793          	srli	a5,s1,0xc
    800004ba:	07aa                	slli	a5,a5,0xa
    800004bc:	0017e793          	ori	a5,a5,1
    800004c0:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800004c4:	3a5d                	addiw	s4,s4,-9
    800004c6:	036a0063          	beq	s4,s6,800004e6 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800004ca:	0149d933          	srl	s2,s3,s4
    800004ce:	1ff97913          	andi	s2,s2,511
    800004d2:	090e                	slli	s2,s2,0x3
    800004d4:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004d6:	00093483          	ld	s1,0(s2)
    800004da:	0014f793          	andi	a5,s1,1
    800004de:	dfd5                	beqz	a5,8000049a <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004e0:	80a9                	srli	s1,s1,0xa
    800004e2:	04b2                	slli	s1,s1,0xc
    800004e4:	b7c5                	j	800004c4 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    800004e6:	00c9d513          	srli	a0,s3,0xc
    800004ea:	1ff57513          	andi	a0,a0,511
    800004ee:	050e                	slli	a0,a0,0x3
    800004f0:	9526                	add	a0,a0,s1
}
    800004f2:	70e2                	ld	ra,56(sp)
    800004f4:	7442                	ld	s0,48(sp)
    800004f6:	74a2                	ld	s1,40(sp)
    800004f8:	7902                	ld	s2,32(sp)
    800004fa:	69e2                	ld	s3,24(sp)
    800004fc:	6a42                	ld	s4,16(sp)
    800004fe:	6aa2                	ld	s5,8(sp)
    80000500:	6b02                	ld	s6,0(sp)
    80000502:	6121                	addi	sp,sp,64
    80000504:	8082                	ret
        return 0;
    80000506:	4501                	li	a0,0
    80000508:	b7ed                	j	800004f2 <walk+0x8e>

000000008000050a <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000050a:	57fd                	li	a5,-1
    8000050c:	83e9                	srli	a5,a5,0x1a
    8000050e:	00b7f463          	bgeu	a5,a1,80000516 <walkaddr+0xc>
    return 0;
    80000512:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000514:	8082                	ret
{
    80000516:	1141                	addi	sp,sp,-16
    80000518:	e406                	sd	ra,8(sp)
    8000051a:	e022                	sd	s0,0(sp)
    8000051c:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000051e:	4601                	li	a2,0
    80000520:	00000097          	auipc	ra,0x0
    80000524:	f44080e7          	jalr	-188(ra) # 80000464 <walk>
  if(pte == 0)
    80000528:	c105                	beqz	a0,80000548 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    8000052a:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000052c:	0117f693          	andi	a3,a5,17
    80000530:	4745                	li	a4,17
    return 0;
    80000532:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000534:	00e68663          	beq	a3,a4,80000540 <walkaddr+0x36>
}
    80000538:	60a2                	ld	ra,8(sp)
    8000053a:	6402                	ld	s0,0(sp)
    8000053c:	0141                	addi	sp,sp,16
    8000053e:	8082                	ret
  pa = PTE2PA(*pte);
    80000540:	00a7d513          	srli	a0,a5,0xa
    80000544:	0532                	slli	a0,a0,0xc
  return pa;
    80000546:	bfcd                	j	80000538 <walkaddr+0x2e>
    return 0;
    80000548:	4501                	li	a0,0
    8000054a:	b7fd                	j	80000538 <walkaddr+0x2e>

000000008000054c <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    8000054c:	715d                	addi	sp,sp,-80
    8000054e:	e486                	sd	ra,72(sp)
    80000550:	e0a2                	sd	s0,64(sp)
    80000552:	fc26                	sd	s1,56(sp)
    80000554:	f84a                	sd	s2,48(sp)
    80000556:	f44e                	sd	s3,40(sp)
    80000558:	f052                	sd	s4,32(sp)
    8000055a:	ec56                	sd	s5,24(sp)
    8000055c:	e85a                	sd	s6,16(sp)
    8000055e:	e45e                	sd	s7,8(sp)
    80000560:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    80000562:	c205                	beqz	a2,80000582 <mappages+0x36>
    80000564:	8aaa                	mv	s5,a0
    80000566:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    80000568:	77fd                	lui	a5,0xfffff
    8000056a:	00f5fa33          	and	s4,a1,a5
  last = PGROUNDDOWN(va + size - 1);
    8000056e:	15fd                	addi	a1,a1,-1
    80000570:	00c589b3          	add	s3,a1,a2
    80000574:	00f9f9b3          	and	s3,s3,a5
  a = PGROUNDDOWN(va);
    80000578:	8952                	mv	s2,s4
    8000057a:	41468a33          	sub	s4,a3,s4
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    8000057e:	6b85                	lui	s7,0x1
    80000580:	a015                	j	800005a4 <mappages+0x58>
    panic("mappages: size");
    80000582:	00008517          	auipc	a0,0x8
    80000586:	ad650513          	addi	a0,a0,-1322 # 80008058 <etext+0x58>
    8000058a:	00006097          	auipc	ra,0x6
    8000058e:	8f8080e7          	jalr	-1800(ra) # 80005e82 <panic>
      panic("mappages: remap");
    80000592:	00008517          	auipc	a0,0x8
    80000596:	ad650513          	addi	a0,a0,-1322 # 80008068 <etext+0x68>
    8000059a:	00006097          	auipc	ra,0x6
    8000059e:	8e8080e7          	jalr	-1816(ra) # 80005e82 <panic>
    a += PGSIZE;
    800005a2:	995e                	add	s2,s2,s7
  for(;;){
    800005a4:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800005a8:	4605                	li	a2,1
    800005aa:	85ca                	mv	a1,s2
    800005ac:	8556                	mv	a0,s5
    800005ae:	00000097          	auipc	ra,0x0
    800005b2:	eb6080e7          	jalr	-330(ra) # 80000464 <walk>
    800005b6:	cd19                	beqz	a0,800005d4 <mappages+0x88>
    if(*pte & PTE_V)
    800005b8:	611c                	ld	a5,0(a0)
    800005ba:	8b85                	andi	a5,a5,1
    800005bc:	fbf9                	bnez	a5,80000592 <mappages+0x46>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800005be:	80b1                	srli	s1,s1,0xc
    800005c0:	04aa                	slli	s1,s1,0xa
    800005c2:	0164e4b3          	or	s1,s1,s6
    800005c6:	0014e493          	ori	s1,s1,1
    800005ca:	e104                	sd	s1,0(a0)
    if(a == last)
    800005cc:	fd391be3          	bne	s2,s3,800005a2 <mappages+0x56>
    pa += PGSIZE;
  }
  return 0;
    800005d0:	4501                	li	a0,0
    800005d2:	a011                	j	800005d6 <mappages+0x8a>
      return -1;
    800005d4:	557d                	li	a0,-1
}
    800005d6:	60a6                	ld	ra,72(sp)
    800005d8:	6406                	ld	s0,64(sp)
    800005da:	74e2                	ld	s1,56(sp)
    800005dc:	7942                	ld	s2,48(sp)
    800005de:	79a2                	ld	s3,40(sp)
    800005e0:	7a02                	ld	s4,32(sp)
    800005e2:	6ae2                	ld	s5,24(sp)
    800005e4:	6b42                	ld	s6,16(sp)
    800005e6:	6ba2                	ld	s7,8(sp)
    800005e8:	6161                	addi	sp,sp,80
    800005ea:	8082                	ret

00000000800005ec <kvmmap>:
{
    800005ec:	1141                	addi	sp,sp,-16
    800005ee:	e406                	sd	ra,8(sp)
    800005f0:	e022                	sd	s0,0(sp)
    800005f2:	0800                	addi	s0,sp,16
    800005f4:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    800005f6:	86b2                	mv	a3,a2
    800005f8:	863e                	mv	a2,a5
    800005fa:	00000097          	auipc	ra,0x0
    800005fe:	f52080e7          	jalr	-174(ra) # 8000054c <mappages>
    80000602:	e509                	bnez	a0,8000060c <kvmmap+0x20>
}
    80000604:	60a2                	ld	ra,8(sp)
    80000606:	6402                	ld	s0,0(sp)
    80000608:	0141                	addi	sp,sp,16
    8000060a:	8082                	ret
    panic("kvmmap");
    8000060c:	00008517          	auipc	a0,0x8
    80000610:	a6c50513          	addi	a0,a0,-1428 # 80008078 <etext+0x78>
    80000614:	00006097          	auipc	ra,0x6
    80000618:	86e080e7          	jalr	-1938(ra) # 80005e82 <panic>

000000008000061c <kvmmake>:
{
    8000061c:	1101                	addi	sp,sp,-32
    8000061e:	ec06                	sd	ra,24(sp)
    80000620:	e822                	sd	s0,16(sp)
    80000622:	e426                	sd	s1,8(sp)
    80000624:	e04a                	sd	s2,0(sp)
    80000626:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000628:	00000097          	auipc	ra,0x0
    8000062c:	af0080e7          	jalr	-1296(ra) # 80000118 <kalloc>
    80000630:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000632:	6605                	lui	a2,0x1
    80000634:	4581                	li	a1,0
    80000636:	00000097          	auipc	ra,0x0
    8000063a:	b42080e7          	jalr	-1214(ra) # 80000178 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    8000063e:	4719                	li	a4,6
    80000640:	6685                	lui	a3,0x1
    80000642:	10000637          	lui	a2,0x10000
    80000646:	100005b7          	lui	a1,0x10000
    8000064a:	8526                	mv	a0,s1
    8000064c:	00000097          	auipc	ra,0x0
    80000650:	fa0080e7          	jalr	-96(ra) # 800005ec <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000654:	4719                	li	a4,6
    80000656:	6685                	lui	a3,0x1
    80000658:	10001637          	lui	a2,0x10001
    8000065c:	100015b7          	lui	a1,0x10001
    80000660:	8526                	mv	a0,s1
    80000662:	00000097          	auipc	ra,0x0
    80000666:	f8a080e7          	jalr	-118(ra) # 800005ec <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    8000066a:	4719                	li	a4,6
    8000066c:	004006b7          	lui	a3,0x400
    80000670:	0c000637          	lui	a2,0xc000
    80000674:	0c0005b7          	lui	a1,0xc000
    80000678:	8526                	mv	a0,s1
    8000067a:	00000097          	auipc	ra,0x0
    8000067e:	f72080e7          	jalr	-142(ra) # 800005ec <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80000682:	00008917          	auipc	s2,0x8
    80000686:	97e90913          	addi	s2,s2,-1666 # 80008000 <etext>
    8000068a:	4729                	li	a4,10
    8000068c:	80008697          	auipc	a3,0x80008
    80000690:	97468693          	addi	a3,a3,-1676 # 8000 <_entry-0x7fff8000>
    80000694:	4605                	li	a2,1
    80000696:	067e                	slli	a2,a2,0x1f
    80000698:	85b2                	mv	a1,a2
    8000069a:	8526                	mv	a0,s1
    8000069c:	00000097          	auipc	ra,0x0
    800006a0:	f50080e7          	jalr	-176(ra) # 800005ec <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800006a4:	4719                	li	a4,6
    800006a6:	46c5                	li	a3,17
    800006a8:	06ee                	slli	a3,a3,0x1b
    800006aa:	412686b3          	sub	a3,a3,s2
    800006ae:	864a                	mv	a2,s2
    800006b0:	85ca                	mv	a1,s2
    800006b2:	8526                	mv	a0,s1
    800006b4:	00000097          	auipc	ra,0x0
    800006b8:	f38080e7          	jalr	-200(ra) # 800005ec <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006bc:	4729                	li	a4,10
    800006be:	6685                	lui	a3,0x1
    800006c0:	00007617          	auipc	a2,0x7
    800006c4:	94060613          	addi	a2,a2,-1728 # 80007000 <_trampoline>
    800006c8:	040005b7          	lui	a1,0x4000
    800006cc:	15fd                	addi	a1,a1,-1
    800006ce:	05b2                	slli	a1,a1,0xc
    800006d0:	8526                	mv	a0,s1
    800006d2:	00000097          	auipc	ra,0x0
    800006d6:	f1a080e7          	jalr	-230(ra) # 800005ec <kvmmap>
  proc_mapstacks(kpgtbl);
    800006da:	8526                	mv	a0,s1
    800006dc:	00000097          	auipc	ra,0x0
    800006e0:	606080e7          	jalr	1542(ra) # 80000ce2 <proc_mapstacks>
}
    800006e4:	8526                	mv	a0,s1
    800006e6:	60e2                	ld	ra,24(sp)
    800006e8:	6442                	ld	s0,16(sp)
    800006ea:	64a2                	ld	s1,8(sp)
    800006ec:	6902                	ld	s2,0(sp)
    800006ee:	6105                	addi	sp,sp,32
    800006f0:	8082                	ret

00000000800006f2 <kvminit>:
{
    800006f2:	1141                	addi	sp,sp,-16
    800006f4:	e406                	sd	ra,8(sp)
    800006f6:	e022                	sd	s0,0(sp)
    800006f8:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    800006fa:	00000097          	auipc	ra,0x0
    800006fe:	f22080e7          	jalr	-222(ra) # 8000061c <kvmmake>
    80000702:	00008797          	auipc	a5,0x8
    80000706:	1ca7b323          	sd	a0,454(a5) # 800088c8 <kernel_pagetable>
}
    8000070a:	60a2                	ld	ra,8(sp)
    8000070c:	6402                	ld	s0,0(sp)
    8000070e:	0141                	addi	sp,sp,16
    80000710:	8082                	ret

0000000080000712 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000712:	715d                	addi	sp,sp,-80
    80000714:	e486                	sd	ra,72(sp)
    80000716:	e0a2                	sd	s0,64(sp)
    80000718:	fc26                	sd	s1,56(sp)
    8000071a:	f84a                	sd	s2,48(sp)
    8000071c:	f44e                	sd	s3,40(sp)
    8000071e:	f052                	sd	s4,32(sp)
    80000720:	ec56                	sd	s5,24(sp)
    80000722:	e85a                	sd	s6,16(sp)
    80000724:	e45e                	sd	s7,8(sp)
    80000726:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000728:	03459793          	slli	a5,a1,0x34
    8000072c:	e795                	bnez	a5,80000758 <uvmunmap+0x46>
    8000072e:	8a2a                	mv	s4,a0
    80000730:	892e                	mv	s2,a1
    80000732:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000734:	0632                	slli	a2,a2,0xc
    80000736:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    8000073a:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000073c:	6b05                	lui	s6,0x1
    8000073e:	0735e863          	bltu	a1,s3,800007ae <uvmunmap+0x9c>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80000742:	60a6                	ld	ra,72(sp)
    80000744:	6406                	ld	s0,64(sp)
    80000746:	74e2                	ld	s1,56(sp)
    80000748:	7942                	ld	s2,48(sp)
    8000074a:	79a2                	ld	s3,40(sp)
    8000074c:	7a02                	ld	s4,32(sp)
    8000074e:	6ae2                	ld	s5,24(sp)
    80000750:	6b42                	ld	s6,16(sp)
    80000752:	6ba2                	ld	s7,8(sp)
    80000754:	6161                	addi	sp,sp,80
    80000756:	8082                	ret
    panic("uvmunmap: not aligned");
    80000758:	00008517          	auipc	a0,0x8
    8000075c:	92850513          	addi	a0,a0,-1752 # 80008080 <etext+0x80>
    80000760:	00005097          	auipc	ra,0x5
    80000764:	722080e7          	jalr	1826(ra) # 80005e82 <panic>
      panic("uvmunmap: walk");
    80000768:	00008517          	auipc	a0,0x8
    8000076c:	93050513          	addi	a0,a0,-1744 # 80008098 <etext+0x98>
    80000770:	00005097          	auipc	ra,0x5
    80000774:	712080e7          	jalr	1810(ra) # 80005e82 <panic>
      panic("uvmunmap: not mapped");
    80000778:	00008517          	auipc	a0,0x8
    8000077c:	93050513          	addi	a0,a0,-1744 # 800080a8 <etext+0xa8>
    80000780:	00005097          	auipc	ra,0x5
    80000784:	702080e7          	jalr	1794(ra) # 80005e82 <panic>
      panic("uvmunmap: not a leaf");
    80000788:	00008517          	auipc	a0,0x8
    8000078c:	93850513          	addi	a0,a0,-1736 # 800080c0 <etext+0xc0>
    80000790:	00005097          	auipc	ra,0x5
    80000794:	6f2080e7          	jalr	1778(ra) # 80005e82 <panic>
      uint64 pa = PTE2PA(*pte);
    80000798:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    8000079a:	0532                	slli	a0,a0,0xc
    8000079c:	00000097          	auipc	ra,0x0
    800007a0:	880080e7          	jalr	-1920(ra) # 8000001c <kfree>
    *pte = 0;
    800007a4:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007a8:	995a                	add	s2,s2,s6
    800007aa:	f9397ce3          	bgeu	s2,s3,80000742 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    800007ae:	4601                	li	a2,0
    800007b0:	85ca                	mv	a1,s2
    800007b2:	8552                	mv	a0,s4
    800007b4:	00000097          	auipc	ra,0x0
    800007b8:	cb0080e7          	jalr	-848(ra) # 80000464 <walk>
    800007bc:	84aa                	mv	s1,a0
    800007be:	d54d                	beqz	a0,80000768 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    800007c0:	6108                	ld	a0,0(a0)
    800007c2:	00157793          	andi	a5,a0,1
    800007c6:	dbcd                	beqz	a5,80000778 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007c8:	3ff57793          	andi	a5,a0,1023
    800007cc:	fb778ee3          	beq	a5,s7,80000788 <uvmunmap+0x76>
    if(do_free){
    800007d0:	fc0a8ae3          	beqz	s5,800007a4 <uvmunmap+0x92>
    800007d4:	b7d1                	j	80000798 <uvmunmap+0x86>

00000000800007d6 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007d6:	1101                	addi	sp,sp,-32
    800007d8:	ec06                	sd	ra,24(sp)
    800007da:	e822                	sd	s0,16(sp)
    800007dc:	e426                	sd	s1,8(sp)
    800007de:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800007e0:	00000097          	auipc	ra,0x0
    800007e4:	938080e7          	jalr	-1736(ra) # 80000118 <kalloc>
    800007e8:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800007ea:	c519                	beqz	a0,800007f8 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    800007ec:	6605                	lui	a2,0x1
    800007ee:	4581                	li	a1,0
    800007f0:	00000097          	auipc	ra,0x0
    800007f4:	988080e7          	jalr	-1656(ra) # 80000178 <memset>
  return pagetable;
}
    800007f8:	8526                	mv	a0,s1
    800007fa:	60e2                	ld	ra,24(sp)
    800007fc:	6442                	ld	s0,16(sp)
    800007fe:	64a2                	ld	s1,8(sp)
    80000800:	6105                	addi	sp,sp,32
    80000802:	8082                	ret

0000000080000804 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80000804:	7179                	addi	sp,sp,-48
    80000806:	f406                	sd	ra,40(sp)
    80000808:	f022                	sd	s0,32(sp)
    8000080a:	ec26                	sd	s1,24(sp)
    8000080c:	e84a                	sd	s2,16(sp)
    8000080e:	e44e                	sd	s3,8(sp)
    80000810:	e052                	sd	s4,0(sp)
    80000812:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000814:	6785                	lui	a5,0x1
    80000816:	04f67863          	bgeu	a2,a5,80000866 <uvmfirst+0x62>
    8000081a:	8a2a                	mv	s4,a0
    8000081c:	89ae                	mv	s3,a1
    8000081e:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    80000820:	00000097          	auipc	ra,0x0
    80000824:	8f8080e7          	jalr	-1800(ra) # 80000118 <kalloc>
    80000828:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    8000082a:	6605                	lui	a2,0x1
    8000082c:	4581                	li	a1,0
    8000082e:	00000097          	auipc	ra,0x0
    80000832:	94a080e7          	jalr	-1718(ra) # 80000178 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80000836:	4779                	li	a4,30
    80000838:	86ca                	mv	a3,s2
    8000083a:	6605                	lui	a2,0x1
    8000083c:	4581                	li	a1,0
    8000083e:	8552                	mv	a0,s4
    80000840:	00000097          	auipc	ra,0x0
    80000844:	d0c080e7          	jalr	-756(ra) # 8000054c <mappages>
  memmove(mem, src, sz);
    80000848:	8626                	mv	a2,s1
    8000084a:	85ce                	mv	a1,s3
    8000084c:	854a                	mv	a0,s2
    8000084e:	00000097          	auipc	ra,0x0
    80000852:	98a080e7          	jalr	-1654(ra) # 800001d8 <memmove>
}
    80000856:	70a2                	ld	ra,40(sp)
    80000858:	7402                	ld	s0,32(sp)
    8000085a:	64e2                	ld	s1,24(sp)
    8000085c:	6942                	ld	s2,16(sp)
    8000085e:	69a2                	ld	s3,8(sp)
    80000860:	6a02                	ld	s4,0(sp)
    80000862:	6145                	addi	sp,sp,48
    80000864:	8082                	ret
    panic("uvmfirst: more than a page");
    80000866:	00008517          	auipc	a0,0x8
    8000086a:	87250513          	addi	a0,a0,-1934 # 800080d8 <etext+0xd8>
    8000086e:	00005097          	auipc	ra,0x5
    80000872:	614080e7          	jalr	1556(ra) # 80005e82 <panic>

0000000080000876 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80000876:	1101                	addi	sp,sp,-32
    80000878:	ec06                	sd	ra,24(sp)
    8000087a:	e822                	sd	s0,16(sp)
    8000087c:	e426                	sd	s1,8(sp)
    8000087e:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80000880:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80000882:	00b67d63          	bgeu	a2,a1,8000089c <uvmdealloc+0x26>
    80000886:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80000888:	6785                	lui	a5,0x1
    8000088a:	17fd                	addi	a5,a5,-1
    8000088c:	00f60733          	add	a4,a2,a5
    80000890:	767d                	lui	a2,0xfffff
    80000892:	8f71                	and	a4,a4,a2
    80000894:	97ae                	add	a5,a5,a1
    80000896:	8ff1                	and	a5,a5,a2
    80000898:	00f76863          	bltu	a4,a5,800008a8 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    8000089c:	8526                	mv	a0,s1
    8000089e:	60e2                	ld	ra,24(sp)
    800008a0:	6442                	ld	s0,16(sp)
    800008a2:	64a2                	ld	s1,8(sp)
    800008a4:	6105                	addi	sp,sp,32
    800008a6:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800008a8:	8f99                	sub	a5,a5,a4
    800008aa:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008ac:	4685                	li	a3,1
    800008ae:	0007861b          	sext.w	a2,a5
    800008b2:	85ba                	mv	a1,a4
    800008b4:	00000097          	auipc	ra,0x0
    800008b8:	e5e080e7          	jalr	-418(ra) # 80000712 <uvmunmap>
    800008bc:	b7c5                	j	8000089c <uvmdealloc+0x26>

00000000800008be <uvmalloc>:
  if(newsz < oldsz)
    800008be:	0ab66563          	bltu	a2,a1,80000968 <uvmalloc+0xaa>
{
    800008c2:	7139                	addi	sp,sp,-64
    800008c4:	fc06                	sd	ra,56(sp)
    800008c6:	f822                	sd	s0,48(sp)
    800008c8:	f426                	sd	s1,40(sp)
    800008ca:	f04a                	sd	s2,32(sp)
    800008cc:	ec4e                	sd	s3,24(sp)
    800008ce:	e852                	sd	s4,16(sp)
    800008d0:	e456                	sd	s5,8(sp)
    800008d2:	e05a                	sd	s6,0(sp)
    800008d4:	0080                	addi	s0,sp,64
    800008d6:	8aaa                	mv	s5,a0
    800008d8:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800008da:	6985                	lui	s3,0x1
    800008dc:	19fd                	addi	s3,s3,-1
    800008de:	95ce                	add	a1,a1,s3
    800008e0:	79fd                	lui	s3,0xfffff
    800008e2:	0135f9b3          	and	s3,a1,s3
  for(a = oldsz; a < newsz; a += PGSIZE){
    800008e6:	08c9f363          	bgeu	s3,a2,8000096c <uvmalloc+0xae>
    800008ea:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    800008ec:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    800008f0:	00000097          	auipc	ra,0x0
    800008f4:	828080e7          	jalr	-2008(ra) # 80000118 <kalloc>
    800008f8:	84aa                	mv	s1,a0
    if(mem == 0){
    800008fa:	c51d                	beqz	a0,80000928 <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    800008fc:	6605                	lui	a2,0x1
    800008fe:	4581                	li	a1,0
    80000900:	00000097          	auipc	ra,0x0
    80000904:	878080e7          	jalr	-1928(ra) # 80000178 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000908:	875a                	mv	a4,s6
    8000090a:	86a6                	mv	a3,s1
    8000090c:	6605                	lui	a2,0x1
    8000090e:	85ca                	mv	a1,s2
    80000910:	8556                	mv	a0,s5
    80000912:	00000097          	auipc	ra,0x0
    80000916:	c3a080e7          	jalr	-966(ra) # 8000054c <mappages>
    8000091a:	e90d                	bnez	a0,8000094c <uvmalloc+0x8e>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000091c:	6785                	lui	a5,0x1
    8000091e:	993e                	add	s2,s2,a5
    80000920:	fd4968e3          	bltu	s2,s4,800008f0 <uvmalloc+0x32>
  return newsz;
    80000924:	8552                	mv	a0,s4
    80000926:	a809                	j	80000938 <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    80000928:	864e                	mv	a2,s3
    8000092a:	85ca                	mv	a1,s2
    8000092c:	8556                	mv	a0,s5
    8000092e:	00000097          	auipc	ra,0x0
    80000932:	f48080e7          	jalr	-184(ra) # 80000876 <uvmdealloc>
      return 0;
    80000936:	4501                	li	a0,0
}
    80000938:	70e2                	ld	ra,56(sp)
    8000093a:	7442                	ld	s0,48(sp)
    8000093c:	74a2                	ld	s1,40(sp)
    8000093e:	7902                	ld	s2,32(sp)
    80000940:	69e2                	ld	s3,24(sp)
    80000942:	6a42                	ld	s4,16(sp)
    80000944:	6aa2                	ld	s5,8(sp)
    80000946:	6b02                	ld	s6,0(sp)
    80000948:	6121                	addi	sp,sp,64
    8000094a:	8082                	ret
      kfree(mem);
    8000094c:	8526                	mv	a0,s1
    8000094e:	fffff097          	auipc	ra,0xfffff
    80000952:	6ce080e7          	jalr	1742(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000956:	864e                	mv	a2,s3
    80000958:	85ca                	mv	a1,s2
    8000095a:	8556                	mv	a0,s5
    8000095c:	00000097          	auipc	ra,0x0
    80000960:	f1a080e7          	jalr	-230(ra) # 80000876 <uvmdealloc>
      return 0;
    80000964:	4501                	li	a0,0
    80000966:	bfc9                	j	80000938 <uvmalloc+0x7a>
    return oldsz;
    80000968:	852e                	mv	a0,a1
}
    8000096a:	8082                	ret
  return newsz;
    8000096c:	8532                	mv	a0,a2
    8000096e:	b7e9                	j	80000938 <uvmalloc+0x7a>

0000000080000970 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80000970:	7179                	addi	sp,sp,-48
    80000972:	f406                	sd	ra,40(sp)
    80000974:	f022                	sd	s0,32(sp)
    80000976:	ec26                	sd	s1,24(sp)
    80000978:	e84a                	sd	s2,16(sp)
    8000097a:	e44e                	sd	s3,8(sp)
    8000097c:	e052                	sd	s4,0(sp)
    8000097e:	1800                	addi	s0,sp,48
    80000980:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000982:	84aa                	mv	s1,a0
    80000984:	6905                	lui	s2,0x1
    80000986:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000988:	4985                	li	s3,1
    8000098a:	a821                	j	800009a2 <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    8000098c:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    8000098e:	0532                	slli	a0,a0,0xc
    80000990:	00000097          	auipc	ra,0x0
    80000994:	fe0080e7          	jalr	-32(ra) # 80000970 <freewalk>
      pagetable[i] = 0;
    80000998:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    8000099c:	04a1                	addi	s1,s1,8
    8000099e:	03248163          	beq	s1,s2,800009c0 <freewalk+0x50>
    pte_t pte = pagetable[i];
    800009a2:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009a4:	00f57793          	andi	a5,a0,15
    800009a8:	ff3782e3          	beq	a5,s3,8000098c <freewalk+0x1c>
    } else if(pte & PTE_V){
    800009ac:	8905                	andi	a0,a0,1
    800009ae:	d57d                	beqz	a0,8000099c <freewalk+0x2c>
      panic("freewalk: leaf");
    800009b0:	00007517          	auipc	a0,0x7
    800009b4:	74850513          	addi	a0,a0,1864 # 800080f8 <etext+0xf8>
    800009b8:	00005097          	auipc	ra,0x5
    800009bc:	4ca080e7          	jalr	1226(ra) # 80005e82 <panic>
    }
  }
  kfree((void*)pagetable);
    800009c0:	8552                	mv	a0,s4
    800009c2:	fffff097          	auipc	ra,0xfffff
    800009c6:	65a080e7          	jalr	1626(ra) # 8000001c <kfree>
}
    800009ca:	70a2                	ld	ra,40(sp)
    800009cc:	7402                	ld	s0,32(sp)
    800009ce:	64e2                	ld	s1,24(sp)
    800009d0:	6942                	ld	s2,16(sp)
    800009d2:	69a2                	ld	s3,8(sp)
    800009d4:	6a02                	ld	s4,0(sp)
    800009d6:	6145                	addi	sp,sp,48
    800009d8:	8082                	ret

00000000800009da <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800009da:	1101                	addi	sp,sp,-32
    800009dc:	ec06                	sd	ra,24(sp)
    800009de:	e822                	sd	s0,16(sp)
    800009e0:	e426                	sd	s1,8(sp)
    800009e2:	1000                	addi	s0,sp,32
    800009e4:	84aa                	mv	s1,a0
  if(sz > 0)
    800009e6:	e999                	bnez	a1,800009fc <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    800009e8:	8526                	mv	a0,s1
    800009ea:	00000097          	auipc	ra,0x0
    800009ee:	f86080e7          	jalr	-122(ra) # 80000970 <freewalk>
}
    800009f2:	60e2                	ld	ra,24(sp)
    800009f4:	6442                	ld	s0,16(sp)
    800009f6:	64a2                	ld	s1,8(sp)
    800009f8:	6105                	addi	sp,sp,32
    800009fa:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    800009fc:	6605                	lui	a2,0x1
    800009fe:	167d                	addi	a2,a2,-1
    80000a00:	962e                	add	a2,a2,a1
    80000a02:	4685                	li	a3,1
    80000a04:	8231                	srli	a2,a2,0xc
    80000a06:	4581                	li	a1,0
    80000a08:	00000097          	auipc	ra,0x0
    80000a0c:	d0a080e7          	jalr	-758(ra) # 80000712 <uvmunmap>
    80000a10:	bfe1                	j	800009e8 <uvmfree+0xe>

0000000080000a12 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000a12:	c679                	beqz	a2,80000ae0 <uvmcopy+0xce>
{
    80000a14:	715d                	addi	sp,sp,-80
    80000a16:	e486                	sd	ra,72(sp)
    80000a18:	e0a2                	sd	s0,64(sp)
    80000a1a:	fc26                	sd	s1,56(sp)
    80000a1c:	f84a                	sd	s2,48(sp)
    80000a1e:	f44e                	sd	s3,40(sp)
    80000a20:	f052                	sd	s4,32(sp)
    80000a22:	ec56                	sd	s5,24(sp)
    80000a24:	e85a                	sd	s6,16(sp)
    80000a26:	e45e                	sd	s7,8(sp)
    80000a28:	0880                	addi	s0,sp,80
    80000a2a:	8b2a                	mv	s6,a0
    80000a2c:	8aae                	mv	s5,a1
    80000a2e:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a30:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000a32:	4601                	li	a2,0
    80000a34:	85ce                	mv	a1,s3
    80000a36:	855a                	mv	a0,s6
    80000a38:	00000097          	auipc	ra,0x0
    80000a3c:	a2c080e7          	jalr	-1492(ra) # 80000464 <walk>
    80000a40:	c531                	beqz	a0,80000a8c <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000a42:	6118                	ld	a4,0(a0)
    80000a44:	00177793          	andi	a5,a4,1
    80000a48:	cbb1                	beqz	a5,80000a9c <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000a4a:	00a75593          	srli	a1,a4,0xa
    80000a4e:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a52:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000a56:	fffff097          	auipc	ra,0xfffff
    80000a5a:	6c2080e7          	jalr	1730(ra) # 80000118 <kalloc>
    80000a5e:	892a                	mv	s2,a0
    80000a60:	c939                	beqz	a0,80000ab6 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000a62:	6605                	lui	a2,0x1
    80000a64:	85de                	mv	a1,s7
    80000a66:	fffff097          	auipc	ra,0xfffff
    80000a6a:	772080e7          	jalr	1906(ra) # 800001d8 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000a6e:	8726                	mv	a4,s1
    80000a70:	86ca                	mv	a3,s2
    80000a72:	6605                	lui	a2,0x1
    80000a74:	85ce                	mv	a1,s3
    80000a76:	8556                	mv	a0,s5
    80000a78:	00000097          	auipc	ra,0x0
    80000a7c:	ad4080e7          	jalr	-1324(ra) # 8000054c <mappages>
    80000a80:	e515                	bnez	a0,80000aac <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000a82:	6785                	lui	a5,0x1
    80000a84:	99be                	add	s3,s3,a5
    80000a86:	fb49e6e3          	bltu	s3,s4,80000a32 <uvmcopy+0x20>
    80000a8a:	a081                	j	80000aca <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000a8c:	00007517          	auipc	a0,0x7
    80000a90:	67c50513          	addi	a0,a0,1660 # 80008108 <etext+0x108>
    80000a94:	00005097          	auipc	ra,0x5
    80000a98:	3ee080e7          	jalr	1006(ra) # 80005e82 <panic>
      panic("uvmcopy: page not present");
    80000a9c:	00007517          	auipc	a0,0x7
    80000aa0:	68c50513          	addi	a0,a0,1676 # 80008128 <etext+0x128>
    80000aa4:	00005097          	auipc	ra,0x5
    80000aa8:	3de080e7          	jalr	990(ra) # 80005e82 <panic>
      kfree(mem);
    80000aac:	854a                	mv	a0,s2
    80000aae:	fffff097          	auipc	ra,0xfffff
    80000ab2:	56e080e7          	jalr	1390(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000ab6:	4685                	li	a3,1
    80000ab8:	00c9d613          	srli	a2,s3,0xc
    80000abc:	4581                	li	a1,0
    80000abe:	8556                	mv	a0,s5
    80000ac0:	00000097          	auipc	ra,0x0
    80000ac4:	c52080e7          	jalr	-942(ra) # 80000712 <uvmunmap>
  return -1;
    80000ac8:	557d                	li	a0,-1
}
    80000aca:	60a6                	ld	ra,72(sp)
    80000acc:	6406                	ld	s0,64(sp)
    80000ace:	74e2                	ld	s1,56(sp)
    80000ad0:	7942                	ld	s2,48(sp)
    80000ad2:	79a2                	ld	s3,40(sp)
    80000ad4:	7a02                	ld	s4,32(sp)
    80000ad6:	6ae2                	ld	s5,24(sp)
    80000ad8:	6b42                	ld	s6,16(sp)
    80000ada:	6ba2                	ld	s7,8(sp)
    80000adc:	6161                	addi	sp,sp,80
    80000ade:	8082                	ret
  return 0;
    80000ae0:	4501                	li	a0,0
}
    80000ae2:	8082                	ret

0000000080000ae4 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000ae4:	1141                	addi	sp,sp,-16
    80000ae6:	e406                	sd	ra,8(sp)
    80000ae8:	e022                	sd	s0,0(sp)
    80000aea:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000aec:	4601                	li	a2,0
    80000aee:	00000097          	auipc	ra,0x0
    80000af2:	976080e7          	jalr	-1674(ra) # 80000464 <walk>
  if(pte == 0)
    80000af6:	c901                	beqz	a0,80000b06 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000af8:	611c                	ld	a5,0(a0)
    80000afa:	9bbd                	andi	a5,a5,-17
    80000afc:	e11c                	sd	a5,0(a0)
}
    80000afe:	60a2                	ld	ra,8(sp)
    80000b00:	6402                	ld	s0,0(sp)
    80000b02:	0141                	addi	sp,sp,16
    80000b04:	8082                	ret
    panic("uvmclear");
    80000b06:	00007517          	auipc	a0,0x7
    80000b0a:	64250513          	addi	a0,a0,1602 # 80008148 <etext+0x148>
    80000b0e:	00005097          	auipc	ra,0x5
    80000b12:	374080e7          	jalr	884(ra) # 80005e82 <panic>

0000000080000b16 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b16:	c6bd                	beqz	a3,80000b84 <copyout+0x6e>
{
    80000b18:	715d                	addi	sp,sp,-80
    80000b1a:	e486                	sd	ra,72(sp)
    80000b1c:	e0a2                	sd	s0,64(sp)
    80000b1e:	fc26                	sd	s1,56(sp)
    80000b20:	f84a                	sd	s2,48(sp)
    80000b22:	f44e                	sd	s3,40(sp)
    80000b24:	f052                	sd	s4,32(sp)
    80000b26:	ec56                	sd	s5,24(sp)
    80000b28:	e85a                	sd	s6,16(sp)
    80000b2a:	e45e                	sd	s7,8(sp)
    80000b2c:	e062                	sd	s8,0(sp)
    80000b2e:	0880                	addi	s0,sp,80
    80000b30:	8b2a                	mv	s6,a0
    80000b32:	8c2e                	mv	s8,a1
    80000b34:	8a32                	mv	s4,a2
    80000b36:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b38:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000b3a:	6a85                	lui	s5,0x1
    80000b3c:	a015                	j	80000b60 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b3e:	9562                	add	a0,a0,s8
    80000b40:	0004861b          	sext.w	a2,s1
    80000b44:	85d2                	mv	a1,s4
    80000b46:	41250533          	sub	a0,a0,s2
    80000b4a:	fffff097          	auipc	ra,0xfffff
    80000b4e:	68e080e7          	jalr	1678(ra) # 800001d8 <memmove>

    len -= n;
    80000b52:	409989b3          	sub	s3,s3,s1
    src += n;
    80000b56:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000b58:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000b5c:	02098263          	beqz	s3,80000b80 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000b60:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b64:	85ca                	mv	a1,s2
    80000b66:	855a                	mv	a0,s6
    80000b68:	00000097          	auipc	ra,0x0
    80000b6c:	9a2080e7          	jalr	-1630(ra) # 8000050a <walkaddr>
    if(pa0 == 0)
    80000b70:	cd01                	beqz	a0,80000b88 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000b72:	418904b3          	sub	s1,s2,s8
    80000b76:	94d6                	add	s1,s1,s5
    if(n > len)
    80000b78:	fc99f3e3          	bgeu	s3,s1,80000b3e <copyout+0x28>
    80000b7c:	84ce                	mv	s1,s3
    80000b7e:	b7c1                	j	80000b3e <copyout+0x28>
  }
  return 0;
    80000b80:	4501                	li	a0,0
    80000b82:	a021                	j	80000b8a <copyout+0x74>
    80000b84:	4501                	li	a0,0
}
    80000b86:	8082                	ret
      return -1;
    80000b88:	557d                	li	a0,-1
}
    80000b8a:	60a6                	ld	ra,72(sp)
    80000b8c:	6406                	ld	s0,64(sp)
    80000b8e:	74e2                	ld	s1,56(sp)
    80000b90:	7942                	ld	s2,48(sp)
    80000b92:	79a2                	ld	s3,40(sp)
    80000b94:	7a02                	ld	s4,32(sp)
    80000b96:	6ae2                	ld	s5,24(sp)
    80000b98:	6b42                	ld	s6,16(sp)
    80000b9a:	6ba2                	ld	s7,8(sp)
    80000b9c:	6c02                	ld	s8,0(sp)
    80000b9e:	6161                	addi	sp,sp,80
    80000ba0:	8082                	ret

0000000080000ba2 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000ba2:	c6bd                	beqz	a3,80000c10 <copyin+0x6e>
{
    80000ba4:	715d                	addi	sp,sp,-80
    80000ba6:	e486                	sd	ra,72(sp)
    80000ba8:	e0a2                	sd	s0,64(sp)
    80000baa:	fc26                	sd	s1,56(sp)
    80000bac:	f84a                	sd	s2,48(sp)
    80000bae:	f44e                	sd	s3,40(sp)
    80000bb0:	f052                	sd	s4,32(sp)
    80000bb2:	ec56                	sd	s5,24(sp)
    80000bb4:	e85a                	sd	s6,16(sp)
    80000bb6:	e45e                	sd	s7,8(sp)
    80000bb8:	e062                	sd	s8,0(sp)
    80000bba:	0880                	addi	s0,sp,80
    80000bbc:	8b2a                	mv	s6,a0
    80000bbe:	8a2e                	mv	s4,a1
    80000bc0:	8c32                	mv	s8,a2
    80000bc2:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000bc4:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000bc6:	6a85                	lui	s5,0x1
    80000bc8:	a015                	j	80000bec <copyin+0x4a>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000bca:	9562                	add	a0,a0,s8
    80000bcc:	0004861b          	sext.w	a2,s1
    80000bd0:	412505b3          	sub	a1,a0,s2
    80000bd4:	8552                	mv	a0,s4
    80000bd6:	fffff097          	auipc	ra,0xfffff
    80000bda:	602080e7          	jalr	1538(ra) # 800001d8 <memmove>

    len -= n;
    80000bde:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000be2:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000be4:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000be8:	02098263          	beqz	s3,80000c0c <copyin+0x6a>
    va0 = PGROUNDDOWN(srcva);
    80000bec:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000bf0:	85ca                	mv	a1,s2
    80000bf2:	855a                	mv	a0,s6
    80000bf4:	00000097          	auipc	ra,0x0
    80000bf8:	916080e7          	jalr	-1770(ra) # 8000050a <walkaddr>
    if(pa0 == 0)
    80000bfc:	cd01                	beqz	a0,80000c14 <copyin+0x72>
    n = PGSIZE - (srcva - va0);
    80000bfe:	418904b3          	sub	s1,s2,s8
    80000c02:	94d6                	add	s1,s1,s5
    if(n > len)
    80000c04:	fc99f3e3          	bgeu	s3,s1,80000bca <copyin+0x28>
    80000c08:	84ce                	mv	s1,s3
    80000c0a:	b7c1                	j	80000bca <copyin+0x28>
  }
  return 0;
    80000c0c:	4501                	li	a0,0
    80000c0e:	a021                	j	80000c16 <copyin+0x74>
    80000c10:	4501                	li	a0,0
}
    80000c12:	8082                	ret
      return -1;
    80000c14:	557d                	li	a0,-1
}
    80000c16:	60a6                	ld	ra,72(sp)
    80000c18:	6406                	ld	s0,64(sp)
    80000c1a:	74e2                	ld	s1,56(sp)
    80000c1c:	7942                	ld	s2,48(sp)
    80000c1e:	79a2                	ld	s3,40(sp)
    80000c20:	7a02                	ld	s4,32(sp)
    80000c22:	6ae2                	ld	s5,24(sp)
    80000c24:	6b42                	ld	s6,16(sp)
    80000c26:	6ba2                	ld	s7,8(sp)
    80000c28:	6c02                	ld	s8,0(sp)
    80000c2a:	6161                	addi	sp,sp,80
    80000c2c:	8082                	ret

0000000080000c2e <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000c2e:	c6c5                	beqz	a3,80000cd6 <copyinstr+0xa8>
{
    80000c30:	715d                	addi	sp,sp,-80
    80000c32:	e486                	sd	ra,72(sp)
    80000c34:	e0a2                	sd	s0,64(sp)
    80000c36:	fc26                	sd	s1,56(sp)
    80000c38:	f84a                	sd	s2,48(sp)
    80000c3a:	f44e                	sd	s3,40(sp)
    80000c3c:	f052                	sd	s4,32(sp)
    80000c3e:	ec56                	sd	s5,24(sp)
    80000c40:	e85a                	sd	s6,16(sp)
    80000c42:	e45e                	sd	s7,8(sp)
    80000c44:	0880                	addi	s0,sp,80
    80000c46:	8a2a                	mv	s4,a0
    80000c48:	8b2e                	mv	s6,a1
    80000c4a:	8bb2                	mv	s7,a2
    80000c4c:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000c4e:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c50:	6985                	lui	s3,0x1
    80000c52:	a035                	j	80000c7e <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000c54:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000c58:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000c5a:	0017b793          	seqz	a5,a5
    80000c5e:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000c62:	60a6                	ld	ra,72(sp)
    80000c64:	6406                	ld	s0,64(sp)
    80000c66:	74e2                	ld	s1,56(sp)
    80000c68:	7942                	ld	s2,48(sp)
    80000c6a:	79a2                	ld	s3,40(sp)
    80000c6c:	7a02                	ld	s4,32(sp)
    80000c6e:	6ae2                	ld	s5,24(sp)
    80000c70:	6b42                	ld	s6,16(sp)
    80000c72:	6ba2                	ld	s7,8(sp)
    80000c74:	6161                	addi	sp,sp,80
    80000c76:	8082                	ret
    srcva = va0 + PGSIZE;
    80000c78:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000c7c:	c8a9                	beqz	s1,80000cce <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80000c7e:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000c82:	85ca                	mv	a1,s2
    80000c84:	8552                	mv	a0,s4
    80000c86:	00000097          	auipc	ra,0x0
    80000c8a:	884080e7          	jalr	-1916(ra) # 8000050a <walkaddr>
    if(pa0 == 0)
    80000c8e:	c131                	beqz	a0,80000cd2 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80000c90:	41790833          	sub	a6,s2,s7
    80000c94:	984e                	add	a6,a6,s3
    if(n > max)
    80000c96:	0104f363          	bgeu	s1,a6,80000c9c <copyinstr+0x6e>
    80000c9a:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000c9c:	955e                	add	a0,a0,s7
    80000c9e:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000ca2:	fc080be3          	beqz	a6,80000c78 <copyinstr+0x4a>
    80000ca6:	985a                	add	a6,a6,s6
    80000ca8:	87da                	mv	a5,s6
      if(*p == '\0'){
    80000caa:	41650633          	sub	a2,a0,s6
    80000cae:	14fd                	addi	s1,s1,-1
    80000cb0:	9b26                	add	s6,s6,s1
    80000cb2:	00f60733          	add	a4,a2,a5
    80000cb6:	00074703          	lbu	a4,0(a4)
    80000cba:	df49                	beqz	a4,80000c54 <copyinstr+0x26>
        *dst = *p;
    80000cbc:	00e78023          	sb	a4,0(a5)
      --max;
    80000cc0:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80000cc4:	0785                	addi	a5,a5,1
    while(n > 0){
    80000cc6:	ff0796e3          	bne	a5,a6,80000cb2 <copyinstr+0x84>
      dst++;
    80000cca:	8b42                	mv	s6,a6
    80000ccc:	b775                	j	80000c78 <copyinstr+0x4a>
    80000cce:	4781                	li	a5,0
    80000cd0:	b769                	j	80000c5a <copyinstr+0x2c>
      return -1;
    80000cd2:	557d                	li	a0,-1
    80000cd4:	b779                	j	80000c62 <copyinstr+0x34>
  int got_null = 0;
    80000cd6:	4781                	li	a5,0
  if(got_null){
    80000cd8:	0017b793          	seqz	a5,a5
    80000cdc:	40f00533          	neg	a0,a5
}
    80000ce0:	8082                	ret

0000000080000ce2 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000ce2:	7139                	addi	sp,sp,-64
    80000ce4:	fc06                	sd	ra,56(sp)
    80000ce6:	f822                	sd	s0,48(sp)
    80000ce8:	f426                	sd	s1,40(sp)
    80000cea:	f04a                	sd	s2,32(sp)
    80000cec:	ec4e                	sd	s3,24(sp)
    80000cee:	e852                	sd	s4,16(sp)
    80000cf0:	e456                	sd	s5,8(sp)
    80000cf2:	e05a                	sd	s6,0(sp)
    80000cf4:	0080                	addi	s0,sp,64
    80000cf6:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000cf8:	00008497          	auipc	s1,0x8
    80000cfc:	04848493          	addi	s1,s1,72 # 80008d40 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000d00:	8b26                	mv	s6,s1
    80000d02:	00007a97          	auipc	s5,0x7
    80000d06:	2fea8a93          	addi	s5,s5,766 # 80008000 <etext>
    80000d0a:	04000937          	lui	s2,0x4000
    80000d0e:	197d                	addi	s2,s2,-1
    80000d10:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d12:	00009a17          	auipc	s4,0x9
    80000d16:	e3ea0a13          	addi	s4,s4,-450 # 80009b50 <tickslock>
    char *pa = kalloc();
    80000d1a:	fffff097          	auipc	ra,0xfffff
    80000d1e:	3fe080e7          	jalr	1022(ra) # 80000118 <kalloc>
    80000d22:	862a                	mv	a2,a0
    if(pa == 0)
    80000d24:	c131                	beqz	a0,80000d68 <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80000d26:	416485b3          	sub	a1,s1,s6
    80000d2a:	858d                	srai	a1,a1,0x3
    80000d2c:	000ab783          	ld	a5,0(s5)
    80000d30:	02f585b3          	mul	a1,a1,a5
    80000d34:	2585                	addiw	a1,a1,1
    80000d36:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000d3a:	4719                	li	a4,6
    80000d3c:	6685                	lui	a3,0x1
    80000d3e:	40b905b3          	sub	a1,s2,a1
    80000d42:	854e                	mv	a0,s3
    80000d44:	00000097          	auipc	ra,0x0
    80000d48:	8a8080e7          	jalr	-1880(ra) # 800005ec <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d4c:	16848493          	addi	s1,s1,360
    80000d50:	fd4495e3          	bne	s1,s4,80000d1a <proc_mapstacks+0x38>
  }
}
    80000d54:	70e2                	ld	ra,56(sp)
    80000d56:	7442                	ld	s0,48(sp)
    80000d58:	74a2                	ld	s1,40(sp)
    80000d5a:	7902                	ld	s2,32(sp)
    80000d5c:	69e2                	ld	s3,24(sp)
    80000d5e:	6a42                	ld	s4,16(sp)
    80000d60:	6aa2                	ld	s5,8(sp)
    80000d62:	6b02                	ld	s6,0(sp)
    80000d64:	6121                	addi	sp,sp,64
    80000d66:	8082                	ret
      panic("kalloc");
    80000d68:	00007517          	auipc	a0,0x7
    80000d6c:	3f050513          	addi	a0,a0,1008 # 80008158 <etext+0x158>
    80000d70:	00005097          	auipc	ra,0x5
    80000d74:	112080e7          	jalr	274(ra) # 80005e82 <panic>

0000000080000d78 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000d78:	7139                	addi	sp,sp,-64
    80000d7a:	fc06                	sd	ra,56(sp)
    80000d7c:	f822                	sd	s0,48(sp)
    80000d7e:	f426                	sd	s1,40(sp)
    80000d80:	f04a                	sd	s2,32(sp)
    80000d82:	ec4e                	sd	s3,24(sp)
    80000d84:	e852                	sd	s4,16(sp)
    80000d86:	e456                	sd	s5,8(sp)
    80000d88:	e05a                	sd	s6,0(sp)
    80000d8a:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000d8c:	00007597          	auipc	a1,0x7
    80000d90:	3d458593          	addi	a1,a1,980 # 80008160 <etext+0x160>
    80000d94:	00008517          	auipc	a0,0x8
    80000d98:	b7c50513          	addi	a0,a0,-1156 # 80008910 <pid_lock>
    80000d9c:	00005097          	auipc	ra,0x5
    80000da0:	5a0080e7          	jalr	1440(ra) # 8000633c <initlock>
  initlock(&wait_lock, "wait_lock");
    80000da4:	00007597          	auipc	a1,0x7
    80000da8:	3c458593          	addi	a1,a1,964 # 80008168 <etext+0x168>
    80000dac:	00008517          	auipc	a0,0x8
    80000db0:	b7c50513          	addi	a0,a0,-1156 # 80008928 <wait_lock>
    80000db4:	00005097          	auipc	ra,0x5
    80000db8:	588080e7          	jalr	1416(ra) # 8000633c <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dbc:	00008497          	auipc	s1,0x8
    80000dc0:	f8448493          	addi	s1,s1,-124 # 80008d40 <proc>
      initlock(&p->lock, "proc");
    80000dc4:	00007b17          	auipc	s6,0x7
    80000dc8:	3b4b0b13          	addi	s6,s6,948 # 80008178 <etext+0x178>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000dcc:	8aa6                	mv	s5,s1
    80000dce:	00007a17          	auipc	s4,0x7
    80000dd2:	232a0a13          	addi	s4,s4,562 # 80008000 <etext>
    80000dd6:	04000937          	lui	s2,0x4000
    80000dda:	197d                	addi	s2,s2,-1
    80000ddc:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dde:	00009997          	auipc	s3,0x9
    80000de2:	d7298993          	addi	s3,s3,-654 # 80009b50 <tickslock>
      initlock(&p->lock, "proc");
    80000de6:	85da                	mv	a1,s6
    80000de8:	8526                	mv	a0,s1
    80000dea:	00005097          	auipc	ra,0x5
    80000dee:	552080e7          	jalr	1362(ra) # 8000633c <initlock>
      p->state = UNUSED;
    80000df2:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000df6:	415487b3          	sub	a5,s1,s5
    80000dfa:	878d                	srai	a5,a5,0x3
    80000dfc:	000a3703          	ld	a4,0(s4)
    80000e00:	02e787b3          	mul	a5,a5,a4
    80000e04:	2785                	addiw	a5,a5,1
    80000e06:	00d7979b          	slliw	a5,a5,0xd
    80000e0a:	40f907b3          	sub	a5,s2,a5
    80000e0e:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e10:	16848493          	addi	s1,s1,360
    80000e14:	fd3499e3          	bne	s1,s3,80000de6 <procinit+0x6e>
  }
}
    80000e18:	70e2                	ld	ra,56(sp)
    80000e1a:	7442                	ld	s0,48(sp)
    80000e1c:	74a2                	ld	s1,40(sp)
    80000e1e:	7902                	ld	s2,32(sp)
    80000e20:	69e2                	ld	s3,24(sp)
    80000e22:	6a42                	ld	s4,16(sp)
    80000e24:	6aa2                	ld	s5,8(sp)
    80000e26:	6b02                	ld	s6,0(sp)
    80000e28:	6121                	addi	sp,sp,64
    80000e2a:	8082                	ret

0000000080000e2c <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000e2c:	1141                	addi	sp,sp,-16
    80000e2e:	e422                	sd	s0,8(sp)
    80000e30:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000e32:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000e34:	2501                	sext.w	a0,a0
    80000e36:	6422                	ld	s0,8(sp)
    80000e38:	0141                	addi	sp,sp,16
    80000e3a:	8082                	ret

0000000080000e3c <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000e3c:	1141                	addi	sp,sp,-16
    80000e3e:	e422                	sd	s0,8(sp)
    80000e40:	0800                	addi	s0,sp,16
    80000e42:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000e44:	2781                	sext.w	a5,a5
    80000e46:	079e                	slli	a5,a5,0x7
  return c;
}
    80000e48:	00008517          	auipc	a0,0x8
    80000e4c:	af850513          	addi	a0,a0,-1288 # 80008940 <cpus>
    80000e50:	953e                	add	a0,a0,a5
    80000e52:	6422                	ld	s0,8(sp)
    80000e54:	0141                	addi	sp,sp,16
    80000e56:	8082                	ret

0000000080000e58 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000e58:	1101                	addi	sp,sp,-32
    80000e5a:	ec06                	sd	ra,24(sp)
    80000e5c:	e822                	sd	s0,16(sp)
    80000e5e:	e426                	sd	s1,8(sp)
    80000e60:	1000                	addi	s0,sp,32
  push_off();
    80000e62:	00005097          	auipc	ra,0x5
    80000e66:	51e080e7          	jalr	1310(ra) # 80006380 <push_off>
    80000e6a:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000e6c:	2781                	sext.w	a5,a5
    80000e6e:	079e                	slli	a5,a5,0x7
    80000e70:	00008717          	auipc	a4,0x8
    80000e74:	aa070713          	addi	a4,a4,-1376 # 80008910 <pid_lock>
    80000e78:	97ba                	add	a5,a5,a4
    80000e7a:	7b84                	ld	s1,48(a5)
  pop_off();
    80000e7c:	00005097          	auipc	ra,0x5
    80000e80:	5a4080e7          	jalr	1444(ra) # 80006420 <pop_off>
  return p;
}
    80000e84:	8526                	mv	a0,s1
    80000e86:	60e2                	ld	ra,24(sp)
    80000e88:	6442                	ld	s0,16(sp)
    80000e8a:	64a2                	ld	s1,8(sp)
    80000e8c:	6105                	addi	sp,sp,32
    80000e8e:	8082                	ret

0000000080000e90 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000e90:	1141                	addi	sp,sp,-16
    80000e92:	e406                	sd	ra,8(sp)
    80000e94:	e022                	sd	s0,0(sp)
    80000e96:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000e98:	00000097          	auipc	ra,0x0
    80000e9c:	fc0080e7          	jalr	-64(ra) # 80000e58 <myproc>
    80000ea0:	00005097          	auipc	ra,0x5
    80000ea4:	5e0080e7          	jalr	1504(ra) # 80006480 <release>

  if (first) {
    80000ea8:	00008797          	auipc	a5,0x8
    80000eac:	9a87a783          	lw	a5,-1624(a5) # 80008850 <first.1678>
    80000eb0:	eb89                	bnez	a5,80000ec2 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80000eb2:	00001097          	auipc	ra,0x1
    80000eb6:	c56080e7          	jalr	-938(ra) # 80001b08 <usertrapret>
}
    80000eba:	60a2                	ld	ra,8(sp)
    80000ebc:	6402                	ld	s0,0(sp)
    80000ebe:	0141                	addi	sp,sp,16
    80000ec0:	8082                	ret
    first = 0;
    80000ec2:	00008797          	auipc	a5,0x8
    80000ec6:	9807a723          	sw	zero,-1650(a5) # 80008850 <first.1678>
    fsinit(ROOTDEV);
    80000eca:	4505                	li	a0,1
    80000ecc:	00002097          	auipc	ra,0x2
    80000ed0:	a6a080e7          	jalr	-1430(ra) # 80002936 <fsinit>
    80000ed4:	bff9                	j	80000eb2 <forkret+0x22>

0000000080000ed6 <allocpid>:
{
    80000ed6:	1101                	addi	sp,sp,-32
    80000ed8:	ec06                	sd	ra,24(sp)
    80000eda:	e822                	sd	s0,16(sp)
    80000edc:	e426                	sd	s1,8(sp)
    80000ede:	e04a                	sd	s2,0(sp)
    80000ee0:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000ee2:	00008917          	auipc	s2,0x8
    80000ee6:	a2e90913          	addi	s2,s2,-1490 # 80008910 <pid_lock>
    80000eea:	854a                	mv	a0,s2
    80000eec:	00005097          	auipc	ra,0x5
    80000ef0:	4e0080e7          	jalr	1248(ra) # 800063cc <acquire>
  pid = nextpid;
    80000ef4:	00008797          	auipc	a5,0x8
    80000ef8:	96078793          	addi	a5,a5,-1696 # 80008854 <nextpid>
    80000efc:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000efe:	0014871b          	addiw	a4,s1,1
    80000f02:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000f04:	854a                	mv	a0,s2
    80000f06:	00005097          	auipc	ra,0x5
    80000f0a:	57a080e7          	jalr	1402(ra) # 80006480 <release>
}
    80000f0e:	8526                	mv	a0,s1
    80000f10:	60e2                	ld	ra,24(sp)
    80000f12:	6442                	ld	s0,16(sp)
    80000f14:	64a2                	ld	s1,8(sp)
    80000f16:	6902                	ld	s2,0(sp)
    80000f18:	6105                	addi	sp,sp,32
    80000f1a:	8082                	ret

0000000080000f1c <proc_pagetable>:
{
    80000f1c:	1101                	addi	sp,sp,-32
    80000f1e:	ec06                	sd	ra,24(sp)
    80000f20:	e822                	sd	s0,16(sp)
    80000f22:	e426                	sd	s1,8(sp)
    80000f24:	e04a                	sd	s2,0(sp)
    80000f26:	1000                	addi	s0,sp,32
    80000f28:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000f2a:	00000097          	auipc	ra,0x0
    80000f2e:	8ac080e7          	jalr	-1876(ra) # 800007d6 <uvmcreate>
    80000f32:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000f34:	c121                	beqz	a0,80000f74 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000f36:	4729                	li	a4,10
    80000f38:	00006697          	auipc	a3,0x6
    80000f3c:	0c868693          	addi	a3,a3,200 # 80007000 <_trampoline>
    80000f40:	6605                	lui	a2,0x1
    80000f42:	040005b7          	lui	a1,0x4000
    80000f46:	15fd                	addi	a1,a1,-1
    80000f48:	05b2                	slli	a1,a1,0xc
    80000f4a:	fffff097          	auipc	ra,0xfffff
    80000f4e:	602080e7          	jalr	1538(ra) # 8000054c <mappages>
    80000f52:	02054863          	bltz	a0,80000f82 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000f56:	4719                	li	a4,6
    80000f58:	05893683          	ld	a3,88(s2)
    80000f5c:	6605                	lui	a2,0x1
    80000f5e:	020005b7          	lui	a1,0x2000
    80000f62:	15fd                	addi	a1,a1,-1
    80000f64:	05b6                	slli	a1,a1,0xd
    80000f66:	8526                	mv	a0,s1
    80000f68:	fffff097          	auipc	ra,0xfffff
    80000f6c:	5e4080e7          	jalr	1508(ra) # 8000054c <mappages>
    80000f70:	02054163          	bltz	a0,80000f92 <proc_pagetable+0x76>
}
    80000f74:	8526                	mv	a0,s1
    80000f76:	60e2                	ld	ra,24(sp)
    80000f78:	6442                	ld	s0,16(sp)
    80000f7a:	64a2                	ld	s1,8(sp)
    80000f7c:	6902                	ld	s2,0(sp)
    80000f7e:	6105                	addi	sp,sp,32
    80000f80:	8082                	ret
    uvmfree(pagetable, 0);
    80000f82:	4581                	li	a1,0
    80000f84:	8526                	mv	a0,s1
    80000f86:	00000097          	auipc	ra,0x0
    80000f8a:	a54080e7          	jalr	-1452(ra) # 800009da <uvmfree>
    return 0;
    80000f8e:	4481                	li	s1,0
    80000f90:	b7d5                	j	80000f74 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000f92:	4681                	li	a3,0
    80000f94:	4605                	li	a2,1
    80000f96:	040005b7          	lui	a1,0x4000
    80000f9a:	15fd                	addi	a1,a1,-1
    80000f9c:	05b2                	slli	a1,a1,0xc
    80000f9e:	8526                	mv	a0,s1
    80000fa0:	fffff097          	auipc	ra,0xfffff
    80000fa4:	772080e7          	jalr	1906(ra) # 80000712 <uvmunmap>
    uvmfree(pagetable, 0);
    80000fa8:	4581                	li	a1,0
    80000faa:	8526                	mv	a0,s1
    80000fac:	00000097          	auipc	ra,0x0
    80000fb0:	a2e080e7          	jalr	-1490(ra) # 800009da <uvmfree>
    return 0;
    80000fb4:	4481                	li	s1,0
    80000fb6:	bf7d                	j	80000f74 <proc_pagetable+0x58>

0000000080000fb8 <proc_freepagetable>:
{
    80000fb8:	1101                	addi	sp,sp,-32
    80000fba:	ec06                	sd	ra,24(sp)
    80000fbc:	e822                	sd	s0,16(sp)
    80000fbe:	e426                	sd	s1,8(sp)
    80000fc0:	e04a                	sd	s2,0(sp)
    80000fc2:	1000                	addi	s0,sp,32
    80000fc4:	84aa                	mv	s1,a0
    80000fc6:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000fc8:	4681                	li	a3,0
    80000fca:	4605                	li	a2,1
    80000fcc:	040005b7          	lui	a1,0x4000
    80000fd0:	15fd                	addi	a1,a1,-1
    80000fd2:	05b2                	slli	a1,a1,0xc
    80000fd4:	fffff097          	auipc	ra,0xfffff
    80000fd8:	73e080e7          	jalr	1854(ra) # 80000712 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80000fdc:	4681                	li	a3,0
    80000fde:	4605                	li	a2,1
    80000fe0:	020005b7          	lui	a1,0x2000
    80000fe4:	15fd                	addi	a1,a1,-1
    80000fe6:	05b6                	slli	a1,a1,0xd
    80000fe8:	8526                	mv	a0,s1
    80000fea:	fffff097          	auipc	ra,0xfffff
    80000fee:	728080e7          	jalr	1832(ra) # 80000712 <uvmunmap>
  uvmfree(pagetable, sz);
    80000ff2:	85ca                	mv	a1,s2
    80000ff4:	8526                	mv	a0,s1
    80000ff6:	00000097          	auipc	ra,0x0
    80000ffa:	9e4080e7          	jalr	-1564(ra) # 800009da <uvmfree>
}
    80000ffe:	60e2                	ld	ra,24(sp)
    80001000:	6442                	ld	s0,16(sp)
    80001002:	64a2                	ld	s1,8(sp)
    80001004:	6902                	ld	s2,0(sp)
    80001006:	6105                	addi	sp,sp,32
    80001008:	8082                	ret

000000008000100a <freeproc>:
{
    8000100a:	1101                	addi	sp,sp,-32
    8000100c:	ec06                	sd	ra,24(sp)
    8000100e:	e822                	sd	s0,16(sp)
    80001010:	e426                	sd	s1,8(sp)
    80001012:	1000                	addi	s0,sp,32
    80001014:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001016:	6d28                	ld	a0,88(a0)
    80001018:	c509                	beqz	a0,80001022 <freeproc+0x18>
    kfree((void*)p->trapframe);
    8000101a:	fffff097          	auipc	ra,0xfffff
    8000101e:	002080e7          	jalr	2(ra) # 8000001c <kfree>
  p->trapframe = 0;
    80001022:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001026:	68a8                	ld	a0,80(s1)
    80001028:	c511                	beqz	a0,80001034 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    8000102a:	64ac                	ld	a1,72(s1)
    8000102c:	00000097          	auipc	ra,0x0
    80001030:	f8c080e7          	jalr	-116(ra) # 80000fb8 <proc_freepagetable>
  p->pagetable = 0;
    80001034:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001038:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    8000103c:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001040:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001044:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001048:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    8000104c:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001050:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001054:	0004ac23          	sw	zero,24(s1)
}
    80001058:	60e2                	ld	ra,24(sp)
    8000105a:	6442                	ld	s0,16(sp)
    8000105c:	64a2                	ld	s1,8(sp)
    8000105e:	6105                	addi	sp,sp,32
    80001060:	8082                	ret

0000000080001062 <allocproc>:
{
    80001062:	1101                	addi	sp,sp,-32
    80001064:	ec06                	sd	ra,24(sp)
    80001066:	e822                	sd	s0,16(sp)
    80001068:	e426                	sd	s1,8(sp)
    8000106a:	e04a                	sd	s2,0(sp)
    8000106c:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    8000106e:	00008497          	auipc	s1,0x8
    80001072:	cd248493          	addi	s1,s1,-814 # 80008d40 <proc>
    80001076:	00009917          	auipc	s2,0x9
    8000107a:	ada90913          	addi	s2,s2,-1318 # 80009b50 <tickslock>
    acquire(&p->lock);
    8000107e:	8526                	mv	a0,s1
    80001080:	00005097          	auipc	ra,0x5
    80001084:	34c080e7          	jalr	844(ra) # 800063cc <acquire>
    if(p->state == UNUSED) {
    80001088:	4c9c                	lw	a5,24(s1)
    8000108a:	c395                	beqz	a5,800010ae <allocproc+0x4c>
      release(&p->lock);
    8000108c:	8526                	mv	a0,s1
    8000108e:	00005097          	auipc	ra,0x5
    80001092:	3f2080e7          	jalr	1010(ra) # 80006480 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001096:	16848493          	addi	s1,s1,360
    8000109a:	ff2492e3          	bne	s1,s2,8000107e <allocproc+0x1c>
  return 0;
    8000109e:	4481                	li	s1,0
}
    800010a0:	8526                	mv	a0,s1
    800010a2:	60e2                	ld	ra,24(sp)
    800010a4:	6442                	ld	s0,16(sp)
    800010a6:	64a2                	ld	s1,8(sp)
    800010a8:	6902                	ld	s2,0(sp)
    800010aa:	6105                	addi	sp,sp,32
    800010ac:	8082                	ret
  p->pid = allocpid();
    800010ae:	00000097          	auipc	ra,0x0
    800010b2:	e28080e7          	jalr	-472(ra) # 80000ed6 <allocpid>
    800010b6:	d888                	sw	a0,48(s1)
  p->state = USED;
    800010b8:	4785                	li	a5,1
    800010ba:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    800010bc:	fffff097          	auipc	ra,0xfffff
    800010c0:	05c080e7          	jalr	92(ra) # 80000118 <kalloc>
    800010c4:	892a                	mv	s2,a0
    800010c6:	eca8                	sd	a0,88(s1)
    800010c8:	cd05                	beqz	a0,80001100 <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    800010ca:	8526                	mv	a0,s1
    800010cc:	00000097          	auipc	ra,0x0
    800010d0:	e50080e7          	jalr	-432(ra) # 80000f1c <proc_pagetable>
    800010d4:	892a                	mv	s2,a0
    800010d6:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    800010d8:	c121                	beqz	a0,80001118 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    800010da:	07000613          	li	a2,112
    800010de:	4581                	li	a1,0
    800010e0:	06048513          	addi	a0,s1,96
    800010e4:	fffff097          	auipc	ra,0xfffff
    800010e8:	094080e7          	jalr	148(ra) # 80000178 <memset>
  p->context.ra = (uint64)forkret;
    800010ec:	00000797          	auipc	a5,0x0
    800010f0:	da478793          	addi	a5,a5,-604 # 80000e90 <forkret>
    800010f4:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    800010f6:	60bc                	ld	a5,64(s1)
    800010f8:	6705                	lui	a4,0x1
    800010fa:	97ba                	add	a5,a5,a4
    800010fc:	f4bc                	sd	a5,104(s1)
  return p;
    800010fe:	b74d                	j	800010a0 <allocproc+0x3e>
    freeproc(p);
    80001100:	8526                	mv	a0,s1
    80001102:	00000097          	auipc	ra,0x0
    80001106:	f08080e7          	jalr	-248(ra) # 8000100a <freeproc>
    release(&p->lock);
    8000110a:	8526                	mv	a0,s1
    8000110c:	00005097          	auipc	ra,0x5
    80001110:	374080e7          	jalr	884(ra) # 80006480 <release>
    return 0;
    80001114:	84ca                	mv	s1,s2
    80001116:	b769                	j	800010a0 <allocproc+0x3e>
    freeproc(p);
    80001118:	8526                	mv	a0,s1
    8000111a:	00000097          	auipc	ra,0x0
    8000111e:	ef0080e7          	jalr	-272(ra) # 8000100a <freeproc>
    release(&p->lock);
    80001122:	8526                	mv	a0,s1
    80001124:	00005097          	auipc	ra,0x5
    80001128:	35c080e7          	jalr	860(ra) # 80006480 <release>
    return 0;
    8000112c:	84ca                	mv	s1,s2
    8000112e:	bf8d                	j	800010a0 <allocproc+0x3e>

0000000080001130 <userinit>:
{
    80001130:	1101                	addi	sp,sp,-32
    80001132:	ec06                	sd	ra,24(sp)
    80001134:	e822                	sd	s0,16(sp)
    80001136:	e426                	sd	s1,8(sp)
    80001138:	1000                	addi	s0,sp,32
  p = allocproc();
    8000113a:	00000097          	auipc	ra,0x0
    8000113e:	f28080e7          	jalr	-216(ra) # 80001062 <allocproc>
    80001142:	84aa                	mv	s1,a0
  initproc = p;
    80001144:	00007797          	auipc	a5,0x7
    80001148:	78a7b623          	sd	a0,1932(a5) # 800088d0 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    8000114c:	03400613          	li	a2,52
    80001150:	00007597          	auipc	a1,0x7
    80001154:	71058593          	addi	a1,a1,1808 # 80008860 <initcode>
    80001158:	6928                	ld	a0,80(a0)
    8000115a:	fffff097          	auipc	ra,0xfffff
    8000115e:	6aa080e7          	jalr	1706(ra) # 80000804 <uvmfirst>
  p->sz = PGSIZE;
    80001162:	6785                	lui	a5,0x1
    80001164:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001166:	6cb8                	ld	a4,88(s1)
    80001168:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    8000116c:	6cb8                	ld	a4,88(s1)
    8000116e:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001170:	4641                	li	a2,16
    80001172:	00007597          	auipc	a1,0x7
    80001176:	00e58593          	addi	a1,a1,14 # 80008180 <etext+0x180>
    8000117a:	15848513          	addi	a0,s1,344
    8000117e:	fffff097          	auipc	ra,0xfffff
    80001182:	14c080e7          	jalr	332(ra) # 800002ca <safestrcpy>
  p->cwd = namei("/");
    80001186:	00007517          	auipc	a0,0x7
    8000118a:	00a50513          	addi	a0,a0,10 # 80008190 <etext+0x190>
    8000118e:	00002097          	auipc	ra,0x2
    80001192:	272080e7          	jalr	626(ra) # 80003400 <namei>
    80001196:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    8000119a:	478d                	li	a5,3
    8000119c:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    8000119e:	8526                	mv	a0,s1
    800011a0:	00005097          	auipc	ra,0x5
    800011a4:	2e0080e7          	jalr	736(ra) # 80006480 <release>
}
    800011a8:	60e2                	ld	ra,24(sp)
    800011aa:	6442                	ld	s0,16(sp)
    800011ac:	64a2                	ld	s1,8(sp)
    800011ae:	6105                	addi	sp,sp,32
    800011b0:	8082                	ret

00000000800011b2 <growproc>:
{
    800011b2:	1101                	addi	sp,sp,-32
    800011b4:	ec06                	sd	ra,24(sp)
    800011b6:	e822                	sd	s0,16(sp)
    800011b8:	e426                	sd	s1,8(sp)
    800011ba:	e04a                	sd	s2,0(sp)
    800011bc:	1000                	addi	s0,sp,32
    800011be:	892a                	mv	s2,a0
  struct proc *p = myproc();
    800011c0:	00000097          	auipc	ra,0x0
    800011c4:	c98080e7          	jalr	-872(ra) # 80000e58 <myproc>
    800011c8:	84aa                	mv	s1,a0
  sz = p->sz;
    800011ca:	652c                	ld	a1,72(a0)
  if(n > 0){
    800011cc:	01204c63          	bgtz	s2,800011e4 <growproc+0x32>
  } else if(n < 0){
    800011d0:	02094663          	bltz	s2,800011fc <growproc+0x4a>
  p->sz = sz;
    800011d4:	e4ac                	sd	a1,72(s1)
  return 0;
    800011d6:	4501                	li	a0,0
}
    800011d8:	60e2                	ld	ra,24(sp)
    800011da:	6442                	ld	s0,16(sp)
    800011dc:	64a2                	ld	s1,8(sp)
    800011de:	6902                	ld	s2,0(sp)
    800011e0:	6105                	addi	sp,sp,32
    800011e2:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    800011e4:	4691                	li	a3,4
    800011e6:	00b90633          	add	a2,s2,a1
    800011ea:	6928                	ld	a0,80(a0)
    800011ec:	fffff097          	auipc	ra,0xfffff
    800011f0:	6d2080e7          	jalr	1746(ra) # 800008be <uvmalloc>
    800011f4:	85aa                	mv	a1,a0
    800011f6:	fd79                	bnez	a0,800011d4 <growproc+0x22>
      return -1;
    800011f8:	557d                	li	a0,-1
    800011fa:	bff9                	j	800011d8 <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800011fc:	00b90633          	add	a2,s2,a1
    80001200:	6928                	ld	a0,80(a0)
    80001202:	fffff097          	auipc	ra,0xfffff
    80001206:	674080e7          	jalr	1652(ra) # 80000876 <uvmdealloc>
    8000120a:	85aa                	mv	a1,a0
    8000120c:	b7e1                	j	800011d4 <growproc+0x22>

000000008000120e <fork>:
{
    8000120e:	7179                	addi	sp,sp,-48
    80001210:	f406                	sd	ra,40(sp)
    80001212:	f022                	sd	s0,32(sp)
    80001214:	ec26                	sd	s1,24(sp)
    80001216:	e84a                	sd	s2,16(sp)
    80001218:	e44e                	sd	s3,8(sp)
    8000121a:	e052                	sd	s4,0(sp)
    8000121c:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000121e:	00000097          	auipc	ra,0x0
    80001222:	c3a080e7          	jalr	-966(ra) # 80000e58 <myproc>
    80001226:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    80001228:	00000097          	auipc	ra,0x0
    8000122c:	e3a080e7          	jalr	-454(ra) # 80001062 <allocproc>
    80001230:	10050b63          	beqz	a0,80001346 <fork+0x138>
    80001234:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001236:	04893603          	ld	a2,72(s2)
    8000123a:	692c                	ld	a1,80(a0)
    8000123c:	05093503          	ld	a0,80(s2)
    80001240:	fffff097          	auipc	ra,0xfffff
    80001244:	7d2080e7          	jalr	2002(ra) # 80000a12 <uvmcopy>
    80001248:	04054663          	bltz	a0,80001294 <fork+0x86>
  np->sz = p->sz;
    8000124c:	04893783          	ld	a5,72(s2)
    80001250:	04f9b423          	sd	a5,72(s3)
  *(np->trapframe) = *(p->trapframe);
    80001254:	05893683          	ld	a3,88(s2)
    80001258:	87b6                	mv	a5,a3
    8000125a:	0589b703          	ld	a4,88(s3)
    8000125e:	12068693          	addi	a3,a3,288
    80001262:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001266:	6788                	ld	a0,8(a5)
    80001268:	6b8c                	ld	a1,16(a5)
    8000126a:	6f90                	ld	a2,24(a5)
    8000126c:	01073023          	sd	a6,0(a4)
    80001270:	e708                	sd	a0,8(a4)
    80001272:	eb0c                	sd	a1,16(a4)
    80001274:	ef10                	sd	a2,24(a4)
    80001276:	02078793          	addi	a5,a5,32
    8000127a:	02070713          	addi	a4,a4,32
    8000127e:	fed792e3          	bne	a5,a3,80001262 <fork+0x54>
  np->trapframe->a0 = 0;
    80001282:	0589b783          	ld	a5,88(s3)
    80001286:	0607b823          	sd	zero,112(a5)
    8000128a:	0d000493          	li	s1,208
  for(i = 0; i < NOFILE; i++)
    8000128e:	15000a13          	li	s4,336
    80001292:	a03d                	j	800012c0 <fork+0xb2>
    freeproc(np);
    80001294:	854e                	mv	a0,s3
    80001296:	00000097          	auipc	ra,0x0
    8000129a:	d74080e7          	jalr	-652(ra) # 8000100a <freeproc>
    release(&np->lock);
    8000129e:	854e                	mv	a0,s3
    800012a0:	00005097          	auipc	ra,0x5
    800012a4:	1e0080e7          	jalr	480(ra) # 80006480 <release>
    return -1;
    800012a8:	5a7d                	li	s4,-1
    800012aa:	a069                	j	80001334 <fork+0x126>
      np->ofile[i] = filedup(p->ofile[i]);
    800012ac:	00002097          	auipc	ra,0x2
    800012b0:	7ea080e7          	jalr	2026(ra) # 80003a96 <filedup>
    800012b4:	009987b3          	add	a5,s3,s1
    800012b8:	e388                	sd	a0,0(a5)
  for(i = 0; i < NOFILE; i++)
    800012ba:	04a1                	addi	s1,s1,8
    800012bc:	01448763          	beq	s1,s4,800012ca <fork+0xbc>
    if(p->ofile[i])
    800012c0:	009907b3          	add	a5,s2,s1
    800012c4:	6388                	ld	a0,0(a5)
    800012c6:	f17d                	bnez	a0,800012ac <fork+0x9e>
    800012c8:	bfcd                	j	800012ba <fork+0xac>
  np->cwd = idup(p->cwd);
    800012ca:	15093503          	ld	a0,336(s2)
    800012ce:	00002097          	auipc	ra,0x2
    800012d2:	8a6080e7          	jalr	-1882(ra) # 80002b74 <idup>
    800012d6:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800012da:	4641                	li	a2,16
    800012dc:	15890593          	addi	a1,s2,344
    800012e0:	15898513          	addi	a0,s3,344
    800012e4:	fffff097          	auipc	ra,0xfffff
    800012e8:	fe6080e7          	jalr	-26(ra) # 800002ca <safestrcpy>
  pid = np->pid;
    800012ec:	0309aa03          	lw	s4,48(s3)
  release(&np->lock);
    800012f0:	854e                	mv	a0,s3
    800012f2:	00005097          	auipc	ra,0x5
    800012f6:	18e080e7          	jalr	398(ra) # 80006480 <release>
  acquire(&wait_lock);
    800012fa:	00007497          	auipc	s1,0x7
    800012fe:	62e48493          	addi	s1,s1,1582 # 80008928 <wait_lock>
    80001302:	8526                	mv	a0,s1
    80001304:	00005097          	auipc	ra,0x5
    80001308:	0c8080e7          	jalr	200(ra) # 800063cc <acquire>
  np->parent = p;
    8000130c:	0329bc23          	sd	s2,56(s3)
  release(&wait_lock);
    80001310:	8526                	mv	a0,s1
    80001312:	00005097          	auipc	ra,0x5
    80001316:	16e080e7          	jalr	366(ra) # 80006480 <release>
  acquire(&np->lock);
    8000131a:	854e                	mv	a0,s3
    8000131c:	00005097          	auipc	ra,0x5
    80001320:	0b0080e7          	jalr	176(ra) # 800063cc <acquire>
  np->state = RUNNABLE;
    80001324:	478d                	li	a5,3
    80001326:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    8000132a:	854e                	mv	a0,s3
    8000132c:	00005097          	auipc	ra,0x5
    80001330:	154080e7          	jalr	340(ra) # 80006480 <release>
}
    80001334:	8552                	mv	a0,s4
    80001336:	70a2                	ld	ra,40(sp)
    80001338:	7402                	ld	s0,32(sp)
    8000133a:	64e2                	ld	s1,24(sp)
    8000133c:	6942                	ld	s2,16(sp)
    8000133e:	69a2                	ld	s3,8(sp)
    80001340:	6a02                	ld	s4,0(sp)
    80001342:	6145                	addi	sp,sp,48
    80001344:	8082                	ret
    return -1;
    80001346:	5a7d                	li	s4,-1
    80001348:	b7f5                	j	80001334 <fork+0x126>

000000008000134a <scheduler>:
{
    8000134a:	7139                	addi	sp,sp,-64
    8000134c:	fc06                	sd	ra,56(sp)
    8000134e:	f822                	sd	s0,48(sp)
    80001350:	f426                	sd	s1,40(sp)
    80001352:	f04a                	sd	s2,32(sp)
    80001354:	ec4e                	sd	s3,24(sp)
    80001356:	e852                	sd	s4,16(sp)
    80001358:	e456                	sd	s5,8(sp)
    8000135a:	e05a                	sd	s6,0(sp)
    8000135c:	0080                	addi	s0,sp,64
    8000135e:	8792                	mv	a5,tp
  int id = r_tp();
    80001360:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001362:	00779a93          	slli	s5,a5,0x7
    80001366:	00007717          	auipc	a4,0x7
    8000136a:	5aa70713          	addi	a4,a4,1450 # 80008910 <pid_lock>
    8000136e:	9756                	add	a4,a4,s5
    80001370:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001374:	00007717          	auipc	a4,0x7
    80001378:	5d470713          	addi	a4,a4,1492 # 80008948 <cpus+0x8>
    8000137c:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    8000137e:	498d                	li	s3,3
        p->state = RUNNING;
    80001380:	4b11                	li	s6,4
        c->proc = p;
    80001382:	079e                	slli	a5,a5,0x7
    80001384:	00007a17          	auipc	s4,0x7
    80001388:	58ca0a13          	addi	s4,s4,1420 # 80008910 <pid_lock>
    8000138c:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    8000138e:	00008917          	auipc	s2,0x8
    80001392:	7c290913          	addi	s2,s2,1986 # 80009b50 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001396:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000139a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000139e:	10079073          	csrw	sstatus,a5
    800013a2:	00008497          	auipc	s1,0x8
    800013a6:	99e48493          	addi	s1,s1,-1634 # 80008d40 <proc>
    800013aa:	a03d                	j	800013d8 <scheduler+0x8e>
        p->state = RUNNING;
    800013ac:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    800013b0:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    800013b4:	06048593          	addi	a1,s1,96
    800013b8:	8556                	mv	a0,s5
    800013ba:	00000097          	auipc	ra,0x0
    800013be:	6a4080e7          	jalr	1700(ra) # 80001a5e <swtch>
        c->proc = 0;
    800013c2:	020a3823          	sd	zero,48(s4)
      release(&p->lock);
    800013c6:	8526                	mv	a0,s1
    800013c8:	00005097          	auipc	ra,0x5
    800013cc:	0b8080e7          	jalr	184(ra) # 80006480 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800013d0:	16848493          	addi	s1,s1,360
    800013d4:	fd2481e3          	beq	s1,s2,80001396 <scheduler+0x4c>
      acquire(&p->lock);
    800013d8:	8526                	mv	a0,s1
    800013da:	00005097          	auipc	ra,0x5
    800013de:	ff2080e7          	jalr	-14(ra) # 800063cc <acquire>
      if(p->state == RUNNABLE) {
    800013e2:	4c9c                	lw	a5,24(s1)
    800013e4:	ff3791e3          	bne	a5,s3,800013c6 <scheduler+0x7c>
    800013e8:	b7d1                	j	800013ac <scheduler+0x62>

00000000800013ea <sched>:
{
    800013ea:	7179                	addi	sp,sp,-48
    800013ec:	f406                	sd	ra,40(sp)
    800013ee:	f022                	sd	s0,32(sp)
    800013f0:	ec26                	sd	s1,24(sp)
    800013f2:	e84a                	sd	s2,16(sp)
    800013f4:	e44e                	sd	s3,8(sp)
    800013f6:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800013f8:	00000097          	auipc	ra,0x0
    800013fc:	a60080e7          	jalr	-1440(ra) # 80000e58 <myproc>
    80001400:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001402:	00005097          	auipc	ra,0x5
    80001406:	f50080e7          	jalr	-176(ra) # 80006352 <holding>
    8000140a:	c93d                	beqz	a0,80001480 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000140c:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8000140e:	2781                	sext.w	a5,a5
    80001410:	079e                	slli	a5,a5,0x7
    80001412:	00007717          	auipc	a4,0x7
    80001416:	4fe70713          	addi	a4,a4,1278 # 80008910 <pid_lock>
    8000141a:	97ba                	add	a5,a5,a4
    8000141c:	0a87a703          	lw	a4,168(a5)
    80001420:	4785                	li	a5,1
    80001422:	06f71763          	bne	a4,a5,80001490 <sched+0xa6>
  if(p->state == RUNNING)
    80001426:	4c98                	lw	a4,24(s1)
    80001428:	4791                	li	a5,4
    8000142a:	06f70b63          	beq	a4,a5,800014a0 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000142e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001432:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001434:	efb5                	bnez	a5,800014b0 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001436:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001438:	00007917          	auipc	s2,0x7
    8000143c:	4d890913          	addi	s2,s2,1240 # 80008910 <pid_lock>
    80001440:	2781                	sext.w	a5,a5
    80001442:	079e                	slli	a5,a5,0x7
    80001444:	97ca                	add	a5,a5,s2
    80001446:	0ac7a983          	lw	s3,172(a5)
    8000144a:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    8000144c:	2781                	sext.w	a5,a5
    8000144e:	079e                	slli	a5,a5,0x7
    80001450:	00007597          	auipc	a1,0x7
    80001454:	4f858593          	addi	a1,a1,1272 # 80008948 <cpus+0x8>
    80001458:	95be                	add	a1,a1,a5
    8000145a:	06048513          	addi	a0,s1,96
    8000145e:	00000097          	auipc	ra,0x0
    80001462:	600080e7          	jalr	1536(ra) # 80001a5e <swtch>
    80001466:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001468:	2781                	sext.w	a5,a5
    8000146a:	079e                	slli	a5,a5,0x7
    8000146c:	97ca                	add	a5,a5,s2
    8000146e:	0b37a623          	sw	s3,172(a5)
}
    80001472:	70a2                	ld	ra,40(sp)
    80001474:	7402                	ld	s0,32(sp)
    80001476:	64e2                	ld	s1,24(sp)
    80001478:	6942                	ld	s2,16(sp)
    8000147a:	69a2                	ld	s3,8(sp)
    8000147c:	6145                	addi	sp,sp,48
    8000147e:	8082                	ret
    panic("sched p->lock");
    80001480:	00007517          	auipc	a0,0x7
    80001484:	d1850513          	addi	a0,a0,-744 # 80008198 <etext+0x198>
    80001488:	00005097          	auipc	ra,0x5
    8000148c:	9fa080e7          	jalr	-1542(ra) # 80005e82 <panic>
    panic("sched locks");
    80001490:	00007517          	auipc	a0,0x7
    80001494:	d1850513          	addi	a0,a0,-744 # 800081a8 <etext+0x1a8>
    80001498:	00005097          	auipc	ra,0x5
    8000149c:	9ea080e7          	jalr	-1558(ra) # 80005e82 <panic>
    panic("sched running");
    800014a0:	00007517          	auipc	a0,0x7
    800014a4:	d1850513          	addi	a0,a0,-744 # 800081b8 <etext+0x1b8>
    800014a8:	00005097          	auipc	ra,0x5
    800014ac:	9da080e7          	jalr	-1574(ra) # 80005e82 <panic>
    panic("sched interruptible");
    800014b0:	00007517          	auipc	a0,0x7
    800014b4:	d1850513          	addi	a0,a0,-744 # 800081c8 <etext+0x1c8>
    800014b8:	00005097          	auipc	ra,0x5
    800014bc:	9ca080e7          	jalr	-1590(ra) # 80005e82 <panic>

00000000800014c0 <yield>:
{
    800014c0:	1101                	addi	sp,sp,-32
    800014c2:	ec06                	sd	ra,24(sp)
    800014c4:	e822                	sd	s0,16(sp)
    800014c6:	e426                	sd	s1,8(sp)
    800014c8:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800014ca:	00000097          	auipc	ra,0x0
    800014ce:	98e080e7          	jalr	-1650(ra) # 80000e58 <myproc>
    800014d2:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800014d4:	00005097          	auipc	ra,0x5
    800014d8:	ef8080e7          	jalr	-264(ra) # 800063cc <acquire>
  p->state = RUNNABLE;
    800014dc:	478d                	li	a5,3
    800014de:	cc9c                	sw	a5,24(s1)
  sched();
    800014e0:	00000097          	auipc	ra,0x0
    800014e4:	f0a080e7          	jalr	-246(ra) # 800013ea <sched>
  release(&p->lock);
    800014e8:	8526                	mv	a0,s1
    800014ea:	00005097          	auipc	ra,0x5
    800014ee:	f96080e7          	jalr	-106(ra) # 80006480 <release>
}
    800014f2:	60e2                	ld	ra,24(sp)
    800014f4:	6442                	ld	s0,16(sp)
    800014f6:	64a2                	ld	s1,8(sp)
    800014f8:	6105                	addi	sp,sp,32
    800014fa:	8082                	ret

00000000800014fc <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800014fc:	7179                	addi	sp,sp,-48
    800014fe:	f406                	sd	ra,40(sp)
    80001500:	f022                	sd	s0,32(sp)
    80001502:	ec26                	sd	s1,24(sp)
    80001504:	e84a                	sd	s2,16(sp)
    80001506:	e44e                	sd	s3,8(sp)
    80001508:	1800                	addi	s0,sp,48
    8000150a:	89aa                	mv	s3,a0
    8000150c:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000150e:	00000097          	auipc	ra,0x0
    80001512:	94a080e7          	jalr	-1718(ra) # 80000e58 <myproc>
    80001516:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001518:	00005097          	auipc	ra,0x5
    8000151c:	eb4080e7          	jalr	-332(ra) # 800063cc <acquire>
  release(lk);
    80001520:	854a                	mv	a0,s2
    80001522:	00005097          	auipc	ra,0x5
    80001526:	f5e080e7          	jalr	-162(ra) # 80006480 <release>

  // Go to sleep.
  p->chan = chan;
    8000152a:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    8000152e:	4789                	li	a5,2
    80001530:	cc9c                	sw	a5,24(s1)

  sched();
    80001532:	00000097          	auipc	ra,0x0
    80001536:	eb8080e7          	jalr	-328(ra) # 800013ea <sched>

  // Tidy up.
  p->chan = 0;
    8000153a:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    8000153e:	8526                	mv	a0,s1
    80001540:	00005097          	auipc	ra,0x5
    80001544:	f40080e7          	jalr	-192(ra) # 80006480 <release>
  acquire(lk);
    80001548:	854a                	mv	a0,s2
    8000154a:	00005097          	auipc	ra,0x5
    8000154e:	e82080e7          	jalr	-382(ra) # 800063cc <acquire>
}
    80001552:	70a2                	ld	ra,40(sp)
    80001554:	7402                	ld	s0,32(sp)
    80001556:	64e2                	ld	s1,24(sp)
    80001558:	6942                	ld	s2,16(sp)
    8000155a:	69a2                	ld	s3,8(sp)
    8000155c:	6145                	addi	sp,sp,48
    8000155e:	8082                	ret

0000000080001560 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80001560:	7139                	addi	sp,sp,-64
    80001562:	fc06                	sd	ra,56(sp)
    80001564:	f822                	sd	s0,48(sp)
    80001566:	f426                	sd	s1,40(sp)
    80001568:	f04a                	sd	s2,32(sp)
    8000156a:	ec4e                	sd	s3,24(sp)
    8000156c:	e852                	sd	s4,16(sp)
    8000156e:	e456                	sd	s5,8(sp)
    80001570:	0080                	addi	s0,sp,64
    80001572:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80001574:	00007497          	auipc	s1,0x7
    80001578:	7cc48493          	addi	s1,s1,1996 # 80008d40 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    8000157c:	4989                	li	s3,2
        p->state = RUNNABLE;
    8000157e:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    80001580:	00008917          	auipc	s2,0x8
    80001584:	5d090913          	addi	s2,s2,1488 # 80009b50 <tickslock>
    80001588:	a811                	j	8000159c <wakeup+0x3c>
      }
      release(&p->lock);
    8000158a:	8526                	mv	a0,s1
    8000158c:	00005097          	auipc	ra,0x5
    80001590:	ef4080e7          	jalr	-268(ra) # 80006480 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001594:	16848493          	addi	s1,s1,360
    80001598:	03248663          	beq	s1,s2,800015c4 <wakeup+0x64>
    if(p != myproc()){
    8000159c:	00000097          	auipc	ra,0x0
    800015a0:	8bc080e7          	jalr	-1860(ra) # 80000e58 <myproc>
    800015a4:	fea488e3          	beq	s1,a0,80001594 <wakeup+0x34>
      acquire(&p->lock);
    800015a8:	8526                	mv	a0,s1
    800015aa:	00005097          	auipc	ra,0x5
    800015ae:	e22080e7          	jalr	-478(ra) # 800063cc <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800015b2:	4c9c                	lw	a5,24(s1)
    800015b4:	fd379be3          	bne	a5,s3,8000158a <wakeup+0x2a>
    800015b8:	709c                	ld	a5,32(s1)
    800015ba:	fd4798e3          	bne	a5,s4,8000158a <wakeup+0x2a>
        p->state = RUNNABLE;
    800015be:	0154ac23          	sw	s5,24(s1)
    800015c2:	b7e1                	j	8000158a <wakeup+0x2a>
    }
  }
}
    800015c4:	70e2                	ld	ra,56(sp)
    800015c6:	7442                	ld	s0,48(sp)
    800015c8:	74a2                	ld	s1,40(sp)
    800015ca:	7902                	ld	s2,32(sp)
    800015cc:	69e2                	ld	s3,24(sp)
    800015ce:	6a42                	ld	s4,16(sp)
    800015d0:	6aa2                	ld	s5,8(sp)
    800015d2:	6121                	addi	sp,sp,64
    800015d4:	8082                	ret

00000000800015d6 <reparent>:
{
    800015d6:	7179                	addi	sp,sp,-48
    800015d8:	f406                	sd	ra,40(sp)
    800015da:	f022                	sd	s0,32(sp)
    800015dc:	ec26                	sd	s1,24(sp)
    800015de:	e84a                	sd	s2,16(sp)
    800015e0:	e44e                	sd	s3,8(sp)
    800015e2:	e052                	sd	s4,0(sp)
    800015e4:	1800                	addi	s0,sp,48
    800015e6:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800015e8:	00007497          	auipc	s1,0x7
    800015ec:	75848493          	addi	s1,s1,1880 # 80008d40 <proc>
      pp->parent = initproc;
    800015f0:	00007a17          	auipc	s4,0x7
    800015f4:	2e0a0a13          	addi	s4,s4,736 # 800088d0 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800015f8:	00008997          	auipc	s3,0x8
    800015fc:	55898993          	addi	s3,s3,1368 # 80009b50 <tickslock>
    80001600:	a029                	j	8000160a <reparent+0x34>
    80001602:	16848493          	addi	s1,s1,360
    80001606:	01348d63          	beq	s1,s3,80001620 <reparent+0x4a>
    if(pp->parent == p){
    8000160a:	7c9c                	ld	a5,56(s1)
    8000160c:	ff279be3          	bne	a5,s2,80001602 <reparent+0x2c>
      pp->parent = initproc;
    80001610:	000a3503          	ld	a0,0(s4)
    80001614:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001616:	00000097          	auipc	ra,0x0
    8000161a:	f4a080e7          	jalr	-182(ra) # 80001560 <wakeup>
    8000161e:	b7d5                	j	80001602 <reparent+0x2c>
}
    80001620:	70a2                	ld	ra,40(sp)
    80001622:	7402                	ld	s0,32(sp)
    80001624:	64e2                	ld	s1,24(sp)
    80001626:	6942                	ld	s2,16(sp)
    80001628:	69a2                	ld	s3,8(sp)
    8000162a:	6a02                	ld	s4,0(sp)
    8000162c:	6145                	addi	sp,sp,48
    8000162e:	8082                	ret

0000000080001630 <exit>:
{
    80001630:	7179                	addi	sp,sp,-48
    80001632:	f406                	sd	ra,40(sp)
    80001634:	f022                	sd	s0,32(sp)
    80001636:	ec26                	sd	s1,24(sp)
    80001638:	e84a                	sd	s2,16(sp)
    8000163a:	e44e                	sd	s3,8(sp)
    8000163c:	e052                	sd	s4,0(sp)
    8000163e:	1800                	addi	s0,sp,48
    80001640:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001642:	00000097          	auipc	ra,0x0
    80001646:	816080e7          	jalr	-2026(ra) # 80000e58 <myproc>
    8000164a:	89aa                	mv	s3,a0
  if(p == initproc)
    8000164c:	00007797          	auipc	a5,0x7
    80001650:	2847b783          	ld	a5,644(a5) # 800088d0 <initproc>
    80001654:	0d050493          	addi	s1,a0,208
    80001658:	15050913          	addi	s2,a0,336
    8000165c:	02a79363          	bne	a5,a0,80001682 <exit+0x52>
    panic("init exiting");
    80001660:	00007517          	auipc	a0,0x7
    80001664:	b8050513          	addi	a0,a0,-1152 # 800081e0 <etext+0x1e0>
    80001668:	00005097          	auipc	ra,0x5
    8000166c:	81a080e7          	jalr	-2022(ra) # 80005e82 <panic>
      fileclose(f);
    80001670:	00002097          	auipc	ra,0x2
    80001674:	478080e7          	jalr	1144(ra) # 80003ae8 <fileclose>
      p->ofile[fd] = 0;
    80001678:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    8000167c:	04a1                	addi	s1,s1,8
    8000167e:	01248563          	beq	s1,s2,80001688 <exit+0x58>
    if(p->ofile[fd]){
    80001682:	6088                	ld	a0,0(s1)
    80001684:	f575                	bnez	a0,80001670 <exit+0x40>
    80001686:	bfdd                	j	8000167c <exit+0x4c>
  begin_op();
    80001688:	00002097          	auipc	ra,0x2
    8000168c:	f94080e7          	jalr	-108(ra) # 8000361c <begin_op>
  iput(p->cwd);
    80001690:	1509b503          	ld	a0,336(s3)
    80001694:	00001097          	auipc	ra,0x1
    80001698:	77e080e7          	jalr	1918(ra) # 80002e12 <iput>
  end_op();
    8000169c:	00002097          	auipc	ra,0x2
    800016a0:	000080e7          	jalr	ra # 8000369c <end_op>
  p->cwd = 0;
    800016a4:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800016a8:	00007497          	auipc	s1,0x7
    800016ac:	28048493          	addi	s1,s1,640 # 80008928 <wait_lock>
    800016b0:	8526                	mv	a0,s1
    800016b2:	00005097          	auipc	ra,0x5
    800016b6:	d1a080e7          	jalr	-742(ra) # 800063cc <acquire>
  reparent(p);
    800016ba:	854e                	mv	a0,s3
    800016bc:	00000097          	auipc	ra,0x0
    800016c0:	f1a080e7          	jalr	-230(ra) # 800015d6 <reparent>
  wakeup(p->parent);
    800016c4:	0389b503          	ld	a0,56(s3)
    800016c8:	00000097          	auipc	ra,0x0
    800016cc:	e98080e7          	jalr	-360(ra) # 80001560 <wakeup>
  acquire(&p->lock);
    800016d0:	854e                	mv	a0,s3
    800016d2:	00005097          	auipc	ra,0x5
    800016d6:	cfa080e7          	jalr	-774(ra) # 800063cc <acquire>
  p->xstate = status;
    800016da:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    800016de:	4795                	li	a5,5
    800016e0:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    800016e4:	8526                	mv	a0,s1
    800016e6:	00005097          	auipc	ra,0x5
    800016ea:	d9a080e7          	jalr	-614(ra) # 80006480 <release>
  sched();
    800016ee:	00000097          	auipc	ra,0x0
    800016f2:	cfc080e7          	jalr	-772(ra) # 800013ea <sched>
  panic("zombie exit");
    800016f6:	00007517          	auipc	a0,0x7
    800016fa:	afa50513          	addi	a0,a0,-1286 # 800081f0 <etext+0x1f0>
    800016fe:	00004097          	auipc	ra,0x4
    80001702:	784080e7          	jalr	1924(ra) # 80005e82 <panic>

0000000080001706 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001706:	7179                	addi	sp,sp,-48
    80001708:	f406                	sd	ra,40(sp)
    8000170a:	f022                	sd	s0,32(sp)
    8000170c:	ec26                	sd	s1,24(sp)
    8000170e:	e84a                	sd	s2,16(sp)
    80001710:	e44e                	sd	s3,8(sp)
    80001712:	1800                	addi	s0,sp,48
    80001714:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001716:	00007497          	auipc	s1,0x7
    8000171a:	62a48493          	addi	s1,s1,1578 # 80008d40 <proc>
    8000171e:	00008997          	auipc	s3,0x8
    80001722:	43298993          	addi	s3,s3,1074 # 80009b50 <tickslock>
    acquire(&p->lock);
    80001726:	8526                	mv	a0,s1
    80001728:	00005097          	auipc	ra,0x5
    8000172c:	ca4080e7          	jalr	-860(ra) # 800063cc <acquire>
    if(p->pid == pid){
    80001730:	589c                	lw	a5,48(s1)
    80001732:	03278363          	beq	a5,s2,80001758 <kill+0x52>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001736:	8526                	mv	a0,s1
    80001738:	00005097          	auipc	ra,0x5
    8000173c:	d48080e7          	jalr	-696(ra) # 80006480 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001740:	16848493          	addi	s1,s1,360
    80001744:	ff3491e3          	bne	s1,s3,80001726 <kill+0x20>
  }
  return -1;
    80001748:	557d                	li	a0,-1
}
    8000174a:	70a2                	ld	ra,40(sp)
    8000174c:	7402                	ld	s0,32(sp)
    8000174e:	64e2                	ld	s1,24(sp)
    80001750:	6942                	ld	s2,16(sp)
    80001752:	69a2                	ld	s3,8(sp)
    80001754:	6145                	addi	sp,sp,48
    80001756:	8082                	ret
      p->killed = 1;
    80001758:	4785                	li	a5,1
    8000175a:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    8000175c:	4c98                	lw	a4,24(s1)
    8000175e:	4789                	li	a5,2
    80001760:	00f70963          	beq	a4,a5,80001772 <kill+0x6c>
      release(&p->lock);
    80001764:	8526                	mv	a0,s1
    80001766:	00005097          	auipc	ra,0x5
    8000176a:	d1a080e7          	jalr	-742(ra) # 80006480 <release>
      return 0;
    8000176e:	4501                	li	a0,0
    80001770:	bfe9                	j	8000174a <kill+0x44>
        p->state = RUNNABLE;
    80001772:	478d                	li	a5,3
    80001774:	cc9c                	sw	a5,24(s1)
    80001776:	b7fd                	j	80001764 <kill+0x5e>

0000000080001778 <setkilled>:

void
setkilled(struct proc *p)
{
    80001778:	1101                	addi	sp,sp,-32
    8000177a:	ec06                	sd	ra,24(sp)
    8000177c:	e822                	sd	s0,16(sp)
    8000177e:	e426                	sd	s1,8(sp)
    80001780:	1000                	addi	s0,sp,32
    80001782:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001784:	00005097          	auipc	ra,0x5
    80001788:	c48080e7          	jalr	-952(ra) # 800063cc <acquire>
  p->killed = 1;
    8000178c:	4785                	li	a5,1
    8000178e:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80001790:	8526                	mv	a0,s1
    80001792:	00005097          	auipc	ra,0x5
    80001796:	cee080e7          	jalr	-786(ra) # 80006480 <release>
}
    8000179a:	60e2                	ld	ra,24(sp)
    8000179c:	6442                	ld	s0,16(sp)
    8000179e:	64a2                	ld	s1,8(sp)
    800017a0:	6105                	addi	sp,sp,32
    800017a2:	8082                	ret

00000000800017a4 <killed>:

int
killed(struct proc *p)
{
    800017a4:	1101                	addi	sp,sp,-32
    800017a6:	ec06                	sd	ra,24(sp)
    800017a8:	e822                	sd	s0,16(sp)
    800017aa:	e426                	sd	s1,8(sp)
    800017ac:	e04a                	sd	s2,0(sp)
    800017ae:	1000                	addi	s0,sp,32
    800017b0:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    800017b2:	00005097          	auipc	ra,0x5
    800017b6:	c1a080e7          	jalr	-998(ra) # 800063cc <acquire>
  k = p->killed;
    800017ba:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    800017be:	8526                	mv	a0,s1
    800017c0:	00005097          	auipc	ra,0x5
    800017c4:	cc0080e7          	jalr	-832(ra) # 80006480 <release>
  return k;
}
    800017c8:	854a                	mv	a0,s2
    800017ca:	60e2                	ld	ra,24(sp)
    800017cc:	6442                	ld	s0,16(sp)
    800017ce:	64a2                	ld	s1,8(sp)
    800017d0:	6902                	ld	s2,0(sp)
    800017d2:	6105                	addi	sp,sp,32
    800017d4:	8082                	ret

00000000800017d6 <wait>:
{
    800017d6:	715d                	addi	sp,sp,-80
    800017d8:	e486                	sd	ra,72(sp)
    800017da:	e0a2                	sd	s0,64(sp)
    800017dc:	fc26                	sd	s1,56(sp)
    800017de:	f84a                	sd	s2,48(sp)
    800017e0:	f44e                	sd	s3,40(sp)
    800017e2:	f052                	sd	s4,32(sp)
    800017e4:	ec56                	sd	s5,24(sp)
    800017e6:	e85a                	sd	s6,16(sp)
    800017e8:	e45e                	sd	s7,8(sp)
    800017ea:	e062                	sd	s8,0(sp)
    800017ec:	0880                	addi	s0,sp,80
    800017ee:	8aaa                	mv	s5,a0
  struct proc *p = myproc();
    800017f0:	fffff097          	auipc	ra,0xfffff
    800017f4:	668080e7          	jalr	1640(ra) # 80000e58 <myproc>
    800017f8:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800017fa:	00007517          	auipc	a0,0x7
    800017fe:	12e50513          	addi	a0,a0,302 # 80008928 <wait_lock>
    80001802:	00005097          	auipc	ra,0x5
    80001806:	bca080e7          	jalr	-1078(ra) # 800063cc <acquire>
    havekids = 0;
    8000180a:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    8000180c:	4a15                	li	s4,5
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000180e:	00008997          	auipc	s3,0x8
    80001812:	34298993          	addi	s3,s3,834 # 80009b50 <tickslock>
        havekids = 1;
    80001816:	4b05                	li	s6,1
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001818:	00007c17          	auipc	s8,0x7
    8000181c:	110c0c13          	addi	s8,s8,272 # 80008928 <wait_lock>
    havekids = 0;
    80001820:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001822:	00007497          	auipc	s1,0x7
    80001826:	51e48493          	addi	s1,s1,1310 # 80008d40 <proc>
    8000182a:	a0bd                	j	80001898 <wait+0xc2>
          pid = pp->pid;
    8000182c:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80001830:	000a8e63          	beqz	s5,8000184c <wait+0x76>
    80001834:	4691                	li	a3,4
    80001836:	02c48613          	addi	a2,s1,44
    8000183a:	85d6                	mv	a1,s5
    8000183c:	05093503          	ld	a0,80(s2)
    80001840:	fffff097          	auipc	ra,0xfffff
    80001844:	2d6080e7          	jalr	726(ra) # 80000b16 <copyout>
    80001848:	02054563          	bltz	a0,80001872 <wait+0x9c>
          freeproc(pp);
    8000184c:	8526                	mv	a0,s1
    8000184e:	fffff097          	auipc	ra,0xfffff
    80001852:	7bc080e7          	jalr	1980(ra) # 8000100a <freeproc>
          release(&pp->lock);
    80001856:	8526                	mv	a0,s1
    80001858:	00005097          	auipc	ra,0x5
    8000185c:	c28080e7          	jalr	-984(ra) # 80006480 <release>
          release(&wait_lock);
    80001860:	00007517          	auipc	a0,0x7
    80001864:	0c850513          	addi	a0,a0,200 # 80008928 <wait_lock>
    80001868:	00005097          	auipc	ra,0x5
    8000186c:	c18080e7          	jalr	-1000(ra) # 80006480 <release>
          return pid;
    80001870:	a0b5                	j	800018dc <wait+0x106>
            release(&pp->lock);
    80001872:	8526                	mv	a0,s1
    80001874:	00005097          	auipc	ra,0x5
    80001878:	c0c080e7          	jalr	-1012(ra) # 80006480 <release>
            release(&wait_lock);
    8000187c:	00007517          	auipc	a0,0x7
    80001880:	0ac50513          	addi	a0,a0,172 # 80008928 <wait_lock>
    80001884:	00005097          	auipc	ra,0x5
    80001888:	bfc080e7          	jalr	-1028(ra) # 80006480 <release>
            return -1;
    8000188c:	59fd                	li	s3,-1
    8000188e:	a0b9                	j	800018dc <wait+0x106>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001890:	16848493          	addi	s1,s1,360
    80001894:	03348463          	beq	s1,s3,800018bc <wait+0xe6>
      if(pp->parent == p){
    80001898:	7c9c                	ld	a5,56(s1)
    8000189a:	ff279be3          	bne	a5,s2,80001890 <wait+0xba>
        acquire(&pp->lock);
    8000189e:	8526                	mv	a0,s1
    800018a0:	00005097          	auipc	ra,0x5
    800018a4:	b2c080e7          	jalr	-1236(ra) # 800063cc <acquire>
        if(pp->state == ZOMBIE){
    800018a8:	4c9c                	lw	a5,24(s1)
    800018aa:	f94781e3          	beq	a5,s4,8000182c <wait+0x56>
        release(&pp->lock);
    800018ae:	8526                	mv	a0,s1
    800018b0:	00005097          	auipc	ra,0x5
    800018b4:	bd0080e7          	jalr	-1072(ra) # 80006480 <release>
        havekids = 1;
    800018b8:	875a                	mv	a4,s6
    800018ba:	bfd9                	j	80001890 <wait+0xba>
    if(!havekids || killed(p)){
    800018bc:	c719                	beqz	a4,800018ca <wait+0xf4>
    800018be:	854a                	mv	a0,s2
    800018c0:	00000097          	auipc	ra,0x0
    800018c4:	ee4080e7          	jalr	-284(ra) # 800017a4 <killed>
    800018c8:	c51d                	beqz	a0,800018f6 <wait+0x120>
      release(&wait_lock);
    800018ca:	00007517          	auipc	a0,0x7
    800018ce:	05e50513          	addi	a0,a0,94 # 80008928 <wait_lock>
    800018d2:	00005097          	auipc	ra,0x5
    800018d6:	bae080e7          	jalr	-1106(ra) # 80006480 <release>
      return -1;
    800018da:	59fd                	li	s3,-1
}
    800018dc:	854e                	mv	a0,s3
    800018de:	60a6                	ld	ra,72(sp)
    800018e0:	6406                	ld	s0,64(sp)
    800018e2:	74e2                	ld	s1,56(sp)
    800018e4:	7942                	ld	s2,48(sp)
    800018e6:	79a2                	ld	s3,40(sp)
    800018e8:	7a02                	ld	s4,32(sp)
    800018ea:	6ae2                	ld	s5,24(sp)
    800018ec:	6b42                	ld	s6,16(sp)
    800018ee:	6ba2                	ld	s7,8(sp)
    800018f0:	6c02                	ld	s8,0(sp)
    800018f2:	6161                	addi	sp,sp,80
    800018f4:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800018f6:	85e2                	mv	a1,s8
    800018f8:	854a                	mv	a0,s2
    800018fa:	00000097          	auipc	ra,0x0
    800018fe:	c02080e7          	jalr	-1022(ra) # 800014fc <sleep>
    havekids = 0;
    80001902:	bf39                	j	80001820 <wait+0x4a>

0000000080001904 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001904:	7179                	addi	sp,sp,-48
    80001906:	f406                	sd	ra,40(sp)
    80001908:	f022                	sd	s0,32(sp)
    8000190a:	ec26                	sd	s1,24(sp)
    8000190c:	e84a                	sd	s2,16(sp)
    8000190e:	e44e                	sd	s3,8(sp)
    80001910:	e052                	sd	s4,0(sp)
    80001912:	1800                	addi	s0,sp,48
    80001914:	84aa                	mv	s1,a0
    80001916:	892e                	mv	s2,a1
    80001918:	89b2                	mv	s3,a2
    8000191a:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    8000191c:	fffff097          	auipc	ra,0xfffff
    80001920:	53c080e7          	jalr	1340(ra) # 80000e58 <myproc>
  if(user_dst){
    80001924:	c08d                	beqz	s1,80001946 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001926:	86d2                	mv	a3,s4
    80001928:	864e                	mv	a2,s3
    8000192a:	85ca                	mv	a1,s2
    8000192c:	6928                	ld	a0,80(a0)
    8000192e:	fffff097          	auipc	ra,0xfffff
    80001932:	1e8080e7          	jalr	488(ra) # 80000b16 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001936:	70a2                	ld	ra,40(sp)
    80001938:	7402                	ld	s0,32(sp)
    8000193a:	64e2                	ld	s1,24(sp)
    8000193c:	6942                	ld	s2,16(sp)
    8000193e:	69a2                	ld	s3,8(sp)
    80001940:	6a02                	ld	s4,0(sp)
    80001942:	6145                	addi	sp,sp,48
    80001944:	8082                	ret
    memmove((char *)dst, src, len);
    80001946:	000a061b          	sext.w	a2,s4
    8000194a:	85ce                	mv	a1,s3
    8000194c:	854a                	mv	a0,s2
    8000194e:	fffff097          	auipc	ra,0xfffff
    80001952:	88a080e7          	jalr	-1910(ra) # 800001d8 <memmove>
    return 0;
    80001956:	8526                	mv	a0,s1
    80001958:	bff9                	j	80001936 <either_copyout+0x32>

000000008000195a <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000195a:	7179                	addi	sp,sp,-48
    8000195c:	f406                	sd	ra,40(sp)
    8000195e:	f022                	sd	s0,32(sp)
    80001960:	ec26                	sd	s1,24(sp)
    80001962:	e84a                	sd	s2,16(sp)
    80001964:	e44e                	sd	s3,8(sp)
    80001966:	e052                	sd	s4,0(sp)
    80001968:	1800                	addi	s0,sp,48
    8000196a:	892a                	mv	s2,a0
    8000196c:	84ae                	mv	s1,a1
    8000196e:	89b2                	mv	s3,a2
    80001970:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001972:	fffff097          	auipc	ra,0xfffff
    80001976:	4e6080e7          	jalr	1254(ra) # 80000e58 <myproc>
  if(user_src){
    8000197a:	c08d                	beqz	s1,8000199c <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    8000197c:	86d2                	mv	a3,s4
    8000197e:	864e                	mv	a2,s3
    80001980:	85ca                	mv	a1,s2
    80001982:	6928                	ld	a0,80(a0)
    80001984:	fffff097          	auipc	ra,0xfffff
    80001988:	21e080e7          	jalr	542(ra) # 80000ba2 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    8000198c:	70a2                	ld	ra,40(sp)
    8000198e:	7402                	ld	s0,32(sp)
    80001990:	64e2                	ld	s1,24(sp)
    80001992:	6942                	ld	s2,16(sp)
    80001994:	69a2                	ld	s3,8(sp)
    80001996:	6a02                	ld	s4,0(sp)
    80001998:	6145                	addi	sp,sp,48
    8000199a:	8082                	ret
    memmove(dst, (char*)src, len);
    8000199c:	000a061b          	sext.w	a2,s4
    800019a0:	85ce                	mv	a1,s3
    800019a2:	854a                	mv	a0,s2
    800019a4:	fffff097          	auipc	ra,0xfffff
    800019a8:	834080e7          	jalr	-1996(ra) # 800001d8 <memmove>
    return 0;
    800019ac:	8526                	mv	a0,s1
    800019ae:	bff9                	j	8000198c <either_copyin+0x32>

00000000800019b0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800019b0:	715d                	addi	sp,sp,-80
    800019b2:	e486                	sd	ra,72(sp)
    800019b4:	e0a2                	sd	s0,64(sp)
    800019b6:	fc26                	sd	s1,56(sp)
    800019b8:	f84a                	sd	s2,48(sp)
    800019ba:	f44e                	sd	s3,40(sp)
    800019bc:	f052                	sd	s4,32(sp)
    800019be:	ec56                	sd	s5,24(sp)
    800019c0:	e85a                	sd	s6,16(sp)
    800019c2:	e45e                	sd	s7,8(sp)
    800019c4:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800019c6:	00006517          	auipc	a0,0x6
    800019ca:	68250513          	addi	a0,a0,1666 # 80008048 <etext+0x48>
    800019ce:	00004097          	auipc	ra,0x4
    800019d2:	4fe080e7          	jalr	1278(ra) # 80005ecc <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800019d6:	00007497          	auipc	s1,0x7
    800019da:	4c248493          	addi	s1,s1,1218 # 80008e98 <proc+0x158>
    800019de:	00008917          	auipc	s2,0x8
    800019e2:	2ca90913          	addi	s2,s2,714 # 80009ca8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800019e6:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    800019e8:	00007997          	auipc	s3,0x7
    800019ec:	81898993          	addi	s3,s3,-2024 # 80008200 <etext+0x200>
    printf("%d %s %s", p->pid, state, p->name);
    800019f0:	00007a97          	auipc	s5,0x7
    800019f4:	818a8a93          	addi	s5,s5,-2024 # 80008208 <etext+0x208>
    printf("\n");
    800019f8:	00006a17          	auipc	s4,0x6
    800019fc:	650a0a13          	addi	s4,s4,1616 # 80008048 <etext+0x48>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a00:	00007b97          	auipc	s7,0x7
    80001a04:	848b8b93          	addi	s7,s7,-1976 # 80008248 <states.1722>
    80001a08:	a00d                	j	80001a2a <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001a0a:	ed86a583          	lw	a1,-296(a3)
    80001a0e:	8556                	mv	a0,s5
    80001a10:	00004097          	auipc	ra,0x4
    80001a14:	4bc080e7          	jalr	1212(ra) # 80005ecc <printf>
    printf("\n");
    80001a18:	8552                	mv	a0,s4
    80001a1a:	00004097          	auipc	ra,0x4
    80001a1e:	4b2080e7          	jalr	1202(ra) # 80005ecc <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a22:	16848493          	addi	s1,s1,360
    80001a26:	03248163          	beq	s1,s2,80001a48 <procdump+0x98>
    if(p->state == UNUSED)
    80001a2a:	86a6                	mv	a3,s1
    80001a2c:	ec04a783          	lw	a5,-320(s1)
    80001a30:	dbed                	beqz	a5,80001a22 <procdump+0x72>
      state = "???";
    80001a32:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a34:	fcfb6be3          	bltu	s6,a5,80001a0a <procdump+0x5a>
    80001a38:	1782                	slli	a5,a5,0x20
    80001a3a:	9381                	srli	a5,a5,0x20
    80001a3c:	078e                	slli	a5,a5,0x3
    80001a3e:	97de                	add	a5,a5,s7
    80001a40:	6390                	ld	a2,0(a5)
    80001a42:	f661                	bnez	a2,80001a0a <procdump+0x5a>
      state = "???";
    80001a44:	864e                	mv	a2,s3
    80001a46:	b7d1                	j	80001a0a <procdump+0x5a>
  }
}
    80001a48:	60a6                	ld	ra,72(sp)
    80001a4a:	6406                	ld	s0,64(sp)
    80001a4c:	74e2                	ld	s1,56(sp)
    80001a4e:	7942                	ld	s2,48(sp)
    80001a50:	79a2                	ld	s3,40(sp)
    80001a52:	7a02                	ld	s4,32(sp)
    80001a54:	6ae2                	ld	s5,24(sp)
    80001a56:	6b42                	ld	s6,16(sp)
    80001a58:	6ba2                	ld	s7,8(sp)
    80001a5a:	6161                	addi	sp,sp,80
    80001a5c:	8082                	ret

0000000080001a5e <swtch>:
    80001a5e:	00153023          	sd	ra,0(a0)
    80001a62:	00253423          	sd	sp,8(a0)
    80001a66:	e900                	sd	s0,16(a0)
    80001a68:	ed04                	sd	s1,24(a0)
    80001a6a:	03253023          	sd	s2,32(a0)
    80001a6e:	03353423          	sd	s3,40(a0)
    80001a72:	03453823          	sd	s4,48(a0)
    80001a76:	03553c23          	sd	s5,56(a0)
    80001a7a:	05653023          	sd	s6,64(a0)
    80001a7e:	05753423          	sd	s7,72(a0)
    80001a82:	05853823          	sd	s8,80(a0)
    80001a86:	05953c23          	sd	s9,88(a0)
    80001a8a:	07a53023          	sd	s10,96(a0)
    80001a8e:	07b53423          	sd	s11,104(a0)
    80001a92:	0005b083          	ld	ra,0(a1)
    80001a96:	0085b103          	ld	sp,8(a1)
    80001a9a:	6980                	ld	s0,16(a1)
    80001a9c:	6d84                	ld	s1,24(a1)
    80001a9e:	0205b903          	ld	s2,32(a1)
    80001aa2:	0285b983          	ld	s3,40(a1)
    80001aa6:	0305ba03          	ld	s4,48(a1)
    80001aaa:	0385ba83          	ld	s5,56(a1)
    80001aae:	0405bb03          	ld	s6,64(a1)
    80001ab2:	0485bb83          	ld	s7,72(a1)
    80001ab6:	0505bc03          	ld	s8,80(a1)
    80001aba:	0585bc83          	ld	s9,88(a1)
    80001abe:	0605bd03          	ld	s10,96(a1)
    80001ac2:	0685bd83          	ld	s11,104(a1)
    80001ac6:	8082                	ret

0000000080001ac8 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001ac8:	1141                	addi	sp,sp,-16
    80001aca:	e406                	sd	ra,8(sp)
    80001acc:	e022                	sd	s0,0(sp)
    80001ace:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001ad0:	00006597          	auipc	a1,0x6
    80001ad4:	7a858593          	addi	a1,a1,1960 # 80008278 <states.1722+0x30>
    80001ad8:	00008517          	auipc	a0,0x8
    80001adc:	07850513          	addi	a0,a0,120 # 80009b50 <tickslock>
    80001ae0:	00005097          	auipc	ra,0x5
    80001ae4:	85c080e7          	jalr	-1956(ra) # 8000633c <initlock>
}
    80001ae8:	60a2                	ld	ra,8(sp)
    80001aea:	6402                	ld	s0,0(sp)
    80001aec:	0141                	addi	sp,sp,16
    80001aee:	8082                	ret

0000000080001af0 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001af0:	1141                	addi	sp,sp,-16
    80001af2:	e422                	sd	s0,8(sp)
    80001af4:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001af6:	00003797          	auipc	a5,0x3
    80001afa:	75a78793          	addi	a5,a5,1882 # 80005250 <kernelvec>
    80001afe:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001b02:	6422                	ld	s0,8(sp)
    80001b04:	0141                	addi	sp,sp,16
    80001b06:	8082                	ret

0000000080001b08 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001b08:	1141                	addi	sp,sp,-16
    80001b0a:	e406                	sd	ra,8(sp)
    80001b0c:	e022                	sd	s0,0(sp)
    80001b0e:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001b10:	fffff097          	auipc	ra,0xfffff
    80001b14:	348080e7          	jalr	840(ra) # 80000e58 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b18:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001b1c:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b1e:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001b22:	00005617          	auipc	a2,0x5
    80001b26:	4de60613          	addi	a2,a2,1246 # 80007000 <_trampoline>
    80001b2a:	00005697          	auipc	a3,0x5
    80001b2e:	4d668693          	addi	a3,a3,1238 # 80007000 <_trampoline>
    80001b32:	8e91                	sub	a3,a3,a2
    80001b34:	040007b7          	lui	a5,0x4000
    80001b38:	17fd                	addi	a5,a5,-1
    80001b3a:	07b2                	slli	a5,a5,0xc
    80001b3c:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001b3e:	10569073          	csrw	stvec,a3
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001b42:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001b44:	180026f3          	csrr	a3,satp
    80001b48:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001b4a:	6d38                	ld	a4,88(a0)
    80001b4c:	6134                	ld	a3,64(a0)
    80001b4e:	6585                	lui	a1,0x1
    80001b50:	96ae                	add	a3,a3,a1
    80001b52:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001b54:	6d38                	ld	a4,88(a0)
    80001b56:	00000697          	auipc	a3,0x0
    80001b5a:	13068693          	addi	a3,a3,304 # 80001c86 <usertrap>
    80001b5e:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001b60:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001b62:	8692                	mv	a3,tp
    80001b64:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b66:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001b6a:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001b6e:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b72:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001b76:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001b78:	6f18                	ld	a4,24(a4)
    80001b7a:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001b7e:	6928                	ld	a0,80(a0)
    80001b80:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80001b82:	00005717          	auipc	a4,0x5
    80001b86:	51a70713          	addi	a4,a4,1306 # 8000709c <userret>
    80001b8a:	8f11                	sub	a4,a4,a2
    80001b8c:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80001b8e:	577d                	li	a4,-1
    80001b90:	177e                	slli	a4,a4,0x3f
    80001b92:	8d59                	or	a0,a0,a4
    80001b94:	9782                	jalr	a5
}
    80001b96:	60a2                	ld	ra,8(sp)
    80001b98:	6402                	ld	s0,0(sp)
    80001b9a:	0141                	addi	sp,sp,16
    80001b9c:	8082                	ret

0000000080001b9e <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001b9e:	1101                	addi	sp,sp,-32
    80001ba0:	ec06                	sd	ra,24(sp)
    80001ba2:	e822                	sd	s0,16(sp)
    80001ba4:	e426                	sd	s1,8(sp)
    80001ba6:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001ba8:	00008497          	auipc	s1,0x8
    80001bac:	fa848493          	addi	s1,s1,-88 # 80009b50 <tickslock>
    80001bb0:	8526                	mv	a0,s1
    80001bb2:	00005097          	auipc	ra,0x5
    80001bb6:	81a080e7          	jalr	-2022(ra) # 800063cc <acquire>
  ticks++;
    80001bba:	00007517          	auipc	a0,0x7
    80001bbe:	d1e50513          	addi	a0,a0,-738 # 800088d8 <ticks>
    80001bc2:	411c                	lw	a5,0(a0)
    80001bc4:	2785                	addiw	a5,a5,1
    80001bc6:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001bc8:	00000097          	auipc	ra,0x0
    80001bcc:	998080e7          	jalr	-1640(ra) # 80001560 <wakeup>
  release(&tickslock);
    80001bd0:	8526                	mv	a0,s1
    80001bd2:	00005097          	auipc	ra,0x5
    80001bd6:	8ae080e7          	jalr	-1874(ra) # 80006480 <release>
}
    80001bda:	60e2                	ld	ra,24(sp)
    80001bdc:	6442                	ld	s0,16(sp)
    80001bde:	64a2                	ld	s1,8(sp)
    80001be0:	6105                	addi	sp,sp,32
    80001be2:	8082                	ret

0000000080001be4 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001be4:	1101                	addi	sp,sp,-32
    80001be6:	ec06                	sd	ra,24(sp)
    80001be8:	e822                	sd	s0,16(sp)
    80001bea:	e426                	sd	s1,8(sp)
    80001bec:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001bee:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001bf2:	00074d63          	bltz	a4,80001c0c <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001bf6:	57fd                	li	a5,-1
    80001bf8:	17fe                	slli	a5,a5,0x3f
    80001bfa:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001bfc:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001bfe:	06f70363          	beq	a4,a5,80001c64 <devintr+0x80>
  }
}
    80001c02:	60e2                	ld	ra,24(sp)
    80001c04:	6442                	ld	s0,16(sp)
    80001c06:	64a2                	ld	s1,8(sp)
    80001c08:	6105                	addi	sp,sp,32
    80001c0a:	8082                	ret
     (scause & 0xff) == 9){
    80001c0c:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80001c10:	46a5                	li	a3,9
    80001c12:	fed792e3          	bne	a5,a3,80001bf6 <devintr+0x12>
    int irq = plic_claim();
    80001c16:	00003097          	auipc	ra,0x3
    80001c1a:	742080e7          	jalr	1858(ra) # 80005358 <plic_claim>
    80001c1e:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001c20:	47a9                	li	a5,10
    80001c22:	02f50763          	beq	a0,a5,80001c50 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001c26:	4785                	li	a5,1
    80001c28:	02f50963          	beq	a0,a5,80001c5a <devintr+0x76>
    return 1;
    80001c2c:	4505                	li	a0,1
    } else if(irq){
    80001c2e:	d8f1                	beqz	s1,80001c02 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001c30:	85a6                	mv	a1,s1
    80001c32:	00006517          	auipc	a0,0x6
    80001c36:	64e50513          	addi	a0,a0,1614 # 80008280 <states.1722+0x38>
    80001c3a:	00004097          	auipc	ra,0x4
    80001c3e:	292080e7          	jalr	658(ra) # 80005ecc <printf>
      plic_complete(irq);
    80001c42:	8526                	mv	a0,s1
    80001c44:	00003097          	auipc	ra,0x3
    80001c48:	738080e7          	jalr	1848(ra) # 8000537c <plic_complete>
    return 1;
    80001c4c:	4505                	li	a0,1
    80001c4e:	bf55                	j	80001c02 <devintr+0x1e>
      uartintr();
    80001c50:	00004097          	auipc	ra,0x4
    80001c54:	69c080e7          	jalr	1692(ra) # 800062ec <uartintr>
    80001c58:	b7ed                	j	80001c42 <devintr+0x5e>
      virtio_disk_intr();
    80001c5a:	00004097          	auipc	ra,0x4
    80001c5e:	c4c080e7          	jalr	-948(ra) # 800058a6 <virtio_disk_intr>
    80001c62:	b7c5                	j	80001c42 <devintr+0x5e>
    if(cpuid() == 0){
    80001c64:	fffff097          	auipc	ra,0xfffff
    80001c68:	1c8080e7          	jalr	456(ra) # 80000e2c <cpuid>
    80001c6c:	c901                	beqz	a0,80001c7c <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001c6e:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001c72:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001c74:	14479073          	csrw	sip,a5
    return 2;
    80001c78:	4509                	li	a0,2
    80001c7a:	b761                	j	80001c02 <devintr+0x1e>
      clockintr();
    80001c7c:	00000097          	auipc	ra,0x0
    80001c80:	f22080e7          	jalr	-222(ra) # 80001b9e <clockintr>
    80001c84:	b7ed                	j	80001c6e <devintr+0x8a>

0000000080001c86 <usertrap>:
{
    80001c86:	1101                	addi	sp,sp,-32
    80001c88:	ec06                	sd	ra,24(sp)
    80001c8a:	e822                	sd	s0,16(sp)
    80001c8c:	e426                	sd	s1,8(sp)
    80001c8e:	e04a                	sd	s2,0(sp)
    80001c90:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c92:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001c96:	1007f793          	andi	a5,a5,256
    80001c9a:	e3b1                	bnez	a5,80001cde <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001c9c:	00003797          	auipc	a5,0x3
    80001ca0:	5b478793          	addi	a5,a5,1460 # 80005250 <kernelvec>
    80001ca4:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001ca8:	fffff097          	auipc	ra,0xfffff
    80001cac:	1b0080e7          	jalr	432(ra) # 80000e58 <myproc>
    80001cb0:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001cb2:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001cb4:	14102773          	csrr	a4,sepc
    80001cb8:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001cba:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001cbe:	47a1                	li	a5,8
    80001cc0:	02f70763          	beq	a4,a5,80001cee <usertrap+0x68>
  } else if((which_dev = devintr()) != 0){
    80001cc4:	00000097          	auipc	ra,0x0
    80001cc8:	f20080e7          	jalr	-224(ra) # 80001be4 <devintr>
    80001ccc:	892a                	mv	s2,a0
    80001cce:	c151                	beqz	a0,80001d52 <usertrap+0xcc>
  if(killed(p))
    80001cd0:	8526                	mv	a0,s1
    80001cd2:	00000097          	auipc	ra,0x0
    80001cd6:	ad2080e7          	jalr	-1326(ra) # 800017a4 <killed>
    80001cda:	c929                	beqz	a0,80001d2c <usertrap+0xa6>
    80001cdc:	a099                	j	80001d22 <usertrap+0x9c>
    panic("usertrap: not from user mode");
    80001cde:	00006517          	auipc	a0,0x6
    80001ce2:	5c250513          	addi	a0,a0,1474 # 800082a0 <states.1722+0x58>
    80001ce6:	00004097          	auipc	ra,0x4
    80001cea:	19c080e7          	jalr	412(ra) # 80005e82 <panic>
    if(killed(p))
    80001cee:	00000097          	auipc	ra,0x0
    80001cf2:	ab6080e7          	jalr	-1354(ra) # 800017a4 <killed>
    80001cf6:	e921                	bnez	a0,80001d46 <usertrap+0xc0>
    p->trapframe->epc += 4;
    80001cf8:	6cb8                	ld	a4,88(s1)
    80001cfa:	6f1c                	ld	a5,24(a4)
    80001cfc:	0791                	addi	a5,a5,4
    80001cfe:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d00:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001d04:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001d08:	10079073          	csrw	sstatus,a5
    syscall();
    80001d0c:	00000097          	auipc	ra,0x0
    80001d10:	2d4080e7          	jalr	724(ra) # 80001fe0 <syscall>
  if(killed(p))
    80001d14:	8526                	mv	a0,s1
    80001d16:	00000097          	auipc	ra,0x0
    80001d1a:	a8e080e7          	jalr	-1394(ra) # 800017a4 <killed>
    80001d1e:	c911                	beqz	a0,80001d32 <usertrap+0xac>
    80001d20:	4901                	li	s2,0
    exit(-1);
    80001d22:	557d                	li	a0,-1
    80001d24:	00000097          	auipc	ra,0x0
    80001d28:	90c080e7          	jalr	-1780(ra) # 80001630 <exit>
  if(which_dev == 2)
    80001d2c:	4789                	li	a5,2
    80001d2e:	04f90f63          	beq	s2,a5,80001d8c <usertrap+0x106>
  usertrapret();
    80001d32:	00000097          	auipc	ra,0x0
    80001d36:	dd6080e7          	jalr	-554(ra) # 80001b08 <usertrapret>
}
    80001d3a:	60e2                	ld	ra,24(sp)
    80001d3c:	6442                	ld	s0,16(sp)
    80001d3e:	64a2                	ld	s1,8(sp)
    80001d40:	6902                	ld	s2,0(sp)
    80001d42:	6105                	addi	sp,sp,32
    80001d44:	8082                	ret
      exit(-1);
    80001d46:	557d                	li	a0,-1
    80001d48:	00000097          	auipc	ra,0x0
    80001d4c:	8e8080e7          	jalr	-1816(ra) # 80001630 <exit>
    80001d50:	b765                	j	80001cf8 <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d52:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001d56:	5890                	lw	a2,48(s1)
    80001d58:	00006517          	auipc	a0,0x6
    80001d5c:	56850513          	addi	a0,a0,1384 # 800082c0 <states.1722+0x78>
    80001d60:	00004097          	auipc	ra,0x4
    80001d64:	16c080e7          	jalr	364(ra) # 80005ecc <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001d68:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001d6c:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001d70:	00006517          	auipc	a0,0x6
    80001d74:	58050513          	addi	a0,a0,1408 # 800082f0 <states.1722+0xa8>
    80001d78:	00004097          	auipc	ra,0x4
    80001d7c:	154080e7          	jalr	340(ra) # 80005ecc <printf>
    setkilled(p);
    80001d80:	8526                	mv	a0,s1
    80001d82:	00000097          	auipc	ra,0x0
    80001d86:	9f6080e7          	jalr	-1546(ra) # 80001778 <setkilled>
    80001d8a:	b769                	j	80001d14 <usertrap+0x8e>
    yield();
    80001d8c:	fffff097          	auipc	ra,0xfffff
    80001d90:	734080e7          	jalr	1844(ra) # 800014c0 <yield>
    80001d94:	bf79                	j	80001d32 <usertrap+0xac>

0000000080001d96 <kerneltrap>:
{
    80001d96:	7179                	addi	sp,sp,-48
    80001d98:	f406                	sd	ra,40(sp)
    80001d9a:	f022                	sd	s0,32(sp)
    80001d9c:	ec26                	sd	s1,24(sp)
    80001d9e:	e84a                	sd	s2,16(sp)
    80001da0:	e44e                	sd	s3,8(sp)
    80001da2:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001da4:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001da8:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001dac:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001db0:	1004f793          	andi	a5,s1,256
    80001db4:	cb85                	beqz	a5,80001de4 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001db6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001dba:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001dbc:	ef85                	bnez	a5,80001df4 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001dbe:	00000097          	auipc	ra,0x0
    80001dc2:	e26080e7          	jalr	-474(ra) # 80001be4 <devintr>
    80001dc6:	cd1d                	beqz	a0,80001e04 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001dc8:	4789                	li	a5,2
    80001dca:	06f50a63          	beq	a0,a5,80001e3e <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001dce:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001dd2:	10049073          	csrw	sstatus,s1
}
    80001dd6:	70a2                	ld	ra,40(sp)
    80001dd8:	7402                	ld	s0,32(sp)
    80001dda:	64e2                	ld	s1,24(sp)
    80001ddc:	6942                	ld	s2,16(sp)
    80001dde:	69a2                	ld	s3,8(sp)
    80001de0:	6145                	addi	sp,sp,48
    80001de2:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001de4:	00006517          	auipc	a0,0x6
    80001de8:	52c50513          	addi	a0,a0,1324 # 80008310 <states.1722+0xc8>
    80001dec:	00004097          	auipc	ra,0x4
    80001df0:	096080e7          	jalr	150(ra) # 80005e82 <panic>
    panic("kerneltrap: interrupts enabled");
    80001df4:	00006517          	auipc	a0,0x6
    80001df8:	54450513          	addi	a0,a0,1348 # 80008338 <states.1722+0xf0>
    80001dfc:	00004097          	auipc	ra,0x4
    80001e00:	086080e7          	jalr	134(ra) # 80005e82 <panic>
    printf("scause %p\n", scause);
    80001e04:	85ce                	mv	a1,s3
    80001e06:	00006517          	auipc	a0,0x6
    80001e0a:	55250513          	addi	a0,a0,1362 # 80008358 <states.1722+0x110>
    80001e0e:	00004097          	auipc	ra,0x4
    80001e12:	0be080e7          	jalr	190(ra) # 80005ecc <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e16:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001e1a:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001e1e:	00006517          	auipc	a0,0x6
    80001e22:	54a50513          	addi	a0,a0,1354 # 80008368 <states.1722+0x120>
    80001e26:	00004097          	auipc	ra,0x4
    80001e2a:	0a6080e7          	jalr	166(ra) # 80005ecc <printf>
    panic("kerneltrap");
    80001e2e:	00006517          	auipc	a0,0x6
    80001e32:	55250513          	addi	a0,a0,1362 # 80008380 <states.1722+0x138>
    80001e36:	00004097          	auipc	ra,0x4
    80001e3a:	04c080e7          	jalr	76(ra) # 80005e82 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001e3e:	fffff097          	auipc	ra,0xfffff
    80001e42:	01a080e7          	jalr	26(ra) # 80000e58 <myproc>
    80001e46:	d541                	beqz	a0,80001dce <kerneltrap+0x38>
    80001e48:	fffff097          	auipc	ra,0xfffff
    80001e4c:	010080e7          	jalr	16(ra) # 80000e58 <myproc>
    80001e50:	4d18                	lw	a4,24(a0)
    80001e52:	4791                	li	a5,4
    80001e54:	f6f71de3          	bne	a4,a5,80001dce <kerneltrap+0x38>
    yield();
    80001e58:	fffff097          	auipc	ra,0xfffff
    80001e5c:	668080e7          	jalr	1640(ra) # 800014c0 <yield>
    80001e60:	b7bd                	j	80001dce <kerneltrap+0x38>

0000000080001e62 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001e62:	1101                	addi	sp,sp,-32
    80001e64:	ec06                	sd	ra,24(sp)
    80001e66:	e822                	sd	s0,16(sp)
    80001e68:	e426                	sd	s1,8(sp)
    80001e6a:	1000                	addi	s0,sp,32
    80001e6c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001e6e:	fffff097          	auipc	ra,0xfffff
    80001e72:	fea080e7          	jalr	-22(ra) # 80000e58 <myproc>
  switch (n) {
    80001e76:	4795                	li	a5,5
    80001e78:	0497e163          	bltu	a5,s1,80001eba <argraw+0x58>
    80001e7c:	048a                	slli	s1,s1,0x2
    80001e7e:	00006717          	auipc	a4,0x6
    80001e82:	53a70713          	addi	a4,a4,1338 # 800083b8 <states.1722+0x170>
    80001e86:	94ba                	add	s1,s1,a4
    80001e88:	409c                	lw	a5,0(s1)
    80001e8a:	97ba                	add	a5,a5,a4
    80001e8c:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001e8e:	6d3c                	ld	a5,88(a0)
    80001e90:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001e92:	60e2                	ld	ra,24(sp)
    80001e94:	6442                	ld	s0,16(sp)
    80001e96:	64a2                	ld	s1,8(sp)
    80001e98:	6105                	addi	sp,sp,32
    80001e9a:	8082                	ret
    return p->trapframe->a1;
    80001e9c:	6d3c                	ld	a5,88(a0)
    80001e9e:	7fa8                	ld	a0,120(a5)
    80001ea0:	bfcd                	j	80001e92 <argraw+0x30>
    return p->trapframe->a2;
    80001ea2:	6d3c                	ld	a5,88(a0)
    80001ea4:	63c8                	ld	a0,128(a5)
    80001ea6:	b7f5                	j	80001e92 <argraw+0x30>
    return p->trapframe->a3;
    80001ea8:	6d3c                	ld	a5,88(a0)
    80001eaa:	67c8                	ld	a0,136(a5)
    80001eac:	b7dd                	j	80001e92 <argraw+0x30>
    return p->trapframe->a4;
    80001eae:	6d3c                	ld	a5,88(a0)
    80001eb0:	6bc8                	ld	a0,144(a5)
    80001eb2:	b7c5                	j	80001e92 <argraw+0x30>
    return p->trapframe->a5;
    80001eb4:	6d3c                	ld	a5,88(a0)
    80001eb6:	6fc8                	ld	a0,152(a5)
    80001eb8:	bfe9                	j	80001e92 <argraw+0x30>
  panic("argraw");
    80001eba:	00006517          	auipc	a0,0x6
    80001ebe:	4d650513          	addi	a0,a0,1238 # 80008390 <states.1722+0x148>
    80001ec2:	00004097          	auipc	ra,0x4
    80001ec6:	fc0080e7          	jalr	-64(ra) # 80005e82 <panic>

0000000080001eca <fetchaddr>:
{
    80001eca:	1101                	addi	sp,sp,-32
    80001ecc:	ec06                	sd	ra,24(sp)
    80001ece:	e822                	sd	s0,16(sp)
    80001ed0:	e426                	sd	s1,8(sp)
    80001ed2:	e04a                	sd	s2,0(sp)
    80001ed4:	1000                	addi	s0,sp,32
    80001ed6:	84aa                	mv	s1,a0
    80001ed8:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001eda:	fffff097          	auipc	ra,0xfffff
    80001ede:	f7e080e7          	jalr	-130(ra) # 80000e58 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80001ee2:	653c                	ld	a5,72(a0)
    80001ee4:	02f4f863          	bgeu	s1,a5,80001f14 <fetchaddr+0x4a>
    80001ee8:	00848713          	addi	a4,s1,8
    80001eec:	02e7e663          	bltu	a5,a4,80001f18 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001ef0:	46a1                	li	a3,8
    80001ef2:	8626                	mv	a2,s1
    80001ef4:	85ca                	mv	a1,s2
    80001ef6:	6928                	ld	a0,80(a0)
    80001ef8:	fffff097          	auipc	ra,0xfffff
    80001efc:	caa080e7          	jalr	-854(ra) # 80000ba2 <copyin>
    80001f00:	00a03533          	snez	a0,a0
    80001f04:	40a00533          	neg	a0,a0
}
    80001f08:	60e2                	ld	ra,24(sp)
    80001f0a:	6442                	ld	s0,16(sp)
    80001f0c:	64a2                	ld	s1,8(sp)
    80001f0e:	6902                	ld	s2,0(sp)
    80001f10:	6105                	addi	sp,sp,32
    80001f12:	8082                	ret
    return -1;
    80001f14:	557d                	li	a0,-1
    80001f16:	bfcd                	j	80001f08 <fetchaddr+0x3e>
    80001f18:	557d                	li	a0,-1
    80001f1a:	b7fd                	j	80001f08 <fetchaddr+0x3e>

0000000080001f1c <fetchstr>:
{
    80001f1c:	7179                	addi	sp,sp,-48
    80001f1e:	f406                	sd	ra,40(sp)
    80001f20:	f022                	sd	s0,32(sp)
    80001f22:	ec26                	sd	s1,24(sp)
    80001f24:	e84a                	sd	s2,16(sp)
    80001f26:	e44e                	sd	s3,8(sp)
    80001f28:	1800                	addi	s0,sp,48
    80001f2a:	892a                	mv	s2,a0
    80001f2c:	84ae                	mv	s1,a1
    80001f2e:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001f30:	fffff097          	auipc	ra,0xfffff
    80001f34:	f28080e7          	jalr	-216(ra) # 80000e58 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80001f38:	86ce                	mv	a3,s3
    80001f3a:	864a                	mv	a2,s2
    80001f3c:	85a6                	mv	a1,s1
    80001f3e:	6928                	ld	a0,80(a0)
    80001f40:	fffff097          	auipc	ra,0xfffff
    80001f44:	cee080e7          	jalr	-786(ra) # 80000c2e <copyinstr>
    80001f48:	00054e63          	bltz	a0,80001f64 <fetchstr+0x48>
  return strlen(buf);
    80001f4c:	8526                	mv	a0,s1
    80001f4e:	ffffe097          	auipc	ra,0xffffe
    80001f52:	3ae080e7          	jalr	942(ra) # 800002fc <strlen>
}
    80001f56:	70a2                	ld	ra,40(sp)
    80001f58:	7402                	ld	s0,32(sp)
    80001f5a:	64e2                	ld	s1,24(sp)
    80001f5c:	6942                	ld	s2,16(sp)
    80001f5e:	69a2                	ld	s3,8(sp)
    80001f60:	6145                	addi	sp,sp,48
    80001f62:	8082                	ret
    return -1;
    80001f64:	557d                	li	a0,-1
    80001f66:	bfc5                	j	80001f56 <fetchstr+0x3a>

0000000080001f68 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80001f68:	1101                	addi	sp,sp,-32
    80001f6a:	ec06                	sd	ra,24(sp)
    80001f6c:	e822                	sd	s0,16(sp)
    80001f6e:	e426                	sd	s1,8(sp)
    80001f70:	1000                	addi	s0,sp,32
    80001f72:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001f74:	00000097          	auipc	ra,0x0
    80001f78:	eee080e7          	jalr	-274(ra) # 80001e62 <argraw>
    80001f7c:	c088                	sw	a0,0(s1)
}
    80001f7e:	60e2                	ld	ra,24(sp)
    80001f80:	6442                	ld	s0,16(sp)
    80001f82:	64a2                	ld	s1,8(sp)
    80001f84:	6105                	addi	sp,sp,32
    80001f86:	8082                	ret

0000000080001f88 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80001f88:	1101                	addi	sp,sp,-32
    80001f8a:	ec06                	sd	ra,24(sp)
    80001f8c:	e822                	sd	s0,16(sp)
    80001f8e:	e426                	sd	s1,8(sp)
    80001f90:	1000                	addi	s0,sp,32
    80001f92:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001f94:	00000097          	auipc	ra,0x0
    80001f98:	ece080e7          	jalr	-306(ra) # 80001e62 <argraw>
    80001f9c:	e088                	sd	a0,0(s1)
}
    80001f9e:	60e2                	ld	ra,24(sp)
    80001fa0:	6442                	ld	s0,16(sp)
    80001fa2:	64a2                	ld	s1,8(sp)
    80001fa4:	6105                	addi	sp,sp,32
    80001fa6:	8082                	ret

0000000080001fa8 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001fa8:	7179                	addi	sp,sp,-48
    80001faa:	f406                	sd	ra,40(sp)
    80001fac:	f022                	sd	s0,32(sp)
    80001fae:	ec26                	sd	s1,24(sp)
    80001fb0:	e84a                	sd	s2,16(sp)
    80001fb2:	1800                	addi	s0,sp,48
    80001fb4:	84ae                	mv	s1,a1
    80001fb6:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    80001fb8:	fd840593          	addi	a1,s0,-40
    80001fbc:	00000097          	auipc	ra,0x0
    80001fc0:	fcc080e7          	jalr	-52(ra) # 80001f88 <argaddr>
  return fetchstr(addr, buf, max);
    80001fc4:	864a                	mv	a2,s2
    80001fc6:	85a6                	mv	a1,s1
    80001fc8:	fd843503          	ld	a0,-40(s0)
    80001fcc:	00000097          	auipc	ra,0x0
    80001fd0:	f50080e7          	jalr	-176(ra) # 80001f1c <fetchstr>
}
    80001fd4:	70a2                	ld	ra,40(sp)
    80001fd6:	7402                	ld	s0,32(sp)
    80001fd8:	64e2                	ld	s1,24(sp)
    80001fda:	6942                	ld	s2,16(sp)
    80001fdc:	6145                	addi	sp,sp,48
    80001fde:	8082                	ret

0000000080001fe0 <syscall>:
[SYS_symlink]   sys_symlink,
};

void
syscall(void)
{
    80001fe0:	1101                	addi	sp,sp,-32
    80001fe2:	ec06                	sd	ra,24(sp)
    80001fe4:	e822                	sd	s0,16(sp)
    80001fe6:	e426                	sd	s1,8(sp)
    80001fe8:	e04a                	sd	s2,0(sp)
    80001fea:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80001fec:	fffff097          	auipc	ra,0xfffff
    80001ff0:	e6c080e7          	jalr	-404(ra) # 80000e58 <myproc>
    80001ff4:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001ff6:	05853903          	ld	s2,88(a0)
    80001ffa:	0a893783          	ld	a5,168(s2)
    80001ffe:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002002:	37fd                	addiw	a5,a5,-1
    80002004:	4755                	li	a4,21
    80002006:	00f76f63          	bltu	a4,a5,80002024 <syscall+0x44>
    8000200a:	00369713          	slli	a4,a3,0x3
    8000200e:	00006797          	auipc	a5,0x6
    80002012:	3c278793          	addi	a5,a5,962 # 800083d0 <syscalls>
    80002016:	97ba                	add	a5,a5,a4
    80002018:	639c                	ld	a5,0(a5)
    8000201a:	c789                	beqz	a5,80002024 <syscall+0x44>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    8000201c:	9782                	jalr	a5
    8000201e:	06a93823          	sd	a0,112(s2)
    80002022:	a839                	j	80002040 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002024:	15848613          	addi	a2,s1,344
    80002028:	588c                	lw	a1,48(s1)
    8000202a:	00006517          	auipc	a0,0x6
    8000202e:	36e50513          	addi	a0,a0,878 # 80008398 <states.1722+0x150>
    80002032:	00004097          	auipc	ra,0x4
    80002036:	e9a080e7          	jalr	-358(ra) # 80005ecc <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    8000203a:	6cbc                	ld	a5,88(s1)
    8000203c:	577d                	li	a4,-1
    8000203e:	fbb8                	sd	a4,112(a5)
  }
}
    80002040:	60e2                	ld	ra,24(sp)
    80002042:	6442                	ld	s0,16(sp)
    80002044:	64a2                	ld	s1,8(sp)
    80002046:	6902                	ld	s2,0(sp)
    80002048:	6105                	addi	sp,sp,32
    8000204a:	8082                	ret

000000008000204c <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    8000204c:	1101                	addi	sp,sp,-32
    8000204e:	ec06                	sd	ra,24(sp)
    80002050:	e822                	sd	s0,16(sp)
    80002052:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80002054:	fec40593          	addi	a1,s0,-20
    80002058:	4501                	li	a0,0
    8000205a:	00000097          	auipc	ra,0x0
    8000205e:	f0e080e7          	jalr	-242(ra) # 80001f68 <argint>
  exit(n);
    80002062:	fec42503          	lw	a0,-20(s0)
    80002066:	fffff097          	auipc	ra,0xfffff
    8000206a:	5ca080e7          	jalr	1482(ra) # 80001630 <exit>
  return 0;  // not reached
}
    8000206e:	4501                	li	a0,0
    80002070:	60e2                	ld	ra,24(sp)
    80002072:	6442                	ld	s0,16(sp)
    80002074:	6105                	addi	sp,sp,32
    80002076:	8082                	ret

0000000080002078 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002078:	1141                	addi	sp,sp,-16
    8000207a:	e406                	sd	ra,8(sp)
    8000207c:	e022                	sd	s0,0(sp)
    8000207e:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002080:	fffff097          	auipc	ra,0xfffff
    80002084:	dd8080e7          	jalr	-552(ra) # 80000e58 <myproc>
}
    80002088:	5908                	lw	a0,48(a0)
    8000208a:	60a2                	ld	ra,8(sp)
    8000208c:	6402                	ld	s0,0(sp)
    8000208e:	0141                	addi	sp,sp,16
    80002090:	8082                	ret

0000000080002092 <sys_fork>:

uint64
sys_fork(void)
{
    80002092:	1141                	addi	sp,sp,-16
    80002094:	e406                	sd	ra,8(sp)
    80002096:	e022                	sd	s0,0(sp)
    80002098:	0800                	addi	s0,sp,16
  return fork();
    8000209a:	fffff097          	auipc	ra,0xfffff
    8000209e:	174080e7          	jalr	372(ra) # 8000120e <fork>
}
    800020a2:	60a2                	ld	ra,8(sp)
    800020a4:	6402                	ld	s0,0(sp)
    800020a6:	0141                	addi	sp,sp,16
    800020a8:	8082                	ret

00000000800020aa <sys_wait>:

uint64
sys_wait(void)
{
    800020aa:	1101                	addi	sp,sp,-32
    800020ac:	ec06                	sd	ra,24(sp)
    800020ae:	e822                	sd	s0,16(sp)
    800020b0:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    800020b2:	fe840593          	addi	a1,s0,-24
    800020b6:	4501                	li	a0,0
    800020b8:	00000097          	auipc	ra,0x0
    800020bc:	ed0080e7          	jalr	-304(ra) # 80001f88 <argaddr>
  return wait(p);
    800020c0:	fe843503          	ld	a0,-24(s0)
    800020c4:	fffff097          	auipc	ra,0xfffff
    800020c8:	712080e7          	jalr	1810(ra) # 800017d6 <wait>
}
    800020cc:	60e2                	ld	ra,24(sp)
    800020ce:	6442                	ld	s0,16(sp)
    800020d0:	6105                	addi	sp,sp,32
    800020d2:	8082                	ret

00000000800020d4 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    800020d4:	7179                	addi	sp,sp,-48
    800020d6:	f406                	sd	ra,40(sp)
    800020d8:	f022                	sd	s0,32(sp)
    800020da:	ec26                	sd	s1,24(sp)
    800020dc:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    800020de:	fdc40593          	addi	a1,s0,-36
    800020e2:	4501                	li	a0,0
    800020e4:	00000097          	auipc	ra,0x0
    800020e8:	e84080e7          	jalr	-380(ra) # 80001f68 <argint>
  addr = myproc()->sz;
    800020ec:	fffff097          	auipc	ra,0xfffff
    800020f0:	d6c080e7          	jalr	-660(ra) # 80000e58 <myproc>
    800020f4:	6524                	ld	s1,72(a0)
  if(growproc(n) < 0)
    800020f6:	fdc42503          	lw	a0,-36(s0)
    800020fa:	fffff097          	auipc	ra,0xfffff
    800020fe:	0b8080e7          	jalr	184(ra) # 800011b2 <growproc>
    80002102:	00054863          	bltz	a0,80002112 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    80002106:	8526                	mv	a0,s1
    80002108:	70a2                	ld	ra,40(sp)
    8000210a:	7402                	ld	s0,32(sp)
    8000210c:	64e2                	ld	s1,24(sp)
    8000210e:	6145                	addi	sp,sp,48
    80002110:	8082                	ret
    return -1;
    80002112:	54fd                	li	s1,-1
    80002114:	bfcd                	j	80002106 <sys_sbrk+0x32>

0000000080002116 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002116:	7139                	addi	sp,sp,-64
    80002118:	fc06                	sd	ra,56(sp)
    8000211a:	f822                	sd	s0,48(sp)
    8000211c:	f426                	sd	s1,40(sp)
    8000211e:	f04a                	sd	s2,32(sp)
    80002120:	ec4e                	sd	s3,24(sp)
    80002122:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80002124:	fcc40593          	addi	a1,s0,-52
    80002128:	4501                	li	a0,0
    8000212a:	00000097          	auipc	ra,0x0
    8000212e:	e3e080e7          	jalr	-450(ra) # 80001f68 <argint>
  if(n < 0)
    80002132:	fcc42783          	lw	a5,-52(s0)
    80002136:	0607cf63          	bltz	a5,800021b4 <sys_sleep+0x9e>
    n = 0;
  acquire(&tickslock);
    8000213a:	00008517          	auipc	a0,0x8
    8000213e:	a1650513          	addi	a0,a0,-1514 # 80009b50 <tickslock>
    80002142:	00004097          	auipc	ra,0x4
    80002146:	28a080e7          	jalr	650(ra) # 800063cc <acquire>
  ticks0 = ticks;
    8000214a:	00006917          	auipc	s2,0x6
    8000214e:	78e92903          	lw	s2,1934(s2) # 800088d8 <ticks>
  while(ticks - ticks0 < n){
    80002152:	fcc42783          	lw	a5,-52(s0)
    80002156:	cf9d                	beqz	a5,80002194 <sys_sleep+0x7e>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002158:	00008997          	auipc	s3,0x8
    8000215c:	9f898993          	addi	s3,s3,-1544 # 80009b50 <tickslock>
    80002160:	00006497          	auipc	s1,0x6
    80002164:	77848493          	addi	s1,s1,1912 # 800088d8 <ticks>
    if(killed(myproc())){
    80002168:	fffff097          	auipc	ra,0xfffff
    8000216c:	cf0080e7          	jalr	-784(ra) # 80000e58 <myproc>
    80002170:	fffff097          	auipc	ra,0xfffff
    80002174:	634080e7          	jalr	1588(ra) # 800017a4 <killed>
    80002178:	e129                	bnez	a0,800021ba <sys_sleep+0xa4>
    sleep(&ticks, &tickslock);
    8000217a:	85ce                	mv	a1,s3
    8000217c:	8526                	mv	a0,s1
    8000217e:	fffff097          	auipc	ra,0xfffff
    80002182:	37e080e7          	jalr	894(ra) # 800014fc <sleep>
  while(ticks - ticks0 < n){
    80002186:	409c                	lw	a5,0(s1)
    80002188:	412787bb          	subw	a5,a5,s2
    8000218c:	fcc42703          	lw	a4,-52(s0)
    80002190:	fce7ece3          	bltu	a5,a4,80002168 <sys_sleep+0x52>
  }
  release(&tickslock);
    80002194:	00008517          	auipc	a0,0x8
    80002198:	9bc50513          	addi	a0,a0,-1604 # 80009b50 <tickslock>
    8000219c:	00004097          	auipc	ra,0x4
    800021a0:	2e4080e7          	jalr	740(ra) # 80006480 <release>
  return 0;
    800021a4:	4501                	li	a0,0
}
    800021a6:	70e2                	ld	ra,56(sp)
    800021a8:	7442                	ld	s0,48(sp)
    800021aa:	74a2                	ld	s1,40(sp)
    800021ac:	7902                	ld	s2,32(sp)
    800021ae:	69e2                	ld	s3,24(sp)
    800021b0:	6121                	addi	sp,sp,64
    800021b2:	8082                	ret
    n = 0;
    800021b4:	fc042623          	sw	zero,-52(s0)
    800021b8:	b749                	j	8000213a <sys_sleep+0x24>
      release(&tickslock);
    800021ba:	00008517          	auipc	a0,0x8
    800021be:	99650513          	addi	a0,a0,-1642 # 80009b50 <tickslock>
    800021c2:	00004097          	auipc	ra,0x4
    800021c6:	2be080e7          	jalr	702(ra) # 80006480 <release>
      return -1;
    800021ca:	557d                	li	a0,-1
    800021cc:	bfe9                	j	800021a6 <sys_sleep+0x90>

00000000800021ce <sys_kill>:

uint64
sys_kill(void)
{
    800021ce:	1101                	addi	sp,sp,-32
    800021d0:	ec06                	sd	ra,24(sp)
    800021d2:	e822                	sd	s0,16(sp)
    800021d4:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    800021d6:	fec40593          	addi	a1,s0,-20
    800021da:	4501                	li	a0,0
    800021dc:	00000097          	auipc	ra,0x0
    800021e0:	d8c080e7          	jalr	-628(ra) # 80001f68 <argint>
  return kill(pid);
    800021e4:	fec42503          	lw	a0,-20(s0)
    800021e8:	fffff097          	auipc	ra,0xfffff
    800021ec:	51e080e7          	jalr	1310(ra) # 80001706 <kill>
}
    800021f0:	60e2                	ld	ra,24(sp)
    800021f2:	6442                	ld	s0,16(sp)
    800021f4:	6105                	addi	sp,sp,32
    800021f6:	8082                	ret

00000000800021f8 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800021f8:	1101                	addi	sp,sp,-32
    800021fa:	ec06                	sd	ra,24(sp)
    800021fc:	e822                	sd	s0,16(sp)
    800021fe:	e426                	sd	s1,8(sp)
    80002200:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002202:	00008517          	auipc	a0,0x8
    80002206:	94e50513          	addi	a0,a0,-1714 # 80009b50 <tickslock>
    8000220a:	00004097          	auipc	ra,0x4
    8000220e:	1c2080e7          	jalr	450(ra) # 800063cc <acquire>
  xticks = ticks;
    80002212:	00006497          	auipc	s1,0x6
    80002216:	6c64a483          	lw	s1,1734(s1) # 800088d8 <ticks>
  release(&tickslock);
    8000221a:	00008517          	auipc	a0,0x8
    8000221e:	93650513          	addi	a0,a0,-1738 # 80009b50 <tickslock>
    80002222:	00004097          	auipc	ra,0x4
    80002226:	25e080e7          	jalr	606(ra) # 80006480 <release>
  return xticks;
}
    8000222a:	02049513          	slli	a0,s1,0x20
    8000222e:	9101                	srli	a0,a0,0x20
    80002230:	60e2                	ld	ra,24(sp)
    80002232:	6442                	ld	s0,16(sp)
    80002234:	64a2                	ld	s1,8(sp)
    80002236:	6105                	addi	sp,sp,32
    80002238:	8082                	ret

000000008000223a <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    8000223a:	7179                	addi	sp,sp,-48
    8000223c:	f406                	sd	ra,40(sp)
    8000223e:	f022                	sd	s0,32(sp)
    80002240:	ec26                	sd	s1,24(sp)
    80002242:	e84a                	sd	s2,16(sp)
    80002244:	e44e                	sd	s3,8(sp)
    80002246:	e052                	sd	s4,0(sp)
    80002248:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000224a:	00006597          	auipc	a1,0x6
    8000224e:	23e58593          	addi	a1,a1,574 # 80008488 <syscalls+0xb8>
    80002252:	00008517          	auipc	a0,0x8
    80002256:	91650513          	addi	a0,a0,-1770 # 80009b68 <bcache>
    8000225a:	00004097          	auipc	ra,0x4
    8000225e:	0e2080e7          	jalr	226(ra) # 8000633c <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002262:	00010797          	auipc	a5,0x10
    80002266:	90678793          	addi	a5,a5,-1786 # 80011b68 <bcache+0x8000>
    8000226a:	00010717          	auipc	a4,0x10
    8000226e:	b6670713          	addi	a4,a4,-1178 # 80011dd0 <bcache+0x8268>
    80002272:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002276:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000227a:	00008497          	auipc	s1,0x8
    8000227e:	90648493          	addi	s1,s1,-1786 # 80009b80 <bcache+0x18>
    b->next = bcache.head.next;
    80002282:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002284:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002286:	00006a17          	auipc	s4,0x6
    8000228a:	20aa0a13          	addi	s4,s4,522 # 80008490 <syscalls+0xc0>
    b->next = bcache.head.next;
    8000228e:	2b893783          	ld	a5,696(s2)
    80002292:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002294:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002298:	85d2                	mv	a1,s4
    8000229a:	01048513          	addi	a0,s1,16
    8000229e:	00001097          	auipc	ra,0x1
    800022a2:	63c080e7          	jalr	1596(ra) # 800038da <initsleeplock>
    bcache.head.next->prev = b;
    800022a6:	2b893783          	ld	a5,696(s2)
    800022aa:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    800022ac:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800022b0:	45848493          	addi	s1,s1,1112
    800022b4:	fd349de3          	bne	s1,s3,8000228e <binit+0x54>
  }
}
    800022b8:	70a2                	ld	ra,40(sp)
    800022ba:	7402                	ld	s0,32(sp)
    800022bc:	64e2                	ld	s1,24(sp)
    800022be:	6942                	ld	s2,16(sp)
    800022c0:	69a2                	ld	s3,8(sp)
    800022c2:	6a02                	ld	s4,0(sp)
    800022c4:	6145                	addi	sp,sp,48
    800022c6:	8082                	ret

00000000800022c8 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    800022c8:	7179                	addi	sp,sp,-48
    800022ca:	f406                	sd	ra,40(sp)
    800022cc:	f022                	sd	s0,32(sp)
    800022ce:	ec26                	sd	s1,24(sp)
    800022d0:	e84a                	sd	s2,16(sp)
    800022d2:	e44e                	sd	s3,8(sp)
    800022d4:	1800                	addi	s0,sp,48
    800022d6:	89aa                	mv	s3,a0
    800022d8:	892e                	mv	s2,a1
  acquire(&bcache.lock);
    800022da:	00008517          	auipc	a0,0x8
    800022de:	88e50513          	addi	a0,a0,-1906 # 80009b68 <bcache>
    800022e2:	00004097          	auipc	ra,0x4
    800022e6:	0ea080e7          	jalr	234(ra) # 800063cc <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800022ea:	00010497          	auipc	s1,0x10
    800022ee:	b364b483          	ld	s1,-1226(s1) # 80011e20 <bcache+0x82b8>
    800022f2:	00010797          	auipc	a5,0x10
    800022f6:	ade78793          	addi	a5,a5,-1314 # 80011dd0 <bcache+0x8268>
    800022fa:	02f48f63          	beq	s1,a5,80002338 <bread+0x70>
    800022fe:	873e                	mv	a4,a5
    80002300:	a021                	j	80002308 <bread+0x40>
    80002302:	68a4                	ld	s1,80(s1)
    80002304:	02e48a63          	beq	s1,a4,80002338 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002308:	449c                	lw	a5,8(s1)
    8000230a:	ff379ce3          	bne	a5,s3,80002302 <bread+0x3a>
    8000230e:	44dc                	lw	a5,12(s1)
    80002310:	ff2799e3          	bne	a5,s2,80002302 <bread+0x3a>
      b->refcnt++;
    80002314:	40bc                	lw	a5,64(s1)
    80002316:	2785                	addiw	a5,a5,1
    80002318:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000231a:	00008517          	auipc	a0,0x8
    8000231e:	84e50513          	addi	a0,a0,-1970 # 80009b68 <bcache>
    80002322:	00004097          	auipc	ra,0x4
    80002326:	15e080e7          	jalr	350(ra) # 80006480 <release>
      acquiresleep(&b->lock);
    8000232a:	01048513          	addi	a0,s1,16
    8000232e:	00001097          	auipc	ra,0x1
    80002332:	5e6080e7          	jalr	1510(ra) # 80003914 <acquiresleep>
      return b;
    80002336:	a8b9                	j	80002394 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002338:	00010497          	auipc	s1,0x10
    8000233c:	ae04b483          	ld	s1,-1312(s1) # 80011e18 <bcache+0x82b0>
    80002340:	00010797          	auipc	a5,0x10
    80002344:	a9078793          	addi	a5,a5,-1392 # 80011dd0 <bcache+0x8268>
    80002348:	00f48863          	beq	s1,a5,80002358 <bread+0x90>
    8000234c:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8000234e:	40bc                	lw	a5,64(s1)
    80002350:	cf81                	beqz	a5,80002368 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002352:	64a4                	ld	s1,72(s1)
    80002354:	fee49de3          	bne	s1,a4,8000234e <bread+0x86>
  panic("bget: no buffers");
    80002358:	00006517          	auipc	a0,0x6
    8000235c:	14050513          	addi	a0,a0,320 # 80008498 <syscalls+0xc8>
    80002360:	00004097          	auipc	ra,0x4
    80002364:	b22080e7          	jalr	-1246(ra) # 80005e82 <panic>
      b->dev = dev;
    80002368:	0134a423          	sw	s3,8(s1)
      b->blockno = blockno;
    8000236c:	0124a623          	sw	s2,12(s1)
      b->valid = 0;
    80002370:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002374:	4785                	li	a5,1
    80002376:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002378:	00007517          	auipc	a0,0x7
    8000237c:	7f050513          	addi	a0,a0,2032 # 80009b68 <bcache>
    80002380:	00004097          	auipc	ra,0x4
    80002384:	100080e7          	jalr	256(ra) # 80006480 <release>
      acquiresleep(&b->lock);
    80002388:	01048513          	addi	a0,s1,16
    8000238c:	00001097          	auipc	ra,0x1
    80002390:	588080e7          	jalr	1416(ra) # 80003914 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002394:	409c                	lw	a5,0(s1)
    80002396:	cb89                	beqz	a5,800023a8 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002398:	8526                	mv	a0,s1
    8000239a:	70a2                	ld	ra,40(sp)
    8000239c:	7402                	ld	s0,32(sp)
    8000239e:	64e2                	ld	s1,24(sp)
    800023a0:	6942                	ld	s2,16(sp)
    800023a2:	69a2                	ld	s3,8(sp)
    800023a4:	6145                	addi	sp,sp,48
    800023a6:	8082                	ret
    virtio_disk_rw(b, 0);
    800023a8:	4581                	li	a1,0
    800023aa:	8526                	mv	a0,s1
    800023ac:	00003097          	auipc	ra,0x3
    800023b0:	26c080e7          	jalr	620(ra) # 80005618 <virtio_disk_rw>
    b->valid = 1;
    800023b4:	4785                	li	a5,1
    800023b6:	c09c                	sw	a5,0(s1)
  return b;
    800023b8:	b7c5                	j	80002398 <bread+0xd0>

00000000800023ba <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800023ba:	1101                	addi	sp,sp,-32
    800023bc:	ec06                	sd	ra,24(sp)
    800023be:	e822                	sd	s0,16(sp)
    800023c0:	e426                	sd	s1,8(sp)
    800023c2:	1000                	addi	s0,sp,32
    800023c4:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800023c6:	0541                	addi	a0,a0,16
    800023c8:	00001097          	auipc	ra,0x1
    800023cc:	5e6080e7          	jalr	1510(ra) # 800039ae <holdingsleep>
    800023d0:	cd01                	beqz	a0,800023e8 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800023d2:	4585                	li	a1,1
    800023d4:	8526                	mv	a0,s1
    800023d6:	00003097          	auipc	ra,0x3
    800023da:	242080e7          	jalr	578(ra) # 80005618 <virtio_disk_rw>
}
    800023de:	60e2                	ld	ra,24(sp)
    800023e0:	6442                	ld	s0,16(sp)
    800023e2:	64a2                	ld	s1,8(sp)
    800023e4:	6105                	addi	sp,sp,32
    800023e6:	8082                	ret
    panic("bwrite");
    800023e8:	00006517          	auipc	a0,0x6
    800023ec:	0c850513          	addi	a0,a0,200 # 800084b0 <syscalls+0xe0>
    800023f0:	00004097          	auipc	ra,0x4
    800023f4:	a92080e7          	jalr	-1390(ra) # 80005e82 <panic>

00000000800023f8 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800023f8:	1101                	addi	sp,sp,-32
    800023fa:	ec06                	sd	ra,24(sp)
    800023fc:	e822                	sd	s0,16(sp)
    800023fe:	e426                	sd	s1,8(sp)
    80002400:	e04a                	sd	s2,0(sp)
    80002402:	1000                	addi	s0,sp,32
    80002404:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002406:	01050913          	addi	s2,a0,16
    8000240a:	854a                	mv	a0,s2
    8000240c:	00001097          	auipc	ra,0x1
    80002410:	5a2080e7          	jalr	1442(ra) # 800039ae <holdingsleep>
    80002414:	c92d                	beqz	a0,80002486 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80002416:	854a                	mv	a0,s2
    80002418:	00001097          	auipc	ra,0x1
    8000241c:	552080e7          	jalr	1362(ra) # 8000396a <releasesleep>

  acquire(&bcache.lock);
    80002420:	00007517          	auipc	a0,0x7
    80002424:	74850513          	addi	a0,a0,1864 # 80009b68 <bcache>
    80002428:	00004097          	auipc	ra,0x4
    8000242c:	fa4080e7          	jalr	-92(ra) # 800063cc <acquire>
  b->refcnt--;
    80002430:	40bc                	lw	a5,64(s1)
    80002432:	37fd                	addiw	a5,a5,-1
    80002434:	0007871b          	sext.w	a4,a5
    80002438:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    8000243a:	eb05                	bnez	a4,8000246a <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000243c:	68bc                	ld	a5,80(s1)
    8000243e:	64b8                	ld	a4,72(s1)
    80002440:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80002442:	64bc                	ld	a5,72(s1)
    80002444:	68b8                	ld	a4,80(s1)
    80002446:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002448:	0000f797          	auipc	a5,0xf
    8000244c:	72078793          	addi	a5,a5,1824 # 80011b68 <bcache+0x8000>
    80002450:	2b87b703          	ld	a4,696(a5)
    80002454:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002456:	00010717          	auipc	a4,0x10
    8000245a:	97a70713          	addi	a4,a4,-1670 # 80011dd0 <bcache+0x8268>
    8000245e:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002460:	2b87b703          	ld	a4,696(a5)
    80002464:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002466:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    8000246a:	00007517          	auipc	a0,0x7
    8000246e:	6fe50513          	addi	a0,a0,1790 # 80009b68 <bcache>
    80002472:	00004097          	auipc	ra,0x4
    80002476:	00e080e7          	jalr	14(ra) # 80006480 <release>
}
    8000247a:	60e2                	ld	ra,24(sp)
    8000247c:	6442                	ld	s0,16(sp)
    8000247e:	64a2                	ld	s1,8(sp)
    80002480:	6902                	ld	s2,0(sp)
    80002482:	6105                	addi	sp,sp,32
    80002484:	8082                	ret
    panic("brelse");
    80002486:	00006517          	auipc	a0,0x6
    8000248a:	03250513          	addi	a0,a0,50 # 800084b8 <syscalls+0xe8>
    8000248e:	00004097          	auipc	ra,0x4
    80002492:	9f4080e7          	jalr	-1548(ra) # 80005e82 <panic>

0000000080002496 <bpin>:

void
bpin(struct buf *b) {
    80002496:	1101                	addi	sp,sp,-32
    80002498:	ec06                	sd	ra,24(sp)
    8000249a:	e822                	sd	s0,16(sp)
    8000249c:	e426                	sd	s1,8(sp)
    8000249e:	1000                	addi	s0,sp,32
    800024a0:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800024a2:	00007517          	auipc	a0,0x7
    800024a6:	6c650513          	addi	a0,a0,1734 # 80009b68 <bcache>
    800024aa:	00004097          	auipc	ra,0x4
    800024ae:	f22080e7          	jalr	-222(ra) # 800063cc <acquire>
  b->refcnt++;
    800024b2:	40bc                	lw	a5,64(s1)
    800024b4:	2785                	addiw	a5,a5,1
    800024b6:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800024b8:	00007517          	auipc	a0,0x7
    800024bc:	6b050513          	addi	a0,a0,1712 # 80009b68 <bcache>
    800024c0:	00004097          	auipc	ra,0x4
    800024c4:	fc0080e7          	jalr	-64(ra) # 80006480 <release>
}
    800024c8:	60e2                	ld	ra,24(sp)
    800024ca:	6442                	ld	s0,16(sp)
    800024cc:	64a2                	ld	s1,8(sp)
    800024ce:	6105                	addi	sp,sp,32
    800024d0:	8082                	ret

00000000800024d2 <bunpin>:

void
bunpin(struct buf *b) {
    800024d2:	1101                	addi	sp,sp,-32
    800024d4:	ec06                	sd	ra,24(sp)
    800024d6:	e822                	sd	s0,16(sp)
    800024d8:	e426                	sd	s1,8(sp)
    800024da:	1000                	addi	s0,sp,32
    800024dc:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800024de:	00007517          	auipc	a0,0x7
    800024e2:	68a50513          	addi	a0,a0,1674 # 80009b68 <bcache>
    800024e6:	00004097          	auipc	ra,0x4
    800024ea:	ee6080e7          	jalr	-282(ra) # 800063cc <acquire>
  b->refcnt--;
    800024ee:	40bc                	lw	a5,64(s1)
    800024f0:	37fd                	addiw	a5,a5,-1
    800024f2:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800024f4:	00007517          	auipc	a0,0x7
    800024f8:	67450513          	addi	a0,a0,1652 # 80009b68 <bcache>
    800024fc:	00004097          	auipc	ra,0x4
    80002500:	f84080e7          	jalr	-124(ra) # 80006480 <release>
}
    80002504:	60e2                	ld	ra,24(sp)
    80002506:	6442                	ld	s0,16(sp)
    80002508:	64a2                	ld	s1,8(sp)
    8000250a:	6105                	addi	sp,sp,32
    8000250c:	8082                	ret

000000008000250e <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    8000250e:	1101                	addi	sp,sp,-32
    80002510:	ec06                	sd	ra,24(sp)
    80002512:	e822                	sd	s0,16(sp)
    80002514:	e426                	sd	s1,8(sp)
    80002516:	e04a                	sd	s2,0(sp)
    80002518:	1000                	addi	s0,sp,32
    8000251a:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    8000251c:	00d5d59b          	srliw	a1,a1,0xd
    80002520:	00010797          	auipc	a5,0x10
    80002524:	d247a783          	lw	a5,-732(a5) # 80012244 <sb+0x1c>
    80002528:	9dbd                	addw	a1,a1,a5
    8000252a:	00000097          	auipc	ra,0x0
    8000252e:	d9e080e7          	jalr	-610(ra) # 800022c8 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002532:	0074f713          	andi	a4,s1,7
    80002536:	4785                	li	a5,1
    80002538:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    8000253c:	14ce                	slli	s1,s1,0x33
    8000253e:	90d9                	srli	s1,s1,0x36
    80002540:	00950733          	add	a4,a0,s1
    80002544:	05874703          	lbu	a4,88(a4)
    80002548:	00e7f6b3          	and	a3,a5,a4
    8000254c:	c69d                	beqz	a3,8000257a <bfree+0x6c>
    8000254e:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002550:	94aa                	add	s1,s1,a0
    80002552:	fff7c793          	not	a5,a5
    80002556:	8ff9                	and	a5,a5,a4
    80002558:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    8000255c:	00001097          	auipc	ra,0x1
    80002560:	298080e7          	jalr	664(ra) # 800037f4 <log_write>
  brelse(bp);
    80002564:	854a                	mv	a0,s2
    80002566:	00000097          	auipc	ra,0x0
    8000256a:	e92080e7          	jalr	-366(ra) # 800023f8 <brelse>
}
    8000256e:	60e2                	ld	ra,24(sp)
    80002570:	6442                	ld	s0,16(sp)
    80002572:	64a2                	ld	s1,8(sp)
    80002574:	6902                	ld	s2,0(sp)
    80002576:	6105                	addi	sp,sp,32
    80002578:	8082                	ret
    panic("freeing free block");
    8000257a:	00006517          	auipc	a0,0x6
    8000257e:	f4650513          	addi	a0,a0,-186 # 800084c0 <syscalls+0xf0>
    80002582:	00004097          	auipc	ra,0x4
    80002586:	900080e7          	jalr	-1792(ra) # 80005e82 <panic>

000000008000258a <balloc>:
{
    8000258a:	711d                	addi	sp,sp,-96
    8000258c:	ec86                	sd	ra,88(sp)
    8000258e:	e8a2                	sd	s0,80(sp)
    80002590:	e4a6                	sd	s1,72(sp)
    80002592:	e0ca                	sd	s2,64(sp)
    80002594:	fc4e                	sd	s3,56(sp)
    80002596:	f852                	sd	s4,48(sp)
    80002598:	f456                	sd	s5,40(sp)
    8000259a:	f05a                	sd	s6,32(sp)
    8000259c:	ec5e                	sd	s7,24(sp)
    8000259e:	e862                	sd	s8,16(sp)
    800025a0:	e466                	sd	s9,8(sp)
    800025a2:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    800025a4:	00010797          	auipc	a5,0x10
    800025a8:	c887a783          	lw	a5,-888(a5) # 8001222c <sb+0x4>
    800025ac:	10078163          	beqz	a5,800026ae <balloc+0x124>
    800025b0:	8baa                	mv	s7,a0
    800025b2:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    800025b4:	00010b17          	auipc	s6,0x10
    800025b8:	c74b0b13          	addi	s6,s6,-908 # 80012228 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800025bc:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    800025be:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800025c0:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    800025c2:	6c89                	lui	s9,0x2
    800025c4:	a061                	j	8000264c <balloc+0xc2>
        bp->data[bi/8] |= m;  // Mark block in use.
    800025c6:	974a                	add	a4,a4,s2
    800025c8:	8fd5                	or	a5,a5,a3
    800025ca:	04f70c23          	sb	a5,88(a4)
        log_write(bp);
    800025ce:	854a                	mv	a0,s2
    800025d0:	00001097          	auipc	ra,0x1
    800025d4:	224080e7          	jalr	548(ra) # 800037f4 <log_write>
        brelse(bp);
    800025d8:	854a                	mv	a0,s2
    800025da:	00000097          	auipc	ra,0x0
    800025de:	e1e080e7          	jalr	-482(ra) # 800023f8 <brelse>
  bp = bread(dev, bno);
    800025e2:	85a6                	mv	a1,s1
    800025e4:	855e                	mv	a0,s7
    800025e6:	00000097          	auipc	ra,0x0
    800025ea:	ce2080e7          	jalr	-798(ra) # 800022c8 <bread>
    800025ee:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800025f0:	40000613          	li	a2,1024
    800025f4:	4581                	li	a1,0
    800025f6:	05850513          	addi	a0,a0,88
    800025fa:	ffffe097          	auipc	ra,0xffffe
    800025fe:	b7e080e7          	jalr	-1154(ra) # 80000178 <memset>
  log_write(bp);
    80002602:	854a                	mv	a0,s2
    80002604:	00001097          	auipc	ra,0x1
    80002608:	1f0080e7          	jalr	496(ra) # 800037f4 <log_write>
  brelse(bp);
    8000260c:	854a                	mv	a0,s2
    8000260e:	00000097          	auipc	ra,0x0
    80002612:	dea080e7          	jalr	-534(ra) # 800023f8 <brelse>
}
    80002616:	8526                	mv	a0,s1
    80002618:	60e6                	ld	ra,88(sp)
    8000261a:	6446                	ld	s0,80(sp)
    8000261c:	64a6                	ld	s1,72(sp)
    8000261e:	6906                	ld	s2,64(sp)
    80002620:	79e2                	ld	s3,56(sp)
    80002622:	7a42                	ld	s4,48(sp)
    80002624:	7aa2                	ld	s5,40(sp)
    80002626:	7b02                	ld	s6,32(sp)
    80002628:	6be2                	ld	s7,24(sp)
    8000262a:	6c42                	ld	s8,16(sp)
    8000262c:	6ca2                	ld	s9,8(sp)
    8000262e:	6125                	addi	sp,sp,96
    80002630:	8082                	ret
    brelse(bp);
    80002632:	854a                	mv	a0,s2
    80002634:	00000097          	auipc	ra,0x0
    80002638:	dc4080e7          	jalr	-572(ra) # 800023f8 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000263c:	015c87bb          	addw	a5,s9,s5
    80002640:	00078a9b          	sext.w	s5,a5
    80002644:	004b2703          	lw	a4,4(s6)
    80002648:	06eaf363          	bgeu	s5,a4,800026ae <balloc+0x124>
    bp = bread(dev, BBLOCK(b, sb));
    8000264c:	41fad79b          	sraiw	a5,s5,0x1f
    80002650:	0137d79b          	srliw	a5,a5,0x13
    80002654:	015787bb          	addw	a5,a5,s5
    80002658:	40d7d79b          	sraiw	a5,a5,0xd
    8000265c:	01cb2583          	lw	a1,28(s6)
    80002660:	9dbd                	addw	a1,a1,a5
    80002662:	855e                	mv	a0,s7
    80002664:	00000097          	auipc	ra,0x0
    80002668:	c64080e7          	jalr	-924(ra) # 800022c8 <bread>
    8000266c:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000266e:	004b2503          	lw	a0,4(s6)
    80002672:	000a849b          	sext.w	s1,s5
    80002676:	8662                	mv	a2,s8
    80002678:	faa4fde3          	bgeu	s1,a0,80002632 <balloc+0xa8>
      m = 1 << (bi % 8);
    8000267c:	41f6579b          	sraiw	a5,a2,0x1f
    80002680:	01d7d69b          	srliw	a3,a5,0x1d
    80002684:	00c6873b          	addw	a4,a3,a2
    80002688:	00777793          	andi	a5,a4,7
    8000268c:	9f95                	subw	a5,a5,a3
    8000268e:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002692:	4037571b          	sraiw	a4,a4,0x3
    80002696:	00e906b3          	add	a3,s2,a4
    8000269a:	0586c683          	lbu	a3,88(a3)
    8000269e:	00d7f5b3          	and	a1,a5,a3
    800026a2:	d195                	beqz	a1,800025c6 <balloc+0x3c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800026a4:	2605                	addiw	a2,a2,1
    800026a6:	2485                	addiw	s1,s1,1
    800026a8:	fd4618e3          	bne	a2,s4,80002678 <balloc+0xee>
    800026ac:	b759                	j	80002632 <balloc+0xa8>
  printf("balloc: out of blocks\n");
    800026ae:	00006517          	auipc	a0,0x6
    800026b2:	e2a50513          	addi	a0,a0,-470 # 800084d8 <syscalls+0x108>
    800026b6:	00004097          	auipc	ra,0x4
    800026ba:	816080e7          	jalr	-2026(ra) # 80005ecc <printf>
  return 0;
    800026be:	4481                	li	s1,0
    800026c0:	bf99                	j	80002616 <balloc+0x8c>

00000000800026c2 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn) //xiugai
{
    800026c2:	7139                	addi	sp,sp,-64
    800026c4:	fc06                	sd	ra,56(sp)
    800026c6:	f822                	sd	s0,48(sp)
    800026c8:	f426                	sd	s1,40(sp)
    800026ca:	f04a                	sd	s2,32(sp)
    800026cc:	ec4e                	sd	s3,24(sp)
    800026ce:	e852                	sd	s4,16(sp)
    800026d0:	e456                	sd	s5,8(sp)
    800026d2:	0080                	addi	s0,sp,64
    800026d4:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800026d6:	47a9                	li	a5,10
    800026d8:	04b7e163          	bltu	a5,a1,8000271a <bmap+0x58>
    if((addr = ip->addrs[bn]) == 0){
    800026dc:	02059493          	slli	s1,a1,0x20
    800026e0:	9081                	srli	s1,s1,0x20
    800026e2:	048a                	slli	s1,s1,0x2
    800026e4:	94aa                	add	s1,s1,a0
    800026e6:	0504a903          	lw	s2,80(s1)
    800026ea:	00090c63          	beqz	s2,80002702 <bmap+0x40>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
    800026ee:	854a                	mv	a0,s2
    800026f0:	70e2                	ld	ra,56(sp)
    800026f2:	7442                	ld	s0,48(sp)
    800026f4:	74a2                	ld	s1,40(sp)
    800026f6:	7902                	ld	s2,32(sp)
    800026f8:	69e2                	ld	s3,24(sp)
    800026fa:	6a42                	ld	s4,16(sp)
    800026fc:	6aa2                	ld	s5,8(sp)
    800026fe:	6121                	addi	sp,sp,64
    80002700:	8082                	ret
      addr = balloc(ip->dev);
    80002702:	4108                	lw	a0,0(a0)
    80002704:	00000097          	auipc	ra,0x0
    80002708:	e86080e7          	jalr	-378(ra) # 8000258a <balloc>
    8000270c:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80002710:	fc090fe3          	beqz	s2,800026ee <bmap+0x2c>
      ip->addrs[bn] = addr;
    80002714:	0524a823          	sw	s2,80(s1)
    80002718:	bfd9                	j	800026ee <bmap+0x2c>
  bn -= NDIRECT;
    8000271a:	ff55849b          	addiw	s1,a1,-11
    8000271e:	0004871b          	sext.w	a4,s1
  if(bn < NINDIRECT){
    80002722:	0ff00793          	li	a5,255
    80002726:	06e7eb63          	bltu	a5,a4,8000279c <bmap+0xda>
    if((addr = ip->addrs[NDIRECT]) == 0){
    8000272a:	07c52903          	lw	s2,124(a0)
    8000272e:	00091d63          	bnez	s2,80002748 <bmap+0x86>
      addr = balloc(ip->dev);
    80002732:	4108                	lw	a0,0(a0)
    80002734:	00000097          	auipc	ra,0x0
    80002738:	e56080e7          	jalr	-426(ra) # 8000258a <balloc>
    8000273c:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80002740:	fa0907e3          	beqz	s2,800026ee <bmap+0x2c>
      ip->addrs[NDIRECT] = addr;
    80002744:	0729ae23          	sw	s2,124(s3)
    bp = bread(ip->dev, addr);
    80002748:	85ca                	mv	a1,s2
    8000274a:	0009a503          	lw	a0,0(s3)
    8000274e:	00000097          	auipc	ra,0x0
    80002752:	b7a080e7          	jalr	-1158(ra) # 800022c8 <bread>
    80002756:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002758:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    8000275c:	1482                	slli	s1,s1,0x20
    8000275e:	9081                	srli	s1,s1,0x20
    80002760:	048a                	slli	s1,s1,0x2
    80002762:	94be                	add	s1,s1,a5
    80002764:	0004a903          	lw	s2,0(s1)
    80002768:	00090863          	beqz	s2,80002778 <bmap+0xb6>
    brelse(bp);
    8000276c:	8552                	mv	a0,s4
    8000276e:	00000097          	auipc	ra,0x0
    80002772:	c8a080e7          	jalr	-886(ra) # 800023f8 <brelse>
    return addr;
    80002776:	bfa5                	j	800026ee <bmap+0x2c>
      addr = balloc(ip->dev);
    80002778:	0009a503          	lw	a0,0(s3)
    8000277c:	00000097          	auipc	ra,0x0
    80002780:	e0e080e7          	jalr	-498(ra) # 8000258a <balloc>
    80002784:	0005091b          	sext.w	s2,a0
      if(addr){
    80002788:	fe0902e3          	beqz	s2,8000276c <bmap+0xaa>
        a[bn] = addr;
    8000278c:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    80002790:	8552                	mv	a0,s4
    80002792:	00001097          	auipc	ra,0x1
    80002796:	062080e7          	jalr	98(ra) # 800037f4 <log_write>
    8000279a:	bfc9                	j	8000276c <bmap+0xaa>
   bn -= NINDIRECT;
    8000279c:	ef55849b          	addiw	s1,a1,-267
    800027a0:	0004871b          	sext.w	a4,s1
  if(bn < NINDIRECT * NINDIRECT) { 
    800027a4:	67c1                	lui	a5,0x10
    800027a6:	0cf77263          	bgeu	a4,a5,8000286a <bmap+0x1a8>
    if((addr = ip->addrs[NDIRECT+1]) == 0)//fenpei diyiceng dakuai
    800027aa:	08052583          	lw	a1,128(a0)
    800027ae:	c1a5                	beqz	a1,8000280e <bmap+0x14c>
    bp = bread(ip->dev, addr);
    800027b0:	0009a503          	lw	a0,0(s3)
    800027b4:	00000097          	auipc	ra,0x0
    800027b8:	b14080e7          	jalr	-1260(ra) # 800022c8 <bread>
    800027bc:	892a                	mv	s2,a0
    a = (uint*)bp->data;
    800027be:	05850a93          	addi	s5,a0,88
    if((addr = a[bn/NINDIRECT]) == 0){
    800027c2:	0084d79b          	srliw	a5,s1,0x8
    800027c6:	078a                	slli	a5,a5,0x2
    800027c8:	9abe                	add	s5,s5,a5
    800027ca:	000aaa03          	lw	s4,0(s5)
    800027ce:	040a0a63          	beqz	s4,80002822 <bmap+0x160>
    brelse(bp);
    800027d2:	854a                	mv	a0,s2
    800027d4:	00000097          	auipc	ra,0x0
    800027d8:	c24080e7          	jalr	-988(ra) # 800023f8 <brelse>
    bp = bread(ip->dev, addr);
    800027dc:	85d2                	mv	a1,s4
    800027de:	0009a503          	lw	a0,0(s3)
    800027e2:	00000097          	auipc	ra,0x0
    800027e6:	ae6080e7          	jalr	-1306(ra) # 800022c8 <bread>
    800027ea:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    800027ec:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    800027f0:	0ff4f593          	andi	a1,s1,255
    800027f4:	058a                	slli	a1,a1,0x2
    800027f6:	00b784b3          	add	s1,a5,a1
    800027fa:	0004a903          	lw	s2,0(s1)
    800027fe:	04090463          	beqz	s2,80002846 <bmap+0x184>
    brelse(bp);
    80002802:	8552                	mv	a0,s4
    80002804:	00000097          	auipc	ra,0x0
    80002808:	bf4080e7          	jalr	-1036(ra) # 800023f8 <brelse>
    return addr;
    8000280c:	b5cd                	j	800026ee <bmap+0x2c>
      ip->addrs[NDIRECT+1] = addr = balloc(ip->dev);
    8000280e:	4108                	lw	a0,0(a0)
    80002810:	00000097          	auipc	ra,0x0
    80002814:	d7a080e7          	jalr	-646(ra) # 8000258a <balloc>
    80002818:	0005059b          	sext.w	a1,a0
    8000281c:	08b9a023          	sw	a1,128(s3)
    80002820:	bf41                	j	800027b0 <bmap+0xee>
      addr = balloc(ip->dev);
    80002822:	0009a503          	lw	a0,0(s3)
    80002826:	00000097          	auipc	ra,0x0
    8000282a:	d64080e7          	jalr	-668(ra) # 8000258a <balloc>
    8000282e:	00050a1b          	sext.w	s4,a0
      if(addr){
    80002832:	fa0a00e3          	beqz	s4,800027d2 <bmap+0x110>
        a[bn/NINDIRECT] = addr;
    80002836:	014aa023          	sw	s4,0(s5)
        log_write(bp);
    8000283a:	854a                	mv	a0,s2
    8000283c:	00001097          	auipc	ra,0x1
    80002840:	fb8080e7          	jalr	-72(ra) # 800037f4 <log_write>
    80002844:	b779                	j	800027d2 <bmap+0x110>
      addr = balloc(ip->dev);
    80002846:	0009a503          	lw	a0,0(s3)
    8000284a:	00000097          	auipc	ra,0x0
    8000284e:	d40080e7          	jalr	-704(ra) # 8000258a <balloc>
    80002852:	0005091b          	sext.w	s2,a0
      if(addr){
    80002856:	fa0906e3          	beqz	s2,80002802 <bmap+0x140>
        a[bn] = addr;
    8000285a:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    8000285e:	8552                	mv	a0,s4
    80002860:	00001097          	auipc	ra,0x1
    80002864:	f94080e7          	jalr	-108(ra) # 800037f4 <log_write>
    80002868:	bf69                	j	80002802 <bmap+0x140>
  panic("bmap: out of range");
    8000286a:	00006517          	auipc	a0,0x6
    8000286e:	c8650513          	addi	a0,a0,-890 # 800084f0 <syscalls+0x120>
    80002872:	00003097          	auipc	ra,0x3
    80002876:	610080e7          	jalr	1552(ra) # 80005e82 <panic>

000000008000287a <iget>:
{
    8000287a:	7179                	addi	sp,sp,-48
    8000287c:	f406                	sd	ra,40(sp)
    8000287e:	f022                	sd	s0,32(sp)
    80002880:	ec26                	sd	s1,24(sp)
    80002882:	e84a                	sd	s2,16(sp)
    80002884:	e44e                	sd	s3,8(sp)
    80002886:	e052                	sd	s4,0(sp)
    80002888:	1800                	addi	s0,sp,48
    8000288a:	89aa                	mv	s3,a0
    8000288c:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    8000288e:	00010517          	auipc	a0,0x10
    80002892:	9ba50513          	addi	a0,a0,-1606 # 80012248 <itable>
    80002896:	00004097          	auipc	ra,0x4
    8000289a:	b36080e7          	jalr	-1226(ra) # 800063cc <acquire>
  empty = 0;
    8000289e:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800028a0:	00010497          	auipc	s1,0x10
    800028a4:	9c048493          	addi	s1,s1,-1600 # 80012260 <itable+0x18>
    800028a8:	00011697          	auipc	a3,0x11
    800028ac:	44868693          	addi	a3,a3,1096 # 80013cf0 <log>
    800028b0:	a039                	j	800028be <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800028b2:	02090b63          	beqz	s2,800028e8 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800028b6:	08848493          	addi	s1,s1,136
    800028ba:	02d48a63          	beq	s1,a3,800028ee <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800028be:	449c                	lw	a5,8(s1)
    800028c0:	fef059e3          	blez	a5,800028b2 <iget+0x38>
    800028c4:	4098                	lw	a4,0(s1)
    800028c6:	ff3716e3          	bne	a4,s3,800028b2 <iget+0x38>
    800028ca:	40d8                	lw	a4,4(s1)
    800028cc:	ff4713e3          	bne	a4,s4,800028b2 <iget+0x38>
      ip->ref++;
    800028d0:	2785                	addiw	a5,a5,1
    800028d2:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800028d4:	00010517          	auipc	a0,0x10
    800028d8:	97450513          	addi	a0,a0,-1676 # 80012248 <itable>
    800028dc:	00004097          	auipc	ra,0x4
    800028e0:	ba4080e7          	jalr	-1116(ra) # 80006480 <release>
      return ip;
    800028e4:	8926                	mv	s2,s1
    800028e6:	a03d                	j	80002914 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800028e8:	f7f9                	bnez	a5,800028b6 <iget+0x3c>
    800028ea:	8926                	mv	s2,s1
    800028ec:	b7e9                	j	800028b6 <iget+0x3c>
  if(empty == 0)
    800028ee:	02090c63          	beqz	s2,80002926 <iget+0xac>
  ip->dev = dev;
    800028f2:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800028f6:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800028fa:	4785                	li	a5,1
    800028fc:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002900:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002904:	00010517          	auipc	a0,0x10
    80002908:	94450513          	addi	a0,a0,-1724 # 80012248 <itable>
    8000290c:	00004097          	auipc	ra,0x4
    80002910:	b74080e7          	jalr	-1164(ra) # 80006480 <release>
}
    80002914:	854a                	mv	a0,s2
    80002916:	70a2                	ld	ra,40(sp)
    80002918:	7402                	ld	s0,32(sp)
    8000291a:	64e2                	ld	s1,24(sp)
    8000291c:	6942                	ld	s2,16(sp)
    8000291e:	69a2                	ld	s3,8(sp)
    80002920:	6a02                	ld	s4,0(sp)
    80002922:	6145                	addi	sp,sp,48
    80002924:	8082                	ret
    panic("iget: no inodes");
    80002926:	00006517          	auipc	a0,0x6
    8000292a:	be250513          	addi	a0,a0,-1054 # 80008508 <syscalls+0x138>
    8000292e:	00003097          	auipc	ra,0x3
    80002932:	554080e7          	jalr	1364(ra) # 80005e82 <panic>

0000000080002936 <fsinit>:
fsinit(int dev) {
    80002936:	7179                	addi	sp,sp,-48
    80002938:	f406                	sd	ra,40(sp)
    8000293a:	f022                	sd	s0,32(sp)
    8000293c:	ec26                	sd	s1,24(sp)
    8000293e:	e84a                	sd	s2,16(sp)
    80002940:	e44e                	sd	s3,8(sp)
    80002942:	1800                	addi	s0,sp,48
    80002944:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002946:	4585                	li	a1,1
    80002948:	00000097          	auipc	ra,0x0
    8000294c:	980080e7          	jalr	-1664(ra) # 800022c8 <bread>
    80002950:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002952:	00010997          	auipc	s3,0x10
    80002956:	8d698993          	addi	s3,s3,-1834 # 80012228 <sb>
    8000295a:	02000613          	li	a2,32
    8000295e:	05850593          	addi	a1,a0,88
    80002962:	854e                	mv	a0,s3
    80002964:	ffffe097          	auipc	ra,0xffffe
    80002968:	874080e7          	jalr	-1932(ra) # 800001d8 <memmove>
  brelse(bp);
    8000296c:	8526                	mv	a0,s1
    8000296e:	00000097          	auipc	ra,0x0
    80002972:	a8a080e7          	jalr	-1398(ra) # 800023f8 <brelse>
  if(sb.magic != FSMAGIC)
    80002976:	0009a703          	lw	a4,0(s3)
    8000297a:	102037b7          	lui	a5,0x10203
    8000297e:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002982:	02f71263          	bne	a4,a5,800029a6 <fsinit+0x70>
  initlog(dev, &sb);
    80002986:	00010597          	auipc	a1,0x10
    8000298a:	8a258593          	addi	a1,a1,-1886 # 80012228 <sb>
    8000298e:	854a                	mv	a0,s2
    80002990:	00001097          	auipc	ra,0x1
    80002994:	be8080e7          	jalr	-1048(ra) # 80003578 <initlog>
}
    80002998:	70a2                	ld	ra,40(sp)
    8000299a:	7402                	ld	s0,32(sp)
    8000299c:	64e2                	ld	s1,24(sp)
    8000299e:	6942                	ld	s2,16(sp)
    800029a0:	69a2                	ld	s3,8(sp)
    800029a2:	6145                	addi	sp,sp,48
    800029a4:	8082                	ret
    panic("invalid file system");
    800029a6:	00006517          	auipc	a0,0x6
    800029aa:	b7250513          	addi	a0,a0,-1166 # 80008518 <syscalls+0x148>
    800029ae:	00003097          	auipc	ra,0x3
    800029b2:	4d4080e7          	jalr	1236(ra) # 80005e82 <panic>

00000000800029b6 <iinit>:
{
    800029b6:	7179                	addi	sp,sp,-48
    800029b8:	f406                	sd	ra,40(sp)
    800029ba:	f022                	sd	s0,32(sp)
    800029bc:	ec26                	sd	s1,24(sp)
    800029be:	e84a                	sd	s2,16(sp)
    800029c0:	e44e                	sd	s3,8(sp)
    800029c2:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    800029c4:	00006597          	auipc	a1,0x6
    800029c8:	b6c58593          	addi	a1,a1,-1172 # 80008530 <syscalls+0x160>
    800029cc:	00010517          	auipc	a0,0x10
    800029d0:	87c50513          	addi	a0,a0,-1924 # 80012248 <itable>
    800029d4:	00004097          	auipc	ra,0x4
    800029d8:	968080e7          	jalr	-1688(ra) # 8000633c <initlock>
  for(i = 0; i < NINODE; i++) {
    800029dc:	00010497          	auipc	s1,0x10
    800029e0:	89448493          	addi	s1,s1,-1900 # 80012270 <itable+0x28>
    800029e4:	00011997          	auipc	s3,0x11
    800029e8:	31c98993          	addi	s3,s3,796 # 80013d00 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    800029ec:	00006917          	auipc	s2,0x6
    800029f0:	b4c90913          	addi	s2,s2,-1204 # 80008538 <syscalls+0x168>
    800029f4:	85ca                	mv	a1,s2
    800029f6:	8526                	mv	a0,s1
    800029f8:	00001097          	auipc	ra,0x1
    800029fc:	ee2080e7          	jalr	-286(ra) # 800038da <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002a00:	08848493          	addi	s1,s1,136
    80002a04:	ff3498e3          	bne	s1,s3,800029f4 <iinit+0x3e>
}
    80002a08:	70a2                	ld	ra,40(sp)
    80002a0a:	7402                	ld	s0,32(sp)
    80002a0c:	64e2                	ld	s1,24(sp)
    80002a0e:	6942                	ld	s2,16(sp)
    80002a10:	69a2                	ld	s3,8(sp)
    80002a12:	6145                	addi	sp,sp,48
    80002a14:	8082                	ret

0000000080002a16 <ialloc>:
{
    80002a16:	715d                	addi	sp,sp,-80
    80002a18:	e486                	sd	ra,72(sp)
    80002a1a:	e0a2                	sd	s0,64(sp)
    80002a1c:	fc26                	sd	s1,56(sp)
    80002a1e:	f84a                	sd	s2,48(sp)
    80002a20:	f44e                	sd	s3,40(sp)
    80002a22:	f052                	sd	s4,32(sp)
    80002a24:	ec56                	sd	s5,24(sp)
    80002a26:	e85a                	sd	s6,16(sp)
    80002a28:	e45e                	sd	s7,8(sp)
    80002a2a:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80002a2c:	00010717          	auipc	a4,0x10
    80002a30:	80872703          	lw	a4,-2040(a4) # 80012234 <sb+0xc>
    80002a34:	4785                	li	a5,1
    80002a36:	04e7fa63          	bgeu	a5,a4,80002a8a <ialloc+0x74>
    80002a3a:	8aaa                	mv	s5,a0
    80002a3c:	8bae                	mv	s7,a1
    80002a3e:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002a40:	0000fa17          	auipc	s4,0xf
    80002a44:	7e8a0a13          	addi	s4,s4,2024 # 80012228 <sb>
    80002a48:	00048b1b          	sext.w	s6,s1
    80002a4c:	0044d593          	srli	a1,s1,0x4
    80002a50:	018a2783          	lw	a5,24(s4)
    80002a54:	9dbd                	addw	a1,a1,a5
    80002a56:	8556                	mv	a0,s5
    80002a58:	00000097          	auipc	ra,0x0
    80002a5c:	870080e7          	jalr	-1936(ra) # 800022c8 <bread>
    80002a60:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002a62:	05850993          	addi	s3,a0,88
    80002a66:	00f4f793          	andi	a5,s1,15
    80002a6a:	079a                	slli	a5,a5,0x6
    80002a6c:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002a6e:	00099783          	lh	a5,0(s3)
    80002a72:	c3a1                	beqz	a5,80002ab2 <ialloc+0x9c>
    brelse(bp);
    80002a74:	00000097          	auipc	ra,0x0
    80002a78:	984080e7          	jalr	-1660(ra) # 800023f8 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002a7c:	0485                	addi	s1,s1,1
    80002a7e:	00ca2703          	lw	a4,12(s4)
    80002a82:	0004879b          	sext.w	a5,s1
    80002a86:	fce7e1e3          	bltu	a5,a4,80002a48 <ialloc+0x32>
  printf("ialloc: no inodes\n");
    80002a8a:	00006517          	auipc	a0,0x6
    80002a8e:	ab650513          	addi	a0,a0,-1354 # 80008540 <syscalls+0x170>
    80002a92:	00003097          	auipc	ra,0x3
    80002a96:	43a080e7          	jalr	1082(ra) # 80005ecc <printf>
  return 0;
    80002a9a:	4501                	li	a0,0
}
    80002a9c:	60a6                	ld	ra,72(sp)
    80002a9e:	6406                	ld	s0,64(sp)
    80002aa0:	74e2                	ld	s1,56(sp)
    80002aa2:	7942                	ld	s2,48(sp)
    80002aa4:	79a2                	ld	s3,40(sp)
    80002aa6:	7a02                	ld	s4,32(sp)
    80002aa8:	6ae2                	ld	s5,24(sp)
    80002aaa:	6b42                	ld	s6,16(sp)
    80002aac:	6ba2                	ld	s7,8(sp)
    80002aae:	6161                	addi	sp,sp,80
    80002ab0:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80002ab2:	04000613          	li	a2,64
    80002ab6:	4581                	li	a1,0
    80002ab8:	854e                	mv	a0,s3
    80002aba:	ffffd097          	auipc	ra,0xffffd
    80002abe:	6be080e7          	jalr	1726(ra) # 80000178 <memset>
      dip->type = type;
    80002ac2:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002ac6:	854a                	mv	a0,s2
    80002ac8:	00001097          	auipc	ra,0x1
    80002acc:	d2c080e7          	jalr	-724(ra) # 800037f4 <log_write>
      brelse(bp);
    80002ad0:	854a                	mv	a0,s2
    80002ad2:	00000097          	auipc	ra,0x0
    80002ad6:	926080e7          	jalr	-1754(ra) # 800023f8 <brelse>
      return iget(dev, inum);
    80002ada:	85da                	mv	a1,s6
    80002adc:	8556                	mv	a0,s5
    80002ade:	00000097          	auipc	ra,0x0
    80002ae2:	d9c080e7          	jalr	-612(ra) # 8000287a <iget>
    80002ae6:	bf5d                	j	80002a9c <ialloc+0x86>

0000000080002ae8 <iupdate>:
{
    80002ae8:	1101                	addi	sp,sp,-32
    80002aea:	ec06                	sd	ra,24(sp)
    80002aec:	e822                	sd	s0,16(sp)
    80002aee:	e426                	sd	s1,8(sp)
    80002af0:	e04a                	sd	s2,0(sp)
    80002af2:	1000                	addi	s0,sp,32
    80002af4:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002af6:	415c                	lw	a5,4(a0)
    80002af8:	0047d79b          	srliw	a5,a5,0x4
    80002afc:	0000f597          	auipc	a1,0xf
    80002b00:	7445a583          	lw	a1,1860(a1) # 80012240 <sb+0x18>
    80002b04:	9dbd                	addw	a1,a1,a5
    80002b06:	4108                	lw	a0,0(a0)
    80002b08:	fffff097          	auipc	ra,0xfffff
    80002b0c:	7c0080e7          	jalr	1984(ra) # 800022c8 <bread>
    80002b10:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002b12:	05850793          	addi	a5,a0,88
    80002b16:	40c8                	lw	a0,4(s1)
    80002b18:	893d                	andi	a0,a0,15
    80002b1a:	051a                	slli	a0,a0,0x6
    80002b1c:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    80002b1e:	04449703          	lh	a4,68(s1)
    80002b22:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    80002b26:	04649703          	lh	a4,70(s1)
    80002b2a:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    80002b2e:	04849703          	lh	a4,72(s1)
    80002b32:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    80002b36:	04a49703          	lh	a4,74(s1)
    80002b3a:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    80002b3e:	44f8                	lw	a4,76(s1)
    80002b40:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002b42:	03400613          	li	a2,52
    80002b46:	05048593          	addi	a1,s1,80
    80002b4a:	0531                	addi	a0,a0,12
    80002b4c:	ffffd097          	auipc	ra,0xffffd
    80002b50:	68c080e7          	jalr	1676(ra) # 800001d8 <memmove>
  log_write(bp);
    80002b54:	854a                	mv	a0,s2
    80002b56:	00001097          	auipc	ra,0x1
    80002b5a:	c9e080e7          	jalr	-866(ra) # 800037f4 <log_write>
  brelse(bp);
    80002b5e:	854a                	mv	a0,s2
    80002b60:	00000097          	auipc	ra,0x0
    80002b64:	898080e7          	jalr	-1896(ra) # 800023f8 <brelse>
}
    80002b68:	60e2                	ld	ra,24(sp)
    80002b6a:	6442                	ld	s0,16(sp)
    80002b6c:	64a2                	ld	s1,8(sp)
    80002b6e:	6902                	ld	s2,0(sp)
    80002b70:	6105                	addi	sp,sp,32
    80002b72:	8082                	ret

0000000080002b74 <idup>:
{
    80002b74:	1101                	addi	sp,sp,-32
    80002b76:	ec06                	sd	ra,24(sp)
    80002b78:	e822                	sd	s0,16(sp)
    80002b7a:	e426                	sd	s1,8(sp)
    80002b7c:	1000                	addi	s0,sp,32
    80002b7e:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002b80:	0000f517          	auipc	a0,0xf
    80002b84:	6c850513          	addi	a0,a0,1736 # 80012248 <itable>
    80002b88:	00004097          	auipc	ra,0x4
    80002b8c:	844080e7          	jalr	-1980(ra) # 800063cc <acquire>
  ip->ref++;
    80002b90:	449c                	lw	a5,8(s1)
    80002b92:	2785                	addiw	a5,a5,1
    80002b94:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002b96:	0000f517          	auipc	a0,0xf
    80002b9a:	6b250513          	addi	a0,a0,1714 # 80012248 <itable>
    80002b9e:	00004097          	auipc	ra,0x4
    80002ba2:	8e2080e7          	jalr	-1822(ra) # 80006480 <release>
}
    80002ba6:	8526                	mv	a0,s1
    80002ba8:	60e2                	ld	ra,24(sp)
    80002baa:	6442                	ld	s0,16(sp)
    80002bac:	64a2                	ld	s1,8(sp)
    80002bae:	6105                	addi	sp,sp,32
    80002bb0:	8082                	ret

0000000080002bb2 <ilock>:
{
    80002bb2:	1101                	addi	sp,sp,-32
    80002bb4:	ec06                	sd	ra,24(sp)
    80002bb6:	e822                	sd	s0,16(sp)
    80002bb8:	e426                	sd	s1,8(sp)
    80002bba:	e04a                	sd	s2,0(sp)
    80002bbc:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002bbe:	c115                	beqz	a0,80002be2 <ilock+0x30>
    80002bc0:	84aa                	mv	s1,a0
    80002bc2:	451c                	lw	a5,8(a0)
    80002bc4:	00f05f63          	blez	a5,80002be2 <ilock+0x30>
  acquiresleep(&ip->lock);
    80002bc8:	0541                	addi	a0,a0,16
    80002bca:	00001097          	auipc	ra,0x1
    80002bce:	d4a080e7          	jalr	-694(ra) # 80003914 <acquiresleep>
  if(ip->valid == 0){
    80002bd2:	40bc                	lw	a5,64(s1)
    80002bd4:	cf99                	beqz	a5,80002bf2 <ilock+0x40>
}
    80002bd6:	60e2                	ld	ra,24(sp)
    80002bd8:	6442                	ld	s0,16(sp)
    80002bda:	64a2                	ld	s1,8(sp)
    80002bdc:	6902                	ld	s2,0(sp)
    80002bde:	6105                	addi	sp,sp,32
    80002be0:	8082                	ret
    panic("ilock");
    80002be2:	00006517          	auipc	a0,0x6
    80002be6:	97650513          	addi	a0,a0,-1674 # 80008558 <syscalls+0x188>
    80002bea:	00003097          	auipc	ra,0x3
    80002bee:	298080e7          	jalr	664(ra) # 80005e82 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002bf2:	40dc                	lw	a5,4(s1)
    80002bf4:	0047d79b          	srliw	a5,a5,0x4
    80002bf8:	0000f597          	auipc	a1,0xf
    80002bfc:	6485a583          	lw	a1,1608(a1) # 80012240 <sb+0x18>
    80002c00:	9dbd                	addw	a1,a1,a5
    80002c02:	4088                	lw	a0,0(s1)
    80002c04:	fffff097          	auipc	ra,0xfffff
    80002c08:	6c4080e7          	jalr	1732(ra) # 800022c8 <bread>
    80002c0c:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002c0e:	05850593          	addi	a1,a0,88
    80002c12:	40dc                	lw	a5,4(s1)
    80002c14:	8bbd                	andi	a5,a5,15
    80002c16:	079a                	slli	a5,a5,0x6
    80002c18:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002c1a:	00059783          	lh	a5,0(a1)
    80002c1e:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002c22:	00259783          	lh	a5,2(a1)
    80002c26:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002c2a:	00459783          	lh	a5,4(a1)
    80002c2e:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002c32:	00659783          	lh	a5,6(a1)
    80002c36:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002c3a:	459c                	lw	a5,8(a1)
    80002c3c:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002c3e:	03400613          	li	a2,52
    80002c42:	05b1                	addi	a1,a1,12
    80002c44:	05048513          	addi	a0,s1,80
    80002c48:	ffffd097          	auipc	ra,0xffffd
    80002c4c:	590080e7          	jalr	1424(ra) # 800001d8 <memmove>
    brelse(bp);
    80002c50:	854a                	mv	a0,s2
    80002c52:	fffff097          	auipc	ra,0xfffff
    80002c56:	7a6080e7          	jalr	1958(ra) # 800023f8 <brelse>
    ip->valid = 1;
    80002c5a:	4785                	li	a5,1
    80002c5c:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002c5e:	04449783          	lh	a5,68(s1)
    80002c62:	fbb5                	bnez	a5,80002bd6 <ilock+0x24>
      panic("ilock: no type");
    80002c64:	00006517          	auipc	a0,0x6
    80002c68:	8fc50513          	addi	a0,a0,-1796 # 80008560 <syscalls+0x190>
    80002c6c:	00003097          	auipc	ra,0x3
    80002c70:	216080e7          	jalr	534(ra) # 80005e82 <panic>

0000000080002c74 <iunlock>:
{
    80002c74:	1101                	addi	sp,sp,-32
    80002c76:	ec06                	sd	ra,24(sp)
    80002c78:	e822                	sd	s0,16(sp)
    80002c7a:	e426                	sd	s1,8(sp)
    80002c7c:	e04a                	sd	s2,0(sp)
    80002c7e:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002c80:	c905                	beqz	a0,80002cb0 <iunlock+0x3c>
    80002c82:	84aa                	mv	s1,a0
    80002c84:	01050913          	addi	s2,a0,16
    80002c88:	854a                	mv	a0,s2
    80002c8a:	00001097          	auipc	ra,0x1
    80002c8e:	d24080e7          	jalr	-732(ra) # 800039ae <holdingsleep>
    80002c92:	cd19                	beqz	a0,80002cb0 <iunlock+0x3c>
    80002c94:	449c                	lw	a5,8(s1)
    80002c96:	00f05d63          	blez	a5,80002cb0 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002c9a:	854a                	mv	a0,s2
    80002c9c:	00001097          	auipc	ra,0x1
    80002ca0:	cce080e7          	jalr	-818(ra) # 8000396a <releasesleep>
}
    80002ca4:	60e2                	ld	ra,24(sp)
    80002ca6:	6442                	ld	s0,16(sp)
    80002ca8:	64a2                	ld	s1,8(sp)
    80002caa:	6902                	ld	s2,0(sp)
    80002cac:	6105                	addi	sp,sp,32
    80002cae:	8082                	ret
    panic("iunlock");
    80002cb0:	00006517          	auipc	a0,0x6
    80002cb4:	8c050513          	addi	a0,a0,-1856 # 80008570 <syscalls+0x1a0>
    80002cb8:	00003097          	auipc	ra,0x3
    80002cbc:	1ca080e7          	jalr	458(ra) # 80005e82 <panic>

0000000080002cc0 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002cc0:	715d                	addi	sp,sp,-80
    80002cc2:	e486                	sd	ra,72(sp)
    80002cc4:	e0a2                	sd	s0,64(sp)
    80002cc6:	fc26                	sd	s1,56(sp)
    80002cc8:	f84a                	sd	s2,48(sp)
    80002cca:	f44e                	sd	s3,40(sp)
    80002ccc:	f052                	sd	s4,32(sp)
    80002cce:	ec56                	sd	s5,24(sp)
    80002cd0:	e85a                	sd	s6,16(sp)
    80002cd2:	e45e                	sd	s7,8(sp)
    80002cd4:	e062                	sd	s8,0(sp)
    80002cd6:	0880                	addi	s0,sp,80
    80002cd8:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002cda:	05050493          	addi	s1,a0,80
    80002cde:	07c50913          	addi	s2,a0,124
    80002ce2:	a021                	j	80002cea <itrunc+0x2a>
    80002ce4:	0491                	addi	s1,s1,4
    80002ce6:	01248d63          	beq	s1,s2,80002d00 <itrunc+0x40>
    if(ip->addrs[i]){
    80002cea:	408c                	lw	a1,0(s1)
    80002cec:	dde5                	beqz	a1,80002ce4 <itrunc+0x24>
      bfree(ip->dev, ip->addrs[i]);
    80002cee:	0009a503          	lw	a0,0(s3)
    80002cf2:	00000097          	auipc	ra,0x0
    80002cf6:	81c080e7          	jalr	-2020(ra) # 8000250e <bfree>
      ip->addrs[i] = 0;
    80002cfa:	0004a023          	sw	zero,0(s1)
    80002cfe:	b7dd                	j	80002ce4 <itrunc+0x24>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002d00:	07c9a583          	lw	a1,124(s3)
    80002d04:	e59d                	bnez	a1,80002d32 <itrunc+0x72>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  if(ip->addrs[NDIRECT+1]){//fangzhao shangmian xunhun shifang
    80002d06:	0809a583          	lw	a1,128(s3)
    80002d0a:	eda5                	bnez	a1,80002d82 <itrunc+0xc2>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT+1]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002d0c:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002d10:	854e                	mv	a0,s3
    80002d12:	00000097          	auipc	ra,0x0
    80002d16:	dd6080e7          	jalr	-554(ra) # 80002ae8 <iupdate>
}
    80002d1a:	60a6                	ld	ra,72(sp)
    80002d1c:	6406                	ld	s0,64(sp)
    80002d1e:	74e2                	ld	s1,56(sp)
    80002d20:	7942                	ld	s2,48(sp)
    80002d22:	79a2                	ld	s3,40(sp)
    80002d24:	7a02                	ld	s4,32(sp)
    80002d26:	6ae2                	ld	s5,24(sp)
    80002d28:	6b42                	ld	s6,16(sp)
    80002d2a:	6ba2                	ld	s7,8(sp)
    80002d2c:	6c02                	ld	s8,0(sp)
    80002d2e:	6161                	addi	sp,sp,80
    80002d30:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002d32:	0009a503          	lw	a0,0(s3)
    80002d36:	fffff097          	auipc	ra,0xfffff
    80002d3a:	592080e7          	jalr	1426(ra) # 800022c8 <bread>
    80002d3e:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002d40:	05850493          	addi	s1,a0,88
    80002d44:	45850913          	addi	s2,a0,1112
    80002d48:	a021                	j	80002d50 <itrunc+0x90>
    80002d4a:	0491                	addi	s1,s1,4
    80002d4c:	01248b63          	beq	s1,s2,80002d62 <itrunc+0xa2>
      if(a[j])
    80002d50:	408c                	lw	a1,0(s1)
    80002d52:	dde5                	beqz	a1,80002d4a <itrunc+0x8a>
        bfree(ip->dev, a[j]);
    80002d54:	0009a503          	lw	a0,0(s3)
    80002d58:	fffff097          	auipc	ra,0xfffff
    80002d5c:	7b6080e7          	jalr	1974(ra) # 8000250e <bfree>
    80002d60:	b7ed                	j	80002d4a <itrunc+0x8a>
    brelse(bp);
    80002d62:	8552                	mv	a0,s4
    80002d64:	fffff097          	auipc	ra,0xfffff
    80002d68:	694080e7          	jalr	1684(ra) # 800023f8 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002d6c:	07c9a583          	lw	a1,124(s3)
    80002d70:	0009a503          	lw	a0,0(s3)
    80002d74:	fffff097          	auipc	ra,0xfffff
    80002d78:	79a080e7          	jalr	1946(ra) # 8000250e <bfree>
    ip->addrs[NDIRECT] = 0;
    80002d7c:	0609ae23          	sw	zero,124(s3)
    80002d80:	b759                	j	80002d06 <itrunc+0x46>
    bp = bread(ip->dev, ip->addrs[NDIRECT+1]);
    80002d82:	0009a503          	lw	a0,0(s3)
    80002d86:	fffff097          	auipc	ra,0xfffff
    80002d8a:	542080e7          	jalr	1346(ra) # 800022c8 <bread>
    80002d8e:	8c2a                	mv	s8,a0
    for(j = 0; j < NINDIRECT; j++){
    80002d90:	05850a13          	addi	s4,a0,88
    80002d94:	45850b13          	addi	s6,a0,1112
    80002d98:	a82d                	j	80002dd2 <itrunc+0x112>
            bfree(ip->dev, a2[k]);
    80002d9a:	0009a503          	lw	a0,0(s3)
    80002d9e:	fffff097          	auipc	ra,0xfffff
    80002da2:	770080e7          	jalr	1904(ra) # 8000250e <bfree>
        for(int k = 0; k < NINDIRECT; k++){
    80002da6:	0491                	addi	s1,s1,4
    80002da8:	00990563          	beq	s2,s1,80002db2 <itrunc+0xf2>
          if(a2[k])
    80002dac:	408c                	lw	a1,0(s1)
    80002dae:	dde5                	beqz	a1,80002da6 <itrunc+0xe6>
    80002db0:	b7ed                	j	80002d9a <itrunc+0xda>
        brelse(bp2);
    80002db2:	855e                	mv	a0,s7
    80002db4:	fffff097          	auipc	ra,0xfffff
    80002db8:	644080e7          	jalr	1604(ra) # 800023f8 <brelse>
        bfree(ip->dev, a[j]);
    80002dbc:	000aa583          	lw	a1,0(s5)
    80002dc0:	0009a503          	lw	a0,0(s3)
    80002dc4:	fffff097          	auipc	ra,0xfffff
    80002dc8:	74a080e7          	jalr	1866(ra) # 8000250e <bfree>
    for(j = 0; j < NINDIRECT; j++){
    80002dcc:	0a11                	addi	s4,s4,4
    80002dce:	034b0263          	beq	s6,s4,80002df2 <itrunc+0x132>
      if(a[j]) {
    80002dd2:	8ad2                	mv	s5,s4
    80002dd4:	000a2583          	lw	a1,0(s4)
    80002dd8:	d9f5                	beqz	a1,80002dcc <itrunc+0x10c>
        struct buf *bp2 = bread(ip->dev, a[j]);
    80002dda:	0009a503          	lw	a0,0(s3)
    80002dde:	fffff097          	auipc	ra,0xfffff
    80002de2:	4ea080e7          	jalr	1258(ra) # 800022c8 <bread>
    80002de6:	8baa                	mv	s7,a0
        for(int k = 0; k < NINDIRECT; k++){
    80002de8:	05850493          	addi	s1,a0,88
    80002dec:	45850913          	addi	s2,a0,1112
    80002df0:	bf75                	j	80002dac <itrunc+0xec>
    brelse(bp);
    80002df2:	8562                	mv	a0,s8
    80002df4:	fffff097          	auipc	ra,0xfffff
    80002df8:	604080e7          	jalr	1540(ra) # 800023f8 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT+1]);
    80002dfc:	0809a583          	lw	a1,128(s3)
    80002e00:	0009a503          	lw	a0,0(s3)
    80002e04:	fffff097          	auipc	ra,0xfffff
    80002e08:	70a080e7          	jalr	1802(ra) # 8000250e <bfree>
    ip->addrs[NDIRECT] = 0;
    80002e0c:	0609ae23          	sw	zero,124(s3)
    80002e10:	bdf5                	j	80002d0c <itrunc+0x4c>

0000000080002e12 <iput>:
{
    80002e12:	1101                	addi	sp,sp,-32
    80002e14:	ec06                	sd	ra,24(sp)
    80002e16:	e822                	sd	s0,16(sp)
    80002e18:	e426                	sd	s1,8(sp)
    80002e1a:	e04a                	sd	s2,0(sp)
    80002e1c:	1000                	addi	s0,sp,32
    80002e1e:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002e20:	0000f517          	auipc	a0,0xf
    80002e24:	42850513          	addi	a0,a0,1064 # 80012248 <itable>
    80002e28:	00003097          	auipc	ra,0x3
    80002e2c:	5a4080e7          	jalr	1444(ra) # 800063cc <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002e30:	4498                	lw	a4,8(s1)
    80002e32:	4785                	li	a5,1
    80002e34:	02f70363          	beq	a4,a5,80002e5a <iput+0x48>
  ip->ref--;
    80002e38:	449c                	lw	a5,8(s1)
    80002e3a:	37fd                	addiw	a5,a5,-1
    80002e3c:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002e3e:	0000f517          	auipc	a0,0xf
    80002e42:	40a50513          	addi	a0,a0,1034 # 80012248 <itable>
    80002e46:	00003097          	auipc	ra,0x3
    80002e4a:	63a080e7          	jalr	1594(ra) # 80006480 <release>
}
    80002e4e:	60e2                	ld	ra,24(sp)
    80002e50:	6442                	ld	s0,16(sp)
    80002e52:	64a2                	ld	s1,8(sp)
    80002e54:	6902                	ld	s2,0(sp)
    80002e56:	6105                	addi	sp,sp,32
    80002e58:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002e5a:	40bc                	lw	a5,64(s1)
    80002e5c:	dff1                	beqz	a5,80002e38 <iput+0x26>
    80002e5e:	04a49783          	lh	a5,74(s1)
    80002e62:	fbf9                	bnez	a5,80002e38 <iput+0x26>
    acquiresleep(&ip->lock);
    80002e64:	01048913          	addi	s2,s1,16
    80002e68:	854a                	mv	a0,s2
    80002e6a:	00001097          	auipc	ra,0x1
    80002e6e:	aaa080e7          	jalr	-1366(ra) # 80003914 <acquiresleep>
    release(&itable.lock);
    80002e72:	0000f517          	auipc	a0,0xf
    80002e76:	3d650513          	addi	a0,a0,982 # 80012248 <itable>
    80002e7a:	00003097          	auipc	ra,0x3
    80002e7e:	606080e7          	jalr	1542(ra) # 80006480 <release>
    itrunc(ip);
    80002e82:	8526                	mv	a0,s1
    80002e84:	00000097          	auipc	ra,0x0
    80002e88:	e3c080e7          	jalr	-452(ra) # 80002cc0 <itrunc>
    ip->type = 0;
    80002e8c:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002e90:	8526                	mv	a0,s1
    80002e92:	00000097          	auipc	ra,0x0
    80002e96:	c56080e7          	jalr	-938(ra) # 80002ae8 <iupdate>
    ip->valid = 0;
    80002e9a:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002e9e:	854a                	mv	a0,s2
    80002ea0:	00001097          	auipc	ra,0x1
    80002ea4:	aca080e7          	jalr	-1334(ra) # 8000396a <releasesleep>
    acquire(&itable.lock);
    80002ea8:	0000f517          	auipc	a0,0xf
    80002eac:	3a050513          	addi	a0,a0,928 # 80012248 <itable>
    80002eb0:	00003097          	auipc	ra,0x3
    80002eb4:	51c080e7          	jalr	1308(ra) # 800063cc <acquire>
    80002eb8:	b741                	j	80002e38 <iput+0x26>

0000000080002eba <iunlockput>:
{
    80002eba:	1101                	addi	sp,sp,-32
    80002ebc:	ec06                	sd	ra,24(sp)
    80002ebe:	e822                	sd	s0,16(sp)
    80002ec0:	e426                	sd	s1,8(sp)
    80002ec2:	1000                	addi	s0,sp,32
    80002ec4:	84aa                	mv	s1,a0
  iunlock(ip);
    80002ec6:	00000097          	auipc	ra,0x0
    80002eca:	dae080e7          	jalr	-594(ra) # 80002c74 <iunlock>
  iput(ip);
    80002ece:	8526                	mv	a0,s1
    80002ed0:	00000097          	auipc	ra,0x0
    80002ed4:	f42080e7          	jalr	-190(ra) # 80002e12 <iput>
}
    80002ed8:	60e2                	ld	ra,24(sp)
    80002eda:	6442                	ld	s0,16(sp)
    80002edc:	64a2                	ld	s1,8(sp)
    80002ede:	6105                	addi	sp,sp,32
    80002ee0:	8082                	ret

0000000080002ee2 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002ee2:	1141                	addi	sp,sp,-16
    80002ee4:	e422                	sd	s0,8(sp)
    80002ee6:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002ee8:	411c                	lw	a5,0(a0)
    80002eea:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002eec:	415c                	lw	a5,4(a0)
    80002eee:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002ef0:	04451783          	lh	a5,68(a0)
    80002ef4:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002ef8:	04a51783          	lh	a5,74(a0)
    80002efc:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002f00:	04c56783          	lwu	a5,76(a0)
    80002f04:	e99c                	sd	a5,16(a1)
}
    80002f06:	6422                	ld	s0,8(sp)
    80002f08:	0141                	addi	sp,sp,16
    80002f0a:	8082                	ret

0000000080002f0c <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002f0c:	457c                	lw	a5,76(a0)
    80002f0e:	0ed7e963          	bltu	a5,a3,80003000 <readi+0xf4>
{
    80002f12:	7159                	addi	sp,sp,-112
    80002f14:	f486                	sd	ra,104(sp)
    80002f16:	f0a2                	sd	s0,96(sp)
    80002f18:	eca6                	sd	s1,88(sp)
    80002f1a:	e8ca                	sd	s2,80(sp)
    80002f1c:	e4ce                	sd	s3,72(sp)
    80002f1e:	e0d2                	sd	s4,64(sp)
    80002f20:	fc56                	sd	s5,56(sp)
    80002f22:	f85a                	sd	s6,48(sp)
    80002f24:	f45e                	sd	s7,40(sp)
    80002f26:	f062                	sd	s8,32(sp)
    80002f28:	ec66                	sd	s9,24(sp)
    80002f2a:	e86a                	sd	s10,16(sp)
    80002f2c:	e46e                	sd	s11,8(sp)
    80002f2e:	1880                	addi	s0,sp,112
    80002f30:	8b2a                	mv	s6,a0
    80002f32:	8bae                	mv	s7,a1
    80002f34:	8a32                	mv	s4,a2
    80002f36:	84b6                	mv	s1,a3
    80002f38:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80002f3a:	9f35                	addw	a4,a4,a3
    return 0;
    80002f3c:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002f3e:	0ad76063          	bltu	a4,a3,80002fde <readi+0xd2>
  if(off + n > ip->size)
    80002f42:	00e7f463          	bgeu	a5,a4,80002f4a <readi+0x3e>
    n = ip->size - off;
    80002f46:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002f4a:	0a0a8963          	beqz	s5,80002ffc <readi+0xf0>
    80002f4e:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002f50:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002f54:	5c7d                	li	s8,-1
    80002f56:	a82d                	j	80002f90 <readi+0x84>
    80002f58:	020d1d93          	slli	s11,s10,0x20
    80002f5c:	020ddd93          	srli	s11,s11,0x20
    80002f60:	05890613          	addi	a2,s2,88
    80002f64:	86ee                	mv	a3,s11
    80002f66:	963a                	add	a2,a2,a4
    80002f68:	85d2                	mv	a1,s4
    80002f6a:	855e                	mv	a0,s7
    80002f6c:	fffff097          	auipc	ra,0xfffff
    80002f70:	998080e7          	jalr	-1640(ra) # 80001904 <either_copyout>
    80002f74:	05850d63          	beq	a0,s8,80002fce <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002f78:	854a                	mv	a0,s2
    80002f7a:	fffff097          	auipc	ra,0xfffff
    80002f7e:	47e080e7          	jalr	1150(ra) # 800023f8 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002f82:	013d09bb          	addw	s3,s10,s3
    80002f86:	009d04bb          	addw	s1,s10,s1
    80002f8a:	9a6e                	add	s4,s4,s11
    80002f8c:	0559f763          	bgeu	s3,s5,80002fda <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    80002f90:	00a4d59b          	srliw	a1,s1,0xa
    80002f94:	855a                	mv	a0,s6
    80002f96:	fffff097          	auipc	ra,0xfffff
    80002f9a:	72c080e7          	jalr	1836(ra) # 800026c2 <bmap>
    80002f9e:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80002fa2:	cd85                	beqz	a1,80002fda <readi+0xce>
    bp = bread(ip->dev, addr);
    80002fa4:	000b2503          	lw	a0,0(s6)
    80002fa8:	fffff097          	auipc	ra,0xfffff
    80002fac:	320080e7          	jalr	800(ra) # 800022c8 <bread>
    80002fb0:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002fb2:	3ff4f713          	andi	a4,s1,1023
    80002fb6:	40ec87bb          	subw	a5,s9,a4
    80002fba:	413a86bb          	subw	a3,s5,s3
    80002fbe:	8d3e                	mv	s10,a5
    80002fc0:	2781                	sext.w	a5,a5
    80002fc2:	0006861b          	sext.w	a2,a3
    80002fc6:	f8f679e3          	bgeu	a2,a5,80002f58 <readi+0x4c>
    80002fca:	8d36                	mv	s10,a3
    80002fcc:	b771                	j	80002f58 <readi+0x4c>
      brelse(bp);
    80002fce:	854a                	mv	a0,s2
    80002fd0:	fffff097          	auipc	ra,0xfffff
    80002fd4:	428080e7          	jalr	1064(ra) # 800023f8 <brelse>
      tot = -1;
    80002fd8:	59fd                	li	s3,-1
  }
  return tot;
    80002fda:	0009851b          	sext.w	a0,s3
}
    80002fde:	70a6                	ld	ra,104(sp)
    80002fe0:	7406                	ld	s0,96(sp)
    80002fe2:	64e6                	ld	s1,88(sp)
    80002fe4:	6946                	ld	s2,80(sp)
    80002fe6:	69a6                	ld	s3,72(sp)
    80002fe8:	6a06                	ld	s4,64(sp)
    80002fea:	7ae2                	ld	s5,56(sp)
    80002fec:	7b42                	ld	s6,48(sp)
    80002fee:	7ba2                	ld	s7,40(sp)
    80002ff0:	7c02                	ld	s8,32(sp)
    80002ff2:	6ce2                	ld	s9,24(sp)
    80002ff4:	6d42                	ld	s10,16(sp)
    80002ff6:	6da2                	ld	s11,8(sp)
    80002ff8:	6165                	addi	sp,sp,112
    80002ffa:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002ffc:	89d6                	mv	s3,s5
    80002ffe:	bff1                	j	80002fda <readi+0xce>
    return 0;
    80003000:	4501                	li	a0,0
}
    80003002:	8082                	ret

0000000080003004 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003004:	457c                	lw	a5,76(a0)
    80003006:	10d7e963          	bltu	a5,a3,80003118 <writei+0x114>
{
    8000300a:	7159                	addi	sp,sp,-112
    8000300c:	f486                	sd	ra,104(sp)
    8000300e:	f0a2                	sd	s0,96(sp)
    80003010:	eca6                	sd	s1,88(sp)
    80003012:	e8ca                	sd	s2,80(sp)
    80003014:	e4ce                	sd	s3,72(sp)
    80003016:	e0d2                	sd	s4,64(sp)
    80003018:	fc56                	sd	s5,56(sp)
    8000301a:	f85a                	sd	s6,48(sp)
    8000301c:	f45e                	sd	s7,40(sp)
    8000301e:	f062                	sd	s8,32(sp)
    80003020:	ec66                	sd	s9,24(sp)
    80003022:	e86a                	sd	s10,16(sp)
    80003024:	e46e                	sd	s11,8(sp)
    80003026:	1880                	addi	s0,sp,112
    80003028:	8aaa                	mv	s5,a0
    8000302a:	8bae                	mv	s7,a1
    8000302c:	8a32                	mv	s4,a2
    8000302e:	8936                	mv	s2,a3
    80003030:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003032:	9f35                	addw	a4,a4,a3
    80003034:	0ed76463          	bltu	a4,a3,8000311c <writei+0x118>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003038:	040437b7          	lui	a5,0x4043
    8000303c:	c0078793          	addi	a5,a5,-1024 # 4042c00 <_entry-0x7bfbd400>
    80003040:	0ee7e063          	bltu	a5,a4,80003120 <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003044:	0c0b0863          	beqz	s6,80003114 <writei+0x110>
    80003048:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    8000304a:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    8000304e:	5c7d                	li	s8,-1
    80003050:	a091                	j	80003094 <writei+0x90>
    80003052:	020d1d93          	slli	s11,s10,0x20
    80003056:	020ddd93          	srli	s11,s11,0x20
    8000305a:	05848513          	addi	a0,s1,88
    8000305e:	86ee                	mv	a3,s11
    80003060:	8652                	mv	a2,s4
    80003062:	85de                	mv	a1,s7
    80003064:	953a                	add	a0,a0,a4
    80003066:	fffff097          	auipc	ra,0xfffff
    8000306a:	8f4080e7          	jalr	-1804(ra) # 8000195a <either_copyin>
    8000306e:	07850263          	beq	a0,s8,800030d2 <writei+0xce>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003072:	8526                	mv	a0,s1
    80003074:	00000097          	auipc	ra,0x0
    80003078:	780080e7          	jalr	1920(ra) # 800037f4 <log_write>
    brelse(bp);
    8000307c:	8526                	mv	a0,s1
    8000307e:	fffff097          	auipc	ra,0xfffff
    80003082:	37a080e7          	jalr	890(ra) # 800023f8 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003086:	013d09bb          	addw	s3,s10,s3
    8000308a:	012d093b          	addw	s2,s10,s2
    8000308e:	9a6e                	add	s4,s4,s11
    80003090:	0569f663          	bgeu	s3,s6,800030dc <writei+0xd8>
    uint addr = bmap(ip, off/BSIZE);
    80003094:	00a9559b          	srliw	a1,s2,0xa
    80003098:	8556                	mv	a0,s5
    8000309a:	fffff097          	auipc	ra,0xfffff
    8000309e:	628080e7          	jalr	1576(ra) # 800026c2 <bmap>
    800030a2:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    800030a6:	c99d                	beqz	a1,800030dc <writei+0xd8>
    bp = bread(ip->dev, addr);
    800030a8:	000aa503          	lw	a0,0(s5)
    800030ac:	fffff097          	auipc	ra,0xfffff
    800030b0:	21c080e7          	jalr	540(ra) # 800022c8 <bread>
    800030b4:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800030b6:	3ff97713          	andi	a4,s2,1023
    800030ba:	40ec87bb          	subw	a5,s9,a4
    800030be:	413b06bb          	subw	a3,s6,s3
    800030c2:	8d3e                	mv	s10,a5
    800030c4:	2781                	sext.w	a5,a5
    800030c6:	0006861b          	sext.w	a2,a3
    800030ca:	f8f674e3          	bgeu	a2,a5,80003052 <writei+0x4e>
    800030ce:	8d36                	mv	s10,a3
    800030d0:	b749                	j	80003052 <writei+0x4e>
      brelse(bp);
    800030d2:	8526                	mv	a0,s1
    800030d4:	fffff097          	auipc	ra,0xfffff
    800030d8:	324080e7          	jalr	804(ra) # 800023f8 <brelse>
  }

  if(off > ip->size)
    800030dc:	04caa783          	lw	a5,76(s5)
    800030e0:	0127f463          	bgeu	a5,s2,800030e8 <writei+0xe4>
    ip->size = off;
    800030e4:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800030e8:	8556                	mv	a0,s5
    800030ea:	00000097          	auipc	ra,0x0
    800030ee:	9fe080e7          	jalr	-1538(ra) # 80002ae8 <iupdate>

  return tot;
    800030f2:	0009851b          	sext.w	a0,s3
}
    800030f6:	70a6                	ld	ra,104(sp)
    800030f8:	7406                	ld	s0,96(sp)
    800030fa:	64e6                	ld	s1,88(sp)
    800030fc:	6946                	ld	s2,80(sp)
    800030fe:	69a6                	ld	s3,72(sp)
    80003100:	6a06                	ld	s4,64(sp)
    80003102:	7ae2                	ld	s5,56(sp)
    80003104:	7b42                	ld	s6,48(sp)
    80003106:	7ba2                	ld	s7,40(sp)
    80003108:	7c02                	ld	s8,32(sp)
    8000310a:	6ce2                	ld	s9,24(sp)
    8000310c:	6d42                	ld	s10,16(sp)
    8000310e:	6da2                	ld	s11,8(sp)
    80003110:	6165                	addi	sp,sp,112
    80003112:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003114:	89da                	mv	s3,s6
    80003116:	bfc9                	j	800030e8 <writei+0xe4>
    return -1;
    80003118:	557d                	li	a0,-1
}
    8000311a:	8082                	ret
    return -1;
    8000311c:	557d                	li	a0,-1
    8000311e:	bfe1                	j	800030f6 <writei+0xf2>
    return -1;
    80003120:	557d                	li	a0,-1
    80003122:	bfd1                	j	800030f6 <writei+0xf2>

0000000080003124 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003124:	1141                	addi	sp,sp,-16
    80003126:	e406                	sd	ra,8(sp)
    80003128:	e022                	sd	s0,0(sp)
    8000312a:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    8000312c:	4639                	li	a2,14
    8000312e:	ffffd097          	auipc	ra,0xffffd
    80003132:	122080e7          	jalr	290(ra) # 80000250 <strncmp>
}
    80003136:	60a2                	ld	ra,8(sp)
    80003138:	6402                	ld	s0,0(sp)
    8000313a:	0141                	addi	sp,sp,16
    8000313c:	8082                	ret

000000008000313e <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000313e:	7139                	addi	sp,sp,-64
    80003140:	fc06                	sd	ra,56(sp)
    80003142:	f822                	sd	s0,48(sp)
    80003144:	f426                	sd	s1,40(sp)
    80003146:	f04a                	sd	s2,32(sp)
    80003148:	ec4e                	sd	s3,24(sp)
    8000314a:	e852                	sd	s4,16(sp)
    8000314c:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    8000314e:	04451703          	lh	a4,68(a0)
    80003152:	4785                	li	a5,1
    80003154:	00f71a63          	bne	a4,a5,80003168 <dirlookup+0x2a>
    80003158:	892a                	mv	s2,a0
    8000315a:	89ae                	mv	s3,a1
    8000315c:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    8000315e:	457c                	lw	a5,76(a0)
    80003160:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003162:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003164:	e79d                	bnez	a5,80003192 <dirlookup+0x54>
    80003166:	a8a5                	j	800031de <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003168:	00005517          	auipc	a0,0x5
    8000316c:	41050513          	addi	a0,a0,1040 # 80008578 <syscalls+0x1a8>
    80003170:	00003097          	auipc	ra,0x3
    80003174:	d12080e7          	jalr	-750(ra) # 80005e82 <panic>
      panic("dirlookup read");
    80003178:	00005517          	auipc	a0,0x5
    8000317c:	41850513          	addi	a0,a0,1048 # 80008590 <syscalls+0x1c0>
    80003180:	00003097          	auipc	ra,0x3
    80003184:	d02080e7          	jalr	-766(ra) # 80005e82 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003188:	24c1                	addiw	s1,s1,16
    8000318a:	04c92783          	lw	a5,76(s2)
    8000318e:	04f4f763          	bgeu	s1,a5,800031dc <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003192:	4741                	li	a4,16
    80003194:	86a6                	mv	a3,s1
    80003196:	fc040613          	addi	a2,s0,-64
    8000319a:	4581                	li	a1,0
    8000319c:	854a                	mv	a0,s2
    8000319e:	00000097          	auipc	ra,0x0
    800031a2:	d6e080e7          	jalr	-658(ra) # 80002f0c <readi>
    800031a6:	47c1                	li	a5,16
    800031a8:	fcf518e3          	bne	a0,a5,80003178 <dirlookup+0x3a>
    if(de.inum == 0)
    800031ac:	fc045783          	lhu	a5,-64(s0)
    800031b0:	dfe1                	beqz	a5,80003188 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    800031b2:	fc240593          	addi	a1,s0,-62
    800031b6:	854e                	mv	a0,s3
    800031b8:	00000097          	auipc	ra,0x0
    800031bc:	f6c080e7          	jalr	-148(ra) # 80003124 <namecmp>
    800031c0:	f561                	bnez	a0,80003188 <dirlookup+0x4a>
      if(poff)
    800031c2:	000a0463          	beqz	s4,800031ca <dirlookup+0x8c>
        *poff = off;
    800031c6:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    800031ca:	fc045583          	lhu	a1,-64(s0)
    800031ce:	00092503          	lw	a0,0(s2)
    800031d2:	fffff097          	auipc	ra,0xfffff
    800031d6:	6a8080e7          	jalr	1704(ra) # 8000287a <iget>
    800031da:	a011                	j	800031de <dirlookup+0xa0>
  return 0;
    800031dc:	4501                	li	a0,0
}
    800031de:	70e2                	ld	ra,56(sp)
    800031e0:	7442                	ld	s0,48(sp)
    800031e2:	74a2                	ld	s1,40(sp)
    800031e4:	7902                	ld	s2,32(sp)
    800031e6:	69e2                	ld	s3,24(sp)
    800031e8:	6a42                	ld	s4,16(sp)
    800031ea:	6121                	addi	sp,sp,64
    800031ec:	8082                	ret

00000000800031ee <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800031ee:	711d                	addi	sp,sp,-96
    800031f0:	ec86                	sd	ra,88(sp)
    800031f2:	e8a2                	sd	s0,80(sp)
    800031f4:	e4a6                	sd	s1,72(sp)
    800031f6:	e0ca                	sd	s2,64(sp)
    800031f8:	fc4e                	sd	s3,56(sp)
    800031fa:	f852                	sd	s4,48(sp)
    800031fc:	f456                	sd	s5,40(sp)
    800031fe:	f05a                	sd	s6,32(sp)
    80003200:	ec5e                	sd	s7,24(sp)
    80003202:	e862                	sd	s8,16(sp)
    80003204:	e466                	sd	s9,8(sp)
    80003206:	1080                	addi	s0,sp,96
    80003208:	84aa                	mv	s1,a0
    8000320a:	8b2e                	mv	s6,a1
    8000320c:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    8000320e:	00054703          	lbu	a4,0(a0)
    80003212:	02f00793          	li	a5,47
    80003216:	02f70363          	beq	a4,a5,8000323c <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    8000321a:	ffffe097          	auipc	ra,0xffffe
    8000321e:	c3e080e7          	jalr	-962(ra) # 80000e58 <myproc>
    80003222:	15053503          	ld	a0,336(a0)
    80003226:	00000097          	auipc	ra,0x0
    8000322a:	94e080e7          	jalr	-1714(ra) # 80002b74 <idup>
    8000322e:	89aa                	mv	s3,a0
  while(*path == '/')
    80003230:	02f00913          	li	s2,47
  len = path - s;
    80003234:	4b81                	li	s7,0
  if(len >= DIRSIZ)
    80003236:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003238:	4c05                	li	s8,1
    8000323a:	a865                	j	800032f2 <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    8000323c:	4585                	li	a1,1
    8000323e:	4505                	li	a0,1
    80003240:	fffff097          	auipc	ra,0xfffff
    80003244:	63a080e7          	jalr	1594(ra) # 8000287a <iget>
    80003248:	89aa                	mv	s3,a0
    8000324a:	b7dd                	j	80003230 <namex+0x42>
      iunlockput(ip);
    8000324c:	854e                	mv	a0,s3
    8000324e:	00000097          	auipc	ra,0x0
    80003252:	c6c080e7          	jalr	-916(ra) # 80002eba <iunlockput>
      return 0;
    80003256:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003258:	854e                	mv	a0,s3
    8000325a:	60e6                	ld	ra,88(sp)
    8000325c:	6446                	ld	s0,80(sp)
    8000325e:	64a6                	ld	s1,72(sp)
    80003260:	6906                	ld	s2,64(sp)
    80003262:	79e2                	ld	s3,56(sp)
    80003264:	7a42                	ld	s4,48(sp)
    80003266:	7aa2                	ld	s5,40(sp)
    80003268:	7b02                	ld	s6,32(sp)
    8000326a:	6be2                	ld	s7,24(sp)
    8000326c:	6c42                	ld	s8,16(sp)
    8000326e:	6ca2                	ld	s9,8(sp)
    80003270:	6125                	addi	sp,sp,96
    80003272:	8082                	ret
      iunlock(ip);
    80003274:	854e                	mv	a0,s3
    80003276:	00000097          	auipc	ra,0x0
    8000327a:	9fe080e7          	jalr	-1538(ra) # 80002c74 <iunlock>
      return ip;
    8000327e:	bfe9                	j	80003258 <namex+0x6a>
      iunlockput(ip);
    80003280:	854e                	mv	a0,s3
    80003282:	00000097          	auipc	ra,0x0
    80003286:	c38080e7          	jalr	-968(ra) # 80002eba <iunlockput>
      return 0;
    8000328a:	89d2                	mv	s3,s4
    8000328c:	b7f1                	j	80003258 <namex+0x6a>
  len = path - s;
    8000328e:	40b48633          	sub	a2,s1,a1
    80003292:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    80003296:	094cd463          	bge	s9,s4,8000331e <namex+0x130>
    memmove(name, s, DIRSIZ);
    8000329a:	4639                	li	a2,14
    8000329c:	8556                	mv	a0,s5
    8000329e:	ffffd097          	auipc	ra,0xffffd
    800032a2:	f3a080e7          	jalr	-198(ra) # 800001d8 <memmove>
  while(*path == '/')
    800032a6:	0004c783          	lbu	a5,0(s1)
    800032aa:	01279763          	bne	a5,s2,800032b8 <namex+0xca>
    path++;
    800032ae:	0485                	addi	s1,s1,1
  while(*path == '/')
    800032b0:	0004c783          	lbu	a5,0(s1)
    800032b4:	ff278de3          	beq	a5,s2,800032ae <namex+0xc0>
    ilock(ip);
    800032b8:	854e                	mv	a0,s3
    800032ba:	00000097          	auipc	ra,0x0
    800032be:	8f8080e7          	jalr	-1800(ra) # 80002bb2 <ilock>
    if(ip->type != T_DIR){
    800032c2:	04499783          	lh	a5,68(s3)
    800032c6:	f98793e3          	bne	a5,s8,8000324c <namex+0x5e>
    if(nameiparent && *path == '\0'){
    800032ca:	000b0563          	beqz	s6,800032d4 <namex+0xe6>
    800032ce:	0004c783          	lbu	a5,0(s1)
    800032d2:	d3cd                	beqz	a5,80003274 <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    800032d4:	865e                	mv	a2,s7
    800032d6:	85d6                	mv	a1,s5
    800032d8:	854e                	mv	a0,s3
    800032da:	00000097          	auipc	ra,0x0
    800032de:	e64080e7          	jalr	-412(ra) # 8000313e <dirlookup>
    800032e2:	8a2a                	mv	s4,a0
    800032e4:	dd51                	beqz	a0,80003280 <namex+0x92>
    iunlockput(ip);
    800032e6:	854e                	mv	a0,s3
    800032e8:	00000097          	auipc	ra,0x0
    800032ec:	bd2080e7          	jalr	-1070(ra) # 80002eba <iunlockput>
    ip = next;
    800032f0:	89d2                	mv	s3,s4
  while(*path == '/')
    800032f2:	0004c783          	lbu	a5,0(s1)
    800032f6:	05279763          	bne	a5,s2,80003344 <namex+0x156>
    path++;
    800032fa:	0485                	addi	s1,s1,1
  while(*path == '/')
    800032fc:	0004c783          	lbu	a5,0(s1)
    80003300:	ff278de3          	beq	a5,s2,800032fa <namex+0x10c>
  if(*path == 0)
    80003304:	c79d                	beqz	a5,80003332 <namex+0x144>
    path++;
    80003306:	85a6                	mv	a1,s1
  len = path - s;
    80003308:	8a5e                	mv	s4,s7
    8000330a:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    8000330c:	01278963          	beq	a5,s2,8000331e <namex+0x130>
    80003310:	dfbd                	beqz	a5,8000328e <namex+0xa0>
    path++;
    80003312:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80003314:	0004c783          	lbu	a5,0(s1)
    80003318:	ff279ce3          	bne	a5,s2,80003310 <namex+0x122>
    8000331c:	bf8d                	j	8000328e <namex+0xa0>
    memmove(name, s, len);
    8000331e:	2601                	sext.w	a2,a2
    80003320:	8556                	mv	a0,s5
    80003322:	ffffd097          	auipc	ra,0xffffd
    80003326:	eb6080e7          	jalr	-330(ra) # 800001d8 <memmove>
    name[len] = 0;
    8000332a:	9a56                	add	s4,s4,s5
    8000332c:	000a0023          	sb	zero,0(s4)
    80003330:	bf9d                	j	800032a6 <namex+0xb8>
  if(nameiparent){
    80003332:	f20b03e3          	beqz	s6,80003258 <namex+0x6a>
    iput(ip);
    80003336:	854e                	mv	a0,s3
    80003338:	00000097          	auipc	ra,0x0
    8000333c:	ada080e7          	jalr	-1318(ra) # 80002e12 <iput>
    return 0;
    80003340:	4981                	li	s3,0
    80003342:	bf19                	j	80003258 <namex+0x6a>
  if(*path == 0)
    80003344:	d7fd                	beqz	a5,80003332 <namex+0x144>
  while(*path != '/' && *path != 0)
    80003346:	0004c783          	lbu	a5,0(s1)
    8000334a:	85a6                	mv	a1,s1
    8000334c:	b7d1                	j	80003310 <namex+0x122>

000000008000334e <dirlink>:
{
    8000334e:	7139                	addi	sp,sp,-64
    80003350:	fc06                	sd	ra,56(sp)
    80003352:	f822                	sd	s0,48(sp)
    80003354:	f426                	sd	s1,40(sp)
    80003356:	f04a                	sd	s2,32(sp)
    80003358:	ec4e                	sd	s3,24(sp)
    8000335a:	e852                	sd	s4,16(sp)
    8000335c:	0080                	addi	s0,sp,64
    8000335e:	892a                	mv	s2,a0
    80003360:	8a2e                	mv	s4,a1
    80003362:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003364:	4601                	li	a2,0
    80003366:	00000097          	auipc	ra,0x0
    8000336a:	dd8080e7          	jalr	-552(ra) # 8000313e <dirlookup>
    8000336e:	e93d                	bnez	a0,800033e4 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003370:	04c92483          	lw	s1,76(s2)
    80003374:	c49d                	beqz	s1,800033a2 <dirlink+0x54>
    80003376:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003378:	4741                	li	a4,16
    8000337a:	86a6                	mv	a3,s1
    8000337c:	fc040613          	addi	a2,s0,-64
    80003380:	4581                	li	a1,0
    80003382:	854a                	mv	a0,s2
    80003384:	00000097          	auipc	ra,0x0
    80003388:	b88080e7          	jalr	-1144(ra) # 80002f0c <readi>
    8000338c:	47c1                	li	a5,16
    8000338e:	06f51163          	bne	a0,a5,800033f0 <dirlink+0xa2>
    if(de.inum == 0)
    80003392:	fc045783          	lhu	a5,-64(s0)
    80003396:	c791                	beqz	a5,800033a2 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003398:	24c1                	addiw	s1,s1,16
    8000339a:	04c92783          	lw	a5,76(s2)
    8000339e:	fcf4ede3          	bltu	s1,a5,80003378 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    800033a2:	4639                	li	a2,14
    800033a4:	85d2                	mv	a1,s4
    800033a6:	fc240513          	addi	a0,s0,-62
    800033aa:	ffffd097          	auipc	ra,0xffffd
    800033ae:	ee2080e7          	jalr	-286(ra) # 8000028c <strncpy>
  de.inum = inum;
    800033b2:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800033b6:	4741                	li	a4,16
    800033b8:	86a6                	mv	a3,s1
    800033ba:	fc040613          	addi	a2,s0,-64
    800033be:	4581                	li	a1,0
    800033c0:	854a                	mv	a0,s2
    800033c2:	00000097          	auipc	ra,0x0
    800033c6:	c42080e7          	jalr	-958(ra) # 80003004 <writei>
    800033ca:	1541                	addi	a0,a0,-16
    800033cc:	00a03533          	snez	a0,a0
    800033d0:	40a00533          	neg	a0,a0
}
    800033d4:	70e2                	ld	ra,56(sp)
    800033d6:	7442                	ld	s0,48(sp)
    800033d8:	74a2                	ld	s1,40(sp)
    800033da:	7902                	ld	s2,32(sp)
    800033dc:	69e2                	ld	s3,24(sp)
    800033de:	6a42                	ld	s4,16(sp)
    800033e0:	6121                	addi	sp,sp,64
    800033e2:	8082                	ret
    iput(ip);
    800033e4:	00000097          	auipc	ra,0x0
    800033e8:	a2e080e7          	jalr	-1490(ra) # 80002e12 <iput>
    return -1;
    800033ec:	557d                	li	a0,-1
    800033ee:	b7dd                	j	800033d4 <dirlink+0x86>
      panic("dirlink read");
    800033f0:	00005517          	auipc	a0,0x5
    800033f4:	1b050513          	addi	a0,a0,432 # 800085a0 <syscalls+0x1d0>
    800033f8:	00003097          	auipc	ra,0x3
    800033fc:	a8a080e7          	jalr	-1398(ra) # 80005e82 <panic>

0000000080003400 <namei>:

struct inode*
namei(char *path)
{
    80003400:	1101                	addi	sp,sp,-32
    80003402:	ec06                	sd	ra,24(sp)
    80003404:	e822                	sd	s0,16(sp)
    80003406:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003408:	fe040613          	addi	a2,s0,-32
    8000340c:	4581                	li	a1,0
    8000340e:	00000097          	auipc	ra,0x0
    80003412:	de0080e7          	jalr	-544(ra) # 800031ee <namex>
}
    80003416:	60e2                	ld	ra,24(sp)
    80003418:	6442                	ld	s0,16(sp)
    8000341a:	6105                	addi	sp,sp,32
    8000341c:	8082                	ret

000000008000341e <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    8000341e:	1141                	addi	sp,sp,-16
    80003420:	e406                	sd	ra,8(sp)
    80003422:	e022                	sd	s0,0(sp)
    80003424:	0800                	addi	s0,sp,16
    80003426:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003428:	4585                	li	a1,1
    8000342a:	00000097          	auipc	ra,0x0
    8000342e:	dc4080e7          	jalr	-572(ra) # 800031ee <namex>
}
    80003432:	60a2                	ld	ra,8(sp)
    80003434:	6402                	ld	s0,0(sp)
    80003436:	0141                	addi	sp,sp,16
    80003438:	8082                	ret

000000008000343a <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000343a:	1101                	addi	sp,sp,-32
    8000343c:	ec06                	sd	ra,24(sp)
    8000343e:	e822                	sd	s0,16(sp)
    80003440:	e426                	sd	s1,8(sp)
    80003442:	e04a                	sd	s2,0(sp)
    80003444:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003446:	00011917          	auipc	s2,0x11
    8000344a:	8aa90913          	addi	s2,s2,-1878 # 80013cf0 <log>
    8000344e:	01892583          	lw	a1,24(s2)
    80003452:	02892503          	lw	a0,40(s2)
    80003456:	fffff097          	auipc	ra,0xfffff
    8000345a:	e72080e7          	jalr	-398(ra) # 800022c8 <bread>
    8000345e:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80003460:	02c92683          	lw	a3,44(s2)
    80003464:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003466:	02d05763          	blez	a3,80003494 <write_head+0x5a>
    8000346a:	00011797          	auipc	a5,0x11
    8000346e:	8b678793          	addi	a5,a5,-1866 # 80013d20 <log+0x30>
    80003472:	05c50713          	addi	a4,a0,92
    80003476:	36fd                	addiw	a3,a3,-1
    80003478:	1682                	slli	a3,a3,0x20
    8000347a:	9281                	srli	a3,a3,0x20
    8000347c:	068a                	slli	a3,a3,0x2
    8000347e:	00011617          	auipc	a2,0x11
    80003482:	8a660613          	addi	a2,a2,-1882 # 80013d24 <log+0x34>
    80003486:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003488:	4390                	lw	a2,0(a5)
    8000348a:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000348c:	0791                	addi	a5,a5,4
    8000348e:	0711                	addi	a4,a4,4
    80003490:	fed79ce3          	bne	a5,a3,80003488 <write_head+0x4e>
  }
  bwrite(buf);
    80003494:	8526                	mv	a0,s1
    80003496:	fffff097          	auipc	ra,0xfffff
    8000349a:	f24080e7          	jalr	-220(ra) # 800023ba <bwrite>
  brelse(buf);
    8000349e:	8526                	mv	a0,s1
    800034a0:	fffff097          	auipc	ra,0xfffff
    800034a4:	f58080e7          	jalr	-168(ra) # 800023f8 <brelse>
}
    800034a8:	60e2                	ld	ra,24(sp)
    800034aa:	6442                	ld	s0,16(sp)
    800034ac:	64a2                	ld	s1,8(sp)
    800034ae:	6902                	ld	s2,0(sp)
    800034b0:	6105                	addi	sp,sp,32
    800034b2:	8082                	ret

00000000800034b4 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800034b4:	00011797          	auipc	a5,0x11
    800034b8:	8687a783          	lw	a5,-1944(a5) # 80013d1c <log+0x2c>
    800034bc:	0af05d63          	blez	a5,80003576 <install_trans+0xc2>
{
    800034c0:	7139                	addi	sp,sp,-64
    800034c2:	fc06                	sd	ra,56(sp)
    800034c4:	f822                	sd	s0,48(sp)
    800034c6:	f426                	sd	s1,40(sp)
    800034c8:	f04a                	sd	s2,32(sp)
    800034ca:	ec4e                	sd	s3,24(sp)
    800034cc:	e852                	sd	s4,16(sp)
    800034ce:	e456                	sd	s5,8(sp)
    800034d0:	e05a                	sd	s6,0(sp)
    800034d2:	0080                	addi	s0,sp,64
    800034d4:	8b2a                	mv	s6,a0
    800034d6:	00011a97          	auipc	s5,0x11
    800034da:	84aa8a93          	addi	s5,s5,-1974 # 80013d20 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    800034de:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800034e0:	00011997          	auipc	s3,0x11
    800034e4:	81098993          	addi	s3,s3,-2032 # 80013cf0 <log>
    800034e8:	a035                	j	80003514 <install_trans+0x60>
      bunpin(dbuf);
    800034ea:	8526                	mv	a0,s1
    800034ec:	fffff097          	auipc	ra,0xfffff
    800034f0:	fe6080e7          	jalr	-26(ra) # 800024d2 <bunpin>
    brelse(lbuf);
    800034f4:	854a                	mv	a0,s2
    800034f6:	fffff097          	auipc	ra,0xfffff
    800034fa:	f02080e7          	jalr	-254(ra) # 800023f8 <brelse>
    brelse(dbuf);
    800034fe:	8526                	mv	a0,s1
    80003500:	fffff097          	auipc	ra,0xfffff
    80003504:	ef8080e7          	jalr	-264(ra) # 800023f8 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003508:	2a05                	addiw	s4,s4,1
    8000350a:	0a91                	addi	s5,s5,4
    8000350c:	02c9a783          	lw	a5,44(s3)
    80003510:	04fa5963          	bge	s4,a5,80003562 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003514:	0189a583          	lw	a1,24(s3)
    80003518:	014585bb          	addw	a1,a1,s4
    8000351c:	2585                	addiw	a1,a1,1
    8000351e:	0289a503          	lw	a0,40(s3)
    80003522:	fffff097          	auipc	ra,0xfffff
    80003526:	da6080e7          	jalr	-602(ra) # 800022c8 <bread>
    8000352a:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000352c:	000aa583          	lw	a1,0(s5)
    80003530:	0289a503          	lw	a0,40(s3)
    80003534:	fffff097          	auipc	ra,0xfffff
    80003538:	d94080e7          	jalr	-620(ra) # 800022c8 <bread>
    8000353c:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    8000353e:	40000613          	li	a2,1024
    80003542:	05890593          	addi	a1,s2,88
    80003546:	05850513          	addi	a0,a0,88
    8000354a:	ffffd097          	auipc	ra,0xffffd
    8000354e:	c8e080e7          	jalr	-882(ra) # 800001d8 <memmove>
    bwrite(dbuf);  // write dst to disk
    80003552:	8526                	mv	a0,s1
    80003554:	fffff097          	auipc	ra,0xfffff
    80003558:	e66080e7          	jalr	-410(ra) # 800023ba <bwrite>
    if(recovering == 0)
    8000355c:	f80b1ce3          	bnez	s6,800034f4 <install_trans+0x40>
    80003560:	b769                	j	800034ea <install_trans+0x36>
}
    80003562:	70e2                	ld	ra,56(sp)
    80003564:	7442                	ld	s0,48(sp)
    80003566:	74a2                	ld	s1,40(sp)
    80003568:	7902                	ld	s2,32(sp)
    8000356a:	69e2                	ld	s3,24(sp)
    8000356c:	6a42                	ld	s4,16(sp)
    8000356e:	6aa2                	ld	s5,8(sp)
    80003570:	6b02                	ld	s6,0(sp)
    80003572:	6121                	addi	sp,sp,64
    80003574:	8082                	ret
    80003576:	8082                	ret

0000000080003578 <initlog>:
{
    80003578:	7179                	addi	sp,sp,-48
    8000357a:	f406                	sd	ra,40(sp)
    8000357c:	f022                	sd	s0,32(sp)
    8000357e:	ec26                	sd	s1,24(sp)
    80003580:	e84a                	sd	s2,16(sp)
    80003582:	e44e                	sd	s3,8(sp)
    80003584:	1800                	addi	s0,sp,48
    80003586:	892a                	mv	s2,a0
    80003588:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    8000358a:	00010497          	auipc	s1,0x10
    8000358e:	76648493          	addi	s1,s1,1894 # 80013cf0 <log>
    80003592:	00005597          	auipc	a1,0x5
    80003596:	01e58593          	addi	a1,a1,30 # 800085b0 <syscalls+0x1e0>
    8000359a:	8526                	mv	a0,s1
    8000359c:	00003097          	auipc	ra,0x3
    800035a0:	da0080e7          	jalr	-608(ra) # 8000633c <initlock>
  log.start = sb->logstart;
    800035a4:	0149a583          	lw	a1,20(s3)
    800035a8:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    800035aa:	0109a783          	lw	a5,16(s3)
    800035ae:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    800035b0:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    800035b4:	854a                	mv	a0,s2
    800035b6:	fffff097          	auipc	ra,0xfffff
    800035ba:	d12080e7          	jalr	-750(ra) # 800022c8 <bread>
  log.lh.n = lh->n;
    800035be:	4d3c                	lw	a5,88(a0)
    800035c0:	d4dc                	sw	a5,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    800035c2:	02f05563          	blez	a5,800035ec <initlog+0x74>
    800035c6:	05c50713          	addi	a4,a0,92
    800035ca:	00010697          	auipc	a3,0x10
    800035ce:	75668693          	addi	a3,a3,1878 # 80013d20 <log+0x30>
    800035d2:	37fd                	addiw	a5,a5,-1
    800035d4:	1782                	slli	a5,a5,0x20
    800035d6:	9381                	srli	a5,a5,0x20
    800035d8:	078a                	slli	a5,a5,0x2
    800035da:	06050613          	addi	a2,a0,96
    800035de:	97b2                	add	a5,a5,a2
    log.lh.block[i] = lh->block[i];
    800035e0:	4310                	lw	a2,0(a4)
    800035e2:	c290                	sw	a2,0(a3)
  for (i = 0; i < log.lh.n; i++) {
    800035e4:	0711                	addi	a4,a4,4
    800035e6:	0691                	addi	a3,a3,4
    800035e8:	fef71ce3          	bne	a4,a5,800035e0 <initlog+0x68>
  brelse(buf);
    800035ec:	fffff097          	auipc	ra,0xfffff
    800035f0:	e0c080e7          	jalr	-500(ra) # 800023f8 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800035f4:	4505                	li	a0,1
    800035f6:	00000097          	auipc	ra,0x0
    800035fa:	ebe080e7          	jalr	-322(ra) # 800034b4 <install_trans>
  log.lh.n = 0;
    800035fe:	00010797          	auipc	a5,0x10
    80003602:	7007af23          	sw	zero,1822(a5) # 80013d1c <log+0x2c>
  write_head(); // clear the log
    80003606:	00000097          	auipc	ra,0x0
    8000360a:	e34080e7          	jalr	-460(ra) # 8000343a <write_head>
}
    8000360e:	70a2                	ld	ra,40(sp)
    80003610:	7402                	ld	s0,32(sp)
    80003612:	64e2                	ld	s1,24(sp)
    80003614:	6942                	ld	s2,16(sp)
    80003616:	69a2                	ld	s3,8(sp)
    80003618:	6145                	addi	sp,sp,48
    8000361a:	8082                	ret

000000008000361c <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    8000361c:	1101                	addi	sp,sp,-32
    8000361e:	ec06                	sd	ra,24(sp)
    80003620:	e822                	sd	s0,16(sp)
    80003622:	e426                	sd	s1,8(sp)
    80003624:	e04a                	sd	s2,0(sp)
    80003626:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003628:	00010517          	auipc	a0,0x10
    8000362c:	6c850513          	addi	a0,a0,1736 # 80013cf0 <log>
    80003630:	00003097          	auipc	ra,0x3
    80003634:	d9c080e7          	jalr	-612(ra) # 800063cc <acquire>
  while(1){
    if(log.committing){
    80003638:	00010497          	auipc	s1,0x10
    8000363c:	6b848493          	addi	s1,s1,1720 # 80013cf0 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003640:	4979                	li	s2,30
    80003642:	a039                	j	80003650 <begin_op+0x34>
      sleep(&log, &log.lock);
    80003644:	85a6                	mv	a1,s1
    80003646:	8526                	mv	a0,s1
    80003648:	ffffe097          	auipc	ra,0xffffe
    8000364c:	eb4080e7          	jalr	-332(ra) # 800014fc <sleep>
    if(log.committing){
    80003650:	50dc                	lw	a5,36(s1)
    80003652:	fbed                	bnez	a5,80003644 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003654:	509c                	lw	a5,32(s1)
    80003656:	0017871b          	addiw	a4,a5,1
    8000365a:	0007069b          	sext.w	a3,a4
    8000365e:	0027179b          	slliw	a5,a4,0x2
    80003662:	9fb9                	addw	a5,a5,a4
    80003664:	0017979b          	slliw	a5,a5,0x1
    80003668:	54d8                	lw	a4,44(s1)
    8000366a:	9fb9                	addw	a5,a5,a4
    8000366c:	00f95963          	bge	s2,a5,8000367e <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003670:	85a6                	mv	a1,s1
    80003672:	8526                	mv	a0,s1
    80003674:	ffffe097          	auipc	ra,0xffffe
    80003678:	e88080e7          	jalr	-376(ra) # 800014fc <sleep>
    8000367c:	bfd1                	j	80003650 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    8000367e:	00010517          	auipc	a0,0x10
    80003682:	67250513          	addi	a0,a0,1650 # 80013cf0 <log>
    80003686:	d114                	sw	a3,32(a0)
      release(&log.lock);
    80003688:	00003097          	auipc	ra,0x3
    8000368c:	df8080e7          	jalr	-520(ra) # 80006480 <release>
      break;
    }
  }
}
    80003690:	60e2                	ld	ra,24(sp)
    80003692:	6442                	ld	s0,16(sp)
    80003694:	64a2                	ld	s1,8(sp)
    80003696:	6902                	ld	s2,0(sp)
    80003698:	6105                	addi	sp,sp,32
    8000369a:	8082                	ret

000000008000369c <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    8000369c:	7139                	addi	sp,sp,-64
    8000369e:	fc06                	sd	ra,56(sp)
    800036a0:	f822                	sd	s0,48(sp)
    800036a2:	f426                	sd	s1,40(sp)
    800036a4:	f04a                	sd	s2,32(sp)
    800036a6:	ec4e                	sd	s3,24(sp)
    800036a8:	e852                	sd	s4,16(sp)
    800036aa:	e456                	sd	s5,8(sp)
    800036ac:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800036ae:	00010497          	auipc	s1,0x10
    800036b2:	64248493          	addi	s1,s1,1602 # 80013cf0 <log>
    800036b6:	8526                	mv	a0,s1
    800036b8:	00003097          	auipc	ra,0x3
    800036bc:	d14080e7          	jalr	-748(ra) # 800063cc <acquire>
  log.outstanding -= 1;
    800036c0:	509c                	lw	a5,32(s1)
    800036c2:	37fd                	addiw	a5,a5,-1
    800036c4:	0007891b          	sext.w	s2,a5
    800036c8:	d09c                	sw	a5,32(s1)
  if(log.committing)
    800036ca:	50dc                	lw	a5,36(s1)
    800036cc:	efb9                	bnez	a5,8000372a <end_op+0x8e>
    panic("log.committing");
  if(log.outstanding == 0){
    800036ce:	06091663          	bnez	s2,8000373a <end_op+0x9e>
    do_commit = 1;
    log.committing = 1;
    800036d2:	00010497          	auipc	s1,0x10
    800036d6:	61e48493          	addi	s1,s1,1566 # 80013cf0 <log>
    800036da:	4785                	li	a5,1
    800036dc:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800036de:	8526                	mv	a0,s1
    800036e0:	00003097          	auipc	ra,0x3
    800036e4:	da0080e7          	jalr	-608(ra) # 80006480 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800036e8:	54dc                	lw	a5,44(s1)
    800036ea:	06f04763          	bgtz	a5,80003758 <end_op+0xbc>
    acquire(&log.lock);
    800036ee:	00010497          	auipc	s1,0x10
    800036f2:	60248493          	addi	s1,s1,1538 # 80013cf0 <log>
    800036f6:	8526                	mv	a0,s1
    800036f8:	00003097          	auipc	ra,0x3
    800036fc:	cd4080e7          	jalr	-812(ra) # 800063cc <acquire>
    log.committing = 0;
    80003700:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80003704:	8526                	mv	a0,s1
    80003706:	ffffe097          	auipc	ra,0xffffe
    8000370a:	e5a080e7          	jalr	-422(ra) # 80001560 <wakeup>
    release(&log.lock);
    8000370e:	8526                	mv	a0,s1
    80003710:	00003097          	auipc	ra,0x3
    80003714:	d70080e7          	jalr	-656(ra) # 80006480 <release>
}
    80003718:	70e2                	ld	ra,56(sp)
    8000371a:	7442                	ld	s0,48(sp)
    8000371c:	74a2                	ld	s1,40(sp)
    8000371e:	7902                	ld	s2,32(sp)
    80003720:	69e2                	ld	s3,24(sp)
    80003722:	6a42                	ld	s4,16(sp)
    80003724:	6aa2                	ld	s5,8(sp)
    80003726:	6121                	addi	sp,sp,64
    80003728:	8082                	ret
    panic("log.committing");
    8000372a:	00005517          	auipc	a0,0x5
    8000372e:	e8e50513          	addi	a0,a0,-370 # 800085b8 <syscalls+0x1e8>
    80003732:	00002097          	auipc	ra,0x2
    80003736:	750080e7          	jalr	1872(ra) # 80005e82 <panic>
    wakeup(&log);
    8000373a:	00010497          	auipc	s1,0x10
    8000373e:	5b648493          	addi	s1,s1,1462 # 80013cf0 <log>
    80003742:	8526                	mv	a0,s1
    80003744:	ffffe097          	auipc	ra,0xffffe
    80003748:	e1c080e7          	jalr	-484(ra) # 80001560 <wakeup>
  release(&log.lock);
    8000374c:	8526                	mv	a0,s1
    8000374e:	00003097          	auipc	ra,0x3
    80003752:	d32080e7          	jalr	-718(ra) # 80006480 <release>
  if(do_commit){
    80003756:	b7c9                	j	80003718 <end_op+0x7c>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003758:	00010a97          	auipc	s5,0x10
    8000375c:	5c8a8a93          	addi	s5,s5,1480 # 80013d20 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003760:	00010a17          	auipc	s4,0x10
    80003764:	590a0a13          	addi	s4,s4,1424 # 80013cf0 <log>
    80003768:	018a2583          	lw	a1,24(s4)
    8000376c:	012585bb          	addw	a1,a1,s2
    80003770:	2585                	addiw	a1,a1,1
    80003772:	028a2503          	lw	a0,40(s4)
    80003776:	fffff097          	auipc	ra,0xfffff
    8000377a:	b52080e7          	jalr	-1198(ra) # 800022c8 <bread>
    8000377e:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003780:	000aa583          	lw	a1,0(s5)
    80003784:	028a2503          	lw	a0,40(s4)
    80003788:	fffff097          	auipc	ra,0xfffff
    8000378c:	b40080e7          	jalr	-1216(ra) # 800022c8 <bread>
    80003790:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003792:	40000613          	li	a2,1024
    80003796:	05850593          	addi	a1,a0,88
    8000379a:	05848513          	addi	a0,s1,88
    8000379e:	ffffd097          	auipc	ra,0xffffd
    800037a2:	a3a080e7          	jalr	-1478(ra) # 800001d8 <memmove>
    bwrite(to);  // write the log
    800037a6:	8526                	mv	a0,s1
    800037a8:	fffff097          	auipc	ra,0xfffff
    800037ac:	c12080e7          	jalr	-1006(ra) # 800023ba <bwrite>
    brelse(from);
    800037b0:	854e                	mv	a0,s3
    800037b2:	fffff097          	auipc	ra,0xfffff
    800037b6:	c46080e7          	jalr	-954(ra) # 800023f8 <brelse>
    brelse(to);
    800037ba:	8526                	mv	a0,s1
    800037bc:	fffff097          	auipc	ra,0xfffff
    800037c0:	c3c080e7          	jalr	-964(ra) # 800023f8 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800037c4:	2905                	addiw	s2,s2,1
    800037c6:	0a91                	addi	s5,s5,4
    800037c8:	02ca2783          	lw	a5,44(s4)
    800037cc:	f8f94ee3          	blt	s2,a5,80003768 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800037d0:	00000097          	auipc	ra,0x0
    800037d4:	c6a080e7          	jalr	-918(ra) # 8000343a <write_head>
    install_trans(0); // Now install writes to home locations
    800037d8:	4501                	li	a0,0
    800037da:	00000097          	auipc	ra,0x0
    800037de:	cda080e7          	jalr	-806(ra) # 800034b4 <install_trans>
    log.lh.n = 0;
    800037e2:	00010797          	auipc	a5,0x10
    800037e6:	5207ad23          	sw	zero,1338(a5) # 80013d1c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800037ea:	00000097          	auipc	ra,0x0
    800037ee:	c50080e7          	jalr	-944(ra) # 8000343a <write_head>
    800037f2:	bdf5                	j	800036ee <end_op+0x52>

00000000800037f4 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800037f4:	1101                	addi	sp,sp,-32
    800037f6:	ec06                	sd	ra,24(sp)
    800037f8:	e822                	sd	s0,16(sp)
    800037fa:	e426                	sd	s1,8(sp)
    800037fc:	e04a                	sd	s2,0(sp)
    800037fe:	1000                	addi	s0,sp,32
    80003800:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80003802:	00010917          	auipc	s2,0x10
    80003806:	4ee90913          	addi	s2,s2,1262 # 80013cf0 <log>
    8000380a:	854a                	mv	a0,s2
    8000380c:	00003097          	auipc	ra,0x3
    80003810:	bc0080e7          	jalr	-1088(ra) # 800063cc <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003814:	02c92603          	lw	a2,44(s2)
    80003818:	47f5                	li	a5,29
    8000381a:	06c7c563          	blt	a5,a2,80003884 <log_write+0x90>
    8000381e:	00010797          	auipc	a5,0x10
    80003822:	4ee7a783          	lw	a5,1262(a5) # 80013d0c <log+0x1c>
    80003826:	37fd                	addiw	a5,a5,-1
    80003828:	04f65e63          	bge	a2,a5,80003884 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    8000382c:	00010797          	auipc	a5,0x10
    80003830:	4e47a783          	lw	a5,1252(a5) # 80013d10 <log+0x20>
    80003834:	06f05063          	blez	a5,80003894 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003838:	4781                	li	a5,0
    8000383a:	06c05563          	blez	a2,800038a4 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000383e:	44cc                	lw	a1,12(s1)
    80003840:	00010717          	auipc	a4,0x10
    80003844:	4e070713          	addi	a4,a4,1248 # 80013d20 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003848:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000384a:	4314                	lw	a3,0(a4)
    8000384c:	04b68c63          	beq	a3,a1,800038a4 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80003850:	2785                	addiw	a5,a5,1
    80003852:	0711                	addi	a4,a4,4
    80003854:	fef61be3          	bne	a2,a5,8000384a <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003858:	0621                	addi	a2,a2,8
    8000385a:	060a                	slli	a2,a2,0x2
    8000385c:	00010797          	auipc	a5,0x10
    80003860:	49478793          	addi	a5,a5,1172 # 80013cf0 <log>
    80003864:	963e                	add	a2,a2,a5
    80003866:	44dc                	lw	a5,12(s1)
    80003868:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000386a:	8526                	mv	a0,s1
    8000386c:	fffff097          	auipc	ra,0xfffff
    80003870:	c2a080e7          	jalr	-982(ra) # 80002496 <bpin>
    log.lh.n++;
    80003874:	00010717          	auipc	a4,0x10
    80003878:	47c70713          	addi	a4,a4,1148 # 80013cf0 <log>
    8000387c:	575c                	lw	a5,44(a4)
    8000387e:	2785                	addiw	a5,a5,1
    80003880:	d75c                	sw	a5,44(a4)
    80003882:	a835                	j	800038be <log_write+0xca>
    panic("too big a transaction");
    80003884:	00005517          	auipc	a0,0x5
    80003888:	d4450513          	addi	a0,a0,-700 # 800085c8 <syscalls+0x1f8>
    8000388c:	00002097          	auipc	ra,0x2
    80003890:	5f6080e7          	jalr	1526(ra) # 80005e82 <panic>
    panic("log_write outside of trans");
    80003894:	00005517          	auipc	a0,0x5
    80003898:	d4c50513          	addi	a0,a0,-692 # 800085e0 <syscalls+0x210>
    8000389c:	00002097          	auipc	ra,0x2
    800038a0:	5e6080e7          	jalr	1510(ra) # 80005e82 <panic>
  log.lh.block[i] = b->blockno;
    800038a4:	00878713          	addi	a4,a5,8
    800038a8:	00271693          	slli	a3,a4,0x2
    800038ac:	00010717          	auipc	a4,0x10
    800038b0:	44470713          	addi	a4,a4,1092 # 80013cf0 <log>
    800038b4:	9736                	add	a4,a4,a3
    800038b6:	44d4                	lw	a3,12(s1)
    800038b8:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800038ba:	faf608e3          	beq	a2,a5,8000386a <log_write+0x76>
  }
  release(&log.lock);
    800038be:	00010517          	auipc	a0,0x10
    800038c2:	43250513          	addi	a0,a0,1074 # 80013cf0 <log>
    800038c6:	00003097          	auipc	ra,0x3
    800038ca:	bba080e7          	jalr	-1094(ra) # 80006480 <release>
}
    800038ce:	60e2                	ld	ra,24(sp)
    800038d0:	6442                	ld	s0,16(sp)
    800038d2:	64a2                	ld	s1,8(sp)
    800038d4:	6902                	ld	s2,0(sp)
    800038d6:	6105                	addi	sp,sp,32
    800038d8:	8082                	ret

00000000800038da <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800038da:	1101                	addi	sp,sp,-32
    800038dc:	ec06                	sd	ra,24(sp)
    800038de:	e822                	sd	s0,16(sp)
    800038e0:	e426                	sd	s1,8(sp)
    800038e2:	e04a                	sd	s2,0(sp)
    800038e4:	1000                	addi	s0,sp,32
    800038e6:	84aa                	mv	s1,a0
    800038e8:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800038ea:	00005597          	auipc	a1,0x5
    800038ee:	d1658593          	addi	a1,a1,-746 # 80008600 <syscalls+0x230>
    800038f2:	0521                	addi	a0,a0,8
    800038f4:	00003097          	auipc	ra,0x3
    800038f8:	a48080e7          	jalr	-1464(ra) # 8000633c <initlock>
  lk->name = name;
    800038fc:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003900:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003904:	0204a423          	sw	zero,40(s1)
}
    80003908:	60e2                	ld	ra,24(sp)
    8000390a:	6442                	ld	s0,16(sp)
    8000390c:	64a2                	ld	s1,8(sp)
    8000390e:	6902                	ld	s2,0(sp)
    80003910:	6105                	addi	sp,sp,32
    80003912:	8082                	ret

0000000080003914 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003914:	1101                	addi	sp,sp,-32
    80003916:	ec06                	sd	ra,24(sp)
    80003918:	e822                	sd	s0,16(sp)
    8000391a:	e426                	sd	s1,8(sp)
    8000391c:	e04a                	sd	s2,0(sp)
    8000391e:	1000                	addi	s0,sp,32
    80003920:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003922:	00850913          	addi	s2,a0,8
    80003926:	854a                	mv	a0,s2
    80003928:	00003097          	auipc	ra,0x3
    8000392c:	aa4080e7          	jalr	-1372(ra) # 800063cc <acquire>
  while (lk->locked) {
    80003930:	409c                	lw	a5,0(s1)
    80003932:	cb89                	beqz	a5,80003944 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003934:	85ca                	mv	a1,s2
    80003936:	8526                	mv	a0,s1
    80003938:	ffffe097          	auipc	ra,0xffffe
    8000393c:	bc4080e7          	jalr	-1084(ra) # 800014fc <sleep>
  while (lk->locked) {
    80003940:	409c                	lw	a5,0(s1)
    80003942:	fbed                	bnez	a5,80003934 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003944:	4785                	li	a5,1
    80003946:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003948:	ffffd097          	auipc	ra,0xffffd
    8000394c:	510080e7          	jalr	1296(ra) # 80000e58 <myproc>
    80003950:	591c                	lw	a5,48(a0)
    80003952:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003954:	854a                	mv	a0,s2
    80003956:	00003097          	auipc	ra,0x3
    8000395a:	b2a080e7          	jalr	-1238(ra) # 80006480 <release>
}
    8000395e:	60e2                	ld	ra,24(sp)
    80003960:	6442                	ld	s0,16(sp)
    80003962:	64a2                	ld	s1,8(sp)
    80003964:	6902                	ld	s2,0(sp)
    80003966:	6105                	addi	sp,sp,32
    80003968:	8082                	ret

000000008000396a <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    8000396a:	1101                	addi	sp,sp,-32
    8000396c:	ec06                	sd	ra,24(sp)
    8000396e:	e822                	sd	s0,16(sp)
    80003970:	e426                	sd	s1,8(sp)
    80003972:	e04a                	sd	s2,0(sp)
    80003974:	1000                	addi	s0,sp,32
    80003976:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003978:	00850913          	addi	s2,a0,8
    8000397c:	854a                	mv	a0,s2
    8000397e:	00003097          	auipc	ra,0x3
    80003982:	a4e080e7          	jalr	-1458(ra) # 800063cc <acquire>
  lk->locked = 0;
    80003986:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000398a:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    8000398e:	8526                	mv	a0,s1
    80003990:	ffffe097          	auipc	ra,0xffffe
    80003994:	bd0080e7          	jalr	-1072(ra) # 80001560 <wakeup>
  release(&lk->lk);
    80003998:	854a                	mv	a0,s2
    8000399a:	00003097          	auipc	ra,0x3
    8000399e:	ae6080e7          	jalr	-1306(ra) # 80006480 <release>
}
    800039a2:	60e2                	ld	ra,24(sp)
    800039a4:	6442                	ld	s0,16(sp)
    800039a6:	64a2                	ld	s1,8(sp)
    800039a8:	6902                	ld	s2,0(sp)
    800039aa:	6105                	addi	sp,sp,32
    800039ac:	8082                	ret

00000000800039ae <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800039ae:	7179                	addi	sp,sp,-48
    800039b0:	f406                	sd	ra,40(sp)
    800039b2:	f022                	sd	s0,32(sp)
    800039b4:	ec26                	sd	s1,24(sp)
    800039b6:	e84a                	sd	s2,16(sp)
    800039b8:	e44e                	sd	s3,8(sp)
    800039ba:	1800                	addi	s0,sp,48
    800039bc:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800039be:	00850913          	addi	s2,a0,8
    800039c2:	854a                	mv	a0,s2
    800039c4:	00003097          	auipc	ra,0x3
    800039c8:	a08080e7          	jalr	-1528(ra) # 800063cc <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800039cc:	409c                	lw	a5,0(s1)
    800039ce:	ef99                	bnez	a5,800039ec <holdingsleep+0x3e>
    800039d0:	4481                	li	s1,0
  release(&lk->lk);
    800039d2:	854a                	mv	a0,s2
    800039d4:	00003097          	auipc	ra,0x3
    800039d8:	aac080e7          	jalr	-1364(ra) # 80006480 <release>
  return r;
}
    800039dc:	8526                	mv	a0,s1
    800039de:	70a2                	ld	ra,40(sp)
    800039e0:	7402                	ld	s0,32(sp)
    800039e2:	64e2                	ld	s1,24(sp)
    800039e4:	6942                	ld	s2,16(sp)
    800039e6:	69a2                	ld	s3,8(sp)
    800039e8:	6145                	addi	sp,sp,48
    800039ea:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    800039ec:	0284a983          	lw	s3,40(s1)
    800039f0:	ffffd097          	auipc	ra,0xffffd
    800039f4:	468080e7          	jalr	1128(ra) # 80000e58 <myproc>
    800039f8:	5904                	lw	s1,48(a0)
    800039fa:	413484b3          	sub	s1,s1,s3
    800039fe:	0014b493          	seqz	s1,s1
    80003a02:	bfc1                	j	800039d2 <holdingsleep+0x24>

0000000080003a04 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003a04:	1141                	addi	sp,sp,-16
    80003a06:	e406                	sd	ra,8(sp)
    80003a08:	e022                	sd	s0,0(sp)
    80003a0a:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003a0c:	00005597          	auipc	a1,0x5
    80003a10:	c0458593          	addi	a1,a1,-1020 # 80008610 <syscalls+0x240>
    80003a14:	00010517          	auipc	a0,0x10
    80003a18:	42450513          	addi	a0,a0,1060 # 80013e38 <ftable>
    80003a1c:	00003097          	auipc	ra,0x3
    80003a20:	920080e7          	jalr	-1760(ra) # 8000633c <initlock>
}
    80003a24:	60a2                	ld	ra,8(sp)
    80003a26:	6402                	ld	s0,0(sp)
    80003a28:	0141                	addi	sp,sp,16
    80003a2a:	8082                	ret

0000000080003a2c <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003a2c:	1101                	addi	sp,sp,-32
    80003a2e:	ec06                	sd	ra,24(sp)
    80003a30:	e822                	sd	s0,16(sp)
    80003a32:	e426                	sd	s1,8(sp)
    80003a34:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003a36:	00010517          	auipc	a0,0x10
    80003a3a:	40250513          	addi	a0,a0,1026 # 80013e38 <ftable>
    80003a3e:	00003097          	auipc	ra,0x3
    80003a42:	98e080e7          	jalr	-1650(ra) # 800063cc <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003a46:	00010497          	auipc	s1,0x10
    80003a4a:	40a48493          	addi	s1,s1,1034 # 80013e50 <ftable+0x18>
    80003a4e:	00011717          	auipc	a4,0x11
    80003a52:	3a270713          	addi	a4,a4,930 # 80014df0 <disk>
    if(f->ref == 0){
    80003a56:	40dc                	lw	a5,4(s1)
    80003a58:	cf99                	beqz	a5,80003a76 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003a5a:	02848493          	addi	s1,s1,40
    80003a5e:	fee49ce3          	bne	s1,a4,80003a56 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003a62:	00010517          	auipc	a0,0x10
    80003a66:	3d650513          	addi	a0,a0,982 # 80013e38 <ftable>
    80003a6a:	00003097          	auipc	ra,0x3
    80003a6e:	a16080e7          	jalr	-1514(ra) # 80006480 <release>
  return 0;
    80003a72:	4481                	li	s1,0
    80003a74:	a819                	j	80003a8a <filealloc+0x5e>
      f->ref = 1;
    80003a76:	4785                	li	a5,1
    80003a78:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003a7a:	00010517          	auipc	a0,0x10
    80003a7e:	3be50513          	addi	a0,a0,958 # 80013e38 <ftable>
    80003a82:	00003097          	auipc	ra,0x3
    80003a86:	9fe080e7          	jalr	-1538(ra) # 80006480 <release>
}
    80003a8a:	8526                	mv	a0,s1
    80003a8c:	60e2                	ld	ra,24(sp)
    80003a8e:	6442                	ld	s0,16(sp)
    80003a90:	64a2                	ld	s1,8(sp)
    80003a92:	6105                	addi	sp,sp,32
    80003a94:	8082                	ret

0000000080003a96 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003a96:	1101                	addi	sp,sp,-32
    80003a98:	ec06                	sd	ra,24(sp)
    80003a9a:	e822                	sd	s0,16(sp)
    80003a9c:	e426                	sd	s1,8(sp)
    80003a9e:	1000                	addi	s0,sp,32
    80003aa0:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003aa2:	00010517          	auipc	a0,0x10
    80003aa6:	39650513          	addi	a0,a0,918 # 80013e38 <ftable>
    80003aaa:	00003097          	auipc	ra,0x3
    80003aae:	922080e7          	jalr	-1758(ra) # 800063cc <acquire>
  if(f->ref < 1)
    80003ab2:	40dc                	lw	a5,4(s1)
    80003ab4:	02f05263          	blez	a5,80003ad8 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003ab8:	2785                	addiw	a5,a5,1
    80003aba:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003abc:	00010517          	auipc	a0,0x10
    80003ac0:	37c50513          	addi	a0,a0,892 # 80013e38 <ftable>
    80003ac4:	00003097          	auipc	ra,0x3
    80003ac8:	9bc080e7          	jalr	-1604(ra) # 80006480 <release>
  return f;
}
    80003acc:	8526                	mv	a0,s1
    80003ace:	60e2                	ld	ra,24(sp)
    80003ad0:	6442                	ld	s0,16(sp)
    80003ad2:	64a2                	ld	s1,8(sp)
    80003ad4:	6105                	addi	sp,sp,32
    80003ad6:	8082                	ret
    panic("filedup");
    80003ad8:	00005517          	auipc	a0,0x5
    80003adc:	b4050513          	addi	a0,a0,-1216 # 80008618 <syscalls+0x248>
    80003ae0:	00002097          	auipc	ra,0x2
    80003ae4:	3a2080e7          	jalr	930(ra) # 80005e82 <panic>

0000000080003ae8 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003ae8:	7139                	addi	sp,sp,-64
    80003aea:	fc06                	sd	ra,56(sp)
    80003aec:	f822                	sd	s0,48(sp)
    80003aee:	f426                	sd	s1,40(sp)
    80003af0:	f04a                	sd	s2,32(sp)
    80003af2:	ec4e                	sd	s3,24(sp)
    80003af4:	e852                	sd	s4,16(sp)
    80003af6:	e456                	sd	s5,8(sp)
    80003af8:	0080                	addi	s0,sp,64
    80003afa:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003afc:	00010517          	auipc	a0,0x10
    80003b00:	33c50513          	addi	a0,a0,828 # 80013e38 <ftable>
    80003b04:	00003097          	auipc	ra,0x3
    80003b08:	8c8080e7          	jalr	-1848(ra) # 800063cc <acquire>
  if(f->ref < 1)
    80003b0c:	40dc                	lw	a5,4(s1)
    80003b0e:	06f05163          	blez	a5,80003b70 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003b12:	37fd                	addiw	a5,a5,-1
    80003b14:	0007871b          	sext.w	a4,a5
    80003b18:	c0dc                	sw	a5,4(s1)
    80003b1a:	06e04363          	bgtz	a4,80003b80 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003b1e:	0004a903          	lw	s2,0(s1)
    80003b22:	0094ca83          	lbu	s5,9(s1)
    80003b26:	0104ba03          	ld	s4,16(s1)
    80003b2a:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003b2e:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003b32:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003b36:	00010517          	auipc	a0,0x10
    80003b3a:	30250513          	addi	a0,a0,770 # 80013e38 <ftable>
    80003b3e:	00003097          	auipc	ra,0x3
    80003b42:	942080e7          	jalr	-1726(ra) # 80006480 <release>

  if(ff.type == FD_PIPE){
    80003b46:	4785                	li	a5,1
    80003b48:	04f90d63          	beq	s2,a5,80003ba2 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003b4c:	3979                	addiw	s2,s2,-2
    80003b4e:	4785                	li	a5,1
    80003b50:	0527e063          	bltu	a5,s2,80003b90 <fileclose+0xa8>
    begin_op();
    80003b54:	00000097          	auipc	ra,0x0
    80003b58:	ac8080e7          	jalr	-1336(ra) # 8000361c <begin_op>
    iput(ff.ip);
    80003b5c:	854e                	mv	a0,s3
    80003b5e:	fffff097          	auipc	ra,0xfffff
    80003b62:	2b4080e7          	jalr	692(ra) # 80002e12 <iput>
    end_op();
    80003b66:	00000097          	auipc	ra,0x0
    80003b6a:	b36080e7          	jalr	-1226(ra) # 8000369c <end_op>
    80003b6e:	a00d                	j	80003b90 <fileclose+0xa8>
    panic("fileclose");
    80003b70:	00005517          	auipc	a0,0x5
    80003b74:	ab050513          	addi	a0,a0,-1360 # 80008620 <syscalls+0x250>
    80003b78:	00002097          	auipc	ra,0x2
    80003b7c:	30a080e7          	jalr	778(ra) # 80005e82 <panic>
    release(&ftable.lock);
    80003b80:	00010517          	auipc	a0,0x10
    80003b84:	2b850513          	addi	a0,a0,696 # 80013e38 <ftable>
    80003b88:	00003097          	auipc	ra,0x3
    80003b8c:	8f8080e7          	jalr	-1800(ra) # 80006480 <release>
  }
}
    80003b90:	70e2                	ld	ra,56(sp)
    80003b92:	7442                	ld	s0,48(sp)
    80003b94:	74a2                	ld	s1,40(sp)
    80003b96:	7902                	ld	s2,32(sp)
    80003b98:	69e2                	ld	s3,24(sp)
    80003b9a:	6a42                	ld	s4,16(sp)
    80003b9c:	6aa2                	ld	s5,8(sp)
    80003b9e:	6121                	addi	sp,sp,64
    80003ba0:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003ba2:	85d6                	mv	a1,s5
    80003ba4:	8552                	mv	a0,s4
    80003ba6:	00000097          	auipc	ra,0x0
    80003baa:	34c080e7          	jalr	844(ra) # 80003ef2 <pipeclose>
    80003bae:	b7cd                	j	80003b90 <fileclose+0xa8>

0000000080003bb0 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003bb0:	715d                	addi	sp,sp,-80
    80003bb2:	e486                	sd	ra,72(sp)
    80003bb4:	e0a2                	sd	s0,64(sp)
    80003bb6:	fc26                	sd	s1,56(sp)
    80003bb8:	f84a                	sd	s2,48(sp)
    80003bba:	f44e                	sd	s3,40(sp)
    80003bbc:	0880                	addi	s0,sp,80
    80003bbe:	84aa                	mv	s1,a0
    80003bc0:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003bc2:	ffffd097          	auipc	ra,0xffffd
    80003bc6:	296080e7          	jalr	662(ra) # 80000e58 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003bca:	409c                	lw	a5,0(s1)
    80003bcc:	37f9                	addiw	a5,a5,-2
    80003bce:	4705                	li	a4,1
    80003bd0:	04f76763          	bltu	a4,a5,80003c1e <filestat+0x6e>
    80003bd4:	892a                	mv	s2,a0
    ilock(f->ip);
    80003bd6:	6c88                	ld	a0,24(s1)
    80003bd8:	fffff097          	auipc	ra,0xfffff
    80003bdc:	fda080e7          	jalr	-38(ra) # 80002bb2 <ilock>
    stati(f->ip, &st);
    80003be0:	fb840593          	addi	a1,s0,-72
    80003be4:	6c88                	ld	a0,24(s1)
    80003be6:	fffff097          	auipc	ra,0xfffff
    80003bea:	2fc080e7          	jalr	764(ra) # 80002ee2 <stati>
    iunlock(f->ip);
    80003bee:	6c88                	ld	a0,24(s1)
    80003bf0:	fffff097          	auipc	ra,0xfffff
    80003bf4:	084080e7          	jalr	132(ra) # 80002c74 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003bf8:	46e1                	li	a3,24
    80003bfa:	fb840613          	addi	a2,s0,-72
    80003bfe:	85ce                	mv	a1,s3
    80003c00:	05093503          	ld	a0,80(s2)
    80003c04:	ffffd097          	auipc	ra,0xffffd
    80003c08:	f12080e7          	jalr	-238(ra) # 80000b16 <copyout>
    80003c0c:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003c10:	60a6                	ld	ra,72(sp)
    80003c12:	6406                	ld	s0,64(sp)
    80003c14:	74e2                	ld	s1,56(sp)
    80003c16:	7942                	ld	s2,48(sp)
    80003c18:	79a2                	ld	s3,40(sp)
    80003c1a:	6161                	addi	sp,sp,80
    80003c1c:	8082                	ret
  return -1;
    80003c1e:	557d                	li	a0,-1
    80003c20:	bfc5                	j	80003c10 <filestat+0x60>

0000000080003c22 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003c22:	7179                	addi	sp,sp,-48
    80003c24:	f406                	sd	ra,40(sp)
    80003c26:	f022                	sd	s0,32(sp)
    80003c28:	ec26                	sd	s1,24(sp)
    80003c2a:	e84a                	sd	s2,16(sp)
    80003c2c:	e44e                	sd	s3,8(sp)
    80003c2e:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003c30:	00854783          	lbu	a5,8(a0)
    80003c34:	c3d5                	beqz	a5,80003cd8 <fileread+0xb6>
    80003c36:	84aa                	mv	s1,a0
    80003c38:	89ae                	mv	s3,a1
    80003c3a:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003c3c:	411c                	lw	a5,0(a0)
    80003c3e:	4705                	li	a4,1
    80003c40:	04e78963          	beq	a5,a4,80003c92 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003c44:	470d                	li	a4,3
    80003c46:	04e78d63          	beq	a5,a4,80003ca0 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003c4a:	4709                	li	a4,2
    80003c4c:	06e79e63          	bne	a5,a4,80003cc8 <fileread+0xa6>
    ilock(f->ip);
    80003c50:	6d08                	ld	a0,24(a0)
    80003c52:	fffff097          	auipc	ra,0xfffff
    80003c56:	f60080e7          	jalr	-160(ra) # 80002bb2 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003c5a:	874a                	mv	a4,s2
    80003c5c:	5094                	lw	a3,32(s1)
    80003c5e:	864e                	mv	a2,s3
    80003c60:	4585                	li	a1,1
    80003c62:	6c88                	ld	a0,24(s1)
    80003c64:	fffff097          	auipc	ra,0xfffff
    80003c68:	2a8080e7          	jalr	680(ra) # 80002f0c <readi>
    80003c6c:	892a                	mv	s2,a0
    80003c6e:	00a05563          	blez	a0,80003c78 <fileread+0x56>
      f->off += r;
    80003c72:	509c                	lw	a5,32(s1)
    80003c74:	9fa9                	addw	a5,a5,a0
    80003c76:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003c78:	6c88                	ld	a0,24(s1)
    80003c7a:	fffff097          	auipc	ra,0xfffff
    80003c7e:	ffa080e7          	jalr	-6(ra) # 80002c74 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003c82:	854a                	mv	a0,s2
    80003c84:	70a2                	ld	ra,40(sp)
    80003c86:	7402                	ld	s0,32(sp)
    80003c88:	64e2                	ld	s1,24(sp)
    80003c8a:	6942                	ld	s2,16(sp)
    80003c8c:	69a2                	ld	s3,8(sp)
    80003c8e:	6145                	addi	sp,sp,48
    80003c90:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003c92:	6908                	ld	a0,16(a0)
    80003c94:	00000097          	auipc	ra,0x0
    80003c98:	3ce080e7          	jalr	974(ra) # 80004062 <piperead>
    80003c9c:	892a                	mv	s2,a0
    80003c9e:	b7d5                	j	80003c82 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003ca0:	02451783          	lh	a5,36(a0)
    80003ca4:	03079693          	slli	a3,a5,0x30
    80003ca8:	92c1                	srli	a3,a3,0x30
    80003caa:	4725                	li	a4,9
    80003cac:	02d76863          	bltu	a4,a3,80003cdc <fileread+0xba>
    80003cb0:	0792                	slli	a5,a5,0x4
    80003cb2:	00010717          	auipc	a4,0x10
    80003cb6:	0e670713          	addi	a4,a4,230 # 80013d98 <devsw>
    80003cba:	97ba                	add	a5,a5,a4
    80003cbc:	639c                	ld	a5,0(a5)
    80003cbe:	c38d                	beqz	a5,80003ce0 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003cc0:	4505                	li	a0,1
    80003cc2:	9782                	jalr	a5
    80003cc4:	892a                	mv	s2,a0
    80003cc6:	bf75                	j	80003c82 <fileread+0x60>
    panic("fileread");
    80003cc8:	00005517          	auipc	a0,0x5
    80003ccc:	96850513          	addi	a0,a0,-1688 # 80008630 <syscalls+0x260>
    80003cd0:	00002097          	auipc	ra,0x2
    80003cd4:	1b2080e7          	jalr	434(ra) # 80005e82 <panic>
    return -1;
    80003cd8:	597d                	li	s2,-1
    80003cda:	b765                	j	80003c82 <fileread+0x60>
      return -1;
    80003cdc:	597d                	li	s2,-1
    80003cde:	b755                	j	80003c82 <fileread+0x60>
    80003ce0:	597d                	li	s2,-1
    80003ce2:	b745                	j	80003c82 <fileread+0x60>

0000000080003ce4 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80003ce4:	715d                	addi	sp,sp,-80
    80003ce6:	e486                	sd	ra,72(sp)
    80003ce8:	e0a2                	sd	s0,64(sp)
    80003cea:	fc26                	sd	s1,56(sp)
    80003cec:	f84a                	sd	s2,48(sp)
    80003cee:	f44e                	sd	s3,40(sp)
    80003cf0:	f052                	sd	s4,32(sp)
    80003cf2:	ec56                	sd	s5,24(sp)
    80003cf4:	e85a                	sd	s6,16(sp)
    80003cf6:	e45e                	sd	s7,8(sp)
    80003cf8:	e062                	sd	s8,0(sp)
    80003cfa:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80003cfc:	00954783          	lbu	a5,9(a0)
    80003d00:	10078663          	beqz	a5,80003e0c <filewrite+0x128>
    80003d04:	892a                	mv	s2,a0
    80003d06:	8aae                	mv	s5,a1
    80003d08:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80003d0a:	411c                	lw	a5,0(a0)
    80003d0c:	4705                	li	a4,1
    80003d0e:	02e78263          	beq	a5,a4,80003d32 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003d12:	470d                	li	a4,3
    80003d14:	02e78663          	beq	a5,a4,80003d40 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003d18:	4709                	li	a4,2
    80003d1a:	0ee79163          	bne	a5,a4,80003dfc <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003d1e:	0ac05d63          	blez	a2,80003dd8 <filewrite+0xf4>
    int i = 0;
    80003d22:	4981                	li	s3,0
    80003d24:	6b05                	lui	s6,0x1
    80003d26:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80003d2a:	6b85                	lui	s7,0x1
    80003d2c:	c00b8b9b          	addiw	s7,s7,-1024
    80003d30:	a861                	j	80003dc8 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80003d32:	6908                	ld	a0,16(a0)
    80003d34:	00000097          	auipc	ra,0x0
    80003d38:	22e080e7          	jalr	558(ra) # 80003f62 <pipewrite>
    80003d3c:	8a2a                	mv	s4,a0
    80003d3e:	a045                	j	80003dde <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003d40:	02451783          	lh	a5,36(a0)
    80003d44:	03079693          	slli	a3,a5,0x30
    80003d48:	92c1                	srli	a3,a3,0x30
    80003d4a:	4725                	li	a4,9
    80003d4c:	0cd76263          	bltu	a4,a3,80003e10 <filewrite+0x12c>
    80003d50:	0792                	slli	a5,a5,0x4
    80003d52:	00010717          	auipc	a4,0x10
    80003d56:	04670713          	addi	a4,a4,70 # 80013d98 <devsw>
    80003d5a:	97ba                	add	a5,a5,a4
    80003d5c:	679c                	ld	a5,8(a5)
    80003d5e:	cbdd                	beqz	a5,80003e14 <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80003d60:	4505                	li	a0,1
    80003d62:	9782                	jalr	a5
    80003d64:	8a2a                	mv	s4,a0
    80003d66:	a8a5                	j	80003dde <filewrite+0xfa>
    80003d68:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80003d6c:	00000097          	auipc	ra,0x0
    80003d70:	8b0080e7          	jalr	-1872(ra) # 8000361c <begin_op>
      ilock(f->ip);
    80003d74:	01893503          	ld	a0,24(s2)
    80003d78:	fffff097          	auipc	ra,0xfffff
    80003d7c:	e3a080e7          	jalr	-454(ra) # 80002bb2 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003d80:	8762                	mv	a4,s8
    80003d82:	02092683          	lw	a3,32(s2)
    80003d86:	01598633          	add	a2,s3,s5
    80003d8a:	4585                	li	a1,1
    80003d8c:	01893503          	ld	a0,24(s2)
    80003d90:	fffff097          	auipc	ra,0xfffff
    80003d94:	274080e7          	jalr	628(ra) # 80003004 <writei>
    80003d98:	84aa                	mv	s1,a0
    80003d9a:	00a05763          	blez	a0,80003da8 <filewrite+0xc4>
        f->off += r;
    80003d9e:	02092783          	lw	a5,32(s2)
    80003da2:	9fa9                	addw	a5,a5,a0
    80003da4:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003da8:	01893503          	ld	a0,24(s2)
    80003dac:	fffff097          	auipc	ra,0xfffff
    80003db0:	ec8080e7          	jalr	-312(ra) # 80002c74 <iunlock>
      end_op();
    80003db4:	00000097          	auipc	ra,0x0
    80003db8:	8e8080e7          	jalr	-1816(ra) # 8000369c <end_op>

      if(r != n1){
    80003dbc:	009c1f63          	bne	s8,s1,80003dda <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80003dc0:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003dc4:	0149db63          	bge	s3,s4,80003dda <filewrite+0xf6>
      int n1 = n - i;
    80003dc8:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80003dcc:	84be                	mv	s1,a5
    80003dce:	2781                	sext.w	a5,a5
    80003dd0:	f8fb5ce3          	bge	s6,a5,80003d68 <filewrite+0x84>
    80003dd4:	84de                	mv	s1,s7
    80003dd6:	bf49                	j	80003d68 <filewrite+0x84>
    int i = 0;
    80003dd8:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80003dda:	013a1f63          	bne	s4,s3,80003df8 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003dde:	8552                	mv	a0,s4
    80003de0:	60a6                	ld	ra,72(sp)
    80003de2:	6406                	ld	s0,64(sp)
    80003de4:	74e2                	ld	s1,56(sp)
    80003de6:	7942                	ld	s2,48(sp)
    80003de8:	79a2                	ld	s3,40(sp)
    80003dea:	7a02                	ld	s4,32(sp)
    80003dec:	6ae2                	ld	s5,24(sp)
    80003dee:	6b42                	ld	s6,16(sp)
    80003df0:	6ba2                	ld	s7,8(sp)
    80003df2:	6c02                	ld	s8,0(sp)
    80003df4:	6161                	addi	sp,sp,80
    80003df6:	8082                	ret
    ret = (i == n ? n : -1);
    80003df8:	5a7d                	li	s4,-1
    80003dfa:	b7d5                	j	80003dde <filewrite+0xfa>
    panic("filewrite");
    80003dfc:	00005517          	auipc	a0,0x5
    80003e00:	84450513          	addi	a0,a0,-1980 # 80008640 <syscalls+0x270>
    80003e04:	00002097          	auipc	ra,0x2
    80003e08:	07e080e7          	jalr	126(ra) # 80005e82 <panic>
    return -1;
    80003e0c:	5a7d                	li	s4,-1
    80003e0e:	bfc1                	j	80003dde <filewrite+0xfa>
      return -1;
    80003e10:	5a7d                	li	s4,-1
    80003e12:	b7f1                	j	80003dde <filewrite+0xfa>
    80003e14:	5a7d                	li	s4,-1
    80003e16:	b7e1                	j	80003dde <filewrite+0xfa>

0000000080003e18 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003e18:	7179                	addi	sp,sp,-48
    80003e1a:	f406                	sd	ra,40(sp)
    80003e1c:	f022                	sd	s0,32(sp)
    80003e1e:	ec26                	sd	s1,24(sp)
    80003e20:	e84a                	sd	s2,16(sp)
    80003e22:	e44e                	sd	s3,8(sp)
    80003e24:	e052                	sd	s4,0(sp)
    80003e26:	1800                	addi	s0,sp,48
    80003e28:	84aa                	mv	s1,a0
    80003e2a:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003e2c:	0005b023          	sd	zero,0(a1)
    80003e30:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003e34:	00000097          	auipc	ra,0x0
    80003e38:	bf8080e7          	jalr	-1032(ra) # 80003a2c <filealloc>
    80003e3c:	e088                	sd	a0,0(s1)
    80003e3e:	c551                	beqz	a0,80003eca <pipealloc+0xb2>
    80003e40:	00000097          	auipc	ra,0x0
    80003e44:	bec080e7          	jalr	-1044(ra) # 80003a2c <filealloc>
    80003e48:	00aa3023          	sd	a0,0(s4)
    80003e4c:	c92d                	beqz	a0,80003ebe <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003e4e:	ffffc097          	auipc	ra,0xffffc
    80003e52:	2ca080e7          	jalr	714(ra) # 80000118 <kalloc>
    80003e56:	892a                	mv	s2,a0
    80003e58:	c125                	beqz	a0,80003eb8 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003e5a:	4985                	li	s3,1
    80003e5c:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003e60:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003e64:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003e68:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003e6c:	00004597          	auipc	a1,0x4
    80003e70:	7e458593          	addi	a1,a1,2020 # 80008650 <syscalls+0x280>
    80003e74:	00002097          	auipc	ra,0x2
    80003e78:	4c8080e7          	jalr	1224(ra) # 8000633c <initlock>
  (*f0)->type = FD_PIPE;
    80003e7c:	609c                	ld	a5,0(s1)
    80003e7e:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003e82:	609c                	ld	a5,0(s1)
    80003e84:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003e88:	609c                	ld	a5,0(s1)
    80003e8a:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003e8e:	609c                	ld	a5,0(s1)
    80003e90:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003e94:	000a3783          	ld	a5,0(s4)
    80003e98:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003e9c:	000a3783          	ld	a5,0(s4)
    80003ea0:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003ea4:	000a3783          	ld	a5,0(s4)
    80003ea8:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003eac:	000a3783          	ld	a5,0(s4)
    80003eb0:	0127b823          	sd	s2,16(a5)
  return 0;
    80003eb4:	4501                	li	a0,0
    80003eb6:	a025                	j	80003ede <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003eb8:	6088                	ld	a0,0(s1)
    80003eba:	e501                	bnez	a0,80003ec2 <pipealloc+0xaa>
    80003ebc:	a039                	j	80003eca <pipealloc+0xb2>
    80003ebe:	6088                	ld	a0,0(s1)
    80003ec0:	c51d                	beqz	a0,80003eee <pipealloc+0xd6>
    fileclose(*f0);
    80003ec2:	00000097          	auipc	ra,0x0
    80003ec6:	c26080e7          	jalr	-986(ra) # 80003ae8 <fileclose>
  if(*f1)
    80003eca:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003ece:	557d                	li	a0,-1
  if(*f1)
    80003ed0:	c799                	beqz	a5,80003ede <pipealloc+0xc6>
    fileclose(*f1);
    80003ed2:	853e                	mv	a0,a5
    80003ed4:	00000097          	auipc	ra,0x0
    80003ed8:	c14080e7          	jalr	-1004(ra) # 80003ae8 <fileclose>
  return -1;
    80003edc:	557d                	li	a0,-1
}
    80003ede:	70a2                	ld	ra,40(sp)
    80003ee0:	7402                	ld	s0,32(sp)
    80003ee2:	64e2                	ld	s1,24(sp)
    80003ee4:	6942                	ld	s2,16(sp)
    80003ee6:	69a2                	ld	s3,8(sp)
    80003ee8:	6a02                	ld	s4,0(sp)
    80003eea:	6145                	addi	sp,sp,48
    80003eec:	8082                	ret
  return -1;
    80003eee:	557d                	li	a0,-1
    80003ef0:	b7fd                	j	80003ede <pipealloc+0xc6>

0000000080003ef2 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003ef2:	1101                	addi	sp,sp,-32
    80003ef4:	ec06                	sd	ra,24(sp)
    80003ef6:	e822                	sd	s0,16(sp)
    80003ef8:	e426                	sd	s1,8(sp)
    80003efa:	e04a                	sd	s2,0(sp)
    80003efc:	1000                	addi	s0,sp,32
    80003efe:	84aa                	mv	s1,a0
    80003f00:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003f02:	00002097          	auipc	ra,0x2
    80003f06:	4ca080e7          	jalr	1226(ra) # 800063cc <acquire>
  if(writable){
    80003f0a:	02090d63          	beqz	s2,80003f44 <pipeclose+0x52>
    pi->writeopen = 0;
    80003f0e:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003f12:	21848513          	addi	a0,s1,536
    80003f16:	ffffd097          	auipc	ra,0xffffd
    80003f1a:	64a080e7          	jalr	1610(ra) # 80001560 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003f1e:	2204b783          	ld	a5,544(s1)
    80003f22:	eb95                	bnez	a5,80003f56 <pipeclose+0x64>
    release(&pi->lock);
    80003f24:	8526                	mv	a0,s1
    80003f26:	00002097          	auipc	ra,0x2
    80003f2a:	55a080e7          	jalr	1370(ra) # 80006480 <release>
    kfree((char*)pi);
    80003f2e:	8526                	mv	a0,s1
    80003f30:	ffffc097          	auipc	ra,0xffffc
    80003f34:	0ec080e7          	jalr	236(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80003f38:	60e2                	ld	ra,24(sp)
    80003f3a:	6442                	ld	s0,16(sp)
    80003f3c:	64a2                	ld	s1,8(sp)
    80003f3e:	6902                	ld	s2,0(sp)
    80003f40:	6105                	addi	sp,sp,32
    80003f42:	8082                	ret
    pi->readopen = 0;
    80003f44:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003f48:	21c48513          	addi	a0,s1,540
    80003f4c:	ffffd097          	auipc	ra,0xffffd
    80003f50:	614080e7          	jalr	1556(ra) # 80001560 <wakeup>
    80003f54:	b7e9                	j	80003f1e <pipeclose+0x2c>
    release(&pi->lock);
    80003f56:	8526                	mv	a0,s1
    80003f58:	00002097          	auipc	ra,0x2
    80003f5c:	528080e7          	jalr	1320(ra) # 80006480 <release>
}
    80003f60:	bfe1                	j	80003f38 <pipeclose+0x46>

0000000080003f62 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003f62:	7159                	addi	sp,sp,-112
    80003f64:	f486                	sd	ra,104(sp)
    80003f66:	f0a2                	sd	s0,96(sp)
    80003f68:	eca6                	sd	s1,88(sp)
    80003f6a:	e8ca                	sd	s2,80(sp)
    80003f6c:	e4ce                	sd	s3,72(sp)
    80003f6e:	e0d2                	sd	s4,64(sp)
    80003f70:	fc56                	sd	s5,56(sp)
    80003f72:	f85a                	sd	s6,48(sp)
    80003f74:	f45e                	sd	s7,40(sp)
    80003f76:	f062                	sd	s8,32(sp)
    80003f78:	ec66                	sd	s9,24(sp)
    80003f7a:	1880                	addi	s0,sp,112
    80003f7c:	84aa                	mv	s1,a0
    80003f7e:	8aae                	mv	s5,a1
    80003f80:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003f82:	ffffd097          	auipc	ra,0xffffd
    80003f86:	ed6080e7          	jalr	-298(ra) # 80000e58 <myproc>
    80003f8a:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003f8c:	8526                	mv	a0,s1
    80003f8e:	00002097          	auipc	ra,0x2
    80003f92:	43e080e7          	jalr	1086(ra) # 800063cc <acquire>
  while(i < n){
    80003f96:	0d405463          	blez	s4,8000405e <pipewrite+0xfc>
    80003f9a:	8ba6                	mv	s7,s1
  int i = 0;
    80003f9c:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003f9e:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003fa0:	21848c93          	addi	s9,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003fa4:	21c48c13          	addi	s8,s1,540
    80003fa8:	a08d                	j	8000400a <pipewrite+0xa8>
      release(&pi->lock);
    80003faa:	8526                	mv	a0,s1
    80003fac:	00002097          	auipc	ra,0x2
    80003fb0:	4d4080e7          	jalr	1236(ra) # 80006480 <release>
      return -1;
    80003fb4:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003fb6:	854a                	mv	a0,s2
    80003fb8:	70a6                	ld	ra,104(sp)
    80003fba:	7406                	ld	s0,96(sp)
    80003fbc:	64e6                	ld	s1,88(sp)
    80003fbe:	6946                	ld	s2,80(sp)
    80003fc0:	69a6                	ld	s3,72(sp)
    80003fc2:	6a06                	ld	s4,64(sp)
    80003fc4:	7ae2                	ld	s5,56(sp)
    80003fc6:	7b42                	ld	s6,48(sp)
    80003fc8:	7ba2                	ld	s7,40(sp)
    80003fca:	7c02                	ld	s8,32(sp)
    80003fcc:	6ce2                	ld	s9,24(sp)
    80003fce:	6165                	addi	sp,sp,112
    80003fd0:	8082                	ret
      wakeup(&pi->nread);
    80003fd2:	8566                	mv	a0,s9
    80003fd4:	ffffd097          	auipc	ra,0xffffd
    80003fd8:	58c080e7          	jalr	1420(ra) # 80001560 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003fdc:	85de                	mv	a1,s7
    80003fde:	8562                	mv	a0,s8
    80003fe0:	ffffd097          	auipc	ra,0xffffd
    80003fe4:	51c080e7          	jalr	1308(ra) # 800014fc <sleep>
    80003fe8:	a839                	j	80004006 <pipewrite+0xa4>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003fea:	21c4a783          	lw	a5,540(s1)
    80003fee:	0017871b          	addiw	a4,a5,1
    80003ff2:	20e4ae23          	sw	a4,540(s1)
    80003ff6:	1ff7f793          	andi	a5,a5,511
    80003ffa:	97a6                	add	a5,a5,s1
    80003ffc:	f9f44703          	lbu	a4,-97(s0)
    80004000:	00e78c23          	sb	a4,24(a5)
      i++;
    80004004:	2905                	addiw	s2,s2,1
  while(i < n){
    80004006:	05495063          	bge	s2,s4,80004046 <pipewrite+0xe4>
    if(pi->readopen == 0 || killed(pr)){
    8000400a:	2204a783          	lw	a5,544(s1)
    8000400e:	dfd1                	beqz	a5,80003faa <pipewrite+0x48>
    80004010:	854e                	mv	a0,s3
    80004012:	ffffd097          	auipc	ra,0xffffd
    80004016:	792080e7          	jalr	1938(ra) # 800017a4 <killed>
    8000401a:	f941                	bnez	a0,80003faa <pipewrite+0x48>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    8000401c:	2184a783          	lw	a5,536(s1)
    80004020:	21c4a703          	lw	a4,540(s1)
    80004024:	2007879b          	addiw	a5,a5,512
    80004028:	faf705e3          	beq	a4,a5,80003fd2 <pipewrite+0x70>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000402c:	4685                	li	a3,1
    8000402e:	01590633          	add	a2,s2,s5
    80004032:	f9f40593          	addi	a1,s0,-97
    80004036:	0509b503          	ld	a0,80(s3)
    8000403a:	ffffd097          	auipc	ra,0xffffd
    8000403e:	b68080e7          	jalr	-1176(ra) # 80000ba2 <copyin>
    80004042:	fb6514e3          	bne	a0,s6,80003fea <pipewrite+0x88>
  wakeup(&pi->nread);
    80004046:	21848513          	addi	a0,s1,536
    8000404a:	ffffd097          	auipc	ra,0xffffd
    8000404e:	516080e7          	jalr	1302(ra) # 80001560 <wakeup>
  release(&pi->lock);
    80004052:	8526                	mv	a0,s1
    80004054:	00002097          	auipc	ra,0x2
    80004058:	42c080e7          	jalr	1068(ra) # 80006480 <release>
  return i;
    8000405c:	bfa9                	j	80003fb6 <pipewrite+0x54>
  int i = 0;
    8000405e:	4901                	li	s2,0
    80004060:	b7dd                	j	80004046 <pipewrite+0xe4>

0000000080004062 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004062:	715d                	addi	sp,sp,-80
    80004064:	e486                	sd	ra,72(sp)
    80004066:	e0a2                	sd	s0,64(sp)
    80004068:	fc26                	sd	s1,56(sp)
    8000406a:	f84a                	sd	s2,48(sp)
    8000406c:	f44e                	sd	s3,40(sp)
    8000406e:	f052                	sd	s4,32(sp)
    80004070:	ec56                	sd	s5,24(sp)
    80004072:	e85a                	sd	s6,16(sp)
    80004074:	0880                	addi	s0,sp,80
    80004076:	84aa                	mv	s1,a0
    80004078:	892e                	mv	s2,a1
    8000407a:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    8000407c:	ffffd097          	auipc	ra,0xffffd
    80004080:	ddc080e7          	jalr	-548(ra) # 80000e58 <myproc>
    80004084:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004086:	8b26                	mv	s6,s1
    80004088:	8526                	mv	a0,s1
    8000408a:	00002097          	auipc	ra,0x2
    8000408e:	342080e7          	jalr	834(ra) # 800063cc <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004092:	2184a703          	lw	a4,536(s1)
    80004096:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    8000409a:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000409e:	02f71763          	bne	a4,a5,800040cc <piperead+0x6a>
    800040a2:	2244a783          	lw	a5,548(s1)
    800040a6:	c39d                	beqz	a5,800040cc <piperead+0x6a>
    if(killed(pr)){
    800040a8:	8552                	mv	a0,s4
    800040aa:	ffffd097          	auipc	ra,0xffffd
    800040ae:	6fa080e7          	jalr	1786(ra) # 800017a4 <killed>
    800040b2:	e941                	bnez	a0,80004142 <piperead+0xe0>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800040b4:	85da                	mv	a1,s6
    800040b6:	854e                	mv	a0,s3
    800040b8:	ffffd097          	auipc	ra,0xffffd
    800040bc:	444080e7          	jalr	1092(ra) # 800014fc <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800040c0:	2184a703          	lw	a4,536(s1)
    800040c4:	21c4a783          	lw	a5,540(s1)
    800040c8:	fcf70de3          	beq	a4,a5,800040a2 <piperead+0x40>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800040cc:	09505263          	blez	s5,80004150 <piperead+0xee>
    800040d0:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800040d2:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    800040d4:	2184a783          	lw	a5,536(s1)
    800040d8:	21c4a703          	lw	a4,540(s1)
    800040dc:	02f70d63          	beq	a4,a5,80004116 <piperead+0xb4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    800040e0:	0017871b          	addiw	a4,a5,1
    800040e4:	20e4ac23          	sw	a4,536(s1)
    800040e8:	1ff7f793          	andi	a5,a5,511
    800040ec:	97a6                	add	a5,a5,s1
    800040ee:	0187c783          	lbu	a5,24(a5)
    800040f2:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800040f6:	4685                	li	a3,1
    800040f8:	fbf40613          	addi	a2,s0,-65
    800040fc:	85ca                	mv	a1,s2
    800040fe:	050a3503          	ld	a0,80(s4)
    80004102:	ffffd097          	auipc	ra,0xffffd
    80004106:	a14080e7          	jalr	-1516(ra) # 80000b16 <copyout>
    8000410a:	01650663          	beq	a0,s6,80004116 <piperead+0xb4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000410e:	2985                	addiw	s3,s3,1
    80004110:	0905                	addi	s2,s2,1
    80004112:	fd3a91e3          	bne	s5,s3,800040d4 <piperead+0x72>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004116:	21c48513          	addi	a0,s1,540
    8000411a:	ffffd097          	auipc	ra,0xffffd
    8000411e:	446080e7          	jalr	1094(ra) # 80001560 <wakeup>
  release(&pi->lock);
    80004122:	8526                	mv	a0,s1
    80004124:	00002097          	auipc	ra,0x2
    80004128:	35c080e7          	jalr	860(ra) # 80006480 <release>
  return i;
}
    8000412c:	854e                	mv	a0,s3
    8000412e:	60a6                	ld	ra,72(sp)
    80004130:	6406                	ld	s0,64(sp)
    80004132:	74e2                	ld	s1,56(sp)
    80004134:	7942                	ld	s2,48(sp)
    80004136:	79a2                	ld	s3,40(sp)
    80004138:	7a02                	ld	s4,32(sp)
    8000413a:	6ae2                	ld	s5,24(sp)
    8000413c:	6b42                	ld	s6,16(sp)
    8000413e:	6161                	addi	sp,sp,80
    80004140:	8082                	ret
      release(&pi->lock);
    80004142:	8526                	mv	a0,s1
    80004144:	00002097          	auipc	ra,0x2
    80004148:	33c080e7          	jalr	828(ra) # 80006480 <release>
      return -1;
    8000414c:	59fd                	li	s3,-1
    8000414e:	bff9                	j	8000412c <piperead+0xca>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004150:	4981                	li	s3,0
    80004152:	b7d1                	j	80004116 <piperead+0xb4>

0000000080004154 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80004154:	1141                	addi	sp,sp,-16
    80004156:	e422                	sd	s0,8(sp)
    80004158:	0800                	addi	s0,sp,16
    8000415a:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    8000415c:	8905                	andi	a0,a0,1
    8000415e:	c111                	beqz	a0,80004162 <flags2perm+0xe>
      perm = PTE_X;
    80004160:	4521                	li	a0,8
    if(flags & 0x2)
    80004162:	8b89                	andi	a5,a5,2
    80004164:	c399                	beqz	a5,8000416a <flags2perm+0x16>
      perm |= PTE_W;
    80004166:	00456513          	ori	a0,a0,4
    return perm;
}
    8000416a:	6422                	ld	s0,8(sp)
    8000416c:	0141                	addi	sp,sp,16
    8000416e:	8082                	ret

0000000080004170 <exec>:

int
exec(char *path, char **argv)
{
    80004170:	df010113          	addi	sp,sp,-528
    80004174:	20113423          	sd	ra,520(sp)
    80004178:	20813023          	sd	s0,512(sp)
    8000417c:	ffa6                	sd	s1,504(sp)
    8000417e:	fbca                	sd	s2,496(sp)
    80004180:	f7ce                	sd	s3,488(sp)
    80004182:	f3d2                	sd	s4,480(sp)
    80004184:	efd6                	sd	s5,472(sp)
    80004186:	ebda                	sd	s6,464(sp)
    80004188:	e7de                	sd	s7,456(sp)
    8000418a:	e3e2                	sd	s8,448(sp)
    8000418c:	ff66                	sd	s9,440(sp)
    8000418e:	fb6a                	sd	s10,432(sp)
    80004190:	f76e                	sd	s11,424(sp)
    80004192:	0c00                	addi	s0,sp,528
    80004194:	84aa                	mv	s1,a0
    80004196:	dea43c23          	sd	a0,-520(s0)
    8000419a:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    8000419e:	ffffd097          	auipc	ra,0xffffd
    800041a2:	cba080e7          	jalr	-838(ra) # 80000e58 <myproc>
    800041a6:	892a                	mv	s2,a0

  begin_op();
    800041a8:	fffff097          	auipc	ra,0xfffff
    800041ac:	474080e7          	jalr	1140(ra) # 8000361c <begin_op>

  if((ip = namei(path)) == 0){
    800041b0:	8526                	mv	a0,s1
    800041b2:	fffff097          	auipc	ra,0xfffff
    800041b6:	24e080e7          	jalr	590(ra) # 80003400 <namei>
    800041ba:	c92d                	beqz	a0,8000422c <exec+0xbc>
    800041bc:	84aa                	mv	s1,a0
    end_op();
    return -1;
  }
  ilock(ip);
    800041be:	fffff097          	auipc	ra,0xfffff
    800041c2:	9f4080e7          	jalr	-1548(ra) # 80002bb2 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800041c6:	04000713          	li	a4,64
    800041ca:	4681                	li	a3,0
    800041cc:	e5040613          	addi	a2,s0,-432
    800041d0:	4581                	li	a1,0
    800041d2:	8526                	mv	a0,s1
    800041d4:	fffff097          	auipc	ra,0xfffff
    800041d8:	d38080e7          	jalr	-712(ra) # 80002f0c <readi>
    800041dc:	04000793          	li	a5,64
    800041e0:	00f51a63          	bne	a0,a5,800041f4 <exec+0x84>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    800041e4:	e5042703          	lw	a4,-432(s0)
    800041e8:	464c47b7          	lui	a5,0x464c4
    800041ec:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    800041f0:	04f70463          	beq	a4,a5,80004238 <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    800041f4:	8526                	mv	a0,s1
    800041f6:	fffff097          	auipc	ra,0xfffff
    800041fa:	cc4080e7          	jalr	-828(ra) # 80002eba <iunlockput>
    end_op();
    800041fe:	fffff097          	auipc	ra,0xfffff
    80004202:	49e080e7          	jalr	1182(ra) # 8000369c <end_op>
  }
  return -1;
    80004206:	557d                	li	a0,-1
}
    80004208:	20813083          	ld	ra,520(sp)
    8000420c:	20013403          	ld	s0,512(sp)
    80004210:	74fe                	ld	s1,504(sp)
    80004212:	795e                	ld	s2,496(sp)
    80004214:	79be                	ld	s3,488(sp)
    80004216:	7a1e                	ld	s4,480(sp)
    80004218:	6afe                	ld	s5,472(sp)
    8000421a:	6b5e                	ld	s6,464(sp)
    8000421c:	6bbe                	ld	s7,456(sp)
    8000421e:	6c1e                	ld	s8,448(sp)
    80004220:	7cfa                	ld	s9,440(sp)
    80004222:	7d5a                	ld	s10,432(sp)
    80004224:	7dba                	ld	s11,424(sp)
    80004226:	21010113          	addi	sp,sp,528
    8000422a:	8082                	ret
    end_op();
    8000422c:	fffff097          	auipc	ra,0xfffff
    80004230:	470080e7          	jalr	1136(ra) # 8000369c <end_op>
    return -1;
    80004234:	557d                	li	a0,-1
    80004236:	bfc9                	j	80004208 <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    80004238:	854a                	mv	a0,s2
    8000423a:	ffffd097          	auipc	ra,0xffffd
    8000423e:	ce2080e7          	jalr	-798(ra) # 80000f1c <proc_pagetable>
    80004242:	8baa                	mv	s7,a0
    80004244:	d945                	beqz	a0,800041f4 <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004246:	e7042983          	lw	s3,-400(s0)
    8000424a:	e8845783          	lhu	a5,-376(s0)
    8000424e:	c7ad                	beqz	a5,800042b8 <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004250:	4a01                	li	s4,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004252:	4b01                	li	s6,0
    if(ph.vaddr % PGSIZE != 0)
    80004254:	6c85                	lui	s9,0x1
    80004256:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    8000425a:	def43823          	sd	a5,-528(s0)
    8000425e:	ac0d                	j	80004490 <exec+0x320>
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80004260:	00004517          	auipc	a0,0x4
    80004264:	3f850513          	addi	a0,a0,1016 # 80008658 <syscalls+0x288>
    80004268:	00002097          	auipc	ra,0x2
    8000426c:	c1a080e7          	jalr	-998(ra) # 80005e82 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004270:	8756                	mv	a4,s5
    80004272:	012d86bb          	addw	a3,s11,s2
    80004276:	4581                	li	a1,0
    80004278:	8526                	mv	a0,s1
    8000427a:	fffff097          	auipc	ra,0xfffff
    8000427e:	c92080e7          	jalr	-878(ra) # 80002f0c <readi>
    80004282:	2501                	sext.w	a0,a0
    80004284:	1aaa9a63          	bne	s5,a0,80004438 <exec+0x2c8>
  for(i = 0; i < sz; i += PGSIZE){
    80004288:	6785                	lui	a5,0x1
    8000428a:	0127893b          	addw	s2,a5,s2
    8000428e:	77fd                	lui	a5,0xfffff
    80004290:	01478a3b          	addw	s4,a5,s4
    80004294:	1f897563          	bgeu	s2,s8,8000447e <exec+0x30e>
    pa = walkaddr(pagetable, va + i);
    80004298:	02091593          	slli	a1,s2,0x20
    8000429c:	9181                	srli	a1,a1,0x20
    8000429e:	95ea                	add	a1,a1,s10
    800042a0:	855e                	mv	a0,s7
    800042a2:	ffffc097          	auipc	ra,0xffffc
    800042a6:	268080e7          	jalr	616(ra) # 8000050a <walkaddr>
    800042aa:	862a                	mv	a2,a0
    if(pa == 0)
    800042ac:	d955                	beqz	a0,80004260 <exec+0xf0>
      n = PGSIZE;
    800042ae:	8ae6                	mv	s5,s9
    if(sz - i < PGSIZE)
    800042b0:	fd9a70e3          	bgeu	s4,s9,80004270 <exec+0x100>
      n = sz - i;
    800042b4:	8ad2                	mv	s5,s4
    800042b6:	bf6d                	j	80004270 <exec+0x100>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800042b8:	4a01                	li	s4,0
  iunlockput(ip);
    800042ba:	8526                	mv	a0,s1
    800042bc:	fffff097          	auipc	ra,0xfffff
    800042c0:	bfe080e7          	jalr	-1026(ra) # 80002eba <iunlockput>
  end_op();
    800042c4:	fffff097          	auipc	ra,0xfffff
    800042c8:	3d8080e7          	jalr	984(ra) # 8000369c <end_op>
  p = myproc();
    800042cc:	ffffd097          	auipc	ra,0xffffd
    800042d0:	b8c080e7          	jalr	-1140(ra) # 80000e58 <myproc>
    800042d4:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    800042d6:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    800042da:	6785                	lui	a5,0x1
    800042dc:	17fd                	addi	a5,a5,-1
    800042de:	9a3e                	add	s4,s4,a5
    800042e0:	757d                	lui	a0,0xfffff
    800042e2:	00aa77b3          	and	a5,s4,a0
    800042e6:	e0f43423          	sd	a5,-504(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    800042ea:	4691                	li	a3,4
    800042ec:	6609                	lui	a2,0x2
    800042ee:	963e                	add	a2,a2,a5
    800042f0:	85be                	mv	a1,a5
    800042f2:	855e                	mv	a0,s7
    800042f4:	ffffc097          	auipc	ra,0xffffc
    800042f8:	5ca080e7          	jalr	1482(ra) # 800008be <uvmalloc>
    800042fc:	8b2a                	mv	s6,a0
  ip = 0;
    800042fe:	4481                	li	s1,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    80004300:	12050c63          	beqz	a0,80004438 <exec+0x2c8>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004304:	75f9                	lui	a1,0xffffe
    80004306:	95aa                	add	a1,a1,a0
    80004308:	855e                	mv	a0,s7
    8000430a:	ffffc097          	auipc	ra,0xffffc
    8000430e:	7da080e7          	jalr	2010(ra) # 80000ae4 <uvmclear>
  stackbase = sp - PGSIZE;
    80004312:	7c7d                	lui	s8,0xfffff
    80004314:	9c5a                	add	s8,s8,s6
  for(argc = 0; argv[argc]; argc++) {
    80004316:	e0043783          	ld	a5,-512(s0)
    8000431a:	6388                	ld	a0,0(a5)
    8000431c:	c535                	beqz	a0,80004388 <exec+0x218>
    8000431e:	e9040993          	addi	s3,s0,-368
    80004322:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    80004326:	895a                	mv	s2,s6
    sp -= strlen(argv[argc]) + 1;
    80004328:	ffffc097          	auipc	ra,0xffffc
    8000432c:	fd4080e7          	jalr	-44(ra) # 800002fc <strlen>
    80004330:	2505                	addiw	a0,a0,1
    80004332:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004336:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    8000433a:	13896663          	bltu	s2,s8,80004466 <exec+0x2f6>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    8000433e:	e0043d83          	ld	s11,-512(s0)
    80004342:	000dba03          	ld	s4,0(s11)
    80004346:	8552                	mv	a0,s4
    80004348:	ffffc097          	auipc	ra,0xffffc
    8000434c:	fb4080e7          	jalr	-76(ra) # 800002fc <strlen>
    80004350:	0015069b          	addiw	a3,a0,1
    80004354:	8652                	mv	a2,s4
    80004356:	85ca                	mv	a1,s2
    80004358:	855e                	mv	a0,s7
    8000435a:	ffffc097          	auipc	ra,0xffffc
    8000435e:	7bc080e7          	jalr	1980(ra) # 80000b16 <copyout>
    80004362:	10054663          	bltz	a0,8000446e <exec+0x2fe>
    ustack[argc] = sp;
    80004366:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    8000436a:	0485                	addi	s1,s1,1
    8000436c:	008d8793          	addi	a5,s11,8
    80004370:	e0f43023          	sd	a5,-512(s0)
    80004374:	008db503          	ld	a0,8(s11)
    80004378:	c911                	beqz	a0,8000438c <exec+0x21c>
    if(argc >= MAXARG)
    8000437a:	09a1                	addi	s3,s3,8
    8000437c:	fb3c96e3          	bne	s9,s3,80004328 <exec+0x1b8>
  sz = sz1;
    80004380:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004384:	4481                	li	s1,0
    80004386:	a84d                	j	80004438 <exec+0x2c8>
  sp = sz;
    80004388:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    8000438a:	4481                	li	s1,0
  ustack[argc] = 0;
    8000438c:	00349793          	slli	a5,s1,0x3
    80004390:	f9040713          	addi	a4,s0,-112
    80004394:	97ba                	add	a5,a5,a4
    80004396:	f007b023          	sd	zero,-256(a5) # f00 <_entry-0x7ffff100>
  sp -= (argc+1) * sizeof(uint64);
    8000439a:	00148693          	addi	a3,s1,1
    8000439e:	068e                	slli	a3,a3,0x3
    800043a0:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    800043a4:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    800043a8:	01897663          	bgeu	s2,s8,800043b4 <exec+0x244>
  sz = sz1;
    800043ac:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800043b0:	4481                	li	s1,0
    800043b2:	a059                	j	80004438 <exec+0x2c8>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800043b4:	e9040613          	addi	a2,s0,-368
    800043b8:	85ca                	mv	a1,s2
    800043ba:	855e                	mv	a0,s7
    800043bc:	ffffc097          	auipc	ra,0xffffc
    800043c0:	75a080e7          	jalr	1882(ra) # 80000b16 <copyout>
    800043c4:	0a054963          	bltz	a0,80004476 <exec+0x306>
  p->trapframe->a1 = sp;
    800043c8:	058ab783          	ld	a5,88(s5)
    800043cc:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    800043d0:	df843783          	ld	a5,-520(s0)
    800043d4:	0007c703          	lbu	a4,0(a5)
    800043d8:	cf11                	beqz	a4,800043f4 <exec+0x284>
    800043da:	0785                	addi	a5,a5,1
    if(*s == '/')
    800043dc:	02f00693          	li	a3,47
    800043e0:	a039                	j	800043ee <exec+0x27e>
      last = s+1;
    800043e2:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    800043e6:	0785                	addi	a5,a5,1
    800043e8:	fff7c703          	lbu	a4,-1(a5)
    800043ec:	c701                	beqz	a4,800043f4 <exec+0x284>
    if(*s == '/')
    800043ee:	fed71ce3          	bne	a4,a3,800043e6 <exec+0x276>
    800043f2:	bfc5                	j	800043e2 <exec+0x272>
  safestrcpy(p->name, last, sizeof(p->name));
    800043f4:	4641                	li	a2,16
    800043f6:	df843583          	ld	a1,-520(s0)
    800043fa:	158a8513          	addi	a0,s5,344
    800043fe:	ffffc097          	auipc	ra,0xffffc
    80004402:	ecc080e7          	jalr	-308(ra) # 800002ca <safestrcpy>
  oldpagetable = p->pagetable;
    80004406:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    8000440a:	057ab823          	sd	s7,80(s5)
  p->sz = sz;
    8000440e:	056ab423          	sd	s6,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004412:	058ab783          	ld	a5,88(s5)
    80004416:	e6843703          	ld	a4,-408(s0)
    8000441a:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    8000441c:	058ab783          	ld	a5,88(s5)
    80004420:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004424:	85ea                	mv	a1,s10
    80004426:	ffffd097          	auipc	ra,0xffffd
    8000442a:	b92080e7          	jalr	-1134(ra) # 80000fb8 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    8000442e:	0004851b          	sext.w	a0,s1
    80004432:	bbd9                	j	80004208 <exec+0x98>
    80004434:	e1443423          	sd	s4,-504(s0)
    proc_freepagetable(pagetable, sz);
    80004438:	e0843583          	ld	a1,-504(s0)
    8000443c:	855e                	mv	a0,s7
    8000443e:	ffffd097          	auipc	ra,0xffffd
    80004442:	b7a080e7          	jalr	-1158(ra) # 80000fb8 <proc_freepagetable>
  if(ip){
    80004446:	da0497e3          	bnez	s1,800041f4 <exec+0x84>
  return -1;
    8000444a:	557d                	li	a0,-1
    8000444c:	bb75                	j	80004208 <exec+0x98>
    8000444e:	e1443423          	sd	s4,-504(s0)
    80004452:	b7dd                	j	80004438 <exec+0x2c8>
    80004454:	e1443423          	sd	s4,-504(s0)
    80004458:	b7c5                	j	80004438 <exec+0x2c8>
    8000445a:	e1443423          	sd	s4,-504(s0)
    8000445e:	bfe9                	j	80004438 <exec+0x2c8>
    80004460:	e1443423          	sd	s4,-504(s0)
    80004464:	bfd1                	j	80004438 <exec+0x2c8>
  sz = sz1;
    80004466:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    8000446a:	4481                	li	s1,0
    8000446c:	b7f1                	j	80004438 <exec+0x2c8>
  sz = sz1;
    8000446e:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004472:	4481                	li	s1,0
    80004474:	b7d1                	j	80004438 <exec+0x2c8>
  sz = sz1;
    80004476:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    8000447a:	4481                	li	s1,0
    8000447c:	bf75                	j	80004438 <exec+0x2c8>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    8000447e:	e0843a03          	ld	s4,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004482:	2b05                	addiw	s6,s6,1
    80004484:	0389899b          	addiw	s3,s3,56
    80004488:	e8845783          	lhu	a5,-376(s0)
    8000448c:	e2fb57e3          	bge	s6,a5,800042ba <exec+0x14a>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004490:	2981                	sext.w	s3,s3
    80004492:	03800713          	li	a4,56
    80004496:	86ce                	mv	a3,s3
    80004498:	e1840613          	addi	a2,s0,-488
    8000449c:	4581                	li	a1,0
    8000449e:	8526                	mv	a0,s1
    800044a0:	fffff097          	auipc	ra,0xfffff
    800044a4:	a6c080e7          	jalr	-1428(ra) # 80002f0c <readi>
    800044a8:	03800793          	li	a5,56
    800044ac:	f8f514e3          	bne	a0,a5,80004434 <exec+0x2c4>
    if(ph.type != ELF_PROG_LOAD)
    800044b0:	e1842783          	lw	a5,-488(s0)
    800044b4:	4705                	li	a4,1
    800044b6:	fce796e3          	bne	a5,a4,80004482 <exec+0x312>
    if(ph.memsz < ph.filesz)
    800044ba:	e4043903          	ld	s2,-448(s0)
    800044be:	e3843783          	ld	a5,-456(s0)
    800044c2:	f8f966e3          	bltu	s2,a5,8000444e <exec+0x2de>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800044c6:	e2843783          	ld	a5,-472(s0)
    800044ca:	993e                	add	s2,s2,a5
    800044cc:	f8f964e3          	bltu	s2,a5,80004454 <exec+0x2e4>
    if(ph.vaddr % PGSIZE != 0)
    800044d0:	df043703          	ld	a4,-528(s0)
    800044d4:	8ff9                	and	a5,a5,a4
    800044d6:	f3d1                	bnez	a5,8000445a <exec+0x2ea>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    800044d8:	e1c42503          	lw	a0,-484(s0)
    800044dc:	00000097          	auipc	ra,0x0
    800044e0:	c78080e7          	jalr	-904(ra) # 80004154 <flags2perm>
    800044e4:	86aa                	mv	a3,a0
    800044e6:	864a                	mv	a2,s2
    800044e8:	85d2                	mv	a1,s4
    800044ea:	855e                	mv	a0,s7
    800044ec:	ffffc097          	auipc	ra,0xffffc
    800044f0:	3d2080e7          	jalr	978(ra) # 800008be <uvmalloc>
    800044f4:	e0a43423          	sd	a0,-504(s0)
    800044f8:	d525                	beqz	a0,80004460 <exec+0x2f0>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800044fa:	e2843d03          	ld	s10,-472(s0)
    800044fe:	e2042d83          	lw	s11,-480(s0)
    80004502:	e3842c03          	lw	s8,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004506:	f60c0ce3          	beqz	s8,8000447e <exec+0x30e>
    8000450a:	8a62                	mv	s4,s8
    8000450c:	4901                	li	s2,0
    8000450e:	b369                	j	80004298 <exec+0x128>

0000000080004510 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004510:	7179                	addi	sp,sp,-48
    80004512:	f406                	sd	ra,40(sp)
    80004514:	f022                	sd	s0,32(sp)
    80004516:	ec26                	sd	s1,24(sp)
    80004518:	e84a                	sd	s2,16(sp)
    8000451a:	1800                	addi	s0,sp,48
    8000451c:	892e                	mv	s2,a1
    8000451e:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80004520:	fdc40593          	addi	a1,s0,-36
    80004524:	ffffe097          	auipc	ra,0xffffe
    80004528:	a44080e7          	jalr	-1468(ra) # 80001f68 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    8000452c:	fdc42703          	lw	a4,-36(s0)
    80004530:	47bd                	li	a5,15
    80004532:	02e7eb63          	bltu	a5,a4,80004568 <argfd+0x58>
    80004536:	ffffd097          	auipc	ra,0xffffd
    8000453a:	922080e7          	jalr	-1758(ra) # 80000e58 <myproc>
    8000453e:	fdc42703          	lw	a4,-36(s0)
    80004542:	01a70793          	addi	a5,a4,26
    80004546:	078e                	slli	a5,a5,0x3
    80004548:	953e                	add	a0,a0,a5
    8000454a:	611c                	ld	a5,0(a0)
    8000454c:	c385                	beqz	a5,8000456c <argfd+0x5c>
    return -1;
  if(pfd)
    8000454e:	00090463          	beqz	s2,80004556 <argfd+0x46>
    *pfd = fd;
    80004552:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004556:	4501                	li	a0,0
  if(pf)
    80004558:	c091                	beqz	s1,8000455c <argfd+0x4c>
    *pf = f;
    8000455a:	e09c                	sd	a5,0(s1)
}
    8000455c:	70a2                	ld	ra,40(sp)
    8000455e:	7402                	ld	s0,32(sp)
    80004560:	64e2                	ld	s1,24(sp)
    80004562:	6942                	ld	s2,16(sp)
    80004564:	6145                	addi	sp,sp,48
    80004566:	8082                	ret
    return -1;
    80004568:	557d                	li	a0,-1
    8000456a:	bfcd                	j	8000455c <argfd+0x4c>
    8000456c:	557d                	li	a0,-1
    8000456e:	b7fd                	j	8000455c <argfd+0x4c>

0000000080004570 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004570:	1101                	addi	sp,sp,-32
    80004572:	ec06                	sd	ra,24(sp)
    80004574:	e822                	sd	s0,16(sp)
    80004576:	e426                	sd	s1,8(sp)
    80004578:	1000                	addi	s0,sp,32
    8000457a:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    8000457c:	ffffd097          	auipc	ra,0xffffd
    80004580:	8dc080e7          	jalr	-1828(ra) # 80000e58 <myproc>
    80004584:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80004586:	0d050793          	addi	a5,a0,208 # fffffffffffff0d0 <end+0xffffffff7ffe1f60>
    8000458a:	4501                	li	a0,0
    8000458c:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    8000458e:	6398                	ld	a4,0(a5)
    80004590:	cb19                	beqz	a4,800045a6 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80004592:	2505                	addiw	a0,a0,1
    80004594:	07a1                	addi	a5,a5,8
    80004596:	fed51ce3          	bne	a0,a3,8000458e <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    8000459a:	557d                	li	a0,-1
}
    8000459c:	60e2                	ld	ra,24(sp)
    8000459e:	6442                	ld	s0,16(sp)
    800045a0:	64a2                	ld	s1,8(sp)
    800045a2:	6105                	addi	sp,sp,32
    800045a4:	8082                	ret
      p->ofile[fd] = f;
    800045a6:	01a50793          	addi	a5,a0,26
    800045aa:	078e                	slli	a5,a5,0x3
    800045ac:	963e                	add	a2,a2,a5
    800045ae:	e204                	sd	s1,0(a2)
      return fd;
    800045b0:	b7f5                	j	8000459c <fdalloc+0x2c>

00000000800045b2 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800045b2:	715d                	addi	sp,sp,-80
    800045b4:	e486                	sd	ra,72(sp)
    800045b6:	e0a2                	sd	s0,64(sp)
    800045b8:	fc26                	sd	s1,56(sp)
    800045ba:	f84a                	sd	s2,48(sp)
    800045bc:	f44e                	sd	s3,40(sp)
    800045be:	f052                	sd	s4,32(sp)
    800045c0:	ec56                	sd	s5,24(sp)
    800045c2:	e85a                	sd	s6,16(sp)
    800045c4:	0880                	addi	s0,sp,80
    800045c6:	8b2e                	mv	s6,a1
    800045c8:	89b2                	mv	s3,a2
    800045ca:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800045cc:	fb040593          	addi	a1,s0,-80
    800045d0:	fffff097          	auipc	ra,0xfffff
    800045d4:	e4e080e7          	jalr	-434(ra) # 8000341e <nameiparent>
    800045d8:	84aa                	mv	s1,a0
    800045da:	16050063          	beqz	a0,8000473a <create+0x188>
    return 0;

  ilock(dp);
    800045de:	ffffe097          	auipc	ra,0xffffe
    800045e2:	5d4080e7          	jalr	1492(ra) # 80002bb2 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800045e6:	4601                	li	a2,0
    800045e8:	fb040593          	addi	a1,s0,-80
    800045ec:	8526                	mv	a0,s1
    800045ee:	fffff097          	auipc	ra,0xfffff
    800045f2:	b50080e7          	jalr	-1200(ra) # 8000313e <dirlookup>
    800045f6:	8aaa                	mv	s5,a0
    800045f8:	c931                	beqz	a0,8000464c <create+0x9a>
    iunlockput(dp);
    800045fa:	8526                	mv	a0,s1
    800045fc:	fffff097          	auipc	ra,0xfffff
    80004600:	8be080e7          	jalr	-1858(ra) # 80002eba <iunlockput>
    ilock(ip);
    80004604:	8556                	mv	a0,s5
    80004606:	ffffe097          	auipc	ra,0xffffe
    8000460a:	5ac080e7          	jalr	1452(ra) # 80002bb2 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    8000460e:	000b059b          	sext.w	a1,s6
    80004612:	4789                	li	a5,2
    80004614:	02f59563          	bne	a1,a5,8000463e <create+0x8c>
    80004618:	044ad783          	lhu	a5,68(s5)
    8000461c:	37f9                	addiw	a5,a5,-2
    8000461e:	17c2                	slli	a5,a5,0x30
    80004620:	93c1                	srli	a5,a5,0x30
    80004622:	4705                	li	a4,1
    80004624:	00f76d63          	bltu	a4,a5,8000463e <create+0x8c>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80004628:	8556                	mv	a0,s5
    8000462a:	60a6                	ld	ra,72(sp)
    8000462c:	6406                	ld	s0,64(sp)
    8000462e:	74e2                	ld	s1,56(sp)
    80004630:	7942                	ld	s2,48(sp)
    80004632:	79a2                	ld	s3,40(sp)
    80004634:	7a02                	ld	s4,32(sp)
    80004636:	6ae2                	ld	s5,24(sp)
    80004638:	6b42                	ld	s6,16(sp)
    8000463a:	6161                	addi	sp,sp,80
    8000463c:	8082                	ret
    iunlockput(ip);
    8000463e:	8556                	mv	a0,s5
    80004640:	fffff097          	auipc	ra,0xfffff
    80004644:	87a080e7          	jalr	-1926(ra) # 80002eba <iunlockput>
    return 0;
    80004648:	4a81                	li	s5,0
    8000464a:	bff9                	j	80004628 <create+0x76>
  if((ip = ialloc(dp->dev, type)) == 0){
    8000464c:	85da                	mv	a1,s6
    8000464e:	4088                	lw	a0,0(s1)
    80004650:	ffffe097          	auipc	ra,0xffffe
    80004654:	3c6080e7          	jalr	966(ra) # 80002a16 <ialloc>
    80004658:	8a2a                	mv	s4,a0
    8000465a:	c921                	beqz	a0,800046aa <create+0xf8>
  ilock(ip);
    8000465c:	ffffe097          	auipc	ra,0xffffe
    80004660:	556080e7          	jalr	1366(ra) # 80002bb2 <ilock>
  ip->major = major;
    80004664:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    80004668:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    8000466c:	4785                	li	a5,1
    8000466e:	04fa1523          	sh	a5,74(s4)
  iupdate(ip);
    80004672:	8552                	mv	a0,s4
    80004674:	ffffe097          	auipc	ra,0xffffe
    80004678:	474080e7          	jalr	1140(ra) # 80002ae8 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000467c:	000b059b          	sext.w	a1,s6
    80004680:	4785                	li	a5,1
    80004682:	02f58b63          	beq	a1,a5,800046b8 <create+0x106>
  if(dirlink(dp, name, ip->inum) < 0)
    80004686:	004a2603          	lw	a2,4(s4)
    8000468a:	fb040593          	addi	a1,s0,-80
    8000468e:	8526                	mv	a0,s1
    80004690:	fffff097          	auipc	ra,0xfffff
    80004694:	cbe080e7          	jalr	-834(ra) # 8000334e <dirlink>
    80004698:	06054f63          	bltz	a0,80004716 <create+0x164>
  iunlockput(dp);
    8000469c:	8526                	mv	a0,s1
    8000469e:	fffff097          	auipc	ra,0xfffff
    800046a2:	81c080e7          	jalr	-2020(ra) # 80002eba <iunlockput>
  return ip;
    800046a6:	8ad2                	mv	s5,s4
    800046a8:	b741                	j	80004628 <create+0x76>
    iunlockput(dp);
    800046aa:	8526                	mv	a0,s1
    800046ac:	fffff097          	auipc	ra,0xfffff
    800046b0:	80e080e7          	jalr	-2034(ra) # 80002eba <iunlockput>
    return 0;
    800046b4:	8ad2                	mv	s5,s4
    800046b6:	bf8d                	j	80004628 <create+0x76>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800046b8:	004a2603          	lw	a2,4(s4)
    800046bc:	00004597          	auipc	a1,0x4
    800046c0:	fbc58593          	addi	a1,a1,-68 # 80008678 <syscalls+0x2a8>
    800046c4:	8552                	mv	a0,s4
    800046c6:	fffff097          	auipc	ra,0xfffff
    800046ca:	c88080e7          	jalr	-888(ra) # 8000334e <dirlink>
    800046ce:	04054463          	bltz	a0,80004716 <create+0x164>
    800046d2:	40d0                	lw	a2,4(s1)
    800046d4:	00004597          	auipc	a1,0x4
    800046d8:	fac58593          	addi	a1,a1,-84 # 80008680 <syscalls+0x2b0>
    800046dc:	8552                	mv	a0,s4
    800046de:	fffff097          	auipc	ra,0xfffff
    800046e2:	c70080e7          	jalr	-912(ra) # 8000334e <dirlink>
    800046e6:	02054863          	bltz	a0,80004716 <create+0x164>
  if(dirlink(dp, name, ip->inum) < 0)
    800046ea:	004a2603          	lw	a2,4(s4)
    800046ee:	fb040593          	addi	a1,s0,-80
    800046f2:	8526                	mv	a0,s1
    800046f4:	fffff097          	auipc	ra,0xfffff
    800046f8:	c5a080e7          	jalr	-934(ra) # 8000334e <dirlink>
    800046fc:	00054d63          	bltz	a0,80004716 <create+0x164>
    dp->nlink++;  // for ".."
    80004700:	04a4d783          	lhu	a5,74(s1)
    80004704:	2785                	addiw	a5,a5,1
    80004706:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    8000470a:	8526                	mv	a0,s1
    8000470c:	ffffe097          	auipc	ra,0xffffe
    80004710:	3dc080e7          	jalr	988(ra) # 80002ae8 <iupdate>
    80004714:	b761                	j	8000469c <create+0xea>
  ip->nlink = 0;
    80004716:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    8000471a:	8552                	mv	a0,s4
    8000471c:	ffffe097          	auipc	ra,0xffffe
    80004720:	3cc080e7          	jalr	972(ra) # 80002ae8 <iupdate>
  iunlockput(ip);
    80004724:	8552                	mv	a0,s4
    80004726:	ffffe097          	auipc	ra,0xffffe
    8000472a:	794080e7          	jalr	1940(ra) # 80002eba <iunlockput>
  iunlockput(dp);
    8000472e:	8526                	mv	a0,s1
    80004730:	ffffe097          	auipc	ra,0xffffe
    80004734:	78a080e7          	jalr	1930(ra) # 80002eba <iunlockput>
  return 0;
    80004738:	bdc5                	j	80004628 <create+0x76>
    return 0;
    8000473a:	8aaa                	mv	s5,a0
    8000473c:	b5f5                	j	80004628 <create+0x76>

000000008000473e <sys_dup>:
{
    8000473e:	7179                	addi	sp,sp,-48
    80004740:	f406                	sd	ra,40(sp)
    80004742:	f022                	sd	s0,32(sp)
    80004744:	ec26                	sd	s1,24(sp)
    80004746:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004748:	fd840613          	addi	a2,s0,-40
    8000474c:	4581                	li	a1,0
    8000474e:	4501                	li	a0,0
    80004750:	00000097          	auipc	ra,0x0
    80004754:	dc0080e7          	jalr	-576(ra) # 80004510 <argfd>
    return -1;
    80004758:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    8000475a:	02054363          	bltz	a0,80004780 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    8000475e:	fd843503          	ld	a0,-40(s0)
    80004762:	00000097          	auipc	ra,0x0
    80004766:	e0e080e7          	jalr	-498(ra) # 80004570 <fdalloc>
    8000476a:	84aa                	mv	s1,a0
    return -1;
    8000476c:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    8000476e:	00054963          	bltz	a0,80004780 <sys_dup+0x42>
  filedup(f);
    80004772:	fd843503          	ld	a0,-40(s0)
    80004776:	fffff097          	auipc	ra,0xfffff
    8000477a:	320080e7          	jalr	800(ra) # 80003a96 <filedup>
  return fd;
    8000477e:	87a6                	mv	a5,s1
}
    80004780:	853e                	mv	a0,a5
    80004782:	70a2                	ld	ra,40(sp)
    80004784:	7402                	ld	s0,32(sp)
    80004786:	64e2                	ld	s1,24(sp)
    80004788:	6145                	addi	sp,sp,48
    8000478a:	8082                	ret

000000008000478c <sys_read>:
{
    8000478c:	7179                	addi	sp,sp,-48
    8000478e:	f406                	sd	ra,40(sp)
    80004790:	f022                	sd	s0,32(sp)
    80004792:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004794:	fd840593          	addi	a1,s0,-40
    80004798:	4505                	li	a0,1
    8000479a:	ffffd097          	auipc	ra,0xffffd
    8000479e:	7ee080e7          	jalr	2030(ra) # 80001f88 <argaddr>
  argint(2, &n);
    800047a2:	fe440593          	addi	a1,s0,-28
    800047a6:	4509                	li	a0,2
    800047a8:	ffffd097          	auipc	ra,0xffffd
    800047ac:	7c0080e7          	jalr	1984(ra) # 80001f68 <argint>
  if(argfd(0, 0, &f) < 0)
    800047b0:	fe840613          	addi	a2,s0,-24
    800047b4:	4581                	li	a1,0
    800047b6:	4501                	li	a0,0
    800047b8:	00000097          	auipc	ra,0x0
    800047bc:	d58080e7          	jalr	-680(ra) # 80004510 <argfd>
    800047c0:	87aa                	mv	a5,a0
    return -1;
    800047c2:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800047c4:	0007cc63          	bltz	a5,800047dc <sys_read+0x50>
  return fileread(f, p, n);
    800047c8:	fe442603          	lw	a2,-28(s0)
    800047cc:	fd843583          	ld	a1,-40(s0)
    800047d0:	fe843503          	ld	a0,-24(s0)
    800047d4:	fffff097          	auipc	ra,0xfffff
    800047d8:	44e080e7          	jalr	1102(ra) # 80003c22 <fileread>
}
    800047dc:	70a2                	ld	ra,40(sp)
    800047de:	7402                	ld	s0,32(sp)
    800047e0:	6145                	addi	sp,sp,48
    800047e2:	8082                	ret

00000000800047e4 <sys_write>:
{
    800047e4:	7179                	addi	sp,sp,-48
    800047e6:	f406                	sd	ra,40(sp)
    800047e8:	f022                	sd	s0,32(sp)
    800047ea:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    800047ec:	fd840593          	addi	a1,s0,-40
    800047f0:	4505                	li	a0,1
    800047f2:	ffffd097          	auipc	ra,0xffffd
    800047f6:	796080e7          	jalr	1942(ra) # 80001f88 <argaddr>
  argint(2, &n);
    800047fa:	fe440593          	addi	a1,s0,-28
    800047fe:	4509                	li	a0,2
    80004800:	ffffd097          	auipc	ra,0xffffd
    80004804:	768080e7          	jalr	1896(ra) # 80001f68 <argint>
  if(argfd(0, 0, &f) < 0)
    80004808:	fe840613          	addi	a2,s0,-24
    8000480c:	4581                	li	a1,0
    8000480e:	4501                	li	a0,0
    80004810:	00000097          	auipc	ra,0x0
    80004814:	d00080e7          	jalr	-768(ra) # 80004510 <argfd>
    80004818:	87aa                	mv	a5,a0
    return -1;
    8000481a:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000481c:	0007cc63          	bltz	a5,80004834 <sys_write+0x50>
  return filewrite(f, p, n);
    80004820:	fe442603          	lw	a2,-28(s0)
    80004824:	fd843583          	ld	a1,-40(s0)
    80004828:	fe843503          	ld	a0,-24(s0)
    8000482c:	fffff097          	auipc	ra,0xfffff
    80004830:	4b8080e7          	jalr	1208(ra) # 80003ce4 <filewrite>
}
    80004834:	70a2                	ld	ra,40(sp)
    80004836:	7402                	ld	s0,32(sp)
    80004838:	6145                	addi	sp,sp,48
    8000483a:	8082                	ret

000000008000483c <sys_close>:
{
    8000483c:	1101                	addi	sp,sp,-32
    8000483e:	ec06                	sd	ra,24(sp)
    80004840:	e822                	sd	s0,16(sp)
    80004842:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004844:	fe040613          	addi	a2,s0,-32
    80004848:	fec40593          	addi	a1,s0,-20
    8000484c:	4501                	li	a0,0
    8000484e:	00000097          	auipc	ra,0x0
    80004852:	cc2080e7          	jalr	-830(ra) # 80004510 <argfd>
    return -1;
    80004856:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004858:	02054463          	bltz	a0,80004880 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    8000485c:	ffffc097          	auipc	ra,0xffffc
    80004860:	5fc080e7          	jalr	1532(ra) # 80000e58 <myproc>
    80004864:	fec42783          	lw	a5,-20(s0)
    80004868:	07e9                	addi	a5,a5,26
    8000486a:	078e                	slli	a5,a5,0x3
    8000486c:	97aa                	add	a5,a5,a0
    8000486e:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80004872:	fe043503          	ld	a0,-32(s0)
    80004876:	fffff097          	auipc	ra,0xfffff
    8000487a:	272080e7          	jalr	626(ra) # 80003ae8 <fileclose>
  return 0;
    8000487e:	4781                	li	a5,0
}
    80004880:	853e                	mv	a0,a5
    80004882:	60e2                	ld	ra,24(sp)
    80004884:	6442                	ld	s0,16(sp)
    80004886:	6105                	addi	sp,sp,32
    80004888:	8082                	ret

000000008000488a <sys_fstat>:
{
    8000488a:	1101                	addi	sp,sp,-32
    8000488c:	ec06                	sd	ra,24(sp)
    8000488e:	e822                	sd	s0,16(sp)
    80004890:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    80004892:	fe040593          	addi	a1,s0,-32
    80004896:	4505                	li	a0,1
    80004898:	ffffd097          	auipc	ra,0xffffd
    8000489c:	6f0080e7          	jalr	1776(ra) # 80001f88 <argaddr>
  if(argfd(0, 0, &f) < 0)
    800048a0:	fe840613          	addi	a2,s0,-24
    800048a4:	4581                	li	a1,0
    800048a6:	4501                	li	a0,0
    800048a8:	00000097          	auipc	ra,0x0
    800048ac:	c68080e7          	jalr	-920(ra) # 80004510 <argfd>
    800048b0:	87aa                	mv	a5,a0
    return -1;
    800048b2:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800048b4:	0007ca63          	bltz	a5,800048c8 <sys_fstat+0x3e>
  return filestat(f, st);
    800048b8:	fe043583          	ld	a1,-32(s0)
    800048bc:	fe843503          	ld	a0,-24(s0)
    800048c0:	fffff097          	auipc	ra,0xfffff
    800048c4:	2f0080e7          	jalr	752(ra) # 80003bb0 <filestat>
}
    800048c8:	60e2                	ld	ra,24(sp)
    800048ca:	6442                	ld	s0,16(sp)
    800048cc:	6105                	addi	sp,sp,32
    800048ce:	8082                	ret

00000000800048d0 <sys_link>:
{
    800048d0:	7169                	addi	sp,sp,-304
    800048d2:	f606                	sd	ra,296(sp)
    800048d4:	f222                	sd	s0,288(sp)
    800048d6:	ee26                	sd	s1,280(sp)
    800048d8:	ea4a                	sd	s2,272(sp)
    800048da:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800048dc:	08000613          	li	a2,128
    800048e0:	ed040593          	addi	a1,s0,-304
    800048e4:	4501                	li	a0,0
    800048e6:	ffffd097          	auipc	ra,0xffffd
    800048ea:	6c2080e7          	jalr	1730(ra) # 80001fa8 <argstr>
    return -1;
    800048ee:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800048f0:	10054e63          	bltz	a0,80004a0c <sys_link+0x13c>
    800048f4:	08000613          	li	a2,128
    800048f8:	f5040593          	addi	a1,s0,-176
    800048fc:	4505                	li	a0,1
    800048fe:	ffffd097          	auipc	ra,0xffffd
    80004902:	6aa080e7          	jalr	1706(ra) # 80001fa8 <argstr>
    return -1;
    80004906:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004908:	10054263          	bltz	a0,80004a0c <sys_link+0x13c>
  begin_op();
    8000490c:	fffff097          	auipc	ra,0xfffff
    80004910:	d10080e7          	jalr	-752(ra) # 8000361c <begin_op>
  if((ip = namei(old)) == 0){
    80004914:	ed040513          	addi	a0,s0,-304
    80004918:	fffff097          	auipc	ra,0xfffff
    8000491c:	ae8080e7          	jalr	-1304(ra) # 80003400 <namei>
    80004920:	84aa                	mv	s1,a0
    80004922:	c551                	beqz	a0,800049ae <sys_link+0xde>
  ilock(ip);
    80004924:	ffffe097          	auipc	ra,0xffffe
    80004928:	28e080e7          	jalr	654(ra) # 80002bb2 <ilock>
  if(ip->type == T_DIR){
    8000492c:	04449703          	lh	a4,68(s1)
    80004930:	4785                	li	a5,1
    80004932:	08f70463          	beq	a4,a5,800049ba <sys_link+0xea>
  ip->nlink++;
    80004936:	04a4d783          	lhu	a5,74(s1)
    8000493a:	2785                	addiw	a5,a5,1
    8000493c:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004940:	8526                	mv	a0,s1
    80004942:	ffffe097          	auipc	ra,0xffffe
    80004946:	1a6080e7          	jalr	422(ra) # 80002ae8 <iupdate>
  iunlock(ip);
    8000494a:	8526                	mv	a0,s1
    8000494c:	ffffe097          	auipc	ra,0xffffe
    80004950:	328080e7          	jalr	808(ra) # 80002c74 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004954:	fd040593          	addi	a1,s0,-48
    80004958:	f5040513          	addi	a0,s0,-176
    8000495c:	fffff097          	auipc	ra,0xfffff
    80004960:	ac2080e7          	jalr	-1342(ra) # 8000341e <nameiparent>
    80004964:	892a                	mv	s2,a0
    80004966:	c935                	beqz	a0,800049da <sys_link+0x10a>
  ilock(dp);
    80004968:	ffffe097          	auipc	ra,0xffffe
    8000496c:	24a080e7          	jalr	586(ra) # 80002bb2 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004970:	00092703          	lw	a4,0(s2)
    80004974:	409c                	lw	a5,0(s1)
    80004976:	04f71d63          	bne	a4,a5,800049d0 <sys_link+0x100>
    8000497a:	40d0                	lw	a2,4(s1)
    8000497c:	fd040593          	addi	a1,s0,-48
    80004980:	854a                	mv	a0,s2
    80004982:	fffff097          	auipc	ra,0xfffff
    80004986:	9cc080e7          	jalr	-1588(ra) # 8000334e <dirlink>
    8000498a:	04054363          	bltz	a0,800049d0 <sys_link+0x100>
  iunlockput(dp);
    8000498e:	854a                	mv	a0,s2
    80004990:	ffffe097          	auipc	ra,0xffffe
    80004994:	52a080e7          	jalr	1322(ra) # 80002eba <iunlockput>
  iput(ip);
    80004998:	8526                	mv	a0,s1
    8000499a:	ffffe097          	auipc	ra,0xffffe
    8000499e:	478080e7          	jalr	1144(ra) # 80002e12 <iput>
  end_op();
    800049a2:	fffff097          	auipc	ra,0xfffff
    800049a6:	cfa080e7          	jalr	-774(ra) # 8000369c <end_op>
  return 0;
    800049aa:	4781                	li	a5,0
    800049ac:	a085                	j	80004a0c <sys_link+0x13c>
    end_op();
    800049ae:	fffff097          	auipc	ra,0xfffff
    800049b2:	cee080e7          	jalr	-786(ra) # 8000369c <end_op>
    return -1;
    800049b6:	57fd                	li	a5,-1
    800049b8:	a891                	j	80004a0c <sys_link+0x13c>
    iunlockput(ip);
    800049ba:	8526                	mv	a0,s1
    800049bc:	ffffe097          	auipc	ra,0xffffe
    800049c0:	4fe080e7          	jalr	1278(ra) # 80002eba <iunlockput>
    end_op();
    800049c4:	fffff097          	auipc	ra,0xfffff
    800049c8:	cd8080e7          	jalr	-808(ra) # 8000369c <end_op>
    return -1;
    800049cc:	57fd                	li	a5,-1
    800049ce:	a83d                	j	80004a0c <sys_link+0x13c>
    iunlockput(dp);
    800049d0:	854a                	mv	a0,s2
    800049d2:	ffffe097          	auipc	ra,0xffffe
    800049d6:	4e8080e7          	jalr	1256(ra) # 80002eba <iunlockput>
  ilock(ip);
    800049da:	8526                	mv	a0,s1
    800049dc:	ffffe097          	auipc	ra,0xffffe
    800049e0:	1d6080e7          	jalr	470(ra) # 80002bb2 <ilock>
  ip->nlink--;
    800049e4:	04a4d783          	lhu	a5,74(s1)
    800049e8:	37fd                	addiw	a5,a5,-1
    800049ea:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800049ee:	8526                	mv	a0,s1
    800049f0:	ffffe097          	auipc	ra,0xffffe
    800049f4:	0f8080e7          	jalr	248(ra) # 80002ae8 <iupdate>
  iunlockput(ip);
    800049f8:	8526                	mv	a0,s1
    800049fa:	ffffe097          	auipc	ra,0xffffe
    800049fe:	4c0080e7          	jalr	1216(ra) # 80002eba <iunlockput>
  end_op();
    80004a02:	fffff097          	auipc	ra,0xfffff
    80004a06:	c9a080e7          	jalr	-870(ra) # 8000369c <end_op>
  return -1;
    80004a0a:	57fd                	li	a5,-1
}
    80004a0c:	853e                	mv	a0,a5
    80004a0e:	70b2                	ld	ra,296(sp)
    80004a10:	7412                	ld	s0,288(sp)
    80004a12:	64f2                	ld	s1,280(sp)
    80004a14:	6952                	ld	s2,272(sp)
    80004a16:	6155                	addi	sp,sp,304
    80004a18:	8082                	ret

0000000080004a1a <sys_unlink>:
{
    80004a1a:	7151                	addi	sp,sp,-240
    80004a1c:	f586                	sd	ra,232(sp)
    80004a1e:	f1a2                	sd	s0,224(sp)
    80004a20:	eda6                	sd	s1,216(sp)
    80004a22:	e9ca                	sd	s2,208(sp)
    80004a24:	e5ce                	sd	s3,200(sp)
    80004a26:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004a28:	08000613          	li	a2,128
    80004a2c:	f3040593          	addi	a1,s0,-208
    80004a30:	4501                	li	a0,0
    80004a32:	ffffd097          	auipc	ra,0xffffd
    80004a36:	576080e7          	jalr	1398(ra) # 80001fa8 <argstr>
    80004a3a:	18054163          	bltz	a0,80004bbc <sys_unlink+0x1a2>
  begin_op();
    80004a3e:	fffff097          	auipc	ra,0xfffff
    80004a42:	bde080e7          	jalr	-1058(ra) # 8000361c <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004a46:	fb040593          	addi	a1,s0,-80
    80004a4a:	f3040513          	addi	a0,s0,-208
    80004a4e:	fffff097          	auipc	ra,0xfffff
    80004a52:	9d0080e7          	jalr	-1584(ra) # 8000341e <nameiparent>
    80004a56:	84aa                	mv	s1,a0
    80004a58:	c979                	beqz	a0,80004b2e <sys_unlink+0x114>
  ilock(dp);
    80004a5a:	ffffe097          	auipc	ra,0xffffe
    80004a5e:	158080e7          	jalr	344(ra) # 80002bb2 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004a62:	00004597          	auipc	a1,0x4
    80004a66:	c1658593          	addi	a1,a1,-1002 # 80008678 <syscalls+0x2a8>
    80004a6a:	fb040513          	addi	a0,s0,-80
    80004a6e:	ffffe097          	auipc	ra,0xffffe
    80004a72:	6b6080e7          	jalr	1718(ra) # 80003124 <namecmp>
    80004a76:	14050a63          	beqz	a0,80004bca <sys_unlink+0x1b0>
    80004a7a:	00004597          	auipc	a1,0x4
    80004a7e:	c0658593          	addi	a1,a1,-1018 # 80008680 <syscalls+0x2b0>
    80004a82:	fb040513          	addi	a0,s0,-80
    80004a86:	ffffe097          	auipc	ra,0xffffe
    80004a8a:	69e080e7          	jalr	1694(ra) # 80003124 <namecmp>
    80004a8e:	12050e63          	beqz	a0,80004bca <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004a92:	f2c40613          	addi	a2,s0,-212
    80004a96:	fb040593          	addi	a1,s0,-80
    80004a9a:	8526                	mv	a0,s1
    80004a9c:	ffffe097          	auipc	ra,0xffffe
    80004aa0:	6a2080e7          	jalr	1698(ra) # 8000313e <dirlookup>
    80004aa4:	892a                	mv	s2,a0
    80004aa6:	12050263          	beqz	a0,80004bca <sys_unlink+0x1b0>
  ilock(ip);
    80004aaa:	ffffe097          	auipc	ra,0xffffe
    80004aae:	108080e7          	jalr	264(ra) # 80002bb2 <ilock>
  if(ip->nlink < 1)
    80004ab2:	04a91783          	lh	a5,74(s2)
    80004ab6:	08f05263          	blez	a5,80004b3a <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004aba:	04491703          	lh	a4,68(s2)
    80004abe:	4785                	li	a5,1
    80004ac0:	08f70563          	beq	a4,a5,80004b4a <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004ac4:	4641                	li	a2,16
    80004ac6:	4581                	li	a1,0
    80004ac8:	fc040513          	addi	a0,s0,-64
    80004acc:	ffffb097          	auipc	ra,0xffffb
    80004ad0:	6ac080e7          	jalr	1708(ra) # 80000178 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004ad4:	4741                	li	a4,16
    80004ad6:	f2c42683          	lw	a3,-212(s0)
    80004ada:	fc040613          	addi	a2,s0,-64
    80004ade:	4581                	li	a1,0
    80004ae0:	8526                	mv	a0,s1
    80004ae2:	ffffe097          	auipc	ra,0xffffe
    80004ae6:	522080e7          	jalr	1314(ra) # 80003004 <writei>
    80004aea:	47c1                	li	a5,16
    80004aec:	0af51563          	bne	a0,a5,80004b96 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80004af0:	04491703          	lh	a4,68(s2)
    80004af4:	4785                	li	a5,1
    80004af6:	0af70863          	beq	a4,a5,80004ba6 <sys_unlink+0x18c>
  iunlockput(dp);
    80004afa:	8526                	mv	a0,s1
    80004afc:	ffffe097          	auipc	ra,0xffffe
    80004b00:	3be080e7          	jalr	958(ra) # 80002eba <iunlockput>
  ip->nlink--;
    80004b04:	04a95783          	lhu	a5,74(s2)
    80004b08:	37fd                	addiw	a5,a5,-1
    80004b0a:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004b0e:	854a                	mv	a0,s2
    80004b10:	ffffe097          	auipc	ra,0xffffe
    80004b14:	fd8080e7          	jalr	-40(ra) # 80002ae8 <iupdate>
  iunlockput(ip);
    80004b18:	854a                	mv	a0,s2
    80004b1a:	ffffe097          	auipc	ra,0xffffe
    80004b1e:	3a0080e7          	jalr	928(ra) # 80002eba <iunlockput>
  end_op();
    80004b22:	fffff097          	auipc	ra,0xfffff
    80004b26:	b7a080e7          	jalr	-1158(ra) # 8000369c <end_op>
  return 0;
    80004b2a:	4501                	li	a0,0
    80004b2c:	a84d                	j	80004bde <sys_unlink+0x1c4>
    end_op();
    80004b2e:	fffff097          	auipc	ra,0xfffff
    80004b32:	b6e080e7          	jalr	-1170(ra) # 8000369c <end_op>
    return -1;
    80004b36:	557d                	li	a0,-1
    80004b38:	a05d                	j	80004bde <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004b3a:	00004517          	auipc	a0,0x4
    80004b3e:	b4e50513          	addi	a0,a0,-1202 # 80008688 <syscalls+0x2b8>
    80004b42:	00001097          	auipc	ra,0x1
    80004b46:	340080e7          	jalr	832(ra) # 80005e82 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004b4a:	04c92703          	lw	a4,76(s2)
    80004b4e:	02000793          	li	a5,32
    80004b52:	f6e7f9e3          	bgeu	a5,a4,80004ac4 <sys_unlink+0xaa>
    80004b56:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004b5a:	4741                	li	a4,16
    80004b5c:	86ce                	mv	a3,s3
    80004b5e:	f1840613          	addi	a2,s0,-232
    80004b62:	4581                	li	a1,0
    80004b64:	854a                	mv	a0,s2
    80004b66:	ffffe097          	auipc	ra,0xffffe
    80004b6a:	3a6080e7          	jalr	934(ra) # 80002f0c <readi>
    80004b6e:	47c1                	li	a5,16
    80004b70:	00f51b63          	bne	a0,a5,80004b86 <sys_unlink+0x16c>
    if(de.inum != 0)
    80004b74:	f1845783          	lhu	a5,-232(s0)
    80004b78:	e7a1                	bnez	a5,80004bc0 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004b7a:	29c1                	addiw	s3,s3,16
    80004b7c:	04c92783          	lw	a5,76(s2)
    80004b80:	fcf9ede3          	bltu	s3,a5,80004b5a <sys_unlink+0x140>
    80004b84:	b781                	j	80004ac4 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004b86:	00004517          	auipc	a0,0x4
    80004b8a:	b1a50513          	addi	a0,a0,-1254 # 800086a0 <syscalls+0x2d0>
    80004b8e:	00001097          	auipc	ra,0x1
    80004b92:	2f4080e7          	jalr	756(ra) # 80005e82 <panic>
    panic("unlink: writei");
    80004b96:	00004517          	auipc	a0,0x4
    80004b9a:	b2250513          	addi	a0,a0,-1246 # 800086b8 <syscalls+0x2e8>
    80004b9e:	00001097          	auipc	ra,0x1
    80004ba2:	2e4080e7          	jalr	740(ra) # 80005e82 <panic>
    dp->nlink--;
    80004ba6:	04a4d783          	lhu	a5,74(s1)
    80004baa:	37fd                	addiw	a5,a5,-1
    80004bac:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004bb0:	8526                	mv	a0,s1
    80004bb2:	ffffe097          	auipc	ra,0xffffe
    80004bb6:	f36080e7          	jalr	-202(ra) # 80002ae8 <iupdate>
    80004bba:	b781                	j	80004afa <sys_unlink+0xe0>
    return -1;
    80004bbc:	557d                	li	a0,-1
    80004bbe:	a005                	j	80004bde <sys_unlink+0x1c4>
    iunlockput(ip);
    80004bc0:	854a                	mv	a0,s2
    80004bc2:	ffffe097          	auipc	ra,0xffffe
    80004bc6:	2f8080e7          	jalr	760(ra) # 80002eba <iunlockput>
  iunlockput(dp);
    80004bca:	8526                	mv	a0,s1
    80004bcc:	ffffe097          	auipc	ra,0xffffe
    80004bd0:	2ee080e7          	jalr	750(ra) # 80002eba <iunlockput>
  end_op();
    80004bd4:	fffff097          	auipc	ra,0xfffff
    80004bd8:	ac8080e7          	jalr	-1336(ra) # 8000369c <end_op>
  return -1;
    80004bdc:	557d                	li	a0,-1
}
    80004bde:	70ae                	ld	ra,232(sp)
    80004be0:	740e                	ld	s0,224(sp)
    80004be2:	64ee                	ld	s1,216(sp)
    80004be4:	694e                	ld	s2,208(sp)
    80004be6:	69ae                	ld	s3,200(sp)
    80004be8:	616d                	addi	sp,sp,240
    80004bea:	8082                	ret

0000000080004bec <sys_open>:

uint64
sys_open(void)
{
    80004bec:	7131                	addi	sp,sp,-192
    80004bee:	fd06                	sd	ra,184(sp)
    80004bf0:	f922                	sd	s0,176(sp)
    80004bf2:	f526                	sd	s1,168(sp)
    80004bf4:	f14a                	sd	s2,160(sp)
    80004bf6:	ed4e                	sd	s3,152(sp)
    80004bf8:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004bfa:	f4c40593          	addi	a1,s0,-180
    80004bfe:	4505                	li	a0,1
    80004c00:	ffffd097          	auipc	ra,0xffffd
    80004c04:	368080e7          	jalr	872(ra) # 80001f68 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004c08:	08000613          	li	a2,128
    80004c0c:	f5040593          	addi	a1,s0,-176
    80004c10:	4501                	li	a0,0
    80004c12:	ffffd097          	auipc	ra,0xffffd
    80004c16:	396080e7          	jalr	918(ra) # 80001fa8 <argstr>
    80004c1a:	87aa                	mv	a5,a0
    return -1;
    80004c1c:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004c1e:	1207cf63          	bltz	a5,80004d5c <sys_open+0x170>

  begin_op();
    80004c22:	fffff097          	auipc	ra,0xfffff
    80004c26:	9fa080e7          	jalr	-1542(ra) # 8000361c <begin_op>

  if(omode & O_CREATE){
    80004c2a:	f4c42783          	lw	a5,-180(s0)
    80004c2e:	2007f793          	andi	a5,a5,512
    80004c32:	492d                	li	s2,11
      if((ip = namei(path)) == 0){
        end_op();
        return -1;
      }
      ilock(ip);
      if(ip->type == T_SYMLINK && (omode & O_NOFOLLOW) == 0) {
    80004c34:	4991                	li	s3,4
  if(omode & O_CREATE){
    80004c36:	efb1                	bnez	a5,80004c92 <sys_open+0xa6>
      if((ip = namei(path)) == 0){
    80004c38:	f5040513          	addi	a0,s0,-176
    80004c3c:	ffffe097          	auipc	ra,0xffffe
    80004c40:	7c4080e7          	jalr	1988(ra) # 80003400 <namei>
    80004c44:	84aa                	mv	s1,a0
    80004c46:	c97d                	beqz	a0,80004d3c <sys_open+0x150>
      ilock(ip);
    80004c48:	ffffe097          	auipc	ra,0xffffe
    80004c4c:	f6a080e7          	jalr	-150(ra) # 80002bb2 <ilock>
      if(ip->type == T_SYMLINK && (omode & O_NOFOLLOW) == 0) {
    80004c50:	04449783          	lh	a5,68(s1)
    80004c54:	0007871b          	sext.w	a4,a5
    80004c58:	13371463          	bne	a4,s3,80004d80 <sys_open+0x194>
    80004c5c:	f4c42783          	lw	a5,-180(s0)
    80004c60:	6007f793          	andi	a5,a5,1536
    80004c64:	efa1                	bnez	a5,80004cbc <sys_open+0xd0>
        if(++symlink_depth > 10) {
    80004c66:	397d                	addiw	s2,s2,-1
    80004c68:	0e090063          	beqz	s2,80004d48 <sys_open+0x15c>
          iunlockput(ip);
          end_op();
          return -1;
        }
        if(readi(ip, 0, (uint64)path, 0, MAXPATH) < 0) {
    80004c6c:	08000713          	li	a4,128
    80004c70:	4681                	li	a3,0
    80004c72:	f5040613          	addi	a2,s0,-176
    80004c76:	4581                	li	a1,0
    80004c78:	8526                	mv	a0,s1
    80004c7a:	ffffe097          	auipc	ra,0xffffe
    80004c7e:	292080e7          	jalr	658(ra) # 80002f0c <readi>
    80004c82:	0e054463          	bltz	a0,80004d6a <sys_open+0x17e>
          iunlockput(ip);
          end_op();
          return -1;
        }
        iunlockput(ip);
    80004c86:	8526                	mv	a0,s1
    80004c88:	ffffe097          	auipc	ra,0xffffe
    80004c8c:	232080e7          	jalr	562(ra) # 80002eba <iunlockput>
      if((ip = namei(path)) == 0){
    80004c90:	b765                	j	80004c38 <sys_open+0x4c>
    ip = create(path, T_FILE, 0, 0);
    80004c92:	4681                	li	a3,0
    80004c94:	4601                	li	a2,0
    80004c96:	4589                	li	a1,2
    80004c98:	f5040513          	addi	a0,s0,-176
    80004c9c:	00000097          	auipc	ra,0x0
    80004ca0:	916080e7          	jalr	-1770(ra) # 800045b2 <create>
    80004ca4:	84aa                	mv	s1,a0
    if(ip == 0){
    80004ca6:	c549                	beqz	a0,80004d30 <sys_open+0x144>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004ca8:	04449703          	lh	a4,68(s1)
    80004cac:	478d                	li	a5,3
    80004cae:	00f71763          	bne	a4,a5,80004cbc <sys_open+0xd0>
    80004cb2:	0464d703          	lhu	a4,70(s1)
    80004cb6:	47a5                	li	a5,9
    80004cb8:	0ee7e663          	bltu	a5,a4,80004da4 <sys_open+0x1b8>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004cbc:	fffff097          	auipc	ra,0xfffff
    80004cc0:	d70080e7          	jalr	-656(ra) # 80003a2c <filealloc>
    80004cc4:	89aa                	mv	s3,a0
    80004cc6:	10050c63          	beqz	a0,80004dde <sys_open+0x1f2>
    80004cca:	00000097          	auipc	ra,0x0
    80004cce:	8a6080e7          	jalr	-1882(ra) # 80004570 <fdalloc>
    80004cd2:	892a                	mv	s2,a0
    80004cd4:	10054063          	bltz	a0,80004dd4 <sys_open+0x1e8>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004cd8:	04449703          	lh	a4,68(s1)
    80004cdc:	478d                	li	a5,3
    80004cde:	0cf70e63          	beq	a4,a5,80004dba <sys_open+0x1ce>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004ce2:	4789                	li	a5,2
    80004ce4:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004ce8:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004cec:	0099bc23          	sd	s1,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004cf0:	f4c42783          	lw	a5,-180(s0)
    80004cf4:	0017c713          	xori	a4,a5,1
    80004cf8:	8b05                	andi	a4,a4,1
    80004cfa:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004cfe:	0037f713          	andi	a4,a5,3
    80004d02:	00e03733          	snez	a4,a4
    80004d06:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004d0a:	4007f793          	andi	a5,a5,1024
    80004d0e:	c791                	beqz	a5,80004d1a <sys_open+0x12e>
    80004d10:	04449703          	lh	a4,68(s1)
    80004d14:	4789                	li	a5,2
    80004d16:	0af70963          	beq	a4,a5,80004dc8 <sys_open+0x1dc>
    itrunc(ip);
  }

  iunlock(ip);
    80004d1a:	8526                	mv	a0,s1
    80004d1c:	ffffe097          	auipc	ra,0xffffe
    80004d20:	f58080e7          	jalr	-168(ra) # 80002c74 <iunlock>
  end_op();
    80004d24:	fffff097          	auipc	ra,0xfffff
    80004d28:	978080e7          	jalr	-1672(ra) # 8000369c <end_op>

  return fd;
    80004d2c:	854a                	mv	a0,s2
    80004d2e:	a03d                	j	80004d5c <sys_open+0x170>
      end_op();
    80004d30:	fffff097          	auipc	ra,0xfffff
    80004d34:	96c080e7          	jalr	-1684(ra) # 8000369c <end_op>
      return -1;
    80004d38:	557d                	li	a0,-1
    80004d3a:	a00d                	j	80004d5c <sys_open+0x170>
        end_op();
    80004d3c:	fffff097          	auipc	ra,0xfffff
    80004d40:	960080e7          	jalr	-1696(ra) # 8000369c <end_op>
        return -1;
    80004d44:	557d                	li	a0,-1
    80004d46:	a819                	j	80004d5c <sys_open+0x170>
          iunlockput(ip);
    80004d48:	8526                	mv	a0,s1
    80004d4a:	ffffe097          	auipc	ra,0xffffe
    80004d4e:	170080e7          	jalr	368(ra) # 80002eba <iunlockput>
          end_op();
    80004d52:	fffff097          	auipc	ra,0xfffff
    80004d56:	94a080e7          	jalr	-1718(ra) # 8000369c <end_op>
          return -1;
    80004d5a:	557d                	li	a0,-1
}
    80004d5c:	70ea                	ld	ra,184(sp)
    80004d5e:	744a                	ld	s0,176(sp)
    80004d60:	74aa                	ld	s1,168(sp)
    80004d62:	790a                	ld	s2,160(sp)
    80004d64:	69ea                	ld	s3,152(sp)
    80004d66:	6129                	addi	sp,sp,192
    80004d68:	8082                	ret
          iunlockput(ip);
    80004d6a:	8526                	mv	a0,s1
    80004d6c:	ffffe097          	auipc	ra,0xffffe
    80004d70:	14e080e7          	jalr	334(ra) # 80002eba <iunlockput>
          end_op();
    80004d74:	fffff097          	auipc	ra,0xfffff
    80004d78:	928080e7          	jalr	-1752(ra) # 8000369c <end_op>
          return -1;
    80004d7c:	557d                	li	a0,-1
    80004d7e:	bff9                	j	80004d5c <sys_open+0x170>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004d80:	2781                	sext.w	a5,a5
    80004d82:	4705                	li	a4,1
    80004d84:	f2e792e3          	bne	a5,a4,80004ca8 <sys_open+0xbc>
    80004d88:	f4c42783          	lw	a5,-180(s0)
    80004d8c:	db85                	beqz	a5,80004cbc <sys_open+0xd0>
      iunlockput(ip);
    80004d8e:	8526                	mv	a0,s1
    80004d90:	ffffe097          	auipc	ra,0xffffe
    80004d94:	12a080e7          	jalr	298(ra) # 80002eba <iunlockput>
      end_op();
    80004d98:	fffff097          	auipc	ra,0xfffff
    80004d9c:	904080e7          	jalr	-1788(ra) # 8000369c <end_op>
      return -1;
    80004da0:	557d                	li	a0,-1
    80004da2:	bf6d                	j	80004d5c <sys_open+0x170>
    iunlockput(ip);
    80004da4:	8526                	mv	a0,s1
    80004da6:	ffffe097          	auipc	ra,0xffffe
    80004daa:	114080e7          	jalr	276(ra) # 80002eba <iunlockput>
    end_op();
    80004dae:	fffff097          	auipc	ra,0xfffff
    80004db2:	8ee080e7          	jalr	-1810(ra) # 8000369c <end_op>
    return -1;
    80004db6:	557d                	li	a0,-1
    80004db8:	b755                	j	80004d5c <sys_open+0x170>
    f->type = FD_DEVICE;
    80004dba:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004dbe:	04649783          	lh	a5,70(s1)
    80004dc2:	02f99223          	sh	a5,36(s3)
    80004dc6:	b71d                	j	80004cec <sys_open+0x100>
    itrunc(ip);
    80004dc8:	8526                	mv	a0,s1
    80004dca:	ffffe097          	auipc	ra,0xffffe
    80004dce:	ef6080e7          	jalr	-266(ra) # 80002cc0 <itrunc>
    80004dd2:	b7a1                	j	80004d1a <sys_open+0x12e>
      fileclose(f);
    80004dd4:	854e                	mv	a0,s3
    80004dd6:	fffff097          	auipc	ra,0xfffff
    80004dda:	d12080e7          	jalr	-750(ra) # 80003ae8 <fileclose>
    iunlockput(ip);
    80004dde:	8526                	mv	a0,s1
    80004de0:	ffffe097          	auipc	ra,0xffffe
    80004de4:	0da080e7          	jalr	218(ra) # 80002eba <iunlockput>
    end_op();
    80004de8:	fffff097          	auipc	ra,0xfffff
    80004dec:	8b4080e7          	jalr	-1868(ra) # 8000369c <end_op>
    return -1;
    80004df0:	557d                	li	a0,-1
    80004df2:	b7ad                	j	80004d5c <sys_open+0x170>

0000000080004df4 <sys_mkdir>:

uint64
sys_mkdir(void)//cankao
{
    80004df4:	7175                	addi	sp,sp,-144
    80004df6:	e506                	sd	ra,136(sp)
    80004df8:	e122                	sd	s0,128(sp)
    80004dfa:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004dfc:	fffff097          	auipc	ra,0xfffff
    80004e00:	820080e7          	jalr	-2016(ra) # 8000361c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004e04:	08000613          	li	a2,128
    80004e08:	f7040593          	addi	a1,s0,-144
    80004e0c:	4501                	li	a0,0
    80004e0e:	ffffd097          	auipc	ra,0xffffd
    80004e12:	19a080e7          	jalr	410(ra) # 80001fa8 <argstr>
    80004e16:	02054963          	bltz	a0,80004e48 <sys_mkdir+0x54>
    80004e1a:	4681                	li	a3,0
    80004e1c:	4601                	li	a2,0
    80004e1e:	4585                	li	a1,1
    80004e20:	f7040513          	addi	a0,s0,-144
    80004e24:	fffff097          	auipc	ra,0xfffff
    80004e28:	78e080e7          	jalr	1934(ra) # 800045b2 <create>
    80004e2c:	cd11                	beqz	a0,80004e48 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004e2e:	ffffe097          	auipc	ra,0xffffe
    80004e32:	08c080e7          	jalr	140(ra) # 80002eba <iunlockput>
  end_op();
    80004e36:	fffff097          	auipc	ra,0xfffff
    80004e3a:	866080e7          	jalr	-1946(ra) # 8000369c <end_op>
  return 0;
    80004e3e:	4501                	li	a0,0
}
    80004e40:	60aa                	ld	ra,136(sp)
    80004e42:	640a                	ld	s0,128(sp)
    80004e44:	6149                	addi	sp,sp,144
    80004e46:	8082                	ret
    end_op();
    80004e48:	fffff097          	auipc	ra,0xfffff
    80004e4c:	854080e7          	jalr	-1964(ra) # 8000369c <end_op>
    return -1;
    80004e50:	557d                	li	a0,-1
    80004e52:	b7fd                	j	80004e40 <sys_mkdir+0x4c>

0000000080004e54 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004e54:	7135                	addi	sp,sp,-160
    80004e56:	ed06                	sd	ra,152(sp)
    80004e58:	e922                	sd	s0,144(sp)
    80004e5a:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004e5c:	ffffe097          	auipc	ra,0xffffe
    80004e60:	7c0080e7          	jalr	1984(ra) # 8000361c <begin_op>
  argint(1, &major);
    80004e64:	f6c40593          	addi	a1,s0,-148
    80004e68:	4505                	li	a0,1
    80004e6a:	ffffd097          	auipc	ra,0xffffd
    80004e6e:	0fe080e7          	jalr	254(ra) # 80001f68 <argint>
  argint(2, &minor);
    80004e72:	f6840593          	addi	a1,s0,-152
    80004e76:	4509                	li	a0,2
    80004e78:	ffffd097          	auipc	ra,0xffffd
    80004e7c:	0f0080e7          	jalr	240(ra) # 80001f68 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004e80:	08000613          	li	a2,128
    80004e84:	f7040593          	addi	a1,s0,-144
    80004e88:	4501                	li	a0,0
    80004e8a:	ffffd097          	auipc	ra,0xffffd
    80004e8e:	11e080e7          	jalr	286(ra) # 80001fa8 <argstr>
    80004e92:	02054b63          	bltz	a0,80004ec8 <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004e96:	f6841683          	lh	a3,-152(s0)
    80004e9a:	f6c41603          	lh	a2,-148(s0)
    80004e9e:	458d                	li	a1,3
    80004ea0:	f7040513          	addi	a0,s0,-144
    80004ea4:	fffff097          	auipc	ra,0xfffff
    80004ea8:	70e080e7          	jalr	1806(ra) # 800045b2 <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004eac:	cd11                	beqz	a0,80004ec8 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004eae:	ffffe097          	auipc	ra,0xffffe
    80004eb2:	00c080e7          	jalr	12(ra) # 80002eba <iunlockput>
  end_op();
    80004eb6:	ffffe097          	auipc	ra,0xffffe
    80004eba:	7e6080e7          	jalr	2022(ra) # 8000369c <end_op>
  return 0;
    80004ebe:	4501                	li	a0,0
}
    80004ec0:	60ea                	ld	ra,152(sp)
    80004ec2:	644a                	ld	s0,144(sp)
    80004ec4:	610d                	addi	sp,sp,160
    80004ec6:	8082                	ret
    end_op();
    80004ec8:	ffffe097          	auipc	ra,0xffffe
    80004ecc:	7d4080e7          	jalr	2004(ra) # 8000369c <end_op>
    return -1;
    80004ed0:	557d                	li	a0,-1
    80004ed2:	b7fd                	j	80004ec0 <sys_mknod+0x6c>

0000000080004ed4 <sys_chdir>:

uint64
sys_chdir(void)
{
    80004ed4:	7135                	addi	sp,sp,-160
    80004ed6:	ed06                	sd	ra,152(sp)
    80004ed8:	e922                	sd	s0,144(sp)
    80004eda:	e526                	sd	s1,136(sp)
    80004edc:	e14a                	sd	s2,128(sp)
    80004ede:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004ee0:	ffffc097          	auipc	ra,0xffffc
    80004ee4:	f78080e7          	jalr	-136(ra) # 80000e58 <myproc>
    80004ee8:	892a                	mv	s2,a0
  
  begin_op();
    80004eea:	ffffe097          	auipc	ra,0xffffe
    80004eee:	732080e7          	jalr	1842(ra) # 8000361c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004ef2:	08000613          	li	a2,128
    80004ef6:	f6040593          	addi	a1,s0,-160
    80004efa:	4501                	li	a0,0
    80004efc:	ffffd097          	auipc	ra,0xffffd
    80004f00:	0ac080e7          	jalr	172(ra) # 80001fa8 <argstr>
    80004f04:	04054b63          	bltz	a0,80004f5a <sys_chdir+0x86>
    80004f08:	f6040513          	addi	a0,s0,-160
    80004f0c:	ffffe097          	auipc	ra,0xffffe
    80004f10:	4f4080e7          	jalr	1268(ra) # 80003400 <namei>
    80004f14:	84aa                	mv	s1,a0
    80004f16:	c131                	beqz	a0,80004f5a <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004f18:	ffffe097          	auipc	ra,0xffffe
    80004f1c:	c9a080e7          	jalr	-870(ra) # 80002bb2 <ilock>
  if(ip->type != T_DIR){
    80004f20:	04449703          	lh	a4,68(s1)
    80004f24:	4785                	li	a5,1
    80004f26:	04f71063          	bne	a4,a5,80004f66 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004f2a:	8526                	mv	a0,s1
    80004f2c:	ffffe097          	auipc	ra,0xffffe
    80004f30:	d48080e7          	jalr	-696(ra) # 80002c74 <iunlock>
  iput(p->cwd);
    80004f34:	15093503          	ld	a0,336(s2)
    80004f38:	ffffe097          	auipc	ra,0xffffe
    80004f3c:	eda080e7          	jalr	-294(ra) # 80002e12 <iput>
  end_op();
    80004f40:	ffffe097          	auipc	ra,0xffffe
    80004f44:	75c080e7          	jalr	1884(ra) # 8000369c <end_op>
  p->cwd = ip;
    80004f48:	14993823          	sd	s1,336(s2)
  return 0;
    80004f4c:	4501                	li	a0,0
}
    80004f4e:	60ea                	ld	ra,152(sp)
    80004f50:	644a                	ld	s0,144(sp)
    80004f52:	64aa                	ld	s1,136(sp)
    80004f54:	690a                	ld	s2,128(sp)
    80004f56:	610d                	addi	sp,sp,160
    80004f58:	8082                	ret
    end_op();
    80004f5a:	ffffe097          	auipc	ra,0xffffe
    80004f5e:	742080e7          	jalr	1858(ra) # 8000369c <end_op>
    return -1;
    80004f62:	557d                	li	a0,-1
    80004f64:	b7ed                	j	80004f4e <sys_chdir+0x7a>
    iunlockput(ip);
    80004f66:	8526                	mv	a0,s1
    80004f68:	ffffe097          	auipc	ra,0xffffe
    80004f6c:	f52080e7          	jalr	-174(ra) # 80002eba <iunlockput>
    end_op();
    80004f70:	ffffe097          	auipc	ra,0xffffe
    80004f74:	72c080e7          	jalr	1836(ra) # 8000369c <end_op>
    return -1;
    80004f78:	557d                	li	a0,-1
    80004f7a:	bfd1                	j	80004f4e <sys_chdir+0x7a>

0000000080004f7c <sys_exec>:

uint64
sys_exec(void)
{
    80004f7c:	7145                	addi	sp,sp,-464
    80004f7e:	e786                	sd	ra,456(sp)
    80004f80:	e3a2                	sd	s0,448(sp)
    80004f82:	ff26                	sd	s1,440(sp)
    80004f84:	fb4a                	sd	s2,432(sp)
    80004f86:	f74e                	sd	s3,424(sp)
    80004f88:	f352                	sd	s4,416(sp)
    80004f8a:	ef56                	sd	s5,408(sp)
    80004f8c:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80004f8e:	e3840593          	addi	a1,s0,-456
    80004f92:	4505                	li	a0,1
    80004f94:	ffffd097          	auipc	ra,0xffffd
    80004f98:	ff4080e7          	jalr	-12(ra) # 80001f88 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80004f9c:	08000613          	li	a2,128
    80004fa0:	f4040593          	addi	a1,s0,-192
    80004fa4:	4501                	li	a0,0
    80004fa6:	ffffd097          	auipc	ra,0xffffd
    80004faa:	002080e7          	jalr	2(ra) # 80001fa8 <argstr>
    80004fae:	87aa                	mv	a5,a0
    return -1;
    80004fb0:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80004fb2:	0c07c263          	bltz	a5,80005076 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80004fb6:	10000613          	li	a2,256
    80004fba:	4581                	li	a1,0
    80004fbc:	e4040513          	addi	a0,s0,-448
    80004fc0:	ffffb097          	auipc	ra,0xffffb
    80004fc4:	1b8080e7          	jalr	440(ra) # 80000178 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004fc8:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80004fcc:	89a6                	mv	s3,s1
    80004fce:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80004fd0:	02000a13          	li	s4,32
    80004fd4:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004fd8:	00391513          	slli	a0,s2,0x3
    80004fdc:	e3040593          	addi	a1,s0,-464
    80004fe0:	e3843783          	ld	a5,-456(s0)
    80004fe4:	953e                	add	a0,a0,a5
    80004fe6:	ffffd097          	auipc	ra,0xffffd
    80004fea:	ee4080e7          	jalr	-284(ra) # 80001eca <fetchaddr>
    80004fee:	02054a63          	bltz	a0,80005022 <sys_exec+0xa6>
      goto bad;
    }
    if(uarg == 0){
    80004ff2:	e3043783          	ld	a5,-464(s0)
    80004ff6:	c3b9                	beqz	a5,8000503c <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80004ff8:	ffffb097          	auipc	ra,0xffffb
    80004ffc:	120080e7          	jalr	288(ra) # 80000118 <kalloc>
    80005000:	85aa                	mv	a1,a0
    80005002:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005006:	cd11                	beqz	a0,80005022 <sys_exec+0xa6>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005008:	6605                	lui	a2,0x1
    8000500a:	e3043503          	ld	a0,-464(s0)
    8000500e:	ffffd097          	auipc	ra,0xffffd
    80005012:	f0e080e7          	jalr	-242(ra) # 80001f1c <fetchstr>
    80005016:	00054663          	bltz	a0,80005022 <sys_exec+0xa6>
    if(i >= NELEM(argv)){
    8000501a:	0905                	addi	s2,s2,1
    8000501c:	09a1                	addi	s3,s3,8
    8000501e:	fb491be3          	bne	s2,s4,80004fd4 <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005022:	10048913          	addi	s2,s1,256
    80005026:	6088                	ld	a0,0(s1)
    80005028:	c531                	beqz	a0,80005074 <sys_exec+0xf8>
    kfree(argv[i]);
    8000502a:	ffffb097          	auipc	ra,0xffffb
    8000502e:	ff2080e7          	jalr	-14(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005032:	04a1                	addi	s1,s1,8
    80005034:	ff2499e3          	bne	s1,s2,80005026 <sys_exec+0xaa>
  return -1;
    80005038:	557d                	li	a0,-1
    8000503a:	a835                	j	80005076 <sys_exec+0xfa>
      argv[i] = 0;
    8000503c:	0a8e                	slli	s5,s5,0x3
    8000503e:	fc040793          	addi	a5,s0,-64
    80005042:	9abe                	add	s5,s5,a5
    80005044:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80005048:	e4040593          	addi	a1,s0,-448
    8000504c:	f4040513          	addi	a0,s0,-192
    80005050:	fffff097          	auipc	ra,0xfffff
    80005054:	120080e7          	jalr	288(ra) # 80004170 <exec>
    80005058:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000505a:	10048993          	addi	s3,s1,256
    8000505e:	6088                	ld	a0,0(s1)
    80005060:	c901                	beqz	a0,80005070 <sys_exec+0xf4>
    kfree(argv[i]);
    80005062:	ffffb097          	auipc	ra,0xffffb
    80005066:	fba080e7          	jalr	-70(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000506a:	04a1                	addi	s1,s1,8
    8000506c:	ff3499e3          	bne	s1,s3,8000505e <sys_exec+0xe2>
  return ret;
    80005070:	854a                	mv	a0,s2
    80005072:	a011                	j	80005076 <sys_exec+0xfa>
  return -1;
    80005074:	557d                	li	a0,-1
}
    80005076:	60be                	ld	ra,456(sp)
    80005078:	641e                	ld	s0,448(sp)
    8000507a:	74fa                	ld	s1,440(sp)
    8000507c:	795a                	ld	s2,432(sp)
    8000507e:	79ba                	ld	s3,424(sp)
    80005080:	7a1a                	ld	s4,416(sp)
    80005082:	6afa                	ld	s5,408(sp)
    80005084:	6179                	addi	sp,sp,464
    80005086:	8082                	ret

0000000080005088 <sys_pipe>:

uint64
sys_pipe(void)
{
    80005088:	7139                	addi	sp,sp,-64
    8000508a:	fc06                	sd	ra,56(sp)
    8000508c:	f822                	sd	s0,48(sp)
    8000508e:	f426                	sd	s1,40(sp)
    80005090:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005092:	ffffc097          	auipc	ra,0xffffc
    80005096:	dc6080e7          	jalr	-570(ra) # 80000e58 <myproc>
    8000509a:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    8000509c:	fd840593          	addi	a1,s0,-40
    800050a0:	4501                	li	a0,0
    800050a2:	ffffd097          	auipc	ra,0xffffd
    800050a6:	ee6080e7          	jalr	-282(ra) # 80001f88 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    800050aa:	fc840593          	addi	a1,s0,-56
    800050ae:	fd040513          	addi	a0,s0,-48
    800050b2:	fffff097          	auipc	ra,0xfffff
    800050b6:	d66080e7          	jalr	-666(ra) # 80003e18 <pipealloc>
    return -1;
    800050ba:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800050bc:	0c054463          	bltz	a0,80005184 <sys_pipe+0xfc>
  fd0 = -1;
    800050c0:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800050c4:	fd043503          	ld	a0,-48(s0)
    800050c8:	fffff097          	auipc	ra,0xfffff
    800050cc:	4a8080e7          	jalr	1192(ra) # 80004570 <fdalloc>
    800050d0:	fca42223          	sw	a0,-60(s0)
    800050d4:	08054b63          	bltz	a0,8000516a <sys_pipe+0xe2>
    800050d8:	fc843503          	ld	a0,-56(s0)
    800050dc:	fffff097          	auipc	ra,0xfffff
    800050e0:	494080e7          	jalr	1172(ra) # 80004570 <fdalloc>
    800050e4:	fca42023          	sw	a0,-64(s0)
    800050e8:	06054863          	bltz	a0,80005158 <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800050ec:	4691                	li	a3,4
    800050ee:	fc440613          	addi	a2,s0,-60
    800050f2:	fd843583          	ld	a1,-40(s0)
    800050f6:	68a8                	ld	a0,80(s1)
    800050f8:	ffffc097          	auipc	ra,0xffffc
    800050fc:	a1e080e7          	jalr	-1506(ra) # 80000b16 <copyout>
    80005100:	02054063          	bltz	a0,80005120 <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005104:	4691                	li	a3,4
    80005106:	fc040613          	addi	a2,s0,-64
    8000510a:	fd843583          	ld	a1,-40(s0)
    8000510e:	0591                	addi	a1,a1,4
    80005110:	68a8                	ld	a0,80(s1)
    80005112:	ffffc097          	auipc	ra,0xffffc
    80005116:	a04080e7          	jalr	-1532(ra) # 80000b16 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    8000511a:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000511c:	06055463          	bgez	a0,80005184 <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    80005120:	fc442783          	lw	a5,-60(s0)
    80005124:	07e9                	addi	a5,a5,26
    80005126:	078e                	slli	a5,a5,0x3
    80005128:	97a6                	add	a5,a5,s1
    8000512a:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    8000512e:	fc042503          	lw	a0,-64(s0)
    80005132:	0569                	addi	a0,a0,26
    80005134:	050e                	slli	a0,a0,0x3
    80005136:	94aa                	add	s1,s1,a0
    80005138:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    8000513c:	fd043503          	ld	a0,-48(s0)
    80005140:	fffff097          	auipc	ra,0xfffff
    80005144:	9a8080e7          	jalr	-1624(ra) # 80003ae8 <fileclose>
    fileclose(wf);
    80005148:	fc843503          	ld	a0,-56(s0)
    8000514c:	fffff097          	auipc	ra,0xfffff
    80005150:	99c080e7          	jalr	-1636(ra) # 80003ae8 <fileclose>
    return -1;
    80005154:	57fd                	li	a5,-1
    80005156:	a03d                	j	80005184 <sys_pipe+0xfc>
    if(fd0 >= 0)
    80005158:	fc442783          	lw	a5,-60(s0)
    8000515c:	0007c763          	bltz	a5,8000516a <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    80005160:	07e9                	addi	a5,a5,26
    80005162:	078e                	slli	a5,a5,0x3
    80005164:	94be                	add	s1,s1,a5
    80005166:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    8000516a:	fd043503          	ld	a0,-48(s0)
    8000516e:	fffff097          	auipc	ra,0xfffff
    80005172:	97a080e7          	jalr	-1670(ra) # 80003ae8 <fileclose>
    fileclose(wf);
    80005176:	fc843503          	ld	a0,-56(s0)
    8000517a:	fffff097          	auipc	ra,0xfffff
    8000517e:	96e080e7          	jalr	-1682(ra) # 80003ae8 <fileclose>
    return -1;
    80005182:	57fd                	li	a5,-1
}
    80005184:	853e                	mv	a0,a5
    80005186:	70e2                	ld	ra,56(sp)
    80005188:	7442                	ld	s0,48(sp)
    8000518a:	74a2                	ld	s1,40(sp)
    8000518c:	6121                	addi	sp,sp,64
    8000518e:	8082                	ret

0000000080005190 <sys_symlink>:

uint64
sys_symlink(void)
{
    80005190:	712d                	addi	sp,sp,-288
    80005192:	ee06                	sd	ra,280(sp)
    80005194:	ea22                	sd	s0,272(sp)
    80005196:	e626                	sd	s1,264(sp)
    80005198:	1200                	addi	s0,sp,288
  struct inode *ip;
  char target[MAXPATH], path[MAXPATH];
  if(argstr(0, target, MAXPATH) < 0 || argstr(1, path, MAXPATH) < 0)
    8000519a:	08000613          	li	a2,128
    8000519e:	f6040593          	addi	a1,s0,-160
    800051a2:	4501                	li	a0,0
    800051a4:	ffffd097          	auipc	ra,0xffffd
    800051a8:	e04080e7          	jalr	-508(ra) # 80001fa8 <argstr>
    return -1;
    800051ac:	57fd                	li	a5,-1
  if(argstr(0, target, MAXPATH) < 0 || argstr(1, path, MAXPATH) < 0)
    800051ae:	06054a63          	bltz	a0,80005222 <sys_symlink+0x92>
    800051b2:	08000613          	li	a2,128
    800051b6:	ee040593          	addi	a1,s0,-288
    800051ba:	4505                	li	a0,1
    800051bc:	ffffd097          	auipc	ra,0xffffd
    800051c0:	dec080e7          	jalr	-532(ra) # 80001fa8 <argstr>
    return -1;
    800051c4:	57fd                	li	a5,-1
  if(argstr(0, target, MAXPATH) < 0 || argstr(1, path, MAXPATH) < 0)
    800051c6:	04054e63          	bltz	a0,80005222 <sys_symlink+0x92>

  begin_op();
    800051ca:	ffffe097          	auipc	ra,0xffffe
    800051ce:	452080e7          	jalr	1106(ra) # 8000361c <begin_op>

  ip = create(path, T_SYMLINK, 0, 0);
    800051d2:	4681                	li	a3,0
    800051d4:	4601                	li	a2,0
    800051d6:	4591                	li	a1,4
    800051d8:	ee040513          	addi	a0,s0,-288
    800051dc:	fffff097          	auipc	ra,0xfffff
    800051e0:	3d6080e7          	jalr	982(ra) # 800045b2 <create>
    800051e4:	84aa                	mv	s1,a0
  if(ip == 0){
    800051e6:	c521                	beqz	a0,8000522e <sys_symlink+0x9e>
    end_op();
    return -1;
  }

  // use first data block to save path
  if(writei(ip, 0, (uint64)target, 0, strlen(target)) < 0) {
    800051e8:	f6040513          	addi	a0,s0,-160
    800051ec:	ffffb097          	auipc	ra,0xffffb
    800051f0:	110080e7          	jalr	272(ra) # 800002fc <strlen>
    800051f4:	0005071b          	sext.w	a4,a0
    800051f8:	4681                	li	a3,0
    800051fa:	f6040613          	addi	a2,s0,-160
    800051fe:	4581                	li	a1,0
    80005200:	8526                	mv	a0,s1
    80005202:	ffffe097          	auipc	ra,0xffffe
    80005206:	e02080e7          	jalr	-510(ra) # 80003004 <writei>
    8000520a:	02054863          	bltz	a0,8000523a <sys_symlink+0xaa>
    end_op();
    return -1;
  }

  iunlockput(ip);
    8000520e:	8526                	mv	a0,s1
    80005210:	ffffe097          	auipc	ra,0xffffe
    80005214:	caa080e7          	jalr	-854(ra) # 80002eba <iunlockput>

  end_op();
    80005218:	ffffe097          	auipc	ra,0xffffe
    8000521c:	484080e7          	jalr	1156(ra) # 8000369c <end_op>
  return 0;
    80005220:	4781                	li	a5,0
    80005222:	853e                	mv	a0,a5
    80005224:	60f2                	ld	ra,280(sp)
    80005226:	6452                	ld	s0,272(sp)
    80005228:	64b2                	ld	s1,264(sp)
    8000522a:	6115                	addi	sp,sp,288
    8000522c:	8082                	ret
    end_op();
    8000522e:	ffffe097          	auipc	ra,0xffffe
    80005232:	46e080e7          	jalr	1134(ra) # 8000369c <end_op>
    return -1;
    80005236:	57fd                	li	a5,-1
    80005238:	b7ed                	j	80005222 <sys_symlink+0x92>
    end_op();
    8000523a:	ffffe097          	auipc	ra,0xffffe
    8000523e:	462080e7          	jalr	1122(ra) # 8000369c <end_op>
    return -1;
    80005242:	57fd                	li	a5,-1
    80005244:	bff9                	j	80005222 <sys_symlink+0x92>
	...

0000000080005250 <kernelvec>:
    80005250:	7111                	addi	sp,sp,-256
    80005252:	e006                	sd	ra,0(sp)
    80005254:	e40a                	sd	sp,8(sp)
    80005256:	e80e                	sd	gp,16(sp)
    80005258:	ec12                	sd	tp,24(sp)
    8000525a:	f016                	sd	t0,32(sp)
    8000525c:	f41a                	sd	t1,40(sp)
    8000525e:	f81e                	sd	t2,48(sp)
    80005260:	fc22                	sd	s0,56(sp)
    80005262:	e0a6                	sd	s1,64(sp)
    80005264:	e4aa                	sd	a0,72(sp)
    80005266:	e8ae                	sd	a1,80(sp)
    80005268:	ecb2                	sd	a2,88(sp)
    8000526a:	f0b6                	sd	a3,96(sp)
    8000526c:	f4ba                	sd	a4,104(sp)
    8000526e:	f8be                	sd	a5,112(sp)
    80005270:	fcc2                	sd	a6,120(sp)
    80005272:	e146                	sd	a7,128(sp)
    80005274:	e54a                	sd	s2,136(sp)
    80005276:	e94e                	sd	s3,144(sp)
    80005278:	ed52                	sd	s4,152(sp)
    8000527a:	f156                	sd	s5,160(sp)
    8000527c:	f55a                	sd	s6,168(sp)
    8000527e:	f95e                	sd	s7,176(sp)
    80005280:	fd62                	sd	s8,184(sp)
    80005282:	e1e6                	sd	s9,192(sp)
    80005284:	e5ea                	sd	s10,200(sp)
    80005286:	e9ee                	sd	s11,208(sp)
    80005288:	edf2                	sd	t3,216(sp)
    8000528a:	f1f6                	sd	t4,224(sp)
    8000528c:	f5fa                	sd	t5,232(sp)
    8000528e:	f9fe                	sd	t6,240(sp)
    80005290:	b07fc0ef          	jal	ra,80001d96 <kerneltrap>
    80005294:	6082                	ld	ra,0(sp)
    80005296:	6122                	ld	sp,8(sp)
    80005298:	61c2                	ld	gp,16(sp)
    8000529a:	7282                	ld	t0,32(sp)
    8000529c:	7322                	ld	t1,40(sp)
    8000529e:	73c2                	ld	t2,48(sp)
    800052a0:	7462                	ld	s0,56(sp)
    800052a2:	6486                	ld	s1,64(sp)
    800052a4:	6526                	ld	a0,72(sp)
    800052a6:	65c6                	ld	a1,80(sp)
    800052a8:	6666                	ld	a2,88(sp)
    800052aa:	7686                	ld	a3,96(sp)
    800052ac:	7726                	ld	a4,104(sp)
    800052ae:	77c6                	ld	a5,112(sp)
    800052b0:	7866                	ld	a6,120(sp)
    800052b2:	688a                	ld	a7,128(sp)
    800052b4:	692a                	ld	s2,136(sp)
    800052b6:	69ca                	ld	s3,144(sp)
    800052b8:	6a6a                	ld	s4,152(sp)
    800052ba:	7a8a                	ld	s5,160(sp)
    800052bc:	7b2a                	ld	s6,168(sp)
    800052be:	7bca                	ld	s7,176(sp)
    800052c0:	7c6a                	ld	s8,184(sp)
    800052c2:	6c8e                	ld	s9,192(sp)
    800052c4:	6d2e                	ld	s10,200(sp)
    800052c6:	6dce                	ld	s11,208(sp)
    800052c8:	6e6e                	ld	t3,216(sp)
    800052ca:	7e8e                	ld	t4,224(sp)
    800052cc:	7f2e                	ld	t5,232(sp)
    800052ce:	7fce                	ld	t6,240(sp)
    800052d0:	6111                	addi	sp,sp,256
    800052d2:	10200073          	sret
    800052d6:	00000013          	nop
    800052da:	00000013          	nop
    800052de:	0001                	nop

00000000800052e0 <timervec>:
    800052e0:	34051573          	csrrw	a0,mscratch,a0
    800052e4:	e10c                	sd	a1,0(a0)
    800052e6:	e510                	sd	a2,8(a0)
    800052e8:	e914                	sd	a3,16(a0)
    800052ea:	6d0c                	ld	a1,24(a0)
    800052ec:	7110                	ld	a2,32(a0)
    800052ee:	6194                	ld	a3,0(a1)
    800052f0:	96b2                	add	a3,a3,a2
    800052f2:	e194                	sd	a3,0(a1)
    800052f4:	4589                	li	a1,2
    800052f6:	14459073          	csrw	sip,a1
    800052fa:	6914                	ld	a3,16(a0)
    800052fc:	6510                	ld	a2,8(a0)
    800052fe:	610c                	ld	a1,0(a0)
    80005300:	34051573          	csrrw	a0,mscratch,a0
    80005304:	30200073          	mret
	...

000000008000530a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000530a:	1141                	addi	sp,sp,-16
    8000530c:	e422                	sd	s0,8(sp)
    8000530e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005310:	0c0007b7          	lui	a5,0xc000
    80005314:	4705                	li	a4,1
    80005316:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005318:	c3d8                	sw	a4,4(a5)
}
    8000531a:	6422                	ld	s0,8(sp)
    8000531c:	0141                	addi	sp,sp,16
    8000531e:	8082                	ret

0000000080005320 <plicinithart>:

void
plicinithart(void)
{
    80005320:	1141                	addi	sp,sp,-16
    80005322:	e406                	sd	ra,8(sp)
    80005324:	e022                	sd	s0,0(sp)
    80005326:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005328:	ffffc097          	auipc	ra,0xffffc
    8000532c:	b04080e7          	jalr	-1276(ra) # 80000e2c <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005330:	0085171b          	slliw	a4,a0,0x8
    80005334:	0c0027b7          	lui	a5,0xc002
    80005338:	97ba                	add	a5,a5,a4
    8000533a:	40200713          	li	a4,1026
    8000533e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005342:	00d5151b          	slliw	a0,a0,0xd
    80005346:	0c2017b7          	lui	a5,0xc201
    8000534a:	953e                	add	a0,a0,a5
    8000534c:	00052023          	sw	zero,0(a0)
}
    80005350:	60a2                	ld	ra,8(sp)
    80005352:	6402                	ld	s0,0(sp)
    80005354:	0141                	addi	sp,sp,16
    80005356:	8082                	ret

0000000080005358 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005358:	1141                	addi	sp,sp,-16
    8000535a:	e406                	sd	ra,8(sp)
    8000535c:	e022                	sd	s0,0(sp)
    8000535e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005360:	ffffc097          	auipc	ra,0xffffc
    80005364:	acc080e7          	jalr	-1332(ra) # 80000e2c <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005368:	00d5179b          	slliw	a5,a0,0xd
    8000536c:	0c201537          	lui	a0,0xc201
    80005370:	953e                	add	a0,a0,a5
  return irq;
}
    80005372:	4148                	lw	a0,4(a0)
    80005374:	60a2                	ld	ra,8(sp)
    80005376:	6402                	ld	s0,0(sp)
    80005378:	0141                	addi	sp,sp,16
    8000537a:	8082                	ret

000000008000537c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000537c:	1101                	addi	sp,sp,-32
    8000537e:	ec06                	sd	ra,24(sp)
    80005380:	e822                	sd	s0,16(sp)
    80005382:	e426                	sd	s1,8(sp)
    80005384:	1000                	addi	s0,sp,32
    80005386:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005388:	ffffc097          	auipc	ra,0xffffc
    8000538c:	aa4080e7          	jalr	-1372(ra) # 80000e2c <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005390:	00d5151b          	slliw	a0,a0,0xd
    80005394:	0c2017b7          	lui	a5,0xc201
    80005398:	97aa                	add	a5,a5,a0
    8000539a:	c3c4                	sw	s1,4(a5)
}
    8000539c:	60e2                	ld	ra,24(sp)
    8000539e:	6442                	ld	s0,16(sp)
    800053a0:	64a2                	ld	s1,8(sp)
    800053a2:	6105                	addi	sp,sp,32
    800053a4:	8082                	ret

00000000800053a6 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800053a6:	1141                	addi	sp,sp,-16
    800053a8:	e406                	sd	ra,8(sp)
    800053aa:	e022                	sd	s0,0(sp)
    800053ac:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800053ae:	479d                	li	a5,7
    800053b0:	04a7cc63          	blt	a5,a0,80005408 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    800053b4:	00010797          	auipc	a5,0x10
    800053b8:	a3c78793          	addi	a5,a5,-1476 # 80014df0 <disk>
    800053bc:	97aa                	add	a5,a5,a0
    800053be:	0187c783          	lbu	a5,24(a5)
    800053c2:	ebb9                	bnez	a5,80005418 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    800053c4:	00451613          	slli	a2,a0,0x4
    800053c8:	00010797          	auipc	a5,0x10
    800053cc:	a2878793          	addi	a5,a5,-1496 # 80014df0 <disk>
    800053d0:	6394                	ld	a3,0(a5)
    800053d2:	96b2                	add	a3,a3,a2
    800053d4:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    800053d8:	6398                	ld	a4,0(a5)
    800053da:	9732                	add	a4,a4,a2
    800053dc:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    800053e0:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    800053e4:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    800053e8:	953e                	add	a0,a0,a5
    800053ea:	4785                	li	a5,1
    800053ec:	00f50c23          	sb	a5,24(a0) # c201018 <_entry-0x73dfefe8>
  wakeup(&disk.free[0]);
    800053f0:	00010517          	auipc	a0,0x10
    800053f4:	a1850513          	addi	a0,a0,-1512 # 80014e08 <disk+0x18>
    800053f8:	ffffc097          	auipc	ra,0xffffc
    800053fc:	168080e7          	jalr	360(ra) # 80001560 <wakeup>
}
    80005400:	60a2                	ld	ra,8(sp)
    80005402:	6402                	ld	s0,0(sp)
    80005404:	0141                	addi	sp,sp,16
    80005406:	8082                	ret
    panic("free_desc 1");
    80005408:	00003517          	auipc	a0,0x3
    8000540c:	2c050513          	addi	a0,a0,704 # 800086c8 <syscalls+0x2f8>
    80005410:	00001097          	auipc	ra,0x1
    80005414:	a72080e7          	jalr	-1422(ra) # 80005e82 <panic>
    panic("free_desc 2");
    80005418:	00003517          	auipc	a0,0x3
    8000541c:	2c050513          	addi	a0,a0,704 # 800086d8 <syscalls+0x308>
    80005420:	00001097          	auipc	ra,0x1
    80005424:	a62080e7          	jalr	-1438(ra) # 80005e82 <panic>

0000000080005428 <virtio_disk_init>:
{
    80005428:	1101                	addi	sp,sp,-32
    8000542a:	ec06                	sd	ra,24(sp)
    8000542c:	e822                	sd	s0,16(sp)
    8000542e:	e426                	sd	s1,8(sp)
    80005430:	e04a                	sd	s2,0(sp)
    80005432:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005434:	00003597          	auipc	a1,0x3
    80005438:	2b458593          	addi	a1,a1,692 # 800086e8 <syscalls+0x318>
    8000543c:	00010517          	auipc	a0,0x10
    80005440:	adc50513          	addi	a0,a0,-1316 # 80014f18 <disk+0x128>
    80005444:	00001097          	auipc	ra,0x1
    80005448:	ef8080e7          	jalr	-264(ra) # 8000633c <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000544c:	100017b7          	lui	a5,0x10001
    80005450:	4398                	lw	a4,0(a5)
    80005452:	2701                	sext.w	a4,a4
    80005454:	747277b7          	lui	a5,0x74727
    80005458:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    8000545c:	14f71e63          	bne	a4,a5,800055b8 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005460:	100017b7          	lui	a5,0x10001
    80005464:	43dc                	lw	a5,4(a5)
    80005466:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005468:	4709                	li	a4,2
    8000546a:	14e79763          	bne	a5,a4,800055b8 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000546e:	100017b7          	lui	a5,0x10001
    80005472:	479c                	lw	a5,8(a5)
    80005474:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005476:	14e79163          	bne	a5,a4,800055b8 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    8000547a:	100017b7          	lui	a5,0x10001
    8000547e:	47d8                	lw	a4,12(a5)
    80005480:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005482:	554d47b7          	lui	a5,0x554d4
    80005486:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000548a:	12f71763          	bne	a4,a5,800055b8 <virtio_disk_init+0x190>
  *R(VIRTIO_MMIO_STATUS) = status;
    8000548e:	100017b7          	lui	a5,0x10001
    80005492:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005496:	4705                	li	a4,1
    80005498:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000549a:	470d                	li	a4,3
    8000549c:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000549e:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800054a0:	c7ffe737          	lui	a4,0xc7ffe
    800054a4:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fe15ef>
    800054a8:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800054aa:	2701                	sext.w	a4,a4
    800054ac:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800054ae:	472d                	li	a4,11
    800054b0:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    800054b2:	0707a903          	lw	s2,112(a5)
    800054b6:	2901                	sext.w	s2,s2
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    800054b8:	00897793          	andi	a5,s2,8
    800054bc:	10078663          	beqz	a5,800055c8 <virtio_disk_init+0x1a0>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800054c0:	100017b7          	lui	a5,0x10001
    800054c4:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    800054c8:	43fc                	lw	a5,68(a5)
    800054ca:	2781                	sext.w	a5,a5
    800054cc:	10079663          	bnez	a5,800055d8 <virtio_disk_init+0x1b0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800054d0:	100017b7          	lui	a5,0x10001
    800054d4:	5bdc                	lw	a5,52(a5)
    800054d6:	2781                	sext.w	a5,a5
  if(max == 0)
    800054d8:	10078863          	beqz	a5,800055e8 <virtio_disk_init+0x1c0>
  if(max < NUM)
    800054dc:	471d                	li	a4,7
    800054de:	10f77d63          	bgeu	a4,a5,800055f8 <virtio_disk_init+0x1d0>
  disk.desc = kalloc();
    800054e2:	ffffb097          	auipc	ra,0xffffb
    800054e6:	c36080e7          	jalr	-970(ra) # 80000118 <kalloc>
    800054ea:	00010497          	auipc	s1,0x10
    800054ee:	90648493          	addi	s1,s1,-1786 # 80014df0 <disk>
    800054f2:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    800054f4:	ffffb097          	auipc	ra,0xffffb
    800054f8:	c24080e7          	jalr	-988(ra) # 80000118 <kalloc>
    800054fc:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    800054fe:	ffffb097          	auipc	ra,0xffffb
    80005502:	c1a080e7          	jalr	-998(ra) # 80000118 <kalloc>
    80005506:	87aa                	mv	a5,a0
    80005508:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    8000550a:	6088                	ld	a0,0(s1)
    8000550c:	cd75                	beqz	a0,80005608 <virtio_disk_init+0x1e0>
    8000550e:	00010717          	auipc	a4,0x10
    80005512:	8ea73703          	ld	a4,-1814(a4) # 80014df8 <disk+0x8>
    80005516:	cb6d                	beqz	a4,80005608 <virtio_disk_init+0x1e0>
    80005518:	cbe5                	beqz	a5,80005608 <virtio_disk_init+0x1e0>
  memset(disk.desc, 0, PGSIZE);
    8000551a:	6605                	lui	a2,0x1
    8000551c:	4581                	li	a1,0
    8000551e:	ffffb097          	auipc	ra,0xffffb
    80005522:	c5a080e7          	jalr	-934(ra) # 80000178 <memset>
  memset(disk.avail, 0, PGSIZE);
    80005526:	00010497          	auipc	s1,0x10
    8000552a:	8ca48493          	addi	s1,s1,-1846 # 80014df0 <disk>
    8000552e:	6605                	lui	a2,0x1
    80005530:	4581                	li	a1,0
    80005532:	6488                	ld	a0,8(s1)
    80005534:	ffffb097          	auipc	ra,0xffffb
    80005538:	c44080e7          	jalr	-956(ra) # 80000178 <memset>
  memset(disk.used, 0, PGSIZE);
    8000553c:	6605                	lui	a2,0x1
    8000553e:	4581                	li	a1,0
    80005540:	6888                	ld	a0,16(s1)
    80005542:	ffffb097          	auipc	ra,0xffffb
    80005546:	c36080e7          	jalr	-970(ra) # 80000178 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    8000554a:	100017b7          	lui	a5,0x10001
    8000554e:	4721                	li	a4,8
    80005550:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80005552:	4098                	lw	a4,0(s1)
    80005554:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80005558:	40d8                	lw	a4,4(s1)
    8000555a:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    8000555e:	6498                	ld	a4,8(s1)
    80005560:	0007069b          	sext.w	a3,a4
    80005564:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80005568:	9701                	srai	a4,a4,0x20
    8000556a:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    8000556e:	6898                	ld	a4,16(s1)
    80005570:	0007069b          	sext.w	a3,a4
    80005574:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80005578:	9701                	srai	a4,a4,0x20
    8000557a:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    8000557e:	4685                	li	a3,1
    80005580:	c3f4                	sw	a3,68(a5)
    disk.free[i] = 1;
    80005582:	4705                	li	a4,1
    80005584:	00d48c23          	sb	a3,24(s1)
    80005588:	00e48ca3          	sb	a4,25(s1)
    8000558c:	00e48d23          	sb	a4,26(s1)
    80005590:	00e48da3          	sb	a4,27(s1)
    80005594:	00e48e23          	sb	a4,28(s1)
    80005598:	00e48ea3          	sb	a4,29(s1)
    8000559c:	00e48f23          	sb	a4,30(s1)
    800055a0:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    800055a4:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    800055a8:	0727a823          	sw	s2,112(a5)
}
    800055ac:	60e2                	ld	ra,24(sp)
    800055ae:	6442                	ld	s0,16(sp)
    800055b0:	64a2                	ld	s1,8(sp)
    800055b2:	6902                	ld	s2,0(sp)
    800055b4:	6105                	addi	sp,sp,32
    800055b6:	8082                	ret
    panic("could not find virtio disk");
    800055b8:	00003517          	auipc	a0,0x3
    800055bc:	14050513          	addi	a0,a0,320 # 800086f8 <syscalls+0x328>
    800055c0:	00001097          	auipc	ra,0x1
    800055c4:	8c2080e7          	jalr	-1854(ra) # 80005e82 <panic>
    panic("virtio disk FEATURES_OK unset");
    800055c8:	00003517          	auipc	a0,0x3
    800055cc:	15050513          	addi	a0,a0,336 # 80008718 <syscalls+0x348>
    800055d0:	00001097          	auipc	ra,0x1
    800055d4:	8b2080e7          	jalr	-1870(ra) # 80005e82 <panic>
    panic("virtio disk should not be ready");
    800055d8:	00003517          	auipc	a0,0x3
    800055dc:	16050513          	addi	a0,a0,352 # 80008738 <syscalls+0x368>
    800055e0:	00001097          	auipc	ra,0x1
    800055e4:	8a2080e7          	jalr	-1886(ra) # 80005e82 <panic>
    panic("virtio disk has no queue 0");
    800055e8:	00003517          	auipc	a0,0x3
    800055ec:	17050513          	addi	a0,a0,368 # 80008758 <syscalls+0x388>
    800055f0:	00001097          	auipc	ra,0x1
    800055f4:	892080e7          	jalr	-1902(ra) # 80005e82 <panic>
    panic("virtio disk max queue too short");
    800055f8:	00003517          	auipc	a0,0x3
    800055fc:	18050513          	addi	a0,a0,384 # 80008778 <syscalls+0x3a8>
    80005600:	00001097          	auipc	ra,0x1
    80005604:	882080e7          	jalr	-1918(ra) # 80005e82 <panic>
    panic("virtio disk kalloc");
    80005608:	00003517          	auipc	a0,0x3
    8000560c:	19050513          	addi	a0,a0,400 # 80008798 <syscalls+0x3c8>
    80005610:	00001097          	auipc	ra,0x1
    80005614:	872080e7          	jalr	-1934(ra) # 80005e82 <panic>

0000000080005618 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005618:	7159                	addi	sp,sp,-112
    8000561a:	f486                	sd	ra,104(sp)
    8000561c:	f0a2                	sd	s0,96(sp)
    8000561e:	eca6                	sd	s1,88(sp)
    80005620:	e8ca                	sd	s2,80(sp)
    80005622:	e4ce                	sd	s3,72(sp)
    80005624:	e0d2                	sd	s4,64(sp)
    80005626:	fc56                	sd	s5,56(sp)
    80005628:	f85a                	sd	s6,48(sp)
    8000562a:	f45e                	sd	s7,40(sp)
    8000562c:	f062                	sd	s8,32(sp)
    8000562e:	ec66                	sd	s9,24(sp)
    80005630:	e86a                	sd	s10,16(sp)
    80005632:	1880                	addi	s0,sp,112
    80005634:	892a                	mv	s2,a0
    80005636:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005638:	00c52c83          	lw	s9,12(a0)
    8000563c:	001c9c9b          	slliw	s9,s9,0x1
    80005640:	1c82                	slli	s9,s9,0x20
    80005642:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005646:	00010517          	auipc	a0,0x10
    8000564a:	8d250513          	addi	a0,a0,-1838 # 80014f18 <disk+0x128>
    8000564e:	00001097          	auipc	ra,0x1
    80005652:	d7e080e7          	jalr	-642(ra) # 800063cc <acquire>
  for(int i = 0; i < 3; i++){
    80005656:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80005658:	4ba1                	li	s7,8
      disk.free[i] = 0;
    8000565a:	0000fb17          	auipc	s6,0xf
    8000565e:	796b0b13          	addi	s6,s6,1942 # 80014df0 <disk>
  for(int i = 0; i < 3; i++){
    80005662:	4a8d                	li	s5,3
  for(int i = 0; i < NUM; i++){
    80005664:	8a4e                	mv	s4,s3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005666:	00010c17          	auipc	s8,0x10
    8000566a:	8b2c0c13          	addi	s8,s8,-1870 # 80014f18 <disk+0x128>
    8000566e:	a8b5                	j	800056ea <virtio_disk_rw+0xd2>
      disk.free[i] = 0;
    80005670:	00fb06b3          	add	a3,s6,a5
    80005674:	00068c23          	sb	zero,24(a3)
    idx[i] = alloc_desc();
    80005678:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    8000567a:	0207c563          	bltz	a5,800056a4 <virtio_disk_rw+0x8c>
  for(int i = 0; i < 3; i++){
    8000567e:	2485                	addiw	s1,s1,1
    80005680:	0711                	addi	a4,a4,4
    80005682:	1f548a63          	beq	s1,s5,80005876 <virtio_disk_rw+0x25e>
    idx[i] = alloc_desc();
    80005686:	863a                	mv	a2,a4
  for(int i = 0; i < NUM; i++){
    80005688:	0000f697          	auipc	a3,0xf
    8000568c:	76868693          	addi	a3,a3,1896 # 80014df0 <disk>
    80005690:	87d2                	mv	a5,s4
    if(disk.free[i]){
    80005692:	0186c583          	lbu	a1,24(a3)
    80005696:	fde9                	bnez	a1,80005670 <virtio_disk_rw+0x58>
  for(int i = 0; i < NUM; i++){
    80005698:	2785                	addiw	a5,a5,1
    8000569a:	0685                	addi	a3,a3,1
    8000569c:	ff779be3          	bne	a5,s7,80005692 <virtio_disk_rw+0x7a>
    idx[i] = alloc_desc();
    800056a0:	57fd                	li	a5,-1
    800056a2:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    800056a4:	02905a63          	blez	s1,800056d8 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    800056a8:	f9042503          	lw	a0,-112(s0)
    800056ac:	00000097          	auipc	ra,0x0
    800056b0:	cfa080e7          	jalr	-774(ra) # 800053a6 <free_desc>
      for(int j = 0; j < i; j++)
    800056b4:	4785                	li	a5,1
    800056b6:	0297d163          	bge	a5,s1,800056d8 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    800056ba:	f9442503          	lw	a0,-108(s0)
    800056be:	00000097          	auipc	ra,0x0
    800056c2:	ce8080e7          	jalr	-792(ra) # 800053a6 <free_desc>
      for(int j = 0; j < i; j++)
    800056c6:	4789                	li	a5,2
    800056c8:	0097d863          	bge	a5,s1,800056d8 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    800056cc:	f9842503          	lw	a0,-104(s0)
    800056d0:	00000097          	auipc	ra,0x0
    800056d4:	cd6080e7          	jalr	-810(ra) # 800053a6 <free_desc>
    sleep(&disk.free[0], &disk.vdisk_lock);
    800056d8:	85e2                	mv	a1,s8
    800056da:	0000f517          	auipc	a0,0xf
    800056de:	72e50513          	addi	a0,a0,1838 # 80014e08 <disk+0x18>
    800056e2:	ffffc097          	auipc	ra,0xffffc
    800056e6:	e1a080e7          	jalr	-486(ra) # 800014fc <sleep>
  for(int i = 0; i < 3; i++){
    800056ea:	f9040713          	addi	a4,s0,-112
    800056ee:	84ce                	mv	s1,s3
    800056f0:	bf59                	j	80005686 <virtio_disk_rw+0x6e>
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];

  if(write)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    800056f2:	00a60793          	addi	a5,a2,10 # 100a <_entry-0x7fffeff6>
    800056f6:	00479693          	slli	a3,a5,0x4
    800056fa:	0000f797          	auipc	a5,0xf
    800056fe:	6f678793          	addi	a5,a5,1782 # 80014df0 <disk>
    80005702:	97b6                	add	a5,a5,a3
    80005704:	4685                	li	a3,1
    80005706:	c794                	sw	a3,8(a5)
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80005708:	0000f597          	auipc	a1,0xf
    8000570c:	6e858593          	addi	a1,a1,1768 # 80014df0 <disk>
    80005710:	00a60793          	addi	a5,a2,10
    80005714:	0792                	slli	a5,a5,0x4
    80005716:	97ae                	add	a5,a5,a1
    80005718:	0007a623          	sw	zero,12(a5)
  buf0->sector = sector;
    8000571c:	0197b823          	sd	s9,16(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80005720:	f6070693          	addi	a3,a4,-160
    80005724:	619c                	ld	a5,0(a1)
    80005726:	97b6                	add	a5,a5,a3
    80005728:	e388                	sd	a0,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000572a:	6188                	ld	a0,0(a1)
    8000572c:	96aa                	add	a3,a3,a0
    8000572e:	47c1                	li	a5,16
    80005730:	c69c                	sw	a5,8(a3)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005732:	4785                	li	a5,1
    80005734:	00f69623          	sh	a5,12(a3)
  disk.desc[idx[0]].next = idx[1];
    80005738:	f9442783          	lw	a5,-108(s0)
    8000573c:	00f69723          	sh	a5,14(a3)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80005740:	0792                	slli	a5,a5,0x4
    80005742:	953e                	add	a0,a0,a5
    80005744:	05890693          	addi	a3,s2,88
    80005748:	e114                	sd	a3,0(a0)
  disk.desc[idx[1]].len = BSIZE;
    8000574a:	6188                	ld	a0,0(a1)
    8000574c:	97aa                	add	a5,a5,a0
    8000574e:	40000693          	li	a3,1024
    80005752:	c794                	sw	a3,8(a5)
  if(write)
    80005754:	100d0d63          	beqz	s10,8000586e <virtio_disk_rw+0x256>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80005758:	00079623          	sh	zero,12(a5)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000575c:	00c7d683          	lhu	a3,12(a5)
    80005760:	0016e693          	ori	a3,a3,1
    80005764:	00d79623          	sh	a3,12(a5)
  disk.desc[idx[1]].next = idx[2];
    80005768:	f9842583          	lw	a1,-104(s0)
    8000576c:	00b79723          	sh	a1,14(a5)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005770:	0000f697          	auipc	a3,0xf
    80005774:	68068693          	addi	a3,a3,1664 # 80014df0 <disk>
    80005778:	00260793          	addi	a5,a2,2
    8000577c:	0792                	slli	a5,a5,0x4
    8000577e:	97b6                	add	a5,a5,a3
    80005780:	587d                	li	a6,-1
    80005782:	01078823          	sb	a6,16(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005786:	0592                	slli	a1,a1,0x4
    80005788:	952e                	add	a0,a0,a1
    8000578a:	f9070713          	addi	a4,a4,-112
    8000578e:	9736                	add	a4,a4,a3
    80005790:	e118                	sd	a4,0(a0)
  disk.desc[idx[2]].len = 1;
    80005792:	6298                	ld	a4,0(a3)
    80005794:	972e                	add	a4,a4,a1
    80005796:	4585                	li	a1,1
    80005798:	c70c                	sw	a1,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    8000579a:	4509                	li	a0,2
    8000579c:	00a71623          	sh	a0,12(a4)
  disk.desc[idx[2]].next = 0;
    800057a0:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800057a4:	00b92223          	sw	a1,4(s2)
  disk.info[idx[0]].b = b;
    800057a8:	0127b423          	sd	s2,8(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800057ac:	6698                	ld	a4,8(a3)
    800057ae:	00275783          	lhu	a5,2(a4)
    800057b2:	8b9d                	andi	a5,a5,7
    800057b4:	0786                	slli	a5,a5,0x1
    800057b6:	97ba                	add	a5,a5,a4
    800057b8:	00c79223          	sh	a2,4(a5)

  __sync_synchronize();
    800057bc:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    800057c0:	6698                	ld	a4,8(a3)
    800057c2:	00275783          	lhu	a5,2(a4)
    800057c6:	2785                	addiw	a5,a5,1
    800057c8:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    800057cc:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800057d0:	100017b7          	lui	a5,0x10001
    800057d4:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800057d8:	00492703          	lw	a4,4(s2)
    800057dc:	4785                	li	a5,1
    800057de:	02f71163          	bne	a4,a5,80005800 <virtio_disk_rw+0x1e8>
    sleep(b, &disk.vdisk_lock);
    800057e2:	0000f997          	auipc	s3,0xf
    800057e6:	73698993          	addi	s3,s3,1846 # 80014f18 <disk+0x128>
  while(b->disk == 1) {
    800057ea:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    800057ec:	85ce                	mv	a1,s3
    800057ee:	854a                	mv	a0,s2
    800057f0:	ffffc097          	auipc	ra,0xffffc
    800057f4:	d0c080e7          	jalr	-756(ra) # 800014fc <sleep>
  while(b->disk == 1) {
    800057f8:	00492783          	lw	a5,4(s2)
    800057fc:	fe9788e3          	beq	a5,s1,800057ec <virtio_disk_rw+0x1d4>
  }

  disk.info[idx[0]].b = 0;
    80005800:	f9042903          	lw	s2,-112(s0)
    80005804:	00290793          	addi	a5,s2,2
    80005808:	00479713          	slli	a4,a5,0x4
    8000580c:	0000f797          	auipc	a5,0xf
    80005810:	5e478793          	addi	a5,a5,1508 # 80014df0 <disk>
    80005814:	97ba                	add	a5,a5,a4
    80005816:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    8000581a:	0000f997          	auipc	s3,0xf
    8000581e:	5d698993          	addi	s3,s3,1494 # 80014df0 <disk>
    80005822:	00491713          	slli	a4,s2,0x4
    80005826:	0009b783          	ld	a5,0(s3)
    8000582a:	97ba                	add	a5,a5,a4
    8000582c:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005830:	854a                	mv	a0,s2
    80005832:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005836:	00000097          	auipc	ra,0x0
    8000583a:	b70080e7          	jalr	-1168(ra) # 800053a6 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    8000583e:	8885                	andi	s1,s1,1
    80005840:	f0ed                	bnez	s1,80005822 <virtio_disk_rw+0x20a>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005842:	0000f517          	auipc	a0,0xf
    80005846:	6d650513          	addi	a0,a0,1750 # 80014f18 <disk+0x128>
    8000584a:	00001097          	auipc	ra,0x1
    8000584e:	c36080e7          	jalr	-970(ra) # 80006480 <release>
}
    80005852:	70a6                	ld	ra,104(sp)
    80005854:	7406                	ld	s0,96(sp)
    80005856:	64e6                	ld	s1,88(sp)
    80005858:	6946                	ld	s2,80(sp)
    8000585a:	69a6                	ld	s3,72(sp)
    8000585c:	6a06                	ld	s4,64(sp)
    8000585e:	7ae2                	ld	s5,56(sp)
    80005860:	7b42                	ld	s6,48(sp)
    80005862:	7ba2                	ld	s7,40(sp)
    80005864:	7c02                	ld	s8,32(sp)
    80005866:	6ce2                	ld	s9,24(sp)
    80005868:	6d42                	ld	s10,16(sp)
    8000586a:	6165                	addi	sp,sp,112
    8000586c:	8082                	ret
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    8000586e:	4689                	li	a3,2
    80005870:	00d79623          	sh	a3,12(a5)
    80005874:	b5e5                	j	8000575c <virtio_disk_rw+0x144>
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005876:	f9042603          	lw	a2,-112(s0)
    8000587a:	00a60713          	addi	a4,a2,10
    8000587e:	0712                	slli	a4,a4,0x4
    80005880:	0000f517          	auipc	a0,0xf
    80005884:	57850513          	addi	a0,a0,1400 # 80014df8 <disk+0x8>
    80005888:	953a                	add	a0,a0,a4
  if(write)
    8000588a:	e60d14e3          	bnez	s10,800056f2 <virtio_disk_rw+0xda>
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    8000588e:	00a60793          	addi	a5,a2,10
    80005892:	00479693          	slli	a3,a5,0x4
    80005896:	0000f797          	auipc	a5,0xf
    8000589a:	55a78793          	addi	a5,a5,1370 # 80014df0 <disk>
    8000589e:	97b6                	add	a5,a5,a3
    800058a0:	0007a423          	sw	zero,8(a5)
    800058a4:	b595                	j	80005708 <virtio_disk_rw+0xf0>

00000000800058a6 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800058a6:	1101                	addi	sp,sp,-32
    800058a8:	ec06                	sd	ra,24(sp)
    800058aa:	e822                	sd	s0,16(sp)
    800058ac:	e426                	sd	s1,8(sp)
    800058ae:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800058b0:	0000f497          	auipc	s1,0xf
    800058b4:	54048493          	addi	s1,s1,1344 # 80014df0 <disk>
    800058b8:	0000f517          	auipc	a0,0xf
    800058bc:	66050513          	addi	a0,a0,1632 # 80014f18 <disk+0x128>
    800058c0:	00001097          	auipc	ra,0x1
    800058c4:	b0c080e7          	jalr	-1268(ra) # 800063cc <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800058c8:	10001737          	lui	a4,0x10001
    800058cc:	533c                	lw	a5,96(a4)
    800058ce:	8b8d                	andi	a5,a5,3
    800058d0:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    800058d2:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800058d6:	689c                	ld	a5,16(s1)
    800058d8:	0204d703          	lhu	a4,32(s1)
    800058dc:	0027d783          	lhu	a5,2(a5)
    800058e0:	04f70863          	beq	a4,a5,80005930 <virtio_disk_intr+0x8a>
    __sync_synchronize();
    800058e4:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800058e8:	6898                	ld	a4,16(s1)
    800058ea:	0204d783          	lhu	a5,32(s1)
    800058ee:	8b9d                	andi	a5,a5,7
    800058f0:	078e                	slli	a5,a5,0x3
    800058f2:	97ba                	add	a5,a5,a4
    800058f4:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    800058f6:	00278713          	addi	a4,a5,2
    800058fa:	0712                	slli	a4,a4,0x4
    800058fc:	9726                	add	a4,a4,s1
    800058fe:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80005902:	e721                	bnez	a4,8000594a <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005904:	0789                	addi	a5,a5,2
    80005906:	0792                	slli	a5,a5,0x4
    80005908:	97a6                	add	a5,a5,s1
    8000590a:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    8000590c:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005910:	ffffc097          	auipc	ra,0xffffc
    80005914:	c50080e7          	jalr	-944(ra) # 80001560 <wakeup>

    disk.used_idx += 1;
    80005918:	0204d783          	lhu	a5,32(s1)
    8000591c:	2785                	addiw	a5,a5,1
    8000591e:	17c2                	slli	a5,a5,0x30
    80005920:	93c1                	srli	a5,a5,0x30
    80005922:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80005926:	6898                	ld	a4,16(s1)
    80005928:	00275703          	lhu	a4,2(a4)
    8000592c:	faf71ce3          	bne	a4,a5,800058e4 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80005930:	0000f517          	auipc	a0,0xf
    80005934:	5e850513          	addi	a0,a0,1512 # 80014f18 <disk+0x128>
    80005938:	00001097          	auipc	ra,0x1
    8000593c:	b48080e7          	jalr	-1208(ra) # 80006480 <release>
}
    80005940:	60e2                	ld	ra,24(sp)
    80005942:	6442                	ld	s0,16(sp)
    80005944:	64a2                	ld	s1,8(sp)
    80005946:	6105                	addi	sp,sp,32
    80005948:	8082                	ret
      panic("virtio_disk_intr status");
    8000594a:	00003517          	auipc	a0,0x3
    8000594e:	e6650513          	addi	a0,a0,-410 # 800087b0 <syscalls+0x3e0>
    80005952:	00000097          	auipc	ra,0x0
    80005956:	530080e7          	jalr	1328(ra) # 80005e82 <panic>

000000008000595a <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    8000595a:	1141                	addi	sp,sp,-16
    8000595c:	e422                	sd	s0,8(sp)
    8000595e:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005960:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80005964:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80005968:	0037979b          	slliw	a5,a5,0x3
    8000596c:	02004737          	lui	a4,0x2004
    80005970:	97ba                	add	a5,a5,a4
    80005972:	0200c737          	lui	a4,0x200c
    80005976:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000597a:	000f4637          	lui	a2,0xf4
    8000597e:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005982:	95b2                	add	a1,a1,a2
    80005984:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80005986:	00269713          	slli	a4,a3,0x2
    8000598a:	9736                	add	a4,a4,a3
    8000598c:	00371693          	slli	a3,a4,0x3
    80005990:	0000f717          	auipc	a4,0xf
    80005994:	5a070713          	addi	a4,a4,1440 # 80014f30 <timer_scratch>
    80005998:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    8000599a:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    8000599c:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    8000599e:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    800059a2:	00000797          	auipc	a5,0x0
    800059a6:	93e78793          	addi	a5,a5,-1730 # 800052e0 <timervec>
    800059aa:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800059ae:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    800059b2:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800059b6:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    800059ba:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    800059be:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    800059c2:	30479073          	csrw	mie,a5
}
    800059c6:	6422                	ld	s0,8(sp)
    800059c8:	0141                	addi	sp,sp,16
    800059ca:	8082                	ret

00000000800059cc <start>:
{
    800059cc:	1141                	addi	sp,sp,-16
    800059ce:	e406                	sd	ra,8(sp)
    800059d0:	e022                	sd	s0,0(sp)
    800059d2:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800059d4:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    800059d8:	7779                	lui	a4,0xffffe
    800059da:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffe168f>
    800059de:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800059e0:	6705                	lui	a4,0x1
    800059e2:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800059e6:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800059e8:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800059ec:	ffffb797          	auipc	a5,0xffffb
    800059f0:	93a78793          	addi	a5,a5,-1734 # 80000326 <main>
    800059f4:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800059f8:	4781                	li	a5,0
    800059fa:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800059fe:	67c1                	lui	a5,0x10
    80005a00:	17fd                	addi	a5,a5,-1
    80005a02:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005a06:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005a0a:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005a0e:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005a12:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005a16:	57fd                	li	a5,-1
    80005a18:	83a9                	srli	a5,a5,0xa
    80005a1a:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005a1e:	47bd                	li	a5,15
    80005a20:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005a24:	00000097          	auipc	ra,0x0
    80005a28:	f36080e7          	jalr	-202(ra) # 8000595a <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005a2c:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005a30:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005a32:	823e                	mv	tp,a5
  asm volatile("mret");
    80005a34:	30200073          	mret
}
    80005a38:	60a2                	ld	ra,8(sp)
    80005a3a:	6402                	ld	s0,0(sp)
    80005a3c:	0141                	addi	sp,sp,16
    80005a3e:	8082                	ret

0000000080005a40 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005a40:	715d                	addi	sp,sp,-80
    80005a42:	e486                	sd	ra,72(sp)
    80005a44:	e0a2                	sd	s0,64(sp)
    80005a46:	fc26                	sd	s1,56(sp)
    80005a48:	f84a                	sd	s2,48(sp)
    80005a4a:	f44e                	sd	s3,40(sp)
    80005a4c:	f052                	sd	s4,32(sp)
    80005a4e:	ec56                	sd	s5,24(sp)
    80005a50:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80005a52:	04c05663          	blez	a2,80005a9e <consolewrite+0x5e>
    80005a56:	8a2a                	mv	s4,a0
    80005a58:	84ae                	mv	s1,a1
    80005a5a:	89b2                	mv	s3,a2
    80005a5c:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80005a5e:	5afd                	li	s5,-1
    80005a60:	4685                	li	a3,1
    80005a62:	8626                	mv	a2,s1
    80005a64:	85d2                	mv	a1,s4
    80005a66:	fbf40513          	addi	a0,s0,-65
    80005a6a:	ffffc097          	auipc	ra,0xffffc
    80005a6e:	ef0080e7          	jalr	-272(ra) # 8000195a <either_copyin>
    80005a72:	01550c63          	beq	a0,s5,80005a8a <consolewrite+0x4a>
      break;
    uartputc(c);
    80005a76:	fbf44503          	lbu	a0,-65(s0)
    80005a7a:	00000097          	auipc	ra,0x0
    80005a7e:	794080e7          	jalr	1940(ra) # 8000620e <uartputc>
  for(i = 0; i < n; i++){
    80005a82:	2905                	addiw	s2,s2,1
    80005a84:	0485                	addi	s1,s1,1
    80005a86:	fd299de3          	bne	s3,s2,80005a60 <consolewrite+0x20>
  }

  return i;
}
    80005a8a:	854a                	mv	a0,s2
    80005a8c:	60a6                	ld	ra,72(sp)
    80005a8e:	6406                	ld	s0,64(sp)
    80005a90:	74e2                	ld	s1,56(sp)
    80005a92:	7942                	ld	s2,48(sp)
    80005a94:	79a2                	ld	s3,40(sp)
    80005a96:	7a02                	ld	s4,32(sp)
    80005a98:	6ae2                	ld	s5,24(sp)
    80005a9a:	6161                	addi	sp,sp,80
    80005a9c:	8082                	ret
  for(i = 0; i < n; i++){
    80005a9e:	4901                	li	s2,0
    80005aa0:	b7ed                	j	80005a8a <consolewrite+0x4a>

0000000080005aa2 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005aa2:	7119                	addi	sp,sp,-128
    80005aa4:	fc86                	sd	ra,120(sp)
    80005aa6:	f8a2                	sd	s0,112(sp)
    80005aa8:	f4a6                	sd	s1,104(sp)
    80005aaa:	f0ca                	sd	s2,96(sp)
    80005aac:	ecce                	sd	s3,88(sp)
    80005aae:	e8d2                	sd	s4,80(sp)
    80005ab0:	e4d6                	sd	s5,72(sp)
    80005ab2:	e0da                	sd	s6,64(sp)
    80005ab4:	fc5e                	sd	s7,56(sp)
    80005ab6:	f862                	sd	s8,48(sp)
    80005ab8:	f466                	sd	s9,40(sp)
    80005aba:	f06a                	sd	s10,32(sp)
    80005abc:	ec6e                	sd	s11,24(sp)
    80005abe:	0100                	addi	s0,sp,128
    80005ac0:	8b2a                	mv	s6,a0
    80005ac2:	8aae                	mv	s5,a1
    80005ac4:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005ac6:	00060b9b          	sext.w	s7,a2
  acquire(&cons.lock);
    80005aca:	00017517          	auipc	a0,0x17
    80005ace:	5a650513          	addi	a0,a0,1446 # 8001d070 <cons>
    80005ad2:	00001097          	auipc	ra,0x1
    80005ad6:	8fa080e7          	jalr	-1798(ra) # 800063cc <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005ada:	00017497          	auipc	s1,0x17
    80005ade:	59648493          	addi	s1,s1,1430 # 8001d070 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005ae2:	89a6                	mv	s3,s1
    80005ae4:	00017917          	auipc	s2,0x17
    80005ae8:	62490913          	addi	s2,s2,1572 # 8001d108 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

    if(c == C('D')){  // end-of-file
    80005aec:	4c91                	li	s9,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005aee:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80005af0:	4da9                	li	s11,10
  while(n > 0){
    80005af2:	07405b63          	blez	s4,80005b68 <consoleread+0xc6>
    while(cons.r == cons.w){
    80005af6:	0984a783          	lw	a5,152(s1)
    80005afa:	09c4a703          	lw	a4,156(s1)
    80005afe:	02f71763          	bne	a4,a5,80005b2c <consoleread+0x8a>
      if(killed(myproc())){
    80005b02:	ffffb097          	auipc	ra,0xffffb
    80005b06:	356080e7          	jalr	854(ra) # 80000e58 <myproc>
    80005b0a:	ffffc097          	auipc	ra,0xffffc
    80005b0e:	c9a080e7          	jalr	-870(ra) # 800017a4 <killed>
    80005b12:	e535                	bnez	a0,80005b7e <consoleread+0xdc>
      sleep(&cons.r, &cons.lock);
    80005b14:	85ce                	mv	a1,s3
    80005b16:	854a                	mv	a0,s2
    80005b18:	ffffc097          	auipc	ra,0xffffc
    80005b1c:	9e4080e7          	jalr	-1564(ra) # 800014fc <sleep>
    while(cons.r == cons.w){
    80005b20:	0984a783          	lw	a5,152(s1)
    80005b24:	09c4a703          	lw	a4,156(s1)
    80005b28:	fcf70de3          	beq	a4,a5,80005b02 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80005b2c:	0017871b          	addiw	a4,a5,1
    80005b30:	08e4ac23          	sw	a4,152(s1)
    80005b34:	07f7f713          	andi	a4,a5,127
    80005b38:	9726                	add	a4,a4,s1
    80005b3a:	01874703          	lbu	a4,24(a4)
    80005b3e:	00070c1b          	sext.w	s8,a4
    if(c == C('D')){  // end-of-file
    80005b42:	079c0663          	beq	s8,s9,80005bae <consoleread+0x10c>
    cbuf = c;
    80005b46:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005b4a:	4685                	li	a3,1
    80005b4c:	f8f40613          	addi	a2,s0,-113
    80005b50:	85d6                	mv	a1,s5
    80005b52:	855a                	mv	a0,s6
    80005b54:	ffffc097          	auipc	ra,0xffffc
    80005b58:	db0080e7          	jalr	-592(ra) # 80001904 <either_copyout>
    80005b5c:	01a50663          	beq	a0,s10,80005b68 <consoleread+0xc6>
    dst++;
    80005b60:	0a85                	addi	s5,s5,1
    --n;
    80005b62:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80005b64:	f9bc17e3          	bne	s8,s11,80005af2 <consoleread+0x50>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80005b68:	00017517          	auipc	a0,0x17
    80005b6c:	50850513          	addi	a0,a0,1288 # 8001d070 <cons>
    80005b70:	00001097          	auipc	ra,0x1
    80005b74:	910080e7          	jalr	-1776(ra) # 80006480 <release>

  return target - n;
    80005b78:	414b853b          	subw	a0,s7,s4
    80005b7c:	a811                	j	80005b90 <consoleread+0xee>
        release(&cons.lock);
    80005b7e:	00017517          	auipc	a0,0x17
    80005b82:	4f250513          	addi	a0,a0,1266 # 8001d070 <cons>
    80005b86:	00001097          	auipc	ra,0x1
    80005b8a:	8fa080e7          	jalr	-1798(ra) # 80006480 <release>
        return -1;
    80005b8e:	557d                	li	a0,-1
}
    80005b90:	70e6                	ld	ra,120(sp)
    80005b92:	7446                	ld	s0,112(sp)
    80005b94:	74a6                	ld	s1,104(sp)
    80005b96:	7906                	ld	s2,96(sp)
    80005b98:	69e6                	ld	s3,88(sp)
    80005b9a:	6a46                	ld	s4,80(sp)
    80005b9c:	6aa6                	ld	s5,72(sp)
    80005b9e:	6b06                	ld	s6,64(sp)
    80005ba0:	7be2                	ld	s7,56(sp)
    80005ba2:	7c42                	ld	s8,48(sp)
    80005ba4:	7ca2                	ld	s9,40(sp)
    80005ba6:	7d02                	ld	s10,32(sp)
    80005ba8:	6de2                	ld	s11,24(sp)
    80005baa:	6109                	addi	sp,sp,128
    80005bac:	8082                	ret
      if(n < target){
    80005bae:	000a071b          	sext.w	a4,s4
    80005bb2:	fb777be3          	bgeu	a4,s7,80005b68 <consoleread+0xc6>
        cons.r--;
    80005bb6:	00017717          	auipc	a4,0x17
    80005bba:	54f72923          	sw	a5,1362(a4) # 8001d108 <cons+0x98>
    80005bbe:	b76d                	j	80005b68 <consoleread+0xc6>

0000000080005bc0 <consputc>:
{
    80005bc0:	1141                	addi	sp,sp,-16
    80005bc2:	e406                	sd	ra,8(sp)
    80005bc4:	e022                	sd	s0,0(sp)
    80005bc6:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005bc8:	10000793          	li	a5,256
    80005bcc:	00f50a63          	beq	a0,a5,80005be0 <consputc+0x20>
    uartputc_sync(c);
    80005bd0:	00000097          	auipc	ra,0x0
    80005bd4:	564080e7          	jalr	1380(ra) # 80006134 <uartputc_sync>
}
    80005bd8:	60a2                	ld	ra,8(sp)
    80005bda:	6402                	ld	s0,0(sp)
    80005bdc:	0141                	addi	sp,sp,16
    80005bde:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005be0:	4521                	li	a0,8
    80005be2:	00000097          	auipc	ra,0x0
    80005be6:	552080e7          	jalr	1362(ra) # 80006134 <uartputc_sync>
    80005bea:	02000513          	li	a0,32
    80005bee:	00000097          	auipc	ra,0x0
    80005bf2:	546080e7          	jalr	1350(ra) # 80006134 <uartputc_sync>
    80005bf6:	4521                	li	a0,8
    80005bf8:	00000097          	auipc	ra,0x0
    80005bfc:	53c080e7          	jalr	1340(ra) # 80006134 <uartputc_sync>
    80005c00:	bfe1                	j	80005bd8 <consputc+0x18>

0000000080005c02 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005c02:	1101                	addi	sp,sp,-32
    80005c04:	ec06                	sd	ra,24(sp)
    80005c06:	e822                	sd	s0,16(sp)
    80005c08:	e426                	sd	s1,8(sp)
    80005c0a:	e04a                	sd	s2,0(sp)
    80005c0c:	1000                	addi	s0,sp,32
    80005c0e:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005c10:	00017517          	auipc	a0,0x17
    80005c14:	46050513          	addi	a0,a0,1120 # 8001d070 <cons>
    80005c18:	00000097          	auipc	ra,0x0
    80005c1c:	7b4080e7          	jalr	1972(ra) # 800063cc <acquire>

  switch(c){
    80005c20:	47d5                	li	a5,21
    80005c22:	0af48663          	beq	s1,a5,80005cce <consoleintr+0xcc>
    80005c26:	0297ca63          	blt	a5,s1,80005c5a <consoleintr+0x58>
    80005c2a:	47a1                	li	a5,8
    80005c2c:	0ef48763          	beq	s1,a5,80005d1a <consoleintr+0x118>
    80005c30:	47c1                	li	a5,16
    80005c32:	10f49a63          	bne	s1,a5,80005d46 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80005c36:	ffffc097          	auipc	ra,0xffffc
    80005c3a:	d7a080e7          	jalr	-646(ra) # 800019b0 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005c3e:	00017517          	auipc	a0,0x17
    80005c42:	43250513          	addi	a0,a0,1074 # 8001d070 <cons>
    80005c46:	00001097          	auipc	ra,0x1
    80005c4a:	83a080e7          	jalr	-1990(ra) # 80006480 <release>
}
    80005c4e:	60e2                	ld	ra,24(sp)
    80005c50:	6442                	ld	s0,16(sp)
    80005c52:	64a2                	ld	s1,8(sp)
    80005c54:	6902                	ld	s2,0(sp)
    80005c56:	6105                	addi	sp,sp,32
    80005c58:	8082                	ret
  switch(c){
    80005c5a:	07f00793          	li	a5,127
    80005c5e:	0af48e63          	beq	s1,a5,80005d1a <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005c62:	00017717          	auipc	a4,0x17
    80005c66:	40e70713          	addi	a4,a4,1038 # 8001d070 <cons>
    80005c6a:	0a072783          	lw	a5,160(a4)
    80005c6e:	09872703          	lw	a4,152(a4)
    80005c72:	9f99                	subw	a5,a5,a4
    80005c74:	07f00713          	li	a4,127
    80005c78:	fcf763e3          	bltu	a4,a5,80005c3e <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80005c7c:	47b5                	li	a5,13
    80005c7e:	0cf48763          	beq	s1,a5,80005d4c <consoleintr+0x14a>
      consputc(c);
    80005c82:	8526                	mv	a0,s1
    80005c84:	00000097          	auipc	ra,0x0
    80005c88:	f3c080e7          	jalr	-196(ra) # 80005bc0 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005c8c:	00017797          	auipc	a5,0x17
    80005c90:	3e478793          	addi	a5,a5,996 # 8001d070 <cons>
    80005c94:	0a07a683          	lw	a3,160(a5)
    80005c98:	0016871b          	addiw	a4,a3,1
    80005c9c:	0007061b          	sext.w	a2,a4
    80005ca0:	0ae7a023          	sw	a4,160(a5)
    80005ca4:	07f6f693          	andi	a3,a3,127
    80005ca8:	97b6                	add	a5,a5,a3
    80005caa:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80005cae:	47a9                	li	a5,10
    80005cb0:	0cf48563          	beq	s1,a5,80005d7a <consoleintr+0x178>
    80005cb4:	4791                	li	a5,4
    80005cb6:	0cf48263          	beq	s1,a5,80005d7a <consoleintr+0x178>
    80005cba:	00017797          	auipc	a5,0x17
    80005cbe:	44e7a783          	lw	a5,1102(a5) # 8001d108 <cons+0x98>
    80005cc2:	9f1d                	subw	a4,a4,a5
    80005cc4:	08000793          	li	a5,128
    80005cc8:	f6f71be3          	bne	a4,a5,80005c3e <consoleintr+0x3c>
    80005ccc:	a07d                	j	80005d7a <consoleintr+0x178>
    while(cons.e != cons.w &&
    80005cce:	00017717          	auipc	a4,0x17
    80005cd2:	3a270713          	addi	a4,a4,930 # 8001d070 <cons>
    80005cd6:	0a072783          	lw	a5,160(a4)
    80005cda:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005cde:	00017497          	auipc	s1,0x17
    80005ce2:	39248493          	addi	s1,s1,914 # 8001d070 <cons>
    while(cons.e != cons.w &&
    80005ce6:	4929                	li	s2,10
    80005ce8:	f4f70be3          	beq	a4,a5,80005c3e <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005cec:	37fd                	addiw	a5,a5,-1
    80005cee:	07f7f713          	andi	a4,a5,127
    80005cf2:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005cf4:	01874703          	lbu	a4,24(a4)
    80005cf8:	f52703e3          	beq	a4,s2,80005c3e <consoleintr+0x3c>
      cons.e--;
    80005cfc:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005d00:	10000513          	li	a0,256
    80005d04:	00000097          	auipc	ra,0x0
    80005d08:	ebc080e7          	jalr	-324(ra) # 80005bc0 <consputc>
    while(cons.e != cons.w &&
    80005d0c:	0a04a783          	lw	a5,160(s1)
    80005d10:	09c4a703          	lw	a4,156(s1)
    80005d14:	fcf71ce3          	bne	a4,a5,80005cec <consoleintr+0xea>
    80005d18:	b71d                	j	80005c3e <consoleintr+0x3c>
    if(cons.e != cons.w){
    80005d1a:	00017717          	auipc	a4,0x17
    80005d1e:	35670713          	addi	a4,a4,854 # 8001d070 <cons>
    80005d22:	0a072783          	lw	a5,160(a4)
    80005d26:	09c72703          	lw	a4,156(a4)
    80005d2a:	f0f70ae3          	beq	a4,a5,80005c3e <consoleintr+0x3c>
      cons.e--;
    80005d2e:	37fd                	addiw	a5,a5,-1
    80005d30:	00017717          	auipc	a4,0x17
    80005d34:	3ef72023          	sw	a5,992(a4) # 8001d110 <cons+0xa0>
      consputc(BACKSPACE);
    80005d38:	10000513          	li	a0,256
    80005d3c:	00000097          	auipc	ra,0x0
    80005d40:	e84080e7          	jalr	-380(ra) # 80005bc0 <consputc>
    80005d44:	bded                	j	80005c3e <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005d46:	ee048ce3          	beqz	s1,80005c3e <consoleintr+0x3c>
    80005d4a:	bf21                	j	80005c62 <consoleintr+0x60>
      consputc(c);
    80005d4c:	4529                	li	a0,10
    80005d4e:	00000097          	auipc	ra,0x0
    80005d52:	e72080e7          	jalr	-398(ra) # 80005bc0 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005d56:	00017797          	auipc	a5,0x17
    80005d5a:	31a78793          	addi	a5,a5,794 # 8001d070 <cons>
    80005d5e:	0a07a703          	lw	a4,160(a5)
    80005d62:	0017069b          	addiw	a3,a4,1
    80005d66:	0006861b          	sext.w	a2,a3
    80005d6a:	0ad7a023          	sw	a3,160(a5)
    80005d6e:	07f77713          	andi	a4,a4,127
    80005d72:	97ba                	add	a5,a5,a4
    80005d74:	4729                	li	a4,10
    80005d76:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005d7a:	00017797          	auipc	a5,0x17
    80005d7e:	38c7a923          	sw	a2,914(a5) # 8001d10c <cons+0x9c>
        wakeup(&cons.r);
    80005d82:	00017517          	auipc	a0,0x17
    80005d86:	38650513          	addi	a0,a0,902 # 8001d108 <cons+0x98>
    80005d8a:	ffffb097          	auipc	ra,0xffffb
    80005d8e:	7d6080e7          	jalr	2006(ra) # 80001560 <wakeup>
    80005d92:	b575                	j	80005c3e <consoleintr+0x3c>

0000000080005d94 <consoleinit>:

void
consoleinit(void)
{
    80005d94:	1141                	addi	sp,sp,-16
    80005d96:	e406                	sd	ra,8(sp)
    80005d98:	e022                	sd	s0,0(sp)
    80005d9a:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005d9c:	00003597          	auipc	a1,0x3
    80005da0:	a2c58593          	addi	a1,a1,-1492 # 800087c8 <syscalls+0x3f8>
    80005da4:	00017517          	auipc	a0,0x17
    80005da8:	2cc50513          	addi	a0,a0,716 # 8001d070 <cons>
    80005dac:	00000097          	auipc	ra,0x0
    80005db0:	590080e7          	jalr	1424(ra) # 8000633c <initlock>

  uartinit();
    80005db4:	00000097          	auipc	ra,0x0
    80005db8:	330080e7          	jalr	816(ra) # 800060e4 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005dbc:	0000e797          	auipc	a5,0xe
    80005dc0:	fdc78793          	addi	a5,a5,-36 # 80013d98 <devsw>
    80005dc4:	00000717          	auipc	a4,0x0
    80005dc8:	cde70713          	addi	a4,a4,-802 # 80005aa2 <consoleread>
    80005dcc:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005dce:	00000717          	auipc	a4,0x0
    80005dd2:	c7270713          	addi	a4,a4,-910 # 80005a40 <consolewrite>
    80005dd6:	ef98                	sd	a4,24(a5)
}
    80005dd8:	60a2                	ld	ra,8(sp)
    80005dda:	6402                	ld	s0,0(sp)
    80005ddc:	0141                	addi	sp,sp,16
    80005dde:	8082                	ret

0000000080005de0 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005de0:	7179                	addi	sp,sp,-48
    80005de2:	f406                	sd	ra,40(sp)
    80005de4:	f022                	sd	s0,32(sp)
    80005de6:	ec26                	sd	s1,24(sp)
    80005de8:	e84a                	sd	s2,16(sp)
    80005dea:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005dec:	c219                	beqz	a2,80005df2 <printint+0x12>
    80005dee:	08054663          	bltz	a0,80005e7a <printint+0x9a>
    x = -xx;
  else
    x = xx;
    80005df2:	2501                	sext.w	a0,a0
    80005df4:	4881                	li	a7,0
    80005df6:	fd040693          	addi	a3,s0,-48

  i = 0;
    80005dfa:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005dfc:	2581                	sext.w	a1,a1
    80005dfe:	00003617          	auipc	a2,0x3
    80005e02:	9fa60613          	addi	a2,a2,-1542 # 800087f8 <digits>
    80005e06:	883a                	mv	a6,a4
    80005e08:	2705                	addiw	a4,a4,1
    80005e0a:	02b577bb          	remuw	a5,a0,a1
    80005e0e:	1782                	slli	a5,a5,0x20
    80005e10:	9381                	srli	a5,a5,0x20
    80005e12:	97b2                	add	a5,a5,a2
    80005e14:	0007c783          	lbu	a5,0(a5)
    80005e18:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005e1c:	0005079b          	sext.w	a5,a0
    80005e20:	02b5553b          	divuw	a0,a0,a1
    80005e24:	0685                	addi	a3,a3,1
    80005e26:	feb7f0e3          	bgeu	a5,a1,80005e06 <printint+0x26>

  if(sign)
    80005e2a:	00088b63          	beqz	a7,80005e40 <printint+0x60>
    buf[i++] = '-';
    80005e2e:	fe040793          	addi	a5,s0,-32
    80005e32:	973e                	add	a4,a4,a5
    80005e34:	02d00793          	li	a5,45
    80005e38:	fef70823          	sb	a5,-16(a4)
    80005e3c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80005e40:	02e05763          	blez	a4,80005e6e <printint+0x8e>
    80005e44:	fd040793          	addi	a5,s0,-48
    80005e48:	00e784b3          	add	s1,a5,a4
    80005e4c:	fff78913          	addi	s2,a5,-1
    80005e50:	993a                	add	s2,s2,a4
    80005e52:	377d                	addiw	a4,a4,-1
    80005e54:	1702                	slli	a4,a4,0x20
    80005e56:	9301                	srli	a4,a4,0x20
    80005e58:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005e5c:	fff4c503          	lbu	a0,-1(s1)
    80005e60:	00000097          	auipc	ra,0x0
    80005e64:	d60080e7          	jalr	-672(ra) # 80005bc0 <consputc>
  while(--i >= 0)
    80005e68:	14fd                	addi	s1,s1,-1
    80005e6a:	ff2499e3          	bne	s1,s2,80005e5c <printint+0x7c>
}
    80005e6e:	70a2                	ld	ra,40(sp)
    80005e70:	7402                	ld	s0,32(sp)
    80005e72:	64e2                	ld	s1,24(sp)
    80005e74:	6942                	ld	s2,16(sp)
    80005e76:	6145                	addi	sp,sp,48
    80005e78:	8082                	ret
    x = -xx;
    80005e7a:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005e7e:	4885                	li	a7,1
    x = -xx;
    80005e80:	bf9d                	j	80005df6 <printint+0x16>

0000000080005e82 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005e82:	1101                	addi	sp,sp,-32
    80005e84:	ec06                	sd	ra,24(sp)
    80005e86:	e822                	sd	s0,16(sp)
    80005e88:	e426                	sd	s1,8(sp)
    80005e8a:	1000                	addi	s0,sp,32
    80005e8c:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005e8e:	00017797          	auipc	a5,0x17
    80005e92:	2a07a123          	sw	zero,674(a5) # 8001d130 <pr+0x18>
  printf("panic: ");
    80005e96:	00003517          	auipc	a0,0x3
    80005e9a:	93a50513          	addi	a0,a0,-1734 # 800087d0 <syscalls+0x400>
    80005e9e:	00000097          	auipc	ra,0x0
    80005ea2:	02e080e7          	jalr	46(ra) # 80005ecc <printf>
  printf(s);
    80005ea6:	8526                	mv	a0,s1
    80005ea8:	00000097          	auipc	ra,0x0
    80005eac:	024080e7          	jalr	36(ra) # 80005ecc <printf>
  printf("\n");
    80005eb0:	00002517          	auipc	a0,0x2
    80005eb4:	19850513          	addi	a0,a0,408 # 80008048 <etext+0x48>
    80005eb8:	00000097          	auipc	ra,0x0
    80005ebc:	014080e7          	jalr	20(ra) # 80005ecc <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005ec0:	4785                	li	a5,1
    80005ec2:	00003717          	auipc	a4,0x3
    80005ec6:	a0f72d23          	sw	a5,-1510(a4) # 800088dc <panicked>
  for(;;)
    80005eca:	a001                	j	80005eca <panic+0x48>

0000000080005ecc <printf>:
{
    80005ecc:	7131                	addi	sp,sp,-192
    80005ece:	fc86                	sd	ra,120(sp)
    80005ed0:	f8a2                	sd	s0,112(sp)
    80005ed2:	f4a6                	sd	s1,104(sp)
    80005ed4:	f0ca                	sd	s2,96(sp)
    80005ed6:	ecce                	sd	s3,88(sp)
    80005ed8:	e8d2                	sd	s4,80(sp)
    80005eda:	e4d6                	sd	s5,72(sp)
    80005edc:	e0da                	sd	s6,64(sp)
    80005ede:	fc5e                	sd	s7,56(sp)
    80005ee0:	f862                	sd	s8,48(sp)
    80005ee2:	f466                	sd	s9,40(sp)
    80005ee4:	f06a                	sd	s10,32(sp)
    80005ee6:	ec6e                	sd	s11,24(sp)
    80005ee8:	0100                	addi	s0,sp,128
    80005eea:	8a2a                	mv	s4,a0
    80005eec:	e40c                	sd	a1,8(s0)
    80005eee:	e810                	sd	a2,16(s0)
    80005ef0:	ec14                	sd	a3,24(s0)
    80005ef2:	f018                	sd	a4,32(s0)
    80005ef4:	f41c                	sd	a5,40(s0)
    80005ef6:	03043823          	sd	a6,48(s0)
    80005efa:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005efe:	00017d97          	auipc	s11,0x17
    80005f02:	232dad83          	lw	s11,562(s11) # 8001d130 <pr+0x18>
  if(locking)
    80005f06:	020d9b63          	bnez	s11,80005f3c <printf+0x70>
  if (fmt == 0)
    80005f0a:	040a0263          	beqz	s4,80005f4e <printf+0x82>
  va_start(ap, fmt);
    80005f0e:	00840793          	addi	a5,s0,8
    80005f12:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005f16:	000a4503          	lbu	a0,0(s4)
    80005f1a:	16050263          	beqz	a0,8000607e <printf+0x1b2>
    80005f1e:	4481                	li	s1,0
    if(c != '%'){
    80005f20:	02500a93          	li	s5,37
    switch(c){
    80005f24:	07000b13          	li	s6,112
  consputc('x');
    80005f28:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005f2a:	00003b97          	auipc	s7,0x3
    80005f2e:	8ceb8b93          	addi	s7,s7,-1842 # 800087f8 <digits>
    switch(c){
    80005f32:	07300c93          	li	s9,115
    80005f36:	06400c13          	li	s8,100
    80005f3a:	a82d                	j	80005f74 <printf+0xa8>
    acquire(&pr.lock);
    80005f3c:	00017517          	auipc	a0,0x17
    80005f40:	1dc50513          	addi	a0,a0,476 # 8001d118 <pr>
    80005f44:	00000097          	auipc	ra,0x0
    80005f48:	488080e7          	jalr	1160(ra) # 800063cc <acquire>
    80005f4c:	bf7d                	j	80005f0a <printf+0x3e>
    panic("null fmt");
    80005f4e:	00003517          	auipc	a0,0x3
    80005f52:	89250513          	addi	a0,a0,-1902 # 800087e0 <syscalls+0x410>
    80005f56:	00000097          	auipc	ra,0x0
    80005f5a:	f2c080e7          	jalr	-212(ra) # 80005e82 <panic>
      consputc(c);
    80005f5e:	00000097          	auipc	ra,0x0
    80005f62:	c62080e7          	jalr	-926(ra) # 80005bc0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005f66:	2485                	addiw	s1,s1,1
    80005f68:	009a07b3          	add	a5,s4,s1
    80005f6c:	0007c503          	lbu	a0,0(a5)
    80005f70:	10050763          	beqz	a0,8000607e <printf+0x1b2>
    if(c != '%'){
    80005f74:	ff5515e3          	bne	a0,s5,80005f5e <printf+0x92>
    c = fmt[++i] & 0xff;
    80005f78:	2485                	addiw	s1,s1,1
    80005f7a:	009a07b3          	add	a5,s4,s1
    80005f7e:	0007c783          	lbu	a5,0(a5)
    80005f82:	0007891b          	sext.w	s2,a5
    if(c == 0)
    80005f86:	cfe5                	beqz	a5,8000607e <printf+0x1b2>
    switch(c){
    80005f88:	05678a63          	beq	a5,s6,80005fdc <printf+0x110>
    80005f8c:	02fb7663          	bgeu	s6,a5,80005fb8 <printf+0xec>
    80005f90:	09978963          	beq	a5,s9,80006022 <printf+0x156>
    80005f94:	07800713          	li	a4,120
    80005f98:	0ce79863          	bne	a5,a4,80006068 <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    80005f9c:	f8843783          	ld	a5,-120(s0)
    80005fa0:	00878713          	addi	a4,a5,8
    80005fa4:	f8e43423          	sd	a4,-120(s0)
    80005fa8:	4605                	li	a2,1
    80005faa:	85ea                	mv	a1,s10
    80005fac:	4388                	lw	a0,0(a5)
    80005fae:	00000097          	auipc	ra,0x0
    80005fb2:	e32080e7          	jalr	-462(ra) # 80005de0 <printint>
      break;
    80005fb6:	bf45                	j	80005f66 <printf+0x9a>
    switch(c){
    80005fb8:	0b578263          	beq	a5,s5,8000605c <printf+0x190>
    80005fbc:	0b879663          	bne	a5,s8,80006068 <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    80005fc0:	f8843783          	ld	a5,-120(s0)
    80005fc4:	00878713          	addi	a4,a5,8
    80005fc8:	f8e43423          	sd	a4,-120(s0)
    80005fcc:	4605                	li	a2,1
    80005fce:	45a9                	li	a1,10
    80005fd0:	4388                	lw	a0,0(a5)
    80005fd2:	00000097          	auipc	ra,0x0
    80005fd6:	e0e080e7          	jalr	-498(ra) # 80005de0 <printint>
      break;
    80005fda:	b771                	j	80005f66 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80005fdc:	f8843783          	ld	a5,-120(s0)
    80005fe0:	00878713          	addi	a4,a5,8
    80005fe4:	f8e43423          	sd	a4,-120(s0)
    80005fe8:	0007b983          	ld	s3,0(a5)
  consputc('0');
    80005fec:	03000513          	li	a0,48
    80005ff0:	00000097          	auipc	ra,0x0
    80005ff4:	bd0080e7          	jalr	-1072(ra) # 80005bc0 <consputc>
  consputc('x');
    80005ff8:	07800513          	li	a0,120
    80005ffc:	00000097          	auipc	ra,0x0
    80006000:	bc4080e7          	jalr	-1084(ra) # 80005bc0 <consputc>
    80006004:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80006006:	03c9d793          	srli	a5,s3,0x3c
    8000600a:	97de                	add	a5,a5,s7
    8000600c:	0007c503          	lbu	a0,0(a5)
    80006010:	00000097          	auipc	ra,0x0
    80006014:	bb0080e7          	jalr	-1104(ra) # 80005bc0 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80006018:	0992                	slli	s3,s3,0x4
    8000601a:	397d                	addiw	s2,s2,-1
    8000601c:	fe0915e3          	bnez	s2,80006006 <printf+0x13a>
    80006020:	b799                	j	80005f66 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80006022:	f8843783          	ld	a5,-120(s0)
    80006026:	00878713          	addi	a4,a5,8
    8000602a:	f8e43423          	sd	a4,-120(s0)
    8000602e:	0007b903          	ld	s2,0(a5)
    80006032:	00090e63          	beqz	s2,8000604e <printf+0x182>
      for(; *s; s++)
    80006036:	00094503          	lbu	a0,0(s2)
    8000603a:	d515                	beqz	a0,80005f66 <printf+0x9a>
        consputc(*s);
    8000603c:	00000097          	auipc	ra,0x0
    80006040:	b84080e7          	jalr	-1148(ra) # 80005bc0 <consputc>
      for(; *s; s++)
    80006044:	0905                	addi	s2,s2,1
    80006046:	00094503          	lbu	a0,0(s2)
    8000604a:	f96d                	bnez	a0,8000603c <printf+0x170>
    8000604c:	bf29                	j	80005f66 <printf+0x9a>
        s = "(null)";
    8000604e:	00002917          	auipc	s2,0x2
    80006052:	78a90913          	addi	s2,s2,1930 # 800087d8 <syscalls+0x408>
      for(; *s; s++)
    80006056:	02800513          	li	a0,40
    8000605a:	b7cd                	j	8000603c <printf+0x170>
      consputc('%');
    8000605c:	8556                	mv	a0,s5
    8000605e:	00000097          	auipc	ra,0x0
    80006062:	b62080e7          	jalr	-1182(ra) # 80005bc0 <consputc>
      break;
    80006066:	b701                	j	80005f66 <printf+0x9a>
      consputc('%');
    80006068:	8556                	mv	a0,s5
    8000606a:	00000097          	auipc	ra,0x0
    8000606e:	b56080e7          	jalr	-1194(ra) # 80005bc0 <consputc>
      consputc(c);
    80006072:	854a                	mv	a0,s2
    80006074:	00000097          	auipc	ra,0x0
    80006078:	b4c080e7          	jalr	-1204(ra) # 80005bc0 <consputc>
      break;
    8000607c:	b5ed                	j	80005f66 <printf+0x9a>
  if(locking)
    8000607e:	020d9163          	bnez	s11,800060a0 <printf+0x1d4>
}
    80006082:	70e6                	ld	ra,120(sp)
    80006084:	7446                	ld	s0,112(sp)
    80006086:	74a6                	ld	s1,104(sp)
    80006088:	7906                	ld	s2,96(sp)
    8000608a:	69e6                	ld	s3,88(sp)
    8000608c:	6a46                	ld	s4,80(sp)
    8000608e:	6aa6                	ld	s5,72(sp)
    80006090:	6b06                	ld	s6,64(sp)
    80006092:	7be2                	ld	s7,56(sp)
    80006094:	7c42                	ld	s8,48(sp)
    80006096:	7ca2                	ld	s9,40(sp)
    80006098:	7d02                	ld	s10,32(sp)
    8000609a:	6de2                	ld	s11,24(sp)
    8000609c:	6129                	addi	sp,sp,192
    8000609e:	8082                	ret
    release(&pr.lock);
    800060a0:	00017517          	auipc	a0,0x17
    800060a4:	07850513          	addi	a0,a0,120 # 8001d118 <pr>
    800060a8:	00000097          	auipc	ra,0x0
    800060ac:	3d8080e7          	jalr	984(ra) # 80006480 <release>
}
    800060b0:	bfc9                	j	80006082 <printf+0x1b6>

00000000800060b2 <printfinit>:
    ;
}

void
printfinit(void)
{
    800060b2:	1101                	addi	sp,sp,-32
    800060b4:	ec06                	sd	ra,24(sp)
    800060b6:	e822                	sd	s0,16(sp)
    800060b8:	e426                	sd	s1,8(sp)
    800060ba:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    800060bc:	00017497          	auipc	s1,0x17
    800060c0:	05c48493          	addi	s1,s1,92 # 8001d118 <pr>
    800060c4:	00002597          	auipc	a1,0x2
    800060c8:	72c58593          	addi	a1,a1,1836 # 800087f0 <syscalls+0x420>
    800060cc:	8526                	mv	a0,s1
    800060ce:	00000097          	auipc	ra,0x0
    800060d2:	26e080e7          	jalr	622(ra) # 8000633c <initlock>
  pr.locking = 1;
    800060d6:	4785                	li	a5,1
    800060d8:	cc9c                	sw	a5,24(s1)
}
    800060da:	60e2                	ld	ra,24(sp)
    800060dc:	6442                	ld	s0,16(sp)
    800060de:	64a2                	ld	s1,8(sp)
    800060e0:	6105                	addi	sp,sp,32
    800060e2:	8082                	ret

00000000800060e4 <uartinit>:

void uartstart();

void
uartinit(void)
{
    800060e4:	1141                	addi	sp,sp,-16
    800060e6:	e406                	sd	ra,8(sp)
    800060e8:	e022                	sd	s0,0(sp)
    800060ea:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800060ec:	100007b7          	lui	a5,0x10000
    800060f0:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800060f4:	f8000713          	li	a4,-128
    800060f8:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800060fc:	470d                	li	a4,3
    800060fe:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80006102:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80006106:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    8000610a:	469d                	li	a3,7
    8000610c:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80006110:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    80006114:	00002597          	auipc	a1,0x2
    80006118:	6fc58593          	addi	a1,a1,1788 # 80008810 <digits+0x18>
    8000611c:	00017517          	auipc	a0,0x17
    80006120:	01c50513          	addi	a0,a0,28 # 8001d138 <uart_tx_lock>
    80006124:	00000097          	auipc	ra,0x0
    80006128:	218080e7          	jalr	536(ra) # 8000633c <initlock>
}
    8000612c:	60a2                	ld	ra,8(sp)
    8000612e:	6402                	ld	s0,0(sp)
    80006130:	0141                	addi	sp,sp,16
    80006132:	8082                	ret

0000000080006134 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80006134:	1101                	addi	sp,sp,-32
    80006136:	ec06                	sd	ra,24(sp)
    80006138:	e822                	sd	s0,16(sp)
    8000613a:	e426                	sd	s1,8(sp)
    8000613c:	1000                	addi	s0,sp,32
    8000613e:	84aa                	mv	s1,a0
  push_off();
    80006140:	00000097          	auipc	ra,0x0
    80006144:	240080e7          	jalr	576(ra) # 80006380 <push_off>

  if(panicked){
    80006148:	00002797          	auipc	a5,0x2
    8000614c:	7947a783          	lw	a5,1940(a5) # 800088dc <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006150:	10000737          	lui	a4,0x10000
  if(panicked){
    80006154:	c391                	beqz	a5,80006158 <uartputc_sync+0x24>
    for(;;)
    80006156:	a001                	j	80006156 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006158:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000615c:	0ff7f793          	andi	a5,a5,255
    80006160:	0207f793          	andi	a5,a5,32
    80006164:	dbf5                	beqz	a5,80006158 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80006166:	0ff4f793          	andi	a5,s1,255
    8000616a:	10000737          	lui	a4,0x10000
    8000616e:	00f70023          	sb	a5,0(a4) # 10000000 <_entry-0x70000000>

  pop_off();
    80006172:	00000097          	auipc	ra,0x0
    80006176:	2ae080e7          	jalr	686(ra) # 80006420 <pop_off>
}
    8000617a:	60e2                	ld	ra,24(sp)
    8000617c:	6442                	ld	s0,16(sp)
    8000617e:	64a2                	ld	s1,8(sp)
    80006180:	6105                	addi	sp,sp,32
    80006182:	8082                	ret

0000000080006184 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80006184:	00002717          	auipc	a4,0x2
    80006188:	75c73703          	ld	a4,1884(a4) # 800088e0 <uart_tx_r>
    8000618c:	00002797          	auipc	a5,0x2
    80006190:	75c7b783          	ld	a5,1884(a5) # 800088e8 <uart_tx_w>
    80006194:	06e78c63          	beq	a5,a4,8000620c <uartstart+0x88>
{
    80006198:	7139                	addi	sp,sp,-64
    8000619a:	fc06                	sd	ra,56(sp)
    8000619c:	f822                	sd	s0,48(sp)
    8000619e:	f426                	sd	s1,40(sp)
    800061a0:	f04a                	sd	s2,32(sp)
    800061a2:	ec4e                	sd	s3,24(sp)
    800061a4:	e852                	sd	s4,16(sp)
    800061a6:	e456                	sd	s5,8(sp)
    800061a8:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800061aa:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    800061ae:	00017a17          	auipc	s4,0x17
    800061b2:	f8aa0a13          	addi	s4,s4,-118 # 8001d138 <uart_tx_lock>
    uart_tx_r += 1;
    800061b6:	00002497          	auipc	s1,0x2
    800061ba:	72a48493          	addi	s1,s1,1834 # 800088e0 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    800061be:	00002997          	auipc	s3,0x2
    800061c2:	72a98993          	addi	s3,s3,1834 # 800088e8 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800061c6:	00594783          	lbu	a5,5(s2) # 10000005 <_entry-0x6ffffffb>
    800061ca:	0ff7f793          	andi	a5,a5,255
    800061ce:	0207f793          	andi	a5,a5,32
    800061d2:	c785                	beqz	a5,800061fa <uartstart+0x76>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    800061d4:	01f77793          	andi	a5,a4,31
    800061d8:	97d2                	add	a5,a5,s4
    800061da:	0187ca83          	lbu	s5,24(a5)
    uart_tx_r += 1;
    800061de:	0705                	addi	a4,a4,1
    800061e0:	e098                	sd	a4,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    800061e2:	8526                	mv	a0,s1
    800061e4:	ffffb097          	auipc	ra,0xffffb
    800061e8:	37c080e7          	jalr	892(ra) # 80001560 <wakeup>
    
    WriteReg(THR, c);
    800061ec:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    800061f0:	6098                	ld	a4,0(s1)
    800061f2:	0009b783          	ld	a5,0(s3)
    800061f6:	fce798e3          	bne	a5,a4,800061c6 <uartstart+0x42>
  }
}
    800061fa:	70e2                	ld	ra,56(sp)
    800061fc:	7442                	ld	s0,48(sp)
    800061fe:	74a2                	ld	s1,40(sp)
    80006200:	7902                	ld	s2,32(sp)
    80006202:	69e2                	ld	s3,24(sp)
    80006204:	6a42                	ld	s4,16(sp)
    80006206:	6aa2                	ld	s5,8(sp)
    80006208:	6121                	addi	sp,sp,64
    8000620a:	8082                	ret
    8000620c:	8082                	ret

000000008000620e <uartputc>:
{
    8000620e:	7179                	addi	sp,sp,-48
    80006210:	f406                	sd	ra,40(sp)
    80006212:	f022                	sd	s0,32(sp)
    80006214:	ec26                	sd	s1,24(sp)
    80006216:	e84a                	sd	s2,16(sp)
    80006218:	e44e                	sd	s3,8(sp)
    8000621a:	e052                	sd	s4,0(sp)
    8000621c:	1800                	addi	s0,sp,48
    8000621e:	89aa                	mv	s3,a0
  acquire(&uart_tx_lock);
    80006220:	00017517          	auipc	a0,0x17
    80006224:	f1850513          	addi	a0,a0,-232 # 8001d138 <uart_tx_lock>
    80006228:	00000097          	auipc	ra,0x0
    8000622c:	1a4080e7          	jalr	420(ra) # 800063cc <acquire>
  if(panicked){
    80006230:	00002797          	auipc	a5,0x2
    80006234:	6ac7a783          	lw	a5,1708(a5) # 800088dc <panicked>
    80006238:	e7c9                	bnez	a5,800062c2 <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000623a:	00002797          	auipc	a5,0x2
    8000623e:	6ae7b783          	ld	a5,1710(a5) # 800088e8 <uart_tx_w>
    80006242:	00002717          	auipc	a4,0x2
    80006246:	69e73703          	ld	a4,1694(a4) # 800088e0 <uart_tx_r>
    8000624a:	02070713          	addi	a4,a4,32
    sleep(&uart_tx_r, &uart_tx_lock);
    8000624e:	00017a17          	auipc	s4,0x17
    80006252:	eeaa0a13          	addi	s4,s4,-278 # 8001d138 <uart_tx_lock>
    80006256:	00002497          	auipc	s1,0x2
    8000625a:	68a48493          	addi	s1,s1,1674 # 800088e0 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000625e:	00002917          	auipc	s2,0x2
    80006262:	68a90913          	addi	s2,s2,1674 # 800088e8 <uart_tx_w>
    80006266:	00f71f63          	bne	a4,a5,80006284 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    8000626a:	85d2                	mv	a1,s4
    8000626c:	8526                	mv	a0,s1
    8000626e:	ffffb097          	auipc	ra,0xffffb
    80006272:	28e080e7          	jalr	654(ra) # 800014fc <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006276:	00093783          	ld	a5,0(s2)
    8000627a:	6098                	ld	a4,0(s1)
    8000627c:	02070713          	addi	a4,a4,32
    80006280:	fef705e3          	beq	a4,a5,8000626a <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80006284:	00017497          	auipc	s1,0x17
    80006288:	eb448493          	addi	s1,s1,-332 # 8001d138 <uart_tx_lock>
    8000628c:	01f7f713          	andi	a4,a5,31
    80006290:	9726                	add	a4,a4,s1
    80006292:	01370c23          	sb	s3,24(a4)
  uart_tx_w += 1;
    80006296:	0785                	addi	a5,a5,1
    80006298:	00002717          	auipc	a4,0x2
    8000629c:	64f73823          	sd	a5,1616(a4) # 800088e8 <uart_tx_w>
  uartstart();
    800062a0:	00000097          	auipc	ra,0x0
    800062a4:	ee4080e7          	jalr	-284(ra) # 80006184 <uartstart>
  release(&uart_tx_lock);
    800062a8:	8526                	mv	a0,s1
    800062aa:	00000097          	auipc	ra,0x0
    800062ae:	1d6080e7          	jalr	470(ra) # 80006480 <release>
}
    800062b2:	70a2                	ld	ra,40(sp)
    800062b4:	7402                	ld	s0,32(sp)
    800062b6:	64e2                	ld	s1,24(sp)
    800062b8:	6942                	ld	s2,16(sp)
    800062ba:	69a2                	ld	s3,8(sp)
    800062bc:	6a02                	ld	s4,0(sp)
    800062be:	6145                	addi	sp,sp,48
    800062c0:	8082                	ret
    for(;;)
    800062c2:	a001                	j	800062c2 <uartputc+0xb4>

00000000800062c4 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    800062c4:	1141                	addi	sp,sp,-16
    800062c6:	e422                	sd	s0,8(sp)
    800062c8:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    800062ca:	100007b7          	lui	a5,0x10000
    800062ce:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800062d2:	8b85                	andi	a5,a5,1
    800062d4:	cb91                	beqz	a5,800062e8 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    800062d6:	100007b7          	lui	a5,0x10000
    800062da:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    800062de:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    800062e2:	6422                	ld	s0,8(sp)
    800062e4:	0141                	addi	sp,sp,16
    800062e6:	8082                	ret
    return -1;
    800062e8:	557d                	li	a0,-1
    800062ea:	bfe5                	j	800062e2 <uartgetc+0x1e>

00000000800062ec <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    800062ec:	1101                	addi	sp,sp,-32
    800062ee:	ec06                	sd	ra,24(sp)
    800062f0:	e822                	sd	s0,16(sp)
    800062f2:	e426                	sd	s1,8(sp)
    800062f4:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800062f6:	54fd                	li	s1,-1
    int c = uartgetc();
    800062f8:	00000097          	auipc	ra,0x0
    800062fc:	fcc080e7          	jalr	-52(ra) # 800062c4 <uartgetc>
    if(c == -1)
    80006300:	00950763          	beq	a0,s1,8000630e <uartintr+0x22>
      break;
    consoleintr(c);
    80006304:	00000097          	auipc	ra,0x0
    80006308:	8fe080e7          	jalr	-1794(ra) # 80005c02 <consoleintr>
  while(1){
    8000630c:	b7f5                	j	800062f8 <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    8000630e:	00017497          	auipc	s1,0x17
    80006312:	e2a48493          	addi	s1,s1,-470 # 8001d138 <uart_tx_lock>
    80006316:	8526                	mv	a0,s1
    80006318:	00000097          	auipc	ra,0x0
    8000631c:	0b4080e7          	jalr	180(ra) # 800063cc <acquire>
  uartstart();
    80006320:	00000097          	auipc	ra,0x0
    80006324:	e64080e7          	jalr	-412(ra) # 80006184 <uartstart>
  release(&uart_tx_lock);
    80006328:	8526                	mv	a0,s1
    8000632a:	00000097          	auipc	ra,0x0
    8000632e:	156080e7          	jalr	342(ra) # 80006480 <release>
}
    80006332:	60e2                	ld	ra,24(sp)
    80006334:	6442                	ld	s0,16(sp)
    80006336:	64a2                	ld	s1,8(sp)
    80006338:	6105                	addi	sp,sp,32
    8000633a:	8082                	ret

000000008000633c <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    8000633c:	1141                	addi	sp,sp,-16
    8000633e:	e422                	sd	s0,8(sp)
    80006340:	0800                	addi	s0,sp,16
  lk->name = name;
    80006342:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80006344:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006348:	00053823          	sd	zero,16(a0)
}
    8000634c:	6422                	ld	s0,8(sp)
    8000634e:	0141                	addi	sp,sp,16
    80006350:	8082                	ret

0000000080006352 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80006352:	411c                	lw	a5,0(a0)
    80006354:	e399                	bnez	a5,8000635a <holding+0x8>
    80006356:	4501                	li	a0,0
  return r;
}
    80006358:	8082                	ret
{
    8000635a:	1101                	addi	sp,sp,-32
    8000635c:	ec06                	sd	ra,24(sp)
    8000635e:	e822                	sd	s0,16(sp)
    80006360:	e426                	sd	s1,8(sp)
    80006362:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80006364:	6904                	ld	s1,16(a0)
    80006366:	ffffb097          	auipc	ra,0xffffb
    8000636a:	ad6080e7          	jalr	-1322(ra) # 80000e3c <mycpu>
    8000636e:	40a48533          	sub	a0,s1,a0
    80006372:	00153513          	seqz	a0,a0
}
    80006376:	60e2                	ld	ra,24(sp)
    80006378:	6442                	ld	s0,16(sp)
    8000637a:	64a2                	ld	s1,8(sp)
    8000637c:	6105                	addi	sp,sp,32
    8000637e:	8082                	ret

0000000080006380 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80006380:	1101                	addi	sp,sp,-32
    80006382:	ec06                	sd	ra,24(sp)
    80006384:	e822                	sd	s0,16(sp)
    80006386:	e426                	sd	s1,8(sp)
    80006388:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000638a:	100024f3          	csrr	s1,sstatus
    8000638e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80006392:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006394:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80006398:	ffffb097          	auipc	ra,0xffffb
    8000639c:	aa4080e7          	jalr	-1372(ra) # 80000e3c <mycpu>
    800063a0:	5d3c                	lw	a5,120(a0)
    800063a2:	cf89                	beqz	a5,800063bc <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800063a4:	ffffb097          	auipc	ra,0xffffb
    800063a8:	a98080e7          	jalr	-1384(ra) # 80000e3c <mycpu>
    800063ac:	5d3c                	lw	a5,120(a0)
    800063ae:	2785                	addiw	a5,a5,1
    800063b0:	dd3c                	sw	a5,120(a0)
}
    800063b2:	60e2                	ld	ra,24(sp)
    800063b4:	6442                	ld	s0,16(sp)
    800063b6:	64a2                	ld	s1,8(sp)
    800063b8:	6105                	addi	sp,sp,32
    800063ba:	8082                	ret
    mycpu()->intena = old;
    800063bc:	ffffb097          	auipc	ra,0xffffb
    800063c0:	a80080e7          	jalr	-1408(ra) # 80000e3c <mycpu>
  return (x & SSTATUS_SIE) != 0;
    800063c4:	8085                	srli	s1,s1,0x1
    800063c6:	8885                	andi	s1,s1,1
    800063c8:	dd64                	sw	s1,124(a0)
    800063ca:	bfe9                	j	800063a4 <push_off+0x24>

00000000800063cc <acquire>:
{
    800063cc:	1101                	addi	sp,sp,-32
    800063ce:	ec06                	sd	ra,24(sp)
    800063d0:	e822                	sd	s0,16(sp)
    800063d2:	e426                	sd	s1,8(sp)
    800063d4:	1000                	addi	s0,sp,32
    800063d6:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    800063d8:	00000097          	auipc	ra,0x0
    800063dc:	fa8080e7          	jalr	-88(ra) # 80006380 <push_off>
  if(holding(lk))
    800063e0:	8526                	mv	a0,s1
    800063e2:	00000097          	auipc	ra,0x0
    800063e6:	f70080e7          	jalr	-144(ra) # 80006352 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800063ea:	4705                	li	a4,1
  if(holding(lk))
    800063ec:	e115                	bnez	a0,80006410 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800063ee:	87ba                	mv	a5,a4
    800063f0:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800063f4:	2781                	sext.w	a5,a5
    800063f6:	ffe5                	bnez	a5,800063ee <acquire+0x22>
  __sync_synchronize();
    800063f8:	0ff0000f          	fence
  lk->cpu = mycpu();
    800063fc:	ffffb097          	auipc	ra,0xffffb
    80006400:	a40080e7          	jalr	-1472(ra) # 80000e3c <mycpu>
    80006404:	e888                	sd	a0,16(s1)
}
    80006406:	60e2                	ld	ra,24(sp)
    80006408:	6442                	ld	s0,16(sp)
    8000640a:	64a2                	ld	s1,8(sp)
    8000640c:	6105                	addi	sp,sp,32
    8000640e:	8082                	ret
    panic("acquire");
    80006410:	00002517          	auipc	a0,0x2
    80006414:	40850513          	addi	a0,a0,1032 # 80008818 <digits+0x20>
    80006418:	00000097          	auipc	ra,0x0
    8000641c:	a6a080e7          	jalr	-1430(ra) # 80005e82 <panic>

0000000080006420 <pop_off>:

void
pop_off(void)
{
    80006420:	1141                	addi	sp,sp,-16
    80006422:	e406                	sd	ra,8(sp)
    80006424:	e022                	sd	s0,0(sp)
    80006426:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80006428:	ffffb097          	auipc	ra,0xffffb
    8000642c:	a14080e7          	jalr	-1516(ra) # 80000e3c <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006430:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80006434:	8b89                	andi	a5,a5,2
  if(intr_get())
    80006436:	e78d                	bnez	a5,80006460 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80006438:	5d3c                	lw	a5,120(a0)
    8000643a:	02f05b63          	blez	a5,80006470 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    8000643e:	37fd                	addiw	a5,a5,-1
    80006440:	0007871b          	sext.w	a4,a5
    80006444:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80006446:	eb09                	bnez	a4,80006458 <pop_off+0x38>
    80006448:	5d7c                	lw	a5,124(a0)
    8000644a:	c799                	beqz	a5,80006458 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000644c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80006450:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006454:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80006458:	60a2                	ld	ra,8(sp)
    8000645a:	6402                	ld	s0,0(sp)
    8000645c:	0141                	addi	sp,sp,16
    8000645e:	8082                	ret
    panic("pop_off - interruptible");
    80006460:	00002517          	auipc	a0,0x2
    80006464:	3c050513          	addi	a0,a0,960 # 80008820 <digits+0x28>
    80006468:	00000097          	auipc	ra,0x0
    8000646c:	a1a080e7          	jalr	-1510(ra) # 80005e82 <panic>
    panic("pop_off");
    80006470:	00002517          	auipc	a0,0x2
    80006474:	3c850513          	addi	a0,a0,968 # 80008838 <digits+0x40>
    80006478:	00000097          	auipc	ra,0x0
    8000647c:	a0a080e7          	jalr	-1526(ra) # 80005e82 <panic>

0000000080006480 <release>:
{
    80006480:	1101                	addi	sp,sp,-32
    80006482:	ec06                	sd	ra,24(sp)
    80006484:	e822                	sd	s0,16(sp)
    80006486:	e426                	sd	s1,8(sp)
    80006488:	1000                	addi	s0,sp,32
    8000648a:	84aa                	mv	s1,a0
  if(!holding(lk))
    8000648c:	00000097          	auipc	ra,0x0
    80006490:	ec6080e7          	jalr	-314(ra) # 80006352 <holding>
    80006494:	c115                	beqz	a0,800064b8 <release+0x38>
  lk->cpu = 0;
    80006496:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    8000649a:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    8000649e:	0f50000f          	fence	iorw,ow
    800064a2:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    800064a6:	00000097          	auipc	ra,0x0
    800064aa:	f7a080e7          	jalr	-134(ra) # 80006420 <pop_off>
}
    800064ae:	60e2                	ld	ra,24(sp)
    800064b0:	6442                	ld	s0,16(sp)
    800064b2:	64a2                	ld	s1,8(sp)
    800064b4:	6105                	addi	sp,sp,32
    800064b6:	8082                	ret
    panic("release");
    800064b8:	00002517          	auipc	a0,0x2
    800064bc:	38850513          	addi	a0,a0,904 # 80008840 <digits+0x48>
    800064c0:	00000097          	auipc	ra,0x0
    800064c4:	9c2080e7          	jalr	-1598(ra) # 80005e82 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addiw	a0,a0,-1
    8000700a:	0536                	slli	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addiw	a0,a0,-1
    800070ae:	0536                	slli	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...

miniosĿǰ�Ѿ���ɵĹ��ܣ�
bootsector
���뱣��ģʽ
�ڴ����ģ��
�򵥵��̵߳���ģ��
�ź���
ʱ��
��ʱ����DPC�Ͷ�ʱ����TPC
ͳһ���豸����ģ��
��׼��������豸����
�ڴ漰�ַ�����صı�׼C�⺯��


����codes.zip��Ŀ¼�ṹ���£�
codes
|-relocate        ���ӳ����Դ���룬��bootsector��minios���ӳ�һ���������Ĵ��̾���
|-bootsector      bootsector��Դ����
|-minios          minios��Դ����
|-bin             ���е�Ŀ�궼�ڴ�Ŀ¼�С�����minios.vhd���ǿ������Ĵ��̾���

�������minios��
����밲װMicrosoft��Virtual PC 2007
�������΢��Ĺٷ���վ�������İ�װ���򣬳����СԼ30M
http://download.microsoft.com/download/8/5/6/856bfc39-fa48-4315-a2b3-e6697a54ca88/32%20BIT/setup.exe
��װ��ɺ�Ϳ���˫��codes/bin/vm.vmc����minios��

��α���minios:
����minios����Ҫ���ֱ�������
codes/bootsector/bootsector.asm������nasm���б��룬������Ľ������Ϊbootsector���ҿ�����codes/bin
codes/minios/platform/platform.asm������masm32���б��룬����Ľ����codes/minios/platform/platform.obj
����Ĵ��붼��vc6���뼴�ɣ�vc6�Ĺ�����codes/minios/minios.dsw
������ֱ�û��nasm��masm32����Ҫ������Ϊ�������ļ�һ�㲻��Ҫ�Ķ���ֱ�����ұ���õ�Ŀ���ļ��Ϳ�����

˫��minios.dsw��vc6������˵�Project->Project Setting->Debug,�޸�Executable for debug sessionһ��
��Virtual PC.exe������·�����롣����㰲װ��Ĭ�ϵ�·���£��Ͳ���Ҫ�޸�����
Ȼ��ֱ��Ctrl-F5���оͿ��Ա��벢�������ˡ�


vc���̵ľ������ú�����ԭ��

Ϊʲôʹ��vc��
ԭ��ܼ򵥣���Ϊ�Ҳ�����Ϥgcc��Ҫ����gcc�����̸��ӵı������Ӳ�������
����ʵ����ϣ����gcc�ģ����˭�ܰ���дһ��gcc��makefile�Һܸ�л��
��������Щ�ط���͵���ˣ�gcc���ܱ鲻��������ܶ࣬��һ�¾Ϳ�����

vc��������dll�Ĺ��̵Ļ��������õ�
1����������ص��ļ��ӵ�����������
2�����ڶ���debug�汾�Ĵ������ɣ�vc����벻�ٵ��Դ��룬���ÿ��ƣ�����ɾ��Win32 Debug������
3������Ĭ�ϵ�Release�����У������Intrinsic Functions���Ż���������vc libc�еĺ���������д�ı�׼C���Կ⺯������˱����Զ����Ż�������project setting->C++->Optimizationsѡcustomize���ҹ��ϳ���Assume No Aliasing, Generate Intrinsic Functions, Favor Small Code, Full Optimization����Ż�ѡ�
4����project setting->C++->Preprocessor->Additional include directories�м���include���Ŀ¼�����ҹ���Ignore standard include paths
5��project setting->Link�У�output file name�ĳ�../bin/minios.dll������Ignore all default libraries��Generate mapfile, object/libraty modules�е��������
6��project setting->Link->Debug��mapfile name�ĳ�../bin/minios.map,project setting->Link->Output��Entry-point symbol�ĳ�main
7��project setting->post-build step�����һ��"../bin/relocate.exe" ../bin/minios.dll ../bin/bootsector ../bin/minios.vhd
8��project setting->Debug��Executable for debug session�ĳ�C:\Program Files\Microsoft Virtual PC\Virtual PC.exe��working directory�ĳ�../bin��Program arguments�ĳ�-singlepc -pc vm -launch
�����û������ʲô�Ļ���Ӧ�þ���Щ�ˡ��������vc�Ϳ��Ա���minios��ԭ�����ˡ�����Ľ����../bin/minios.dll

Ϊʲôʹ��dll�Ĺ����أ�
��Ϊwindows��dll����һ��relocation�ĶΣ����г��˸�dll�ļ����Ҫ�ض�λ�Ļ�������Ҫ�޸ĵĵ�ַƫ�ơ�����dllĬ�ϵļ���λ����0x10000000������minios����ϣ��������λ��0x400000��ֻ��Ҫ���ض�λ���ÿһ����ָ��ĵ�ַ��ȥ(0x10000000- 0x400000)�Ϳ����ˡ���Ҳ��relocate.exe����������Ҫ������

���ھ���pe�ļ��Ľṹ�Լ��ض����Ľṹ�������кܶ࣬���ֱ���ʱû�����ϣ����Բο�relocate.exe��ԭ����


minios���������̺��ڴ沼��

���ȣ�pc����bios����Ὣbootsector���ص�0x7C00, ��ʱ�μĴ�����ֵ��Ҳ������������ǲ�Ҫ�����Լ�������һ��ɡ���ds, es, ss�����csһ����ֵ����sp����0x8000��λ���ϣ��������Ǿ�����512�ֽڵĶ�ջ�ˡ�

Ȼ��bootsector��minios�������ڴ�0x400000��ʼ���ڴ�ռ��ϡ����bootsector�򵥵�������GDT��ֱ�ӽ��뱣��ģʽ���ҽ�����Ȩ����minios��entrypoint����0x100000��0x3fffff���ں˶ѣ��ں�����Ҫ�Ķ�̬�ڴ涼���ԴӴ˶���ʹ��keMalloc��keFree���䡣�ڴ���͵�4K�ֽڱ���������ж�����ָ�룬����DOS��������0x4000��ʼ��0x8000�����PCI�����������ݿ顣��0x10000��0x1ffff��64K�ֽ�������ΪIDE��DMA�ڴ�飬�����ĵͶ��ڴ���ʱ��û�з��䣬���ܻ���Ϊ�ļ�ϵͳ�Ļ��档

main����������������8259�жϿ�������8253ʱ�ӿ�������������IDT GDT����ʼ��ʱ�ӣ��ں˶Ѻ�������ϵͳ�󣬽����˵�һ������main�������keEntryMain

keEntryMain���ȴ��жϲ��Ҽ���console��keboard��������Ȼ����DPC����kdebug�����Լ�һ����������

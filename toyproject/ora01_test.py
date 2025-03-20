# Oracle 콘솔 연동 예제
# pip install cx_Oracle
import cx_Oracle as oci

# DB연결 설정 변수 선언
sid ='XE'
host = '127.0.0.1' # 127.0.0.1 무방 localhost와 동일
# DB서버가 외부에 있다면. oracle.pknurd.net 또는 211.12.119.45으로 입력필요
port = 1521
username = 'madang'
password = 'madang'

# DB연결 시작
conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
cursor =  conn.cursor() # DB 커서와 동일한 역할을 하는 개체

query = 'select * from Students' # 파이썬에서 쿼리호출시는 ;삭제
cursor.execute(query)#

# 불러온 데이터 처리
for i, item in enumerate(cursor, start=1):
    print(item)

cursor.close()
conn.close()
# DB는 연결하면 항상 마지막에 close(), 파일은 오픈하면 마지막에 close()해야함

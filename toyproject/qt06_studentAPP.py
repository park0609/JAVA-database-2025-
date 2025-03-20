# Oracle Student앱
# CRUD 데이터베이스 DML(SELECT, INSERT, UPDATE, DELETE)
## CREATE(INSERT), REQUEST(SELECT), UPDATE(UPDATE), DELETE(DELETE)
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5 import QtWidgets, QtGui, uic

# Oracle 모듈
import cx_Oracle as oci

## DB연결 설정
sid = 'XE'
host = 'localhost'
port = 1521
username = 'madang'
password = 'madang'

class MainWindow(QMainWindow):
    def __init__(self):
        super(MainWindow, self).__init__()
        self.initUI()
        self.loadData()

    def initUI(self):
        uic.loadUi('./toyproject/Studentdb.ui', self)
        self.setWindowTitle('학생정보앱')
        self.setWindowIcon(QIcon('./image/database.png'))


        # 버튼 기능추가
        self.btn_add.clicked.connect(self.btn_add_click)
        self.btn_mod.clicked.connect(self.btn_mod_click)
        self.btn_del.clicked.connect(self.btn_del_click)
        self.show()
    
    def btn_add_click(self):
        std_name = self.input_std_name.text()
        std_mobile = self.input_std_mobile.text()
        std_regyear = self.input_std_regyear.text()
        print(std_name,std_mobile,std_regyear)

        # 입력검증 필수(Validation Check)
        if std_name == '' or std_regyear == '':
            QMessageBox.about(self,'경고','학생이름 또는 입학년도는 필수입니다!')
            return # 함수 빠져나가기
        else:
            print('DB입력 진행')
            values = (std_name, std_mobile, std_regyear) # 변수값 3개를 튜플로 묶어서 
            self.addData(values) # 튜플을 파라미터로 전달

    def btn_mod_click(self):
        pass
    def btn_del_click(self):
        pass
    # 테이블위젯 데이터와 연관해서 화면 설정
    def makeTable(self, lst_student):
        self.tblstudent.setColumnCount(4)
        self.tblstudent.setRowCount(len(lst_student))# 커서에 들어있는 데이터 길이만큼 row 생성
        self.tblstudent.setHorizontalHeaderLabels(['학생번호','학생이름','핸드폰','입학년도'])

        # 전달받은 cursor를 반복문으로 테이블 위젯에 뿌리는 작업
        for i, (std_id,std_name,std_mobile,std_regyear) in enumerate(lst_student):
            self.tblstudent.setItem(i, 0, QTableWidgetItem(str(std_id))) # oracle number타입은 뿌릴때 str()로 형변환 필요!
            self.tblstudent.setItem(i, 1, QTableWidgetItem(std_name))
            self.tblstudent.setItem(i, 2, QTableWidgetItem(std_mobile))
            self.tblstudent.setItem(i, 3, QTableWidgetItem(str(std_regyear)))
            
    # R(SELECT)
    def loadData(self):
        # DB연결
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()


        query = '''SELECT std_id, std_name
	                    , std_mobile, std_regyear
                     FROM Students'''
        cursor.execute(query)

        # 불러온 데이터 처리
        #for i, (std_id,std_name,std_mobile,std_regyear) in enumerate(cursor, start=1):
        #    print(std_id,std_name,std_mobile,std_regyear)
        lst_student = []
        for _,item in enumerate(cursor):
            lst_student.append(item)

        self.makeTable(lst_student) # 새로 생성한 리스트를 파라미터로 전달

        cursor.close()
        conn.close()
    
    #C(INSERT)
    def addData(self, tuples):
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        try:
            conn.begin() # begin 트랜잭션 시작

            #쿼리 작성
            query = '''INSERT INTO MADANG.STUDENTS
                            (std_id, std_name, std_mobile, std_regyear)
                        VALUES(SEQ_STUDENT.nextval, :v_std_name, :v_std_mobile, :v_std_regyear)
                    '''
            cursor.execute(query, tuples) # query에 들어가는 동적변수 3개는 뒤에 tuples순서대로 매핑시켜줌
            conn.commit() # DB에 있는 커밋과 동일
            last_id = cursor.lastrowid
            print(last_id) # SEQ_STUDENT.CURRVAL
        except Exception as e:
            print(e)
            conn.rollback() # DB rollback동일기능
        finally:
            cursor.close()
            conn.close()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    win = MainWindow()
    app.exec()

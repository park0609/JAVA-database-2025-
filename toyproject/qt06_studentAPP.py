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
basic_msg = '학생정보 v 1.0'

class MainWindow(QMainWindow):
    def __init__(self):
        super(MainWindow, self).__init__()
        self.initUI()
        self.loadData()

    def initUI(self):
        uic.loadUi('./toyproject/Studentdb.ui', self)
        self.setWindowTitle('학생정보앱')
        self.setWindowIcon(QIcon('./image/students.png'))

        #상태바에 메세지 추가
        self.statusbar.showMessage(basic_msg)

        #버튼에 아이콘 추가
        self.btn_add.setIcon(QIcon('./image/add-user.png'))
        self.btn_mod.setIcon(QIcon('./image/edit-user.png'))
        self.btn_del.setIcon(QIcon('./image/del-user.png'))

        # 버튼 기능추가
        self.btn_add.clicked.connect(self.btn_add_click)
        self.btn_mod.clicked.connect(self.btn_mod_click)
        self.btn_del.clicked.connect(self.btn_del_click)
        # 테이블위젯 더블클릭 시그널 추가
        self.tblstudent.doubleClicked.connect(self.tblstudentDoubleClick)
        self.show()
    
    # 화면 인풋위젯 데이터 초기화 함수
    def clearInput(self):
        self.input_std_name.clear()
        self.input_std_mobile.clear()
        self.input_std_regyear.clear()

    # 테이블 위젯 더블클릭 시그널 함수
    def tblstudentDoubleClick(self):
        #QMessageBox.about(self,'더블클릭','동작합니다!')
        selected = self.tblstudent.currentRow() #현재 선택된 row의 index를 반환하는함수
        std_id = self.tblstudent.item(selected,0).text()
        std_name = self.tblstudent.item(selected,1).text()
        std_mobile = self.tblstudent.item(selected,2).text()
        std_regyear = self.tblstudent.item(selected,3).text()
        QMessageBox.about(self,'더블클릭',f'{std_id},{std_name},{std_mobile},{std_regyear}')

        self.input_std_id.setText(std_id)
        self.input_std_name.setText(std_name)
        self.input_std_mobile.setText(std_mobile)
        self.input_std_regyear.setText(std_regyear)

        # 상태바에 메세지 추가
        self.statusbar.showMessage(f'{basic_msg} | 수정모드')

    def btn_add_click(self):
        std_id = self.input_std_id.text()
        std_name = self.input_std_name.text()
        std_mobile = self.input_std_mobile.text()
        std_regyear = self.input_std_regyear.text()
        print(std_name,std_mobile,std_regyear)

        # 입력검증 필수(Validation Check)
        if std_name == '' or std_regyear == '':
            QMessageBox.about(self,'경고','학생이름 또는 입학년도는 필수입니다!')
            return # 함수 빠져나가기
        elif std_id != '':
            QMessageBox.warning(self,'경고','기학생정보를 다시 등록할 수 없습니다!')
            return
        else:
            print('DB입력 진행')
            values = (std_name, std_mobile, std_regyear) # 변수값 3개를 튜플로 묶어서 
            self.addData(values) # 튜플을 파라미터로 전달
            if self.addData(values) == True:
                QMessageBox.about(self,'저장성공','학생정보 등록완료!')
            else:
                QMessageBox.about(self,'저장실패','관리자에게 문의해주세요!')
            self.loadData() #다시 컬럼을 테이블위젯에 띄우기
            self.clearInput() #input값 삭제 함수

            self.statusbar.showMessage(f'{basic_msg} | 저장완료')

    # 수정버튼 클릭 시그널처리 함수
    def btn_mod_click(self):
        std_id = self.input_std_id.text()
        std_name = self.input_std_name.text()
        std_mobile = self.input_std_mobile.text()
        std_regyear = self.input_std_regyear.text()
        #print(std_id, std_name,std_mobile,std_regyear)

        if std_id == '' or std_name == '' or std_mobile == '' or std_regyear == '':
            QMessageBox.about(self,'경고','학생이름 또는 입학년도는 필수입니다!')
            return 
        else:
            print('DB수정진행')    
            values = (std_name,std_mobile,std_regyear,std_id)
            if self.modData(values) == True:
                QMessageBox.about(self,'수정성공','학생정보 수정완료!')
            else:
                QMessageBox.about(self,'수정실패','관리자에게 문의해주세요!')

            self.loadData() 
            self.clearInput()

            self.statusbar.showMessage(f'{basic_msg} | 수정완료')

    #삭제버튼 클릭 시그널처리 함수
    def btn_del_click(self):
        std_id = self.input_std_id.text()
        
        if std_id == '':
            QMessageBox.warning(self,'경고','학생이름 또는 입학년도는 필수입니다!')
            return 
        else:
            print('DB삭제진행')
            # Oracle은 파라미터 타입에 민감. 정확한 타입을 사용해야함
            values = (int(std_id),)
            if self.delData(values) == True:
                QMessageBox.about(self,'삭제성공','학생정보 삭제완료!')
            else:
                QMessageBox.about(self,'삭제실패','관리자에게 문의해주세요!')

            self.loadData() 
            self.clearInput()

            self.statusbar.showMessage(f'{basic_msg} | 삭제완료')


    # 테이블위젯 데이터와 연관해서 화면 설정
    def makeTable(self, lst_student):
        self.tblstudent.setSelectionMode(QAbstractItemView.SingleSelection) # 단일 row선택모드
        self.tblstudent.setEditTriggers(QAbstractItemView.NoEditTriggers) #컬럼수 변경금지
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
        isSuccede = False #성공여부 플랴그 변수
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
            isSuccede = True # 성공
        except Exception as e:
            print(e)
            conn.rollback() # DB rollback동일기능
            isSuccede = False
        finally:
            cursor.close()
            conn.close()

        return isSuccede # 트랜잭션 여부를 리턴
    
    # U(UPDATE)
    def modData(self, tuples):
        isSuccede = False 
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        try:
            conn.begin() 

            
            query = '''
                    UPDATE MADANG.STUDENTS
                       SET std_name= :v_std_name
                         , std_mobile= :v_std_mobile
                         , std_regyear= :v_std_regyear
                     WHERE std_id = :v_std_id
                    '''
            cursor.execute(query, tuples)
            conn.commit() 
     
            isSuccede = True 
        except Exception as e:
            print(e)
            conn.rollback() 
            isSuccede = False
        finally:
            cursor.close()
            conn.close()

        return isSuccede 
    
    #D(DELETE)
    def delData(self, tuples):
        isSuccede = False 
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        try:
            conn.begin() 

            
            query = '''
                    DELETE FROM MADANG.STUDENTS
                     WHERE STD_ID= :v_std_id
                    '''
            cursor.execute(query, tuples)
            conn.commit() 
     
            isSuccede = True 
        except Exception as e:
            print(e)
            conn.rollback() 
            isSuccede = False
        finally:
            cursor.close()
            conn.close()

        return isSuccede


if __name__ == '__main__':
    app = QApplication(sys.argv)
    win = MainWindow()
    app.exec()

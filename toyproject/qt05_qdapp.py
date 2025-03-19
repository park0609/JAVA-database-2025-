## QtDesginer 연동 앱
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5 import QtGui, QtWidgets, uic

class DevWindow(QMainWindow): 
    def __init__(self): 
        super(DevWindow,self).__init__() 
        self.initUI() 

    def initUI(self):
        # QtDesginer 생성 ui파일 로드
        uic.loadUi('./toyproject/sampleqt.ui', self)
        self.setWindowIcon(QIcon('./image/database.png'))
        # ui에 있는 위젯에 접근하려면 이름 그래도 사용
        self.lbl1.setText('UI를 로드했습니다.')
        self.btn1.clicked.connect(self.btn1click)
        self.btn2.clicked.connect(self.btn2click)

        self.show()

    def btn1click(self):
        QMessageBox.about(self,'알림','버튼을 클릭했습니다!')

    def btn2click(self):
        ans = QMessageBox.question(self, '종료','종료하시겠습니까?', QMessageBox.yes | QMessageBox.NO, QMessageBox.No)
        if ans == QMessageBox.yes:
            super().close() # 프로그램 종료

    def closeEvent(self,e):
        ans = QMessageBox.question(self, '종료','종료하시겠습니까?', QMessageBox.yes | QMessageBox.NO, QMessageBox.no)
        if ans == QMessageBox.yes:
            e.accept()
        else:
            e.ignore()


if __name__ == '__main__': 
    app = QApplication(sys.argv) 
    win = DevWindow() 
    app.exec_() 
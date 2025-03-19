## 토이프로젝트
Python GUI - Oracle연동 프로그램

### GUI 프레임워크
- GUI 프레임워크 종류
    1. tkinter 
        - 파이썬에 내장된 프로그램, 중소형 프로그램사용, 간단하게 사용가능, 안 이쁨
    2. **PyOt** / PySide 
        - C/C++에서 사용하는 GUI프레임워크 OT를 파이썬에 사용하게 만든 라이브러리, 현재 6버전, 유료
        - ptot의 사용라이센스 문제로 pyside 릴리스, PyOt에서 PySide 변경하는데 번거로움이 존재
        - tkinter보다 난이도가 있음
        - 아주 이쁨, OtDesiger툴로 포토샵처럼 GUI 디자인중
        - Python GUI중에서 가장 많이 사용중
    3. Kivy
        - OpenGL(게임엔진용 3D 그래픽엔진)으로 구현되는 GUI 프레임 워크
        - 안드로이드, IOS 등 모바일용로 개발가능
        - 최신에 나온 기술이라 아직 불안정
    4. wxPython
        - kivy처럼 멀티 플랫폼 GUI 프레임 워크
        - 무지 어려움

## PyOt5 GUI 사용
- ptqt 설치
    - 콘솔 > `pip install PyQt5` 설치

- QtDesigner 설피
    - https://build-system.fman.io/qt-designer-download 다운로드 후 설치


#### PyQt5 개발
1. PyQt 모듈 사용 원앱만들기
2. 윈도우 기본설정
3. PyQt위젯 사용법(레이블, 버튼...)
4. 시그널(이벤트) 처리방법
5. QtDesigner로 화면 디자인, PyQt와 연동

<img src = '../image/db006.png' width = "250">, 

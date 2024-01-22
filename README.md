### IBK 개발환경 설정

## 0. IDE버전 : STS 4.3.1.RELEASE

## 1. java 버전 : 1.7
	A. ibk_2022 > Alt + Enter > Java Build Path > Libraries탭
	B. Edit > Alternate Jre의 Installed Jres > Add > Standart VM > jdk 1.7 선택 후, Apply

## 2. Project Facet 설정
	A. ibk_2022 > Alt + Enter > Project Facests 
	B. Dynamaic Web Module 체크 > 3.1 버전
	C. Java > 1.7버전
	D. Javascript 체크 후 Apply
	
## 3. .settings파일 overwrite ALL

## 4. Java Build Path 설정
	A. Source탭 > 
		ibk_2022/src 추가
			a) src 펼치고
			b) excluded 더블클릭
			c) exclusion pattern add 클릭
			d) browse > main/java/추가
			e) browse > main/resources/ 추가
		ibk_2022/src/main/java 추가
		ibk_2022/src/main/resources 추가
		Default output folder : ibk_2022/build/classes 셋팅후 > Apply

	B.Libraries탭 > Jar파일 Web App libraries 폴더로 정리
		/ibk_2022/WebContent/WEB-INF/lib JAR파일 삭제후, Add Library > Web App Libraries > Next > Finish

## 5. (추가)GIT Fetch시, 동기화 문제 (Nothing to fetch)
	A. Git Repositories > 오른쪽 클릭 > Properties
	B. Add Entry 버튼 클릭 
	C. key : remote.origin.fetch,  value : +refs/heads/*:refs/remotes/origin/* 입력

## 6. (추가)이클립스 텍스트 에디터 UTF-8 셋팅
	A. Window > Preferences > enc 검색
	B. Workspace, CssFiles, Html Files, Jsp File > UTF-8셋팅 > Apply
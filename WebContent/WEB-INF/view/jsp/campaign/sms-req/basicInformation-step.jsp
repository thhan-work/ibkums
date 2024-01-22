<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<div class="section-left">
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="required pdd-top-4">발송구분</h3>
		</div>
		<div class="reg-right">
			<div class="ele_area">
				<div class="search_field inline-form">
					<div class="inline-block">
						<label class="radio-container">마케팅(고객관리 포함) <input
							type="radio" name="sendType" value="marketing" checked="checked" />
							<span class="checkmark"></span>
						</label> 
						<label class="radio-container">비마케팅(기존계약의 유지 · 관리 등)
							<input type="radio" name="sendType" value="noMarketing" />
							<span class="checkmark"></span>
						</label>
					</div>
				</div>
			</div>
			<div class="mrg-top-10">
				<div class="msg-box color-gray">
					※ 개인정보보호법 (제15조,22조)에 의거하여 개인정보 이용 통제 및 금융소비자의 권리 보장을 위한 설정으로 민원 등
					분쟁이 발생되지 않도록 유의바랍니다.<br />
					<br /> [ 공지 (비마케팅) 목적의 예시 ]<br /> - 대출 원리금 납입 · 미납, 은행상품 만기 안내<br />
					- 은행상품의 갱신 안내, 은행상품의 계약 조건 변경 안내(금리 인상 · 인하 등)<br /> - 금융거래보호를 위해
					통지할 필요가 있는 사항 안내<br /> - 법 · 규정 시행 예정 통지<br /> - 부가서비스 · 이용혜택 변경 안내<br />
					- 상품 및 서비스 가입을 위한 필요서류 · 조건, 상세내용 및 진행과정 안내<br /> - 민원처리 과정 안내,
					완전판매 모니터링 진행<br /> - 영업점 이전 · 통합 · 폐쇄 등의 안내<br /> - 기타 계약의 유지 · 관리에
					필요한 경우 등<br /> ※ 문의 : 정보보호관리팀(8-5410)<br />
				</div>
			</div>
		</div>
	</div>
	<div class="row clearfix">
		<div class="reg-left">
			<h3 class="pdd-top-4"><span class="required">발송명(이벤트명)</span> <span class="icon-tooltip"
					data-tippy-content="발송현황에서 볼 수 있는 명칭입니다."><i
					class="fa fa-info"></i></span></h3>
		</div>
		<div class="reg-right">
			<div class="ele_area remaining" data-input="msgTitle"
				data-count="msgTitle_count" data-text-len="30">
				<input type="text" class="form-control mrg-btm-5" id="msgTitle" name="msgTitle" placeholder="발송명을 입력하세요" />
				<p class="text-right color-gray pull-right">
					<span id="msgTitle_count">0</span>/30자
				</p>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
</script>
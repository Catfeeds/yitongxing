<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp" />

<section class="hbox stretch">
	<aside class="aside-md bg-white b-r">
		<section class="vbox">
			<header class="b-b header">
				<p class="h4">资料审核</p>
			</header>
			<section class="scrollable wrapper w-f">
				<form class="form-horizontal" id="form_pass" action="" method="POST">
					<div class="form-group">
						<label class="col-sm-2 control-label">姓名：</label>
						<div class="col-sm-4">
							<p class="form-control-static">${userAudit.name}</p>
						</div>
						<label class="col-sm-1 control-label">性别：</label>
						<div class="col-sm-5">
							<p class="form-control-static"><c:if test="${userAudit.sex eq 1}">男</c:if><c:if test="${userAudit.sex eq 2}">女</c:if></p>
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">学历：</label>
						<div class="col-sm-4">
							<p class="form-control-static"><c:if test="${userAudit.education eq 1}">本科</c:if><c:if test="${userAudit.education eq 2}">硕士</c:if><c:if test="${userAudit.education eq 3}">博士</c:if><c:if test="${userAudit.education eq 4}">高中</c:if></p>
						</div>
						<label class="col-sm-1 control-label">专业：</label>
						<div class="col-sm-5">
							<p class="form-control-static">${userAudit.specialtyname}</p>
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">语种：</label>
						<div class="col-sm-4">
							<p class="form-control-static">${userAudit.languagename}</p>
						</div>
						<label class="col-sm-1 control-label">区域：</label>
						<div class="col-sm-5">
							<p class="form-control-static">${userAudit.areaname}</p>
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">年龄：</label>
						<div class="col-sm-4">
							<p class="form-control-static">${userAudit.age}岁</p>
						</div>
						<label class="col-sm-1 control-label">等级：</label>
						<div class="col-sm-5">
	                       	<div class="btn-group m-r">
		                       <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
		                         <span class="dropdown-label">
		                         	<c:if test="${empty userAudit.level}">选择等级</c:if>
		                         	<c:if test="${userAudit.level eq 2}">口译员</c:if>
		                         	<c:if test="${userAudit.level eq 3}">高级口译员</c:if>
		                         </span> 
		                         <span class="caret"></span>
		                       </button>
		                       <ul class="dropdown-menu dropdown-select">
		                           <li <c:if test="${userAudit.level eq 2}">class="active"</c:if>><a href="#"><input type="radio" name="level" <c:if test="${userAudit.level eq 2}">checked="checked"</c:if> value="2">口译员</a></li>
		                           <li <c:if test="${userAudit.level eq 3}">class="active"</c:if>><a href="#"><input type="radio" name="level" <c:if test="${userAudit.level eq 3}">checked="checked"</c:if> value="3">高级口译员</a></li>
		                       </ul>
		                     </div>
	                     </div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">出生年月：</label>
						<div class="col-sm-4">
							<p class="form-control-static">${birthdayau}</p>
						</div>
						<label class="col-sm-1 control-label">籍贯：</label>
						<div class="col-sm-5">
	                       <p class="form-control-static">${userAudit.origin}</p>
	                     </div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">手机号：</label>
						<div class="col-sm-4">
	                       	<p class="form-control-static">${userAudit.phone}</p>
	                     </div>
						<label class="col-sm-1 control-label">护照号：</label>
						<div class="col-sm-5">
							<p class="form-control-static">${userAudit.idcardno}</p>
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">毕业学校：</label>
						<div class="col-sm-10">
							<p class="form-control-static">${userAudit.school}</p>
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">个人简介：</label>
						<div class="col-sm-8">
							<p class="form-control-static">${userAudit.remark}</p>
						</div>
						<div class="col-sm-2">&nbsp;</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group col-md-12">
                        <div class="col-md-6">
                        	<label>护照图片</label>
	    					<a <c:if test="${!empty userAudit.studentdownurl}">href="${IMG_URL}${userAudit.passporturl}"</c:if> class="thumbnail" target="_blank">
			                    <c:choose>
	    							<c:when test="${empty userAudit.passporturlmin}">
					                    <img src="view/static/panel/img/blank.png" class="img-rounded">
	    							</c:when>
	    							<c:otherwise>
					                    <img title="点击查看原图" src="${IMG_URL}${userAudit.passporturlmin}" class="img-rounded">
	    							</c:otherwise>
	    						</c:choose>
		                    </a>
	                    </div>
                        <div class="col-md-6">
                        	<label>签证图片</label>
	    					<a <c:if test="${!empty userAudit.visaurl}">href="${IMG_URL}${userAudit.visaurl}"</c:if> class="thumbnail" target="_blank">
			                    <c:choose>
	    							<c:when test="${empty userAudit.visaurlmin}">
					                    <img src="view/static/panel/img/blank.png" class="img-rounded">
	    							</c:when>
	    							<c:otherwise>
					                    <img title="点击查看原图" src="${IMG_URL}${userAudit.visaurlmin}" class="img-rounded">
	    							</c:otherwise>
	    						</c:choose>
		                    </a>
	                    </div>
	                 </div>
	                 <div class="form-group col-md-12">
                        <div class="col-md-6">
                        	<label>学生证正面图片</label>
	    					<a <c:if test="${!empty userAudit.studentupurl}">href="${IMG_URL}${userAudit.studentupurl}"</c:if> class="thumbnail" target="_blank">
			                    <c:choose>
	    							<c:when test="${empty userAudit.studentupurlmin}">
					                    <img src="view/static/panel/img/blank.png" class="img-rounded">
	    							</c:when>
	    							<c:otherwise>
					                    <img title="点击查看原图" src="${IMG_URL}${userAudit.studentupurlmin}" class="img-rounded">
	    							</c:otherwise>
	    						</c:choose>
		                    </a>
	                    </div>
                        <div class="col-md-6">
                        	<label>学生证反面图片</label>
	    					<a <c:if test="${!empty userAudit.studentdownurl}">href="${IMG_URL}${userAudit.studentdownurl}"</c:if> class="thumbnail" target="_blank">
			                    <c:choose>
	    							<c:when test="${empty userAudit.studentdownurlmin}">
					                    <img src="view/static/panel/img/blank.png" class="img-rounded">
	    							</c:when>
	    							<c:otherwise>
					                    <img title="点击查看原图" src="${IMG_URL}${userAudit.studentdownurlmin}" class="img-rounded">
	    							</c:otherwise>
	    						</c:choose>
		                    </a>
	                    </div>
					</div>
				</form>
			</section>
			<footer class="footer b-t bg-white-only">
				<div class="m-t-sm">
					<button type="button" data_submit_type="submit_pass"
						class="btn btn-s-md btn-primary btn-sm input-submit">通&nbsp;&nbsp;&nbsp;&nbsp;过</button>
					<button type="button" data_submit_type="submit_unpass"
						class="btn btn-s-md btn-danger btn-sm input-submit">拒&nbsp;&nbsp;&nbsp;&nbsp;绝</button>
					<button type="button" data_submit_type="submit_cancel"
						class="btn btn-s-md btn-primary btn-sm input-submit">返&nbsp;&nbsp;&nbsp;&nbsp;回</button>
					<span id="form_notice" style="color: red;"></span>
				</div>
			</footer>
		</section>
	</aside>
</section>
<jsp:include page="/view/panel/wrapper.suffix.jsp" />
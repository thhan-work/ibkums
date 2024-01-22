package com.ibk.msg.advice;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.HashMap;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.javassist.NotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@ControllerAdvice
@RestController
@Slf4j
public class ExceptionAdvice {

	@ExceptionHandler(value = IllegalArgumentException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Map<String, Object> handleIllegalArgumentException(Exception e) {
		Map<String, Object> response = new HashMap<>();
		response.put("code", 400);
		response.put("message", e.getMessage());
		return response;
	}

	@ExceptionHandler(value = NotFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public Map<String, Object> handleNotFoundException(Exception e) {
		Map<String, Object> response = new HashMap<>();
		response.put("code", 404);
		response.put("message", e.getMessage());
		return response;
	}

	@ExceptionHandler(value = SQLException.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public Map<String, Object> handleSQLException(Exception e) {
		Map<String, Object> response = new HashMap<>();
		response.put("code", 500);
		response.put("message", e.getCause().getMessage());
		return response;
	}

	@ExceptionHandler(value = BadSqlGrammarException.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public Map<String, Object> handleBadSqlGrammarException(Exception e) {
		log.error("BadSqlGrammarException", e);
		Map<String, Object> response = new HashMap<>();
		response.put("code", 500);
		response.put("message", "SQL 구문 오류 입니다.");
		return response;
	}

	@ExceptionHandler(value = SQLIntegrityConstraintViolationException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Map<String, Object> handleSQLIntegrityConstraintViolationException(Exception e) {
		Map<String, Object> response = new HashMap<>();
		response.put("code", 400);
		response.put("message", e.getCause().getMessage());
		return response;
	}

}

package com.ibk.msg.config.web;

import com.fasterxml.jackson.core.SerializableString;
import com.fasterxml.jackson.core.io.CharacterEscapes;
import com.fasterxml.jackson.core.io.SerializedString;
import org.apache.commons.lang3.text.translate.AggregateTranslator;
import org.apache.commons.lang3.text.translate.CharSequenceTranslator;
import org.apache.commons.lang3.text.translate.EntityArrays;
import org.apache.commons.lang3.text.translate.LookupTranslator;

public class HTMLCharacterEscapes extends CharacterEscapes {

	// 참조 싸이트
	// https://homoefficio.github.io/2016/11/21/Spring%EC%97%90%EC%84%9C-JSON%EC%97%90-XSS-%EB%B0%A9%EC%A7%80-%EC%B2%98%EB%A6%AC-%ED%95%98%EA%B8%B0/

	private int[] asciiEscapes;

	private CharSequenceTranslator translator;

	public HTMLCharacterEscapes() {
		// 1. XSS 방지 처리할 특수 문자 지정
		asciiEscapes = CharacterEscapes.standardAsciiEscapesForJSON();
		/*asciiEscapes['<'] = CharacterEscapes.ESCAPE_CUSTOM;
    asciiEscapes['>'] = CharacterEscapes.ESCAPE_CUSTOM;
    asciiEscapes['&'] = CharacterEscapes.ESCAPE_CUSTOM;
    asciiEscapes['\"'] = CharacterEscapes.ESCAPE_CUSTOM;
    asciiEscapes['('] = CharacterEscapes.ESCAPE_CUSTOM;
    asciiEscapes[')'] = CharacterEscapes.ESCAPE_CUSTOM;
    asciiEscapes['#'] = CharacterEscapes.ESCAPE_CUSTOM;
    asciiEscapes['\''] = CharacterEscapes.ESCAPE_CUSTOM;*/

		// 2. XSS 방지 처리 특수 문자 인코딩 값 지정
		translator = new AggregateTranslator(
				new LookupTranslator(EntityArrays.BASIC_ESCAPE()),  // <, >, &, " 는 여기에 포함됨
				new LookupTranslator(EntityArrays.ISO8859_1_ESCAPE()),
//				new LookupTranslator(EntityArrays.HTML40_EXTENDED_ESCAPE()),
				new LookupTranslator(EntityArrays.JAVA_CTRL_CHARS_ESCAPE())
				);
	}

	@Override
	public int[] getEscapeCodesForAscii() {
		return asciiEscapes;
	}

	@Override
	public SerializableString getEscapeSequence(int ch) {
		return new SerializedString(translator.translate(Character.toString((char) ch)));
	}
}

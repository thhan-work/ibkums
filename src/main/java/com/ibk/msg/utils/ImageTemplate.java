package com.ibk.msg.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.GraphicsEnvironment;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class ImageTemplate {
	BufferedImage img=null;
	Graphics2D g = null;
	private ImageTemplate(BufferedImage img) {		
		this.img = img;
		g = img.createGraphics();


	}

	/*	public void addFont(String fontName)
	{
		try {
		     GraphicsEnvironment ge = 
		         GraphicsEnvironment.getLocalGraphicsEnvironment();
		     ge.registerFont(Font.createFont(Font.TRUETYPE_FONT, new File(fontName + ".ttf")));
		} catch (IOException e) {
		     //Handle exception
		} catch (FontFormatException e){

		}
	}*/
	
	public int createFont(String fontName, int style, int size , String color) {
		try {
			Font createFont = Font.createFont(style, new File(fontName));
			String fontName2 = createFont.getFontName();
			
			System.out.println(fontName2);
			Font f = new Font(fontName2, 0, size);
			
			g.setFont(f);
			
			if (color != null  ) {				
				
				String Red = color.substring(1,3);
				String Green = color.substring(3,5);
				String Blue = color.substring(5,7);

				int red = Integer.parseInt(Red, 16);
				int green = Integer.parseInt(Green, 16);
				int blue = Integer.parseInt(Blue, 16);

				g.setColor(new Color(red,green,blue));

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	public int setFont(String fontName,int style, int size , String color) {

		//���� ���� ������ ���� ���� ����
		if(fontName == null || fontName.isEmpty())
		{
			return -1;
		}

		//result Font ����
		Font f = null;
		//Local ������ ���� ����
		boolean existenceCheck = false;

		// local Font ���� ��������
		GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
		// local Font���� input���������� ������ ������ ���������� ���� 
		for(Font font : ge.getAllFonts())
		{
			//�������� �� ����
			if(font.getName().replaceAll(" ", "").trim().equals(fontName.replaceAll(" ", "").trim()))
			{
				f = new Font(font.getName(), style, size);
				existenceCheck = true;
				break;
			}
		}

		//Local ���� ���� ���� : ������ ���� ���� ����
		if(!existenceCheck)
		{
			
			f = new Font(fontName, style, size);
		}

		g.setFont(f);

		if (color != null  ) {

			String Red = color.substring(1,3);
			String Green = color.substring(3,5);
			String Blue = color.substring(5,7);

			int red = Integer.parseInt(Red, 16);
			int green = Integer.parseInt(Green, 16);
			int blue = Integer.parseInt(Blue, 16);

			g.setColor(new Color(red,green,blue));

		}

		return 0;
	}

	public int drawText(Object text,int x, int y) {
		g.drawString(text.toString(), x, y);
		return 0;
	}

	public int saveImage(String imgPath) {

		try {
			ImageIO.write(img, "jpg", new File(imgPath));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	protected void finalize() throws Throwable {
		super.finalize();
		if ( g != null) {

			g.dispose();

			g = null;

		}

	}
	
	public byte[] getImage() {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try {
			ImageIO.write(this.img, "jpg", baos);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return baos.toByteArray();
	}	
	public static ImageTemplate createInstanceFromImage(String bgImgPath) {

		try {
			//			img = ImageIO.read(new File(bgImgPath));
			/*BufferedReader br = new BufferedReader(new FileReader(bgImgPath));
			String s = br.readLine();
			int len = s.length();
			byte[] data = new byte[len / 2];
			for (int i = 0; i < len; i += 2) {
				data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
						+ Character.digit(s.charAt(i+1), 16));
			}
			 */
			/*BufferedInputStream  inputStream = new BufferedInputStream(new FileInputStream(bgImgPath));
			BufferedImage bufferedImage = ImageIO.read(inputStream);
			ImageIO.write(bufferedImage, "jpg", new File(bgImgPath));	*/

			
			BufferedImage bimage = ImageIO.read(new File(bgImgPath));
			/*BufferedImage bi = new BufferedImage(bimage.getWidth()*2, bimage.getHeight()*2, BufferedImage.TYPE_INT_RGB);
			Graphics g = bi.getGraphics();
			g.drawImage(bi, 0, 0, bimage.getWidth()*2, bimage.getHeight()*2, null);*/

			return new ImageTemplate(bimage) ;

		} catch (IOException e) {

			e.printStackTrace();
		}
		return null;

	}
	
	public static ImageTemplate createInstanceFromImage(byte[] bgImgPath) {

		try {
			//			img = ImageIO.read(new File(bgImgPath));
			/*BufferedReader br = new BufferedReader(new FileReader(bgImgPath));
			String s = br.readLine();
			int len = s.length();
			byte[] data = new byte[len / 2];
			for (int i = 0; i < len; i += 2) {
				data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
						+ Character.digit(s.charAt(i+1), 16));
			}
			 */
			/*BufferedInputStream  inputStream = new BufferedInputStream(new FileInputStream(bgImgPath));
			BufferedImage bufferedImage = ImageIO.read(inputStream);
			ImageIO.write(bufferedImage, "jpg", new File(bgImgPath));	*/

			
			BufferedImage bimage = ImageIO.read(new ByteArrayInputStream(bgImgPath));
			/*BufferedImage bi = new BufferedImage(bimage.getWidth()*2, bimage.getHeight()*2, BufferedImage.TYPE_INT_RGB);
			Graphics g = bi.getGraphics();
			g.drawImage(bi, 0, 0, bimage.getWidth()*2, bimage.getHeight()*2, null);*/

			return new ImageTemplate(bimage) ;

		} catch (IOException e) {

			e.printStackTrace();
		}
		return null;

	}


	public static void main(String[] args) throws IOException {
		//		BOLD	1
		//		ITALIC	2
		//		PLAIN	0
		
		// Font.BOLD | Font.ITALIC
		// 11111111 11111111 11111111 1111111(ITALIC/UNITALIC)1(BOLD/PLAIN)
		/*int a= 0;
		if ((a & Font.BOLD) == Font.BOLD) {
			
		}*/
		
		String[] availableFontFamilyNames = GraphicsEnvironment.getLocalGraphicsEnvironment().getAvailableFontFamilyNames();
		for(String item : availableFontFamilyNames) {
			System.out.println(item);
		}


		ImageTemplate it = createInstanceFromImage("./img/NAMECARDTEMPLATE.jpg");
		it.setFont("맑은 고딕" ,0, 65 , "#000000");
		it.drawText("여상엽", 51, 281);
		it.saveImage("./img/NAMECARDTEMPLATE_PER.jpg");


	}
}

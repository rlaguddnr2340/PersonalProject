package util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Map;

import org.springframework.web.util.UriComponentsBuilder;

public class ApiCall {
	
	private static final String CRLF= "\r\n";
	private static  PrintWriter writer = null;
    private static  OutputStream output = null;

	public String ApiCall(String url, Map<Object,Object> map, String method) throws Exception {
		// 빌더 객체 생성/ 도메인이 들어가는게 아니라 컨택스트패스 같은 개념
		if(method.equals("GET")) {
			UriComponentsBuilder builder = UriComponentsBuilder.fromPath("");
			// 키만 가져오는 걸 반복시킬수있다.
			Iterator iter = map.keySet().iterator(); 
			while (iter.hasNext()) {
				String key = (String) iter.next(); // 키를 가져온다.
				builder.queryParam(key, map.get(key)); // 키가 파라미터명
			}
			String returnUrl = url + builder.toUriString(); // 객채에 있는 파라미터 만큼 반복시키면서 .queryParam 하면 된다.
	
			URL apiurl = new URL(returnUrl);
			HttpURLConnection con = (HttpURLConnection) apiurl.openConnection();
			con.setRequestMethod(method);
			
			InputStreamReader streamReader = new InputStreamReader(con.getInputStream());
			try (BufferedReader lineReader = new BufferedReader(streamReader)) {
				StringBuilder responseBody = new StringBuilder();
				String line;
				while ((line = lineReader.readLine()) != null) {
					responseBody.append(line);
				}
				return responseBody.toString();
			}
			catch (Exception e) {
				return "Api 호출 중 에러발생";
			}
		}
		
		else if(method.equals("POST")){
			URL posturl = new URL(url);
			StringBuilder postData = new StringBuilder();
			for(Map.Entry<Object,Object> params: map.entrySet()) {
				if(postData.length() != 0) postData.append("&");
				postData.append(URLEncoder.encode((String)params.getKey(), "UTF-8"));
				postData.append("=");
				postData.append(URLEncoder.encode(String.valueOf(params.getValue()), "UTF-8"));
			}
			byte[] postDataBytes = postData.toString().getBytes("UTF-8");
			HttpURLConnection conn = (HttpURLConnection)posturl.openConnection();
			conn.setRequestMethod(method);
			conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
			conn.setDoInput(true);
			conn.setDoOutput(true);
            
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String inputLine;
		    StringBuffer response = new StringBuffer();
		    while((inputLine = in.readLine()) != null) { // response 출력
		    	response.append(inputLine);
		    }
			return response.toString();
		}
		
		else {
			String boundary = "====__====";
			URL posturl = new URL(url);
			StringBuilder postData = new StringBuilder();
			for(Map.Entry<Object,Object> params: map.entrySet()) {
				if(postData.length() != 0) postData.append("&");
				postData.append(URLEncoder.encode((String)params.getKey(), "UTF-8"));
				postData.append("=");
				postData.append(URLEncoder.encode(String.valueOf(params.getValue()), "UTF-8"));
			}
			
			byte[] postDataBytes = postData.toString().getBytes("UTF-8");
			HttpURLConnection conn = (HttpURLConnection)posturl.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
			conn.setRequestProperty("Content-Type", "multipart/form-data; boundary="+boundary);
			conn.setDoInput(true);
			conn.setDoOutput(true);
			
			output = conn.getOutputStream();
			writer =  new PrintWriter(new OutputStreamWriter(output, "UTF-8"), true);
			
			output.write(postDataBytes);
			
			Iterator iter = map.keySet().iterator(); 
			while (iter.hasNext()) {
				String key = (String) iter.next(); // 키를 가져온다.
				if(!key.equals("filename")) {
					addString(boundary, key, (String)map.get(key));
				}
			}
			
			if(map.get("filename") !=null) {
				addFile(boundary, "filename", (File)map.get("filename"));
			}
			addEnd(boundary);
            
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String inputLine;
		    StringBuffer response = new StringBuffer();
		    while((inputLine = in.readLine()) != null) { // response 출력
		    	response.append(inputLine);
		    }
		    return response.toString();
		}
	}
	
	public static void addFile(String boundary, String _key, File _file) throws IOException{// Send File
        StringBuilder sb = new StringBuilder();     
        sb.append("--"+ boundary).append(CRLF);
        sb.append("Content-Disposition: form-data; name=\""+ _key +"\"; filename=\"" + _file.getName() + "\"").append(CRLF);
        sb.append("Content-Type: "+ URLConnection.guessContentTypeFromName(_file.getName())).append(CRLF); // Text file itself must be saved in this charset!
        sb.append("Content-Transfer-Encoding: binary").append(CRLF);
        sb.append(CRLF);
        writer.append(sb).flush();
         
        FileInputStream inputStream = new FileInputStream(_file);
        byte[] buffer = new byte[(int)_file.length()];
        int bytesRead = -1;
        while((bytesRead = inputStream.read(buffer)) != -1){
            output.write(buffer, 0, bytesRead);
        }
        output.flush();
        inputStream.close();
         
        writer.append(CRLF).flush();
    }
	
	private void addEnd(String boundary){//End of multipart/form-data.
        StringBuilder sb = new StringBuilder();
        sb.append("--").append(boundary).append("--").append(CRLF);
        this.writer.append(sb).flush();
    }
	
	private void addString(String boundary, String _key, String _value){// Send normal String
        StringBuilder sb = new StringBuilder();
        sb.append("--"+ boundary).append(CRLF);
        sb.append("Content-Disposition: form-data; name=\""+ _key +"\"").append(CRLF);
        sb.append("Content-Type: text/plain; charset=" + "UTF-8").append(CRLF);
        sb.append(CRLF).append(_value).append(CRLF);
         
        this.writer.append(sb).flush();
    }
}

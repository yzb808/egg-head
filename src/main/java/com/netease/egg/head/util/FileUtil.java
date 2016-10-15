package com.netease.egg.head.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.log4j.Logger;
public class FileUtil {
	private static Logger  LOG = Logger.getLogger(FileUtil.class);
    public static String readTextFileFromClassPath(String fileName,String charset){
    	BufferedReader br=null;
    	try{
            StringBuilder sb=new StringBuilder();
            InputStream is = FileUtil.class.getClassLoader().getResourceAsStream(fileName);
            br = new BufferedReader(new InputStreamReader(is,charset));  
            
            while(true){
                String line = br.readLine();
                if(line==null){
                    break;
                }
                sb.append(line).append("\n");
            }
            
            return sb.toString();
        }catch(Exception e){
            throw new RuntimeException("failed to read file:"+fileName,e);
        }finally{
        	if(br!=null){
        		try {
					br.close();
				} catch (IOException e) {
					LOG.error(e);
				}  
        	}
        	 
        }
                                                      
                                                              
    }

}

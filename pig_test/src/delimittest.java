import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;


public class delimittest 
{
	public static void main(String[] qwe) throws IOException
	{
		
		BufferedReader br = new BufferedReader(new FileReader("/home/bashyan-ubuntu/Documents/pig/pigtest/student.txt"));
		String lines, now, now1;
		String[] splits = null;
		
		
		Map<String, String> abMap = new HashMap<String, String>();
		
		while((lines = br.readLine())!=null)
		{
			StringTokenizer st = new StringTokenizer(lines,"||");
			int i=0;
			while(st.hasMoreTokens())
			{
				now = st.nextToken();
				now1 = st.nextToken();
				//System.out.println(now);
				//System.out.println(now1);
				abMap.put(now, now1);				
			}			
		}
		for(Map.Entry E: abMap.entrySet())
		{
			System.out.println(E.getKey()+","+E.getValue());
		}		
		br.close();
	}
}

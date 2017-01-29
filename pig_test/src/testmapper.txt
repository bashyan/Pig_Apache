
import java.io.BufferedReader;  
import java.io.FileReader;
import java.io.IOException;
import java.net.URI;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;

public class testmapper {
	
	
	public static class MyMapper extends Mapper<LongWritable,Text, Text, Text> 
	{
        
		
		private Map<String, String> abMap = new HashMap<String, String>();
		
		private Text outputKey = new Text();
		private Text outputValue = new Text();
		
		protected void setup(Context context) throws java.io.IOException, InterruptedException{
			
			super.setup(context);
		    URI[] files = context.getCacheFiles(); // getCacheFiles returns null
		    Path p = new Path(files[0]);		
			if (p.getName().equals("results")) {
					
				BufferedReader br = new BufferedReader(new FileReader(p.toString()));
				String lines, now, now1;
				while((lines = br.readLine())!=null)
				{
					StringTokenizer st = new StringTokenizer(lines,"||");
					while(st.hasMoreTokens())
					{
						now = st.nextToken();
						now1 = st.nextToken();
						abMap.put(now, now1);				
					}			
				}
				br.close();
				}		
			
			if (abMap.isEmpty()) {
				throw new IOException("MyError:Unable to load RESULTS data.");
			}			
		}

		
        protected void map(LongWritable key, Text value, Context context)
            throws java.io.IOException, InterruptedException {
        	
        	
        	String row = value.toString();
        	StringTokenizer st = new StringTokenizer(row,"||");
        	String now=null, now1=null, pass=null;
			while(st.hasMoreTokens())
			{
				now = st.nextToken();
				now1 = st.nextToken();
				pass = abMap.get(now1);
			}        	
        	String result = now+","+pass;
        	outputKey.set(now1);
        	outputValue.set(result);
      	  	context.write(outputKey,outputValue);
        }
	}
	
	
	
	
	
  public static void main(String[] args) 
                  throws IOException, ClassNotFoundException, InterruptedException {
    
	Configuration conf = new Configuration();
	conf.set("mapred.textoutputformat.separator", ",");
	Job job = Job.getInstance(conf);
    job.setJarByClass(testmapper.class);
    job.setJobName("Map Side Join");
    job.setMapperClass(MyMapper.class);
    job.addCacheFile(new Path("results").toUri());
    job.setNumReduceTasks(0);
    job.setMapOutputKeyClass(Text.class);
    job.setMapOutputValueClass(Text.class);
    
    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));
    
    job.waitForCompletion(true);
    
    
  }
}

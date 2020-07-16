package com.iwe.test;

import com.intuit.karate.junit5.Karate;

class StudyDataLakeTest {

//	@Test
//	void testRunner() {
//		Results results = Runner.path("").parallel(1);
//		generateReport(results.getReportDir());
//		assertEquals(0, results.getFailCount(), results.getErrorMessages());
//	}
	
	@Karate.Test
    Karate testSample() {
		Karate relativeTo = Karate.run("study-datalake").relativeTo(getClass());
        return relativeTo;
    }
	

//	private static void generateReport(String karateOutputPath) {
//		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
//		List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
//		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
//		Configuration config = new Configuration(new File("target"), "demo");
//		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
//		reportBuilder.generateReports();
//	}
}
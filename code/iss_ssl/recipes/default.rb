#
# Cookbook Name:: iss_ssl
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'iis_urlrewrite'


ruby_block "insert" do
  block do
    file = Chef::Util::FileEdit.new("C:\\inetpub\\temp\\appPools\\DefaultAppPool\\DefaultAppPool.config")
	file.insert_line_after_match("<allowedServerVariables>", "<add name=\"SERVER_PORT\" />")
	file.insert_line_after_match("<allowedServerVariables>", "<add name=\"HTTPS\" />")
    file.write_file
  end
 not_if do ::File.exists?('C:\\inetpub\\temp\\appPools\\DefaultAppPool\\DefaultAppPool.config.old') end 
end


#not_if do ::File.exists?('/var/lib/apt/periodic/update-success-stamp') end
#only_if { File.exists?(aspnet_regiis) }

ruby_block "insert" do
  block do
    file = Chef::Util::FileEdit.new("C:\\inetpub\\wwwroot\\web.config")
	file.insert_line_after_match("<system.webServer>", "	        <rewrite>
	            <rules>
	                <rule name=\"http to https\" enabled=\"true\" patternSyntax=\"ECMAScript\" stopProcessing=\"true\">
	                    <match url=\"^(.*)$\" />
	                    <conditions>
	                        <add input=\"{HTTP_HOST}\" matchType=\"Pattern\" pattern=\"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}.*\" negate=\"true\" />
	                        <add input=\"{REQUEST_URI}\" pattern=\".*/Wcf/.*\" negate=\"true\" />
	                        <add input=\"{REQUEST_URI}\" pattern=\".*/Administrator/.*\.svc\" negate=\"true\" />
	                    </conditions>
	                    <action type=\"None\" logRewrittenUrl=\"true\" />
	                    <serverVariables>
	                        <set name=\"HTTPS\" value=\"on\" />
	                        <set name=\"SERVER_PORT\" value=\"443\" />
	                    </serverVariables>
	                </rule>
	            </rules>
        </rewrite>
")
    file.write_file
  end
  not_if do ::File.exists?('C:\\inetpub\\wwwroot\\web.config.old') end
end




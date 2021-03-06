## Get MODIS Data 
#phen_sites = data.frame( SITE_NAME = c("Coweeta","Shalehillsczo","Howland","Shenandoah","Bartlett"),
#                        URL = c("http://phenocam.sr.unh.edu/data/archive/bartlett/ROI/bartlett_deciduous_0001_gcc.csv",
#                                "http://phenocam.sr.unh.edu/data/archive/coweeta/ROI/coweeta_deciduous_0002_gcc.csv",         
#                                "http://phenocam.sr.unh.edu/data/archive/howland1/ROI/howland1_canopy_0001_gcc.csv",          
#                                "http://phenocam.sr.unh.edu/data/archive/shalehillsczo/ROI/shalehillsczo_canopy_0001_gcc.csv",
#                                "http://phenocam.sr.unh.edu/data/archive/shenandoah/ROI/shenandoah_canopy_0001_gcc.csv"),
#                        save_dir = c("bartlett_deciduous_0001_gcc.csv",
#                                     "coweeta_deciduous_0002_gcc.csv",         
#                                     "howland1_canopy_0001_gcc.csv",          
#                                     "shalehillsczo_canopy_0001_gcc.csv",
#                                     "shenandoah_canopy_0001_gcc.csv"),
#                        lat = c(35.0596, 40.6500, 45.2041, 38.5926, 44.0646), 
#                        lon = c(-83.4280, -77.9000, -68.7403, -78.3756, -71.2881))
#
# write.table(dat,"phen_sites.csv",row.names=FALSE,sep=",") 

require('devtools')
require('MODISTools')

dat = read.table("phen_sites.csv",header = TRUE, sep=",") # dat has site specs

LAT = dat$lat
LON = dat$lon
URL_str = levels(dat$URL)
file_name = levels(dat$save_dir)

save_path = "/var/www/ge585/"

for (i in 1:5) {
  
  MODISSubsets(data.frame(lat=LAT[i],long=LON[i],start.date=2010,end.date=2013),
               Product="MOD09A1",Bands=c("sur_refl_day_of_year","sur_refl_qc_500m",
                                         "sur_refl_state_500m","sur_refl_vzen","sur_refl_b01","sur_refl_b02"),
               Size=c(1,1), SaveDir = save_path, StartDate=TRUE)
  
  sys_command = paste("wget", URL_str[i])
  system(sys_command)

  sys_command_save = paste("mv",file_name[i],save_path)
  system(sys_command_save)
  
}



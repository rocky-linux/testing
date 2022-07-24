document.getElementById('topMenu').innerHTML = `
<h1>Live RHEL <----> Rocky Linux Package Comparison</h1>


  <p><br />
  This is a simple page to keep live track of the package differences/drift between RHEL and Rocky Linux.
  <br /><br />
  This page compares the RHEL repository package version(s) against the current Rocky public repos.
  <br /><br />
  The data on this page should be updated <b>every 4 hours.</b>
  <br /><br />
  Historical data can be found in this subdirectory: <b><a href="repocompare_results/">repocompare_results/</a></b>
  <br /><br />
  <b>Important Note:</b> This comparison <b>only includes default modules and non-modular packages</b>.
  <br />

  <p><br />

  <h3>Other Package comparisons between RHEL  <-->  Rocky Linux:</h3>

<table border=1 cellpadding=10>
  <tr>
    <th>RHEL/Rocky 8</th> 
    <th>RHEL/Rocky 9</th> 
    <th>RHEL 8 Beta / Rocky 8 Staging</th> 
    <th>RHEL 9 Beta / Rocky 9 Staging</th>
  </tr>
  
  <tr>
    <td><a href="RHEL_Rocky8_Compare.html">Package Repo Comparison (8)</a></td>
    <td><a href="RHEL_Rocky9_Compare.html">Package Repo Comparison (9)</a></td>
    <td><a href="RHEL_Rocky8_Compare_Beta_stg.html">Package Repo Comparison (8 Beta)</a></td>
    <td><a href="RHEL_Rocky9_Compare_Beta_stg.html">Package Repo Comparison (9 Beta)</a></td>
  </tr>
  
  <tr>
    <td><a href="RHEL_Rocky8_Compare_src.html">SRPM Repo Comparison (8)</a></td>
    <td><a href="RHEL_Rocky9_Compare_src.html">SRPM Repo Comparison (9)</a></td>
    <td><a href="RHEL_Rocky8_Compare_Beta_src_stg.html">SRPM Repo Comparison (8 Beta)</a></td>   
    <td><a href="RHEL_Rocky9_Compare_Beta_src_stg.html">SRPM Repo Comparison (9 Beta)</a></td>   
  </tr>
  
  <tr>
    <td><a href="RHEL_Rocky8_Module_Compare.html">Modules Repo Comparison (8)</a></td>
    <td><a href="RHEL_Rocky9_Module_Compare.html">Modules Repo Comparison (9)</a></td>
    <td><a href="RHEL_Rocky8_Module_Compare_Beta_stg.html">Modules Repo Comparison (8 Beta)</a></td>
    <td><a href="RHEL_Rocky9_Module_Compare_Beta_stg.html">Modules Repo Comparison (9 Beta)</a></td>   
  </tr>
  
  <tr>
    <td><a href="RHEL_Rocky8_Compare_stg.html">Package Repo Comparison (8 staging)</a></td>
    <td><a href="RHEL_Rocky9_Compare_stg.html">Package Repo Comparison (9 staging)</a></td>
    <td></td>
    <td></td>
  </tr>
  
  <tr>
    <td><a href="RHEL_Rocky8_Compare_src_stg.html">SRPM Repo Comparison (8 staging)</a></td>
    <td><a href="RHEL_Rocky9_Compare_src_stg.html">SRPM Repo Comparison (9 staging)</a></td>
    <td></td>
    <td></td>
  </tr>


  <tr>
    <td><a href="RHEL_Rocky8_Module_Compare_stg.html">Modules Repo Comparison (8 staging)</a></td>
    <td><a href="RHEL_Rocky9_Module_Compare_stg.html">Modules Repo Comparison (9 staging)</a></td>
    <td></td>
    <td></td>
  </tr>

</table>



`;

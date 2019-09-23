<?xml version="1.0"?>
<chroma>
  <annotation>
    Hadron Spectrum Input
  </annotation>
  <Param> 
    <InlineMeasurements>
      <elem>
	<Name>MAKE_SOURCE</Name>
	<Frequency>1</Frequency>
	<Param>
	  <version>6</version>
	  <Source>
	    <version>3</version>
	    <SourceType>SHELL_SOURCE</SourceType>
	    <j_decay>3</j_decay>
	    <t_srce>[[SX]] [[SY]] [[SZ]] [[ST]]</t_srce>
	    <quark_smear_lastP>false</quark_smear_lastP>
	    <SmearingParam>
	      <wvf_kind>GAUGE_INV_JACOBI</wvf_kind>
	      <wvf_param>0.21</wvf_param>
	      <wvfIntPar>{{src_smr}}</wvfIntPar>
	      <no_smear_dir>3</no_smear_dir>
	    </SmearingParam>
	    <Displacement>
	      <version>1</version>
	      <DisplacementType>NONE</DisplacementType>
	    </Displacement>
	  </Source>
	</Param>
	<NamedObject>
	  <gauge_id>default_gauge_field</gauge_id>
	  <source_id>sh_source_1</source_id>
	</NamedObject>
      </elem>
      
      {{#kappas}}
      <!-- THE UNPERTUORPED PROPOGATOR -->
      <elem>
	<Name>PROPAGATOR</Name>
	<Frequency>1</Frequency>
	<Param>
	  <version>10</version>
	  <quarkSpinType>FULL</quarkSpinType>
	  <obsvP>false</obsvP>
	  <numRetries>1</numRetries>
	  <FermionAction>
	    <FermAct>SLRC</FermAct>
	    <Kappa>{{kappa}}</Kappa>                    <!-- mass -->
	    <clovCoeff>2.65</clovCoeff>
	    <FermState>
	      <Name>SLIC_FERM_STATE</Name>
	      <n_smear>1</n_smear>
	      <rho>0.1</rho>
	      <orthog_dir>5</orthog_dir>
	      <FermionBC>
		<FermBC>SIMPLE_FERMBC</FermBC>
		<boundary>1 1 1 -1</boundary>
	      </FermionBC>
	    </FermState>
	  </FermionAction>

	  <InvertParam>
            <invType>DDS_INVERTER</invType>
            <Kappa>{{kappa}}</Kappa>
            <Csw>2.65</Csw>
            <Nmr>5</Nmr>  
            <Ncy>8</Ncy>
            <Nkv>18</Nkv>
            <DeflatedNV>4</DeflatedNV>
            <BlockSize>4 4 4 8</BlockSize>
            <RsdDDS>1.0e-12</RsdDDS>
            <MaxDDS>1000</MaxDDS>
            <BlkRel>0</BlkRel>
            <SLRC>1</SLRC>
          </InvertParam>

	</Param>

	<NamedObject>
	  <gauge_id>default_gauge_field</gauge_id>
	  <source_id>sh_source_1</source_id>
	  <prop_id>{{> prop_id}}</prop_id>
	</NamedObject>
      </elem>

      <elem>
	<Name>QIO_WRITE_NAMED_OBJECT</Name>
	<Frequency>1</Frequency>
	<NamedObject>
	  <object_id>{{> prop_id}}</object_id>
	  <object_type>LatticePropagator</object_type>
	</NamedObject>
	<File>
	  <file_name>[[TMP_DIR]]/[[TRAJ]]_{{> prop_id}}.lime</file_name>
	  <file_volfmt>SINGLEFILE</file_volfmt>
	</File>
      </elem>

      {{/kappas}}

      
    </InlineMeasurements>
    <nrow>[[NX]] [[NY]] [[NZ]] [[NT]]</nrow>
  </Param>

  <RNG>
    <Seed>	
      <elem>11</elem>
      <elem>11</elem>
      <elem>11</elem>
      <elem>0</elem>
    </Seed>
  </RNG>

  <Cfg>
    <cfg_type>ILDG</cfg_type>
    <cfg_file>[[CONF]]</cfg_file>
  </Cfg>
</chroma>


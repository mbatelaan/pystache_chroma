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
	    <t_srce>{{SX}} {{SY}} {{SZ}} {{ST}}</t_srce>
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
      {{/kappas}}

      {{#kappas}}
      {{#sink_smearing}}
      <elem>
	<Name>SINK_SMEAR</Name>
	<Frequency>1</Frequency>
	<Param>
	  <version>5</version>
	  <Sink>
	    <version>2</version>
	    <SinkType>{{sink_type}}</SinkType>
	    <j_decay>3</j_decay>
	    {{#smearing}}
	    <SmearingParam>
	      <wvf_kind>GAUGE_INV_JACOBI</wvf_kind>
	      <wvf_param>0.21</wvf_param>
	      <wvfIntPar>{{smintpar}}</wvfIntPar>
	      <no_smear_dir>3</no_smear_dir>
	    </SmearingParam>
	    {{/smearing}}
	    <Displacement>
	      <version>1</version>
	      <DisplacementType>NONE</DisplacementType>
	    </Displacement>
	  </Sink>
	</Param>
	<NamedObject>
	  <gauge_id>default_gauge_field</gauge_id>
	  <prop_id>{{> prop_id}}</prop_id>
	  <smeared_prop_id>{{>prop_id}}_smeared_sink{{#smearing}}_{{smintpar}}{{/smearing}}</smeared_prop_id>
	</NamedObject>
      </elem>
      {{/sink_smearing}}
      {{/kappas}}



      {{#momenta}}
      <!-- END PREAMBLE -->
      <!-- Propagator for mom (4,4,0) -->
      {{#kappas}}
      {{#operators}}
      <elem>
	<Name>PROPAGATOR</Name>
	<Frequency>1</Frequency>
	<Param>
	  <version>10</version>
	  <quarkSpinType>FULL</quarkSpinType>
	  <obsvP>false</obsvP>
	  <numRetries>1</numRetries>
	  <FermionAction>
	    <FermAct>UNPREC_SLRC_FEYNHELL</FermAct>
	    <Kappa>{{kappa}}</Kappa>                    <!-- light mass -->
	    <FeynHellParam>
	      {{#fh-params}}
	      <elem>
		<LambdaReal>{{lam_real}}</LambdaReal>
		<LambdaImag>{{lam_imag}}</LambdaImag>
		<Operator>{{operator}}</Operator>
		<Momentum>{{momentum}}</Momentum>
		<Source>{{SX}} {{SY}} {{SZ}} {{ST}}</Source>
		<NoiseReal>1.0</NoiseReal>
		<NoiseImag>0.0</NoiseImag>
	      </elem>
	      {{/fh-params}}
	      <elem>
		<LambdaReal>0.0001</LambdaReal>
		<LambdaImag>0.0</LambdaImag>
		<Operator>8</Operator>
		<Momentum>-4 -4 0 </Momentum>
		<Source>{{SX}} {{SY}} {{SZ}} {{ST}}</Source>
		<NoiseReal>1.0</NoiseReal>
		<NoiseImag>0.0</NoiseImag>
	      </elem>
	    </FeynHellParam>
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
            <invType>RELIABLE_BICGSTAB_MP_SLRC_FEYNHELL_INVERTER-QCDSF</invType>
            <MaxIter>10000</MaxIter>
            <RsdTarget>1e-12</RsdTarget>
            <Delta>0.01</Delta>
            <CloverParams>
              <Kappa>0.12104</Kappa>
              <clovCoeff>2.65</clovCoeff>
              <FermState>
                <Name>SLIC_FERM_STATE</Name>
                <version>2</version>
                <n_smear>1</n_smear>
                <rho>0.1</rho>
                <smear_in_this_dirP>1 1 1 1</smear_in_this_dirP>
                <FermionBC>
                  <FermBC>SIMPLE_FERMBC</FermBC>
                  <boundary>1 1 1 -1</boundary>
                </FermionBC>
              </FermState>
            </CloverParams>
            <FeynHellParam>
              <elem>
                <LambdaReal>0.0001</LambdaReal>
                <LambdaImag>0.0</LambdaImag>
                <Operator>8</Operator>
                <Momentum>4 4 0 </Momentum>
                <Source>{{SX}} {{SY}} {{SZ}} {{ST}}</Source>
                <NoiseReal>1.0</NoiseReal>
                <NoiseImag>0.0</NoiseImag>
              </elem>
              <elem>
                <LambdaReal>0.0001</LambdaReal>
                <LambdaImag>0.0</LambdaImag>
                <Operator>8</Operator>
                <Momentum>-4 -4 0 </Momentum>
                <Source>{{SX}} {{SY}} {{SZ}} {{ST}}</Source>
                <NoiseReal>1.0</NoiseReal>
                <NoiseImag>0.0</NoiseImag>
              </elem>
            </FeynHellParam>
          </InvertParam>
	</Param>
	<NamedObject>
	  <gauge_id>default_gauge_field</gauge_id>
	  <source_id>sh_source_1</source_id>
	  <prop_id>fh_fh_prop_0.12104_0.0001_g4_q440_0.0001_g4_q-4-40</prop_id>
	  <initial_guess_id>prop_0.12104</initial_guess_id>
	</NamedObject>
      </elem>
      {{/operators}}
      {{/kappas}}
      {{/momenta}}

    </InlineMeasurements>
    <nrow>{{NX}} {{NY}} {{NZ}} {{NT}}</nrow>
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
    <cfg_file>{{CONF}}</cfg_file>
  </Cfg>
</chroma>

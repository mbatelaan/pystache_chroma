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
      <!-- THE UNPERTURBED PROPOGATOR -->
      <elem>
	<Name>PROPAGATOR</Name>
	<Frequency>1</Frequency>
	<Param>
	  <version>10</version>
	  <quarkSpinType>FULL</quarkSpinType>
	  <obsvP>false</obsvP>
	  <numRetries>1</numRetries>
	  <FermionAction>
	    <FermAct>UNPRECONDITIONED_SLRC</FermAct>
	    <Kappa>{{kappa}}</Kappa>                    <!-- mass -->
	    <clovCoeff>{{csw}}</clovCoeff>
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
            <Csw>{{csw}}</Csw>
            <Nmr>5</Nmr>
            <Ncy>8</Ncy>
            <Nkv>18</Nkv>
            <DeflatedNV>4</DeflatedNV>
            <BlockSize>XXBLOCKSIZEXX</BlockSize>
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
	  <smeared_prop_id>{{>prop_id}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</smeared_prop_id>
	</NamedObject>
      </elem>
      {{/sink_smearing}}

      {{/kappas}}



      {{#momenta}}
      <!-- END PREAMBLE -->
      <!-- Propagators for mom {{#fh-params}}({{#q}}{{.}} {{/q}}) {{/fh-params}} -->
      {{#lambdas}}
      {{#kappas}}
      {{#operators}}
      <!-- Propagator for q=[{{#fh-params}}({{#q}}{{.}} {{/q}}) {{/fh-params}}], kappa={{kappa}}, {{#op}}lambda_g{{opval}}={{#lambda}}{{lmb_real}}{{/lambda}}{{^lambda}}0{{/lambda}}, {{/op}} -->
      <elem>
	<Name>PROPAGATOR</Name>
	<Frequency>1</Frequency>
	<Param>
	  <version>10</version>
	  <quarkSpinType>FULL</quarkSpinType>
	  <obsvP>false</obsvP>
	  <numRetries>1</numRetries>
	  <FermionAction>
	    <FermAct>UNPRECONDITIONED_SLRC</FermAct>
	    <Kappa>{{kappa}}</Kappa>                    <!-- light mass -->
	    <clovCoeff>{{csw}}</clovCoeff>
	    <FermState>
	      <Name>SLIC_FERM_STATE</Name>
	      <n_smear>1</n_smear>
	      <rho>0.1</rho>
	      <orthog_dir>5</orthog_dir>
	      <FermionBC>
		<FermBC>SIMPLE_FERMBC</FermBC>
		<boundary>1 1 1 -1</boundary>
	      </FermionBC>
	    <FeynHellParam>
	      {{#op}}
	      {{#fh-params}}
	      <elem>
		<LambdaReal>{{#lambda}}{{lmb_real}}{{/lambda}}{{^lambda}}0{{/lambda}}</LambdaReal>
		<LambdaImag>{{#lambda}}{{lmb_imag}}{{/lambda}}{{^lambda}}0{{/lambda}}</LambdaImag>
		<Operator>{{opval}}</Operator>
		<Momentum>{{#q}}{{.}} {{/q}}</Momentum>
		<Source>[[SX]] [[SY]] [[SZ]] [[ST]]</Source>
		<NoiseReal>1.0</NoiseReal>
		<NoiseImag>0.0</NoiseImag>
	      </elem>
	      {{/fh-params}}
	      {{/op}}
	    </FeynHellParam>
	    </FermState>
	  </FermionAction>

	  <InvertParam>
            <invType>DDS_INVERTER</invType>
            <Kappa>{{kappa}}</Kappa>
            <Csw>{{csw}}</Csw>
            <Nmr>5</Nmr>
            <Ncy>8</Ncy>
            <Nkv>18</Nkv>
            <DeflatedNV>4</DeflatedNV>
            <BlockSize>XXBLOCKSIZEXX</BlockSize>
            <RsdDDS>1.0e-12</RsdDDS>
            <MaxDDS>1000</MaxDDS>
            <BlkRel>0</BlkRel>
            <SLRC>1</SLRC>
          </InvertParam>
	  
	</Param>
	<NamedObject>
	  <gauge_id>default_gauge_field</gauge_id>
	  <source_id>sh_source_1</source_id>
	  <prop_id>{{>prop_id}}</prop_id>
	  <initial_guess_id>prop_{{kappa}}</initial_guess_id>
	  {{#prior}}
 	  <prior_perturbed_guess_id>{{>prior_id}}</prior_perturbed_guess_id>
	  <prior_perturbed_factor>{{factor}}</prior_perturbed_factor>
	  {{/prior}}
	</NamedObject>
      </elem>

      {{/operators}}

      {{/kappas}}
      
      {{/lambdas}}
	
      {{#lambdas}}
      {{#kappas}}
      {{#operators}}
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
	  <smeared_prop_id>{{>prop_id}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</smeared_prop_id>
	</NamedObject>
      </elem>
      {{/sink_smearing}}
      
      {{/operators}}
      
      {{/kappas}}

      {{/lambdas}}

      {{#lambdas}}
      {{#kappas}}
      {{#operators}}
      <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
          <object_id>{{>prop_id}}</object_id>
        </NamedObject>
      </elem>
      {{/operators}}
      {{/kappas}}
      {{/lambdas}}

      {{#baryons}}
      <elem>
	<Name>BARYON_SPECTRUM-QCDSF</Name>
	<Frequency>1</Frequency>
	<Param>
	  <version>1</version>
	  <fwdbwd_average>false</fwdbwd_average>
	  <time_rev>true</time_rev>
	  <mom2_max>{{mom2max}}</mom2_max>
	  <avg_equiv_mom>false</avg_equiv_mom>
	  <xml>false</xml>
	  <lime>true</lime>
	</Param>
	<NamedObject>
	  <gauge_id>default_gauge_field</gauge_id>
	  <sink_pairs>

	    {{#sink_smearing}}
	    {{#unperturbed}}
	    {{#combinations}}
	    <elem>
	      <first_id>{{>comb_id1}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</first_id>
	      <second_id>{{>comb_id2}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</second_id>
	    </elem>
	    {{/combinations}}
	    {{/unperturbed}}

	    {{#lambdas}}
	    {{#operators}}
	    {{#combinations}}
	    <elem>
	      <first_id>{{>comb_pert_id1}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</first_id>
	      <second_id>{{>comb_id2}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</second_id>
	    </elem>
	    {{/combinations}}
	    {{/operators}}
	    {{/lambdas}}

	    {{#lambdas}}
	    {{#operators}}
	    {{#combinations}}
	    <elem>
	      <first_id>{{>comb_id1}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</first_id>
	      <second_id>{{>comb_pert_id2}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</second_id>
	    </elem>
	    {{/combinations}}
	    {{/operators}}
	    {{/lambdas}}
	    
	    {{/sink_smearing}}


	  </sink_pairs>
	</NamedObject>
	<lime_file>[[TMP_DIR]]/baryon_[[TRAJ]]_0.000{{#fh-params}}_{{#q}}{{.}}{{/q}}{{/fh-params}}.lime</lime_file>
	<xml_file>[[TMP_DIR]]/baryon_[[TRAJ]]_0.000{{#fh-params}}_{{#q}}{{.}}{{/q}}{{/fh-params}}.xml</xml_file>
      </elem>
      {{/baryons}}

      {{#mesons}}
      <elem>
	<Name>MESON_SPECTRUM-QCDSF</Name>
	<Frequency>1</Frequency>
	<Param>
	  <version>1</version>
	  <fwdbwd_average>false</fwdbwd_average>
	  <time_rev>true</time_rev>
	  <mom2_max>{{mom2max}}</mom2_max>
	  <avg_equiv_mom>false</avg_equiv_mom>
	  <xml>false</xml>
	  <lime>true</lime>
	</Param>
	<NamedObject>
	  <gauge_id>default_gauge_field</gauge_id>
	  <sink_pairs>

	    {{#sink_smearing}}
	    {{#unperturbed}}
	    {{#combinations}}
	    <elem>
	      <first_id>{{>comb_id1}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</first_id>
	      <second_id>{{>comb_id2}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</second_id>
	    </elem>
	    {{/combinations}}
	    {{/unperturbed}}

	    {{#lambdas}}
	    {{#operators}}
	    {{#combinations}}
	    <elem>
	      <first_id>{{>comb_pert_id1}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</first_id>
	      <second_id>{{>comb_id2}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</second_id>
	    </elem>
	    {{/combinations}}
	    {{/operators}}
	    {{/lambdas}}

	    {{#lambdas}}
	    {{#operators}}
	    {{#combinations}}
	    <elem>
	      <first_id>{{>comb_id1}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</first_id>
	      <second_id>{{>comb_pert_id2}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</second_id>
	    </elem>
	    {{/combinations}}
	    {{/operators}}
	    {{/lambdas}}
	    
	    {{/sink_smearing}}

	  </sink_pairs>
	</NamedObject>
	<lime_file>[[TMP_DIR]]/meson_[[TRAJ]]_0.000{{#fh-params}}_{{#q}}{{.}}{{/q}}{{/fh-params}}.lime</lime_file>
	<xml_file>[[TMP_DIR]]/meson_[[TRAJ]]_0.000{{#fh-params}}_{{#q}}{{.}}{{/q}}{{/fh-params}}.xml</xml_file>
      </elem>
      {{/mesons}}
      
      {{#sink_smearing}}
      {{#lambdas}}
      {{#kappas}}
      {{#operators}}
      <elem>
        <Name>ERASE_NAMED_OBJECT</Name>
        <Frequency>1</Frequency>
        <NamedObject>
	  <object_id>{{>prop_id}}{{#pt}}_sh_pt_sink{{/pt}}{{#smearing}}_sh_sh{{smintpar}}_sink{{/smearing}}</object_id>
        </NamedObject>
      </elem>
      {{/operators}}
      {{/kappas}}
      {{/lambdas}}
      {{/sink_smearing}}

      
      {{/momenta}}

      <!-- ERASE THE UNPERTURBED PROP -->
      {{#kappas}}
      <elem>
	<Name>ERASE_NAMED_OBJECT</Name>
	<Frequency>1</Frequency>
	<NamedObject>
	  <object_id>{{> prop_id}}</object_id>
	</NamedObject>
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


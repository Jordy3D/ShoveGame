// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RadialDisplay"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_RingColour("Ring Colour", Color) = (0,0,0,0)
		_RingInnerThickness("Ring Inner Thickness", Range( 0 , 1)) = 0.7548916
		_RingOuterThickness("Ring Outer Thickness", Range( 0 , 1)) = 1
		_Percentage("Percentage", Range( 0 , 100)) = 77.06226
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _RingColour;
		uniform float _RingOuterThickness;
		uniform float _RingInnerThickness;
		uniform float _Percentage;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float clampResult9_g5 = clamp( ( ( length( (float2( -1,-1 ) + (i.uv_texcoord - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) ) + -_RingOuterThickness ) * (0.0 + (1.0 - 0.0) * (100.0 - 0.0) / (1.0 - 0.0)) ) , 0.0 , 1.0 );
			float clampResult9_g6 = clamp( ( ( length( (float2( -1,-1 ) + (i.uv_texcoord - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) ) + -_RingInnerThickness ) * (0.0 + (1.0 - 0.0) * (100.0 - 0.0) / (1.0 - 0.0)) ) , 0.0 , 1.0 );
			float temp_output_20_0 = ( ( 1.0 - clampResult9_g5 ) * clampResult9_g6 );
			o.Emission = ( _RingColour * temp_output_20_0 ).rgb;
			o.Alpha = 1;
			float2 break3_g5 = ((float2( -1,-1 ) + (i.uv_texcoord - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 )))).xy;
			clip( ( temp_output_20_0 * ( 1.0 - ceil( ( (0.26 + (atan2( break3_g5.y , break3_g5.x ) - 0.0) * (0.33 - 0.26) / (1.0 - 0.0)) - (0.0 + (_Percentage - 0.0) * (0.5 - 0.0) / (100.0 - 0.0)) ) ) ) ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2073;116;1390;660;1161.221;65.13483;1.000111;True;False
Node;AmplifyShaderEditor.RangedFloatNode;15;-1344.586,-137.4817;Inherit;False;Constant;_Float4;Float 4;6;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1340.364,229.239;Inherit;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1163.04,-210.4818;Inherit;False;Property;_RingOuterThickness;Ring Outer Thickness;5;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;16;-1065.616,-134.9017;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-1096.363,34.23907;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-1153.72,152.4642;Inherit;False;Property;_RingInnerThickness;Ring Inner Thickness;4;0;Create;True;0;0;False;0;0.7548916;0.7548916;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;14;-800.6097,-181.934;Inherit;True;RadialGradient;-1;;5;ec972f7745a8353409da2eb8d000a2e3;0;3;1;FLOAT2;0,0;False;6;FLOAT;0;False;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;11;-1061.395,231.819;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;18;-466.0526,-184.7542;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;9;-794.5145,41.46588;Inherit;True;RadialGradient;-1;;6;ec972f7745a8353409da2eb8d000a2e3;0;3;1;FLOAT2;0,0;False;6;FLOAT;0;False;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-512.6755,325.9767;Inherit;False;Property;_Percentage;Percentage;6;0;Create;True;0;0;False;0;77.06226;100;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;-320.5149,-379.8267;Inherit;False;Property;_RingColour;Ring Colour;3;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-304.7952,-179.9167;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;56;-218.4647,324.4904;Inherit;True;RadialWipe;1;;5;9b6f6e7f475b2764994ec3bef03f1ea3;0;1;12;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-2.514893,-327.8267;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;6.384944,165.236;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;370.1681,-57.60234;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;RadialDisplay;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;15;0
WireConnection;14;1;8;0
WireConnection;14;6;17;0
WireConnection;14;7;16;0
WireConnection;11;0;10;0
WireConnection;18;0;14;0
WireConnection;9;1;8;0
WireConnection;9;6;12;0
WireConnection;9;7;11;0
WireConnection;20;0;18;0
WireConnection;20;1;9;0
WireConnection;56;12;46;0
WireConnection;22;0;21;0
WireConnection;22;1;20;0
WireConnection;50;0;20;0
WireConnection;50;1;56;0
WireConnection;0;2;22;0
WireConnection;0;10;50;0
ASEEND*/
//CHKSM=8D75431C8C7D3DE839566A5D71BB7294144C717A
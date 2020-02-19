// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BaneArt/ObjectDistance"
{
	Properties
	{
		_Radius("Radius", Range( 0 , 10)) = 5.588235
		_Strength("Strength", Range( 0 , 1)) = 1
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 2
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform int ArrayLength;
		uniform float4 positionsArray[42];
		uniform float _Radius;
		uniform float _Strength;
		uniform float _EdgeLength;


		float DistanceCheck18_g14( float3 WorldPos , int ArrayLength , float3 objectPosition )
		{
			float closest=10000;
			float now=0;
			for(int i=0; i<ArrayLength;i++)
			{
			  now = distance(WorldPos,positionsArray[i]);
			  if(now < closest)
			  {
			    closest = now;
			  }
			}
			return closest;
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float3 WorldPos18_g14 = ase_worldPos;
			int ArrayLength18_g14 = ArrayLength;
			float3 objectPosition18_g14 = positionsArray[clamp(0,0,(42 - 1))].xyz;
			float localDistanceCheck18_g14 = DistanceCheck18_g14( WorldPos18_g14 , ArrayLength18_g14 , objectPosition18_g14 );
			float clampResult10_g14 = clamp( pow( ( localDistanceCheck18_g14 / _Radius ) , (0.0 + (_Strength - 0.0) * (100.0 - 0.0) / (1.0 - 0.0)) ) , 0.0 , 1.0 );
			float4 lerpResult11 = lerp( tex2D( _TextureSample0, uv_TextureSample0 ) , tex2D( _TextureSample1, uv_TextureSample1 ) , clampResult10_g14);
			o.Albedo = lerpResult11.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2392;250;1049;728;830.5178;541.4385;1.610011;True;False
Node;AmplifyShaderEditor.RangedFloatNode;57;-453.5897,12.72819;Inherit;False;Property;_Strength;Strength;1;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;65;-170.745,19.39665;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-259.4772,-73.03315;Inherit;False;Property;_Radius;Radius;0;0;Create;True;0;0;False;0;5.588235;0.81;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;137;5.077797,-390.0974;Inherit;True;Property;_TextureSample0;Texture Sample 0;8;0;Create;True;0;0;False;0;-1;None;84508b93f15f2b64386ec07486afc7a3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;138;14.73791,-198.506;Inherit;True;Property;_TextureSample1;Texture Sample 0;9;0;Create;True;0;0;False;0;-1;None;c68296334e691ed45b62266cbc716628;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;124;72.6619,34.32032;Inherit;False;DistanceBlendObjectArray;-1;;14;5b9aec6b10979884f8f92cd3b2f819e8;0;2;20;FLOAT;0;False;21;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DdxOpNode;126;-160.9612,437.0956;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DdyOpNode;127;-159.9612,513.0956;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;128;-1008.961,981.0956;Float;False;Property;_CurvatureU1;Curvature U;11;0;Create;True;0;0;False;0;0;0;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;130;-800.9612,789.0956;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;131;-672.9612,965.0956;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;132;-1233.961,597.5956;Float;True;Property;_HeightMap1;HeightMap;7;0;Create;True;0;0;False;0;None;02381451d1e02df4d98530f05c2ba332;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;133;-952.9612,675.5956;Float;False;Property;_Scale1;Scale;10;0;Create;True;0;0;False;0;0.4247461;0.249;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;134;-888.9612,515.5956;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxOcclusionMappingNode;135;-537.8613,575.9957;Inherit;False;0;128;False;-1;128;False;-1;10;0.02;0;False;1,1;True;10,0;Texture2D;7;0;FLOAT2;0,0;False;1;SAMPLER2D;;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT2;0,0;False;6;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;136;-256.9612,357.0956;Float;False;customUVs;1;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;11;405.2619,-91.65505;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-1008.961,1061.096;Float;False;Property;_CurvatureV1;Curvature V;12;0;Create;True;0;0;False;0;0;0;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;725.4511,-90.24815;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;BaneArt/ObjectDistance;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;10;25;False;0.582;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;2;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;65;0;57;0
WireConnection;124;20;58;0
WireConnection;124;21;65;0
WireConnection;126;0;134;0
WireConnection;127;0;134;0
WireConnection;131;0;128;0
WireConnection;131;1;129;0
WireConnection;135;0;134;0
WireConnection;135;1;132;0
WireConnection;135;2;133;0
WireConnection;135;3;130;0
WireConnection;135;5;131;0
WireConnection;136;0;135;0
WireConnection;11;0;137;0
WireConnection;11;1;138;0
WireConnection;11;2;124;0
WireConnection;0;0;11;0
ASEEND*/
//CHKSM=CE020931B9C6F75F7D8F36678FBAC84AD5FB0E96
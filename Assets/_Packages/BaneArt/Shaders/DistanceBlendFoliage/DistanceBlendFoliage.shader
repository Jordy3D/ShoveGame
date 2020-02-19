// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DistanceBlendFoliage"
{
	Properties
	{
		_Float0("Float 0", Float) = 1
		_Float1("Float 1", Float) = 1
		_Float4("Float 4", Float) = 1
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[Toggle]_ToggleSwitch0("Toggle Switch0", Float) = 1
		_Float5("Float 5", Float) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float _Float5;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float4 positionsArray[3];
		uniform float _Float0;
		uniform float _Float1;
		uniform float _Float4;
		uniform float _ToggleSwitch0;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;


		float DistanceCheck18_g1( float3 WorldPos , float3 objectPosition )
		{
			float closest=10000;
			float now=0;
			for(int i=0; i<positionsArray.Length;i++)
			{
			  now = distance(WorldPos,positionsArray[i]);
			  if(now < closest)
			  {
			    closest = now;
			  }
			}
			return closest;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_TextureSample0 = v.texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 WorldPos18_g1 = ase_worldPos;
			float3 objectPosition18_g1 = positionsArray[clamp(0,0,(3 - 1))].xyz;
			float localDistanceCheck18_g1 = DistanceCheck18_g1( WorldPos18_g1 , objectPosition18_g1 );
			float clampResult10_g1 = clamp( pow( ( localDistanceCheck18_g1 / _Float0 ) , _Float1 ) , 0.0 , 1.0 );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float2 appendResult31 = (float2(0.0 , ( float4( v.texcoord.xy, 0.0 , 0.0 ) * ( _Float5 * tex2Dlod( _TextureSample0, float4( uv_TextureSample0, 0, 0.0) ) * clampResult10_g1 ) * ase_vertex3Pos.x ).r));
			v.vertex.xyz += float3( ( appendResult31 * _Float4 ) ,  0.0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color14 = IsGammaSpace() ? float4(0,1,0,1) : float4(0,1,0,1);
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			o.Albedo = lerp(color14,tex2D( _TextureSample1, uv_TextureSample1 ),_ToggleSwitch0).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
77;499;1507;912;1700.194;-148.3212;1.395;True;False
Node;AmplifyShaderEditor.RangedFloatNode;7;-1159.5,205;Inherit;False;Property;_Float1;Float 1;3;0;Create;True;0;0;False;0;1;51.86;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1159.5,109;Inherit;False;Property;_Float0;Float 0;2;0;Create;True;0;0;False;0;1;3.82;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;5;-964.5,135;Inherit;False;DistanceBlendObject;0;;1;5b9aec6b10979884f8f92cd3b2f819e8;0;2;20;FLOAT;0;False;21;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-598.5,346;Inherit;True;Property;_TextureSample0;Texture Sample 0;7;0;Create;True;0;0;False;0;0887de1d76332ae42a8e7bbf1cfbf95e;0887de1d76332ae42a8e7bbf1cfbf95e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-525.5789,252.4011;Inherit;False;Property;_Float5;Float 5;10;0;Create;True;0;0;False;0;2;2.34;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-267.5,143;Inherit;True;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PosVertexDataNode;18;-640.2704,802.5948;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-609.0999,637.4999;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-282.9,612.9;Inherit;False;3;3;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-82.70004,444.9999;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-180,746.5999;Inherit;False;Property;_Float4;Float 4;6;0;Create;True;0;0;False;0;1;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-531.5,-293;Inherit;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;False;0;0,1,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;34;-644.5,-70;Inherit;True;Property;_TextureSample1;Texture Sample 1;8;0;Create;True;0;0;False;0;0887de1d76332ae42a8e7bbf1cfbf95e;06f4abd3108aa964d96fd87acf0b6afa;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;26;-700.5,979.5999;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;29.59999,576.1999;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-1210.5,789;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1127.5,931;Inherit;False;Property;_Float3;Float 3;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1064.5,594;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;24;-890.5,649;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1421.5,856;Inherit;False;Property;_Float2;Float 2;4;0;Create;True;0;0;False;0;1;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;35;-255.5,-43;Inherit;False;Property;_ToggleSwitch0;Toggle Switch0;9;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;21;-1400.5,757;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;199,13;Float;False;True;2;ASEMaterialInspector;0;0;Standard;DistanceBlendFoliage;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;20;6;0
WireConnection;5;21;7;0
WireConnection;11;0;37;0
WireConnection;11;1;10;0
WireConnection;11;2;5;0
WireConnection;27;0;29;0
WireConnection;27;1;11;0
WireConnection;27;2;18;1
WireConnection;31;1;27;0
WireConnection;26;0;24;0
WireConnection;33;0;31;0
WireConnection;33;1;32;0
WireConnection;23;0;21;0
WireConnection;23;1;22;0
WireConnection;19;0;18;1
WireConnection;19;1;23;0
WireConnection;24;0;19;0
WireConnection;24;1;25;0
WireConnection;35;0;14;0
WireConnection;35;1;34;0
WireConnection;0;0;35;0
WireConnection;0;11;33;0
ASEEND*/
//CHKSM=B19BD89FFC5A506D137A994D0AD0E0CC153446DA
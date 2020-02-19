// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GamePlane"
{
	Properties
	{
		_Float0("Float 0", Range( -1 , 1)) = 0
		_Float1("Float 1", Range( -1 , 10)) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_InnerTexture("Inner Texture", 2D) = "white" {}
		_Float6("Float 6", Range( 0 , 5)) = 0
		_Float7("Float 7", Range( 0 , 5)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float _Float7;
		uniform float _Float6;
		uniform sampler2D _InnerTexture;
		uniform float4 _InnerTexture_ST;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Float0;
		uniform float _Float1;


		float2 voronoihash75_g1( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi75_g1( float2 v, float time, inout float2 id, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mr = 0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash75_g1( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = g - f + o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float temp_output_11_0_g1 = ( (-0.1 + (_Float7 - 0.0) * (-10.0 - -0.1) / (10.0 - 0.0)) * 0.1 );
			float temp_output_58_0_g1 = _Float6;
			float time75_g1 = 0.0;
			float3 ase_worldPos = i.worldPos;
			float2 appendResult90_g1 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 coords75_g1 = appendResult90_g1 * temp_output_58_0_g1;
			float2 id75_g1 = 0;
			float voroi75_g1 = voronoi75_g1( coords75_g1, time75_g1,id75_g1, 0 );
			float temp_output_12_0_g1 = saturate( ( abs( voroi75_g1 ) * 1.0 ) );
			float smoothstepResult27_g1 = smoothstep( 0.25 , ( 0.25 + temp_output_11_0_g1 ) , temp_output_12_0_g1);
			float2 uv_InnerTexture = i.uv_texcoord * _InnerTexture_ST.xy + _InnerTexture_ST.zw;
			float2 temp_output_57_0_g1 = i.uv_texcoord;
			float cos24_g1 = cos( 1.55 );
			float sin24_g1 = sin( 1.55 );
			float2 rotator24_g1 = mul( temp_output_57_0_g1 - float2( 0.5,0.5 ) , float2x2( cos24_g1 , -sin24_g1 , sin24_g1 , cos24_g1 )) + float2( 0.5,0.5 );
			float smoothstepResult25_g1 = smoothstep( 0.5 , ( 0.5 + temp_output_11_0_g1 ) , temp_output_12_0_g1);
			float cos23_g1 = cos( 3.13 );
			float sin23_g1 = sin( 3.13 );
			float2 rotator23_g1 = mul( temp_output_57_0_g1 - float2( 0.5,0.5 ) , float2x2( cos23_g1 , -sin23_g1 , sin23_g1 , cos23_g1 )) + float2( 0.5,0.5 );
			float smoothstepResult28_g1 = smoothstep( 0.75 , ( 0.75 + temp_output_11_0_g1 ) , temp_output_12_0_g1);
			float cos26_g1 = cos( 4.02 );
			float sin26_g1 = sin( 4.02 );
			float2 rotator26_g1 = mul( ( temp_output_57_0_g1 + float2( 0.5,0.5 ) ) - float2( 0.5,0.5 ) , float2x2( cos26_g1 , -sin26_g1 , sin26_g1 , cos26_g1 )) + float2( 0.5,0.5 );
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float clampResult20 = clamp( ( ( length( ( (float2( -1,-1 ) + (i.uv_texcoord - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) * float2( 0.5,0.5 ) ) ) + _Float0 ) * _Float1 ) , 0.0 , 1.0 );
			float4 lerpResult3 = lerp( saturate( ( ( smoothstepResult27_g1 * tex2D( _InnerTexture, uv_InnerTexture ) ) + ( ( 1.0 - smoothstepResult27_g1 ) * tex2D( _InnerTexture, rotator24_g1 ) * smoothstepResult25_g1 ) + ( ( 1.0 - smoothstepResult25_g1 ) * tex2D( _InnerTexture, rotator23_g1 ) * smoothstepResult28_g1 ) + ( ( 1.0 - smoothstepResult28_g1 ) * tex2D( _InnerTexture, rotator26_g1 ) ) ) ) , tex2D( _TextureSample0, uv_TextureSample0 ) , clampResult20);
			o.Albedo = lerpResult3.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2173;204;1111;660;1892.017;434.4342;1.3;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-1698.733,161.9134;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;9;-1439.834,208.7132;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1188.533,278.9131;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;8;-1036.834,286.7134;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1182.033,421.9138;Inherit;False;Property;_Float0;Float 0;0;0;Create;True;0;0;False;0;0;-0.36;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-894.7328,280.2133;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1171.633,507.7133;Inherit;False;Property;_Float1;Float 1;3;0;Create;True;0;0;False;0;0;8.7;-1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1421.418,-61.33416;Inherit;False;Property;_Float6;Float 6;7;0;Create;True;0;0;False;0;0;1.6;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-740.0338,265.9135;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-1362.916,-178.3343;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;23;-1377.217,-378.5341;Inherit;True;Property;_InnerTexture;Inner Texture;6;0;Create;True;0;0;False;0;None;e280124c74dc03f42b90c2fefd900752;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1421.418,21.86584;Inherit;False;Property;_Float7;Float 7;8;0;Create;True;0;0;False;0;0;1.73;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;20;-379.5309,237.1323;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;19;-800.2429,-4.075561;Inherit;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;-1;None;9505d896bf2fcb042b0250d9b92b15b3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;21;-1100.317,-134.1343;Inherit;False;Anti-Tile;1;;1;685cb058af4a3b1448253734d2a76849;0;5;60;SAMPLER2D;;False;57;FLOAT2;0,0;False;58;FLOAT;3.09;False;62;FLOAT;-0.4;False;104;FLOAT2;0.5,0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;18;-737.8428,-300.4755;Inherit;True;Property;_s;s;4;0;Create;True;0;0;False;0;-1;None;e280124c74dc03f42b90c2fefd900752;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;3;-320.943,-65.17532;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;GamePlane;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;5;0
WireConnection;10;0;9;0
WireConnection;8;0;10;0
WireConnection;12;0;8;0
WireConnection;12;1;13;0
WireConnection;14;0;12;0
WireConnection;14;1;15;0
WireConnection;20;0;14;0
WireConnection;21;60;23;0
WireConnection;21;57;24;0
WireConnection;21;58;25;0
WireConnection;21;62;27;0
WireConnection;3;0;21;0
WireConnection;3;1;19;0
WireConnection;3;2;20;0
WireConnection;0;0;3;0
ASEEND*/
//CHKSM=79D4B04291081147CA82CEF65BCC409AC5C56B5F
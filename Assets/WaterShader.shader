// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WaterShader"
{
	Properties
	{
		_TessPhongStrength( "Phong Tess Strength", Range( 0, 1 ) ) = 0.5
		_BaseColour("Base Colour", Color) = (0,0.4037895,1,1)
		_VertDirection("Vert Direction", Range( -1 , 1)) = 0
		_WaveSpeed("Wave Speed", Vector) = (0,0,0,0)
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_Float1("Float 1", Range( 1 , 10)) = 0
		_Float2("Float 2", Range( 1 , 10)) = 0
		_Opacity("Opacity", Range( 0 , 1)) = 0
		_srgafd("srgafd", Range( 1 , 50)) = 0
		_EdgeColour("Edge Colour", Color) = (0,0,0,0)
		_IntersectIntensity("Intersect Intensity", Range( 0 , 1)) = 0.2
		_WaveBrightness("Wave Brightness", Range( 0 , 2)) = 0
		_Float0("Float 0", Range( 1 , 20)) = 1
		_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform float _Float1;
		uniform float2 _WaveSpeed;
		uniform float _Float2;
		uniform float2 _Vector0;
		uniform float _Float0;
		uniform float _VertDirection;
		uniform float4 _EdgeColour;
		uniform float4 _BaseColour;
		uniform float _WaveBrightness;
		uniform float4 _Color0;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _IntersectIntensity;
		uniform float _Opacity;
		uniform float _srgafd;
		uniform float _TessPhongStrength;


		float2 voronoihash76( float2 p )
		{
			p = p - 5 * floor( p / 5 );
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi76( float2 v, float time, inout float2 id, float smoothness )
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
			 		float2 o = voronoihash76( n + g );
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


		float2 voronoihash85( float2 p )
		{
			p = p - 5 * floor( p / 5 );
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi85( float2 v, float time, inout float2 id, float smoothness )
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
			 		float2 o = voronoihash85( n + g );
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


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float4 temp_cast_4 = (_srgafd).xxxx;
			return temp_cast_4;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float time76 = 0.0;
			float2 panner53 = ( _Time.y * _WaveSpeed + v.texcoord.xy);
			float2 coords76 = panner53 * _Float1;
			float2 id76 = 0;
			float voroi76 = voronoi76( coords76, time76,id76, 0 );
			float time85 = 0.0;
			float2 panner83 = ( _Time.y * _Vector0 + v.texcoord.xy);
			float2 coords85 = panner83 * _Float2;
			float2 id85 = 0;
			float voroi85 = voronoi85( coords85, time85,id85, 0 );
			float Voronoi77 = ( voroi76 * voroi85 );
			float temp_output_51_0 = ( Voronoi77 * _Float0 );
			float4 temp_cast_0 = (temp_output_51_0).xxxx;
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( temp_cast_0 * _VertDirection * float4( ase_vertexNormal , 0.0 ) ) - float4( ( ( _VertDirection * 0.2 ) * ase_vertexNormal ) , 0.0 ) ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float time76 = 0.0;
			float2 panner53 = ( _Time.y * _WaveSpeed + i.uv_texcoord);
			float2 coords76 = panner53 * _Float1;
			float2 id76 = 0;
			float voroi76 = voronoi76( coords76, time76,id76, 0 );
			float time85 = 0.0;
			float2 panner83 = ( _Time.y * _Vector0 + i.uv_texcoord);
			float2 coords85 = panner83 * _Float2;
			float2 id85 = 0;
			float voroi85 = voronoi85( coords85, time85,id85, 0 );
			float Voronoi77 = ( voroi76 * voroi85 );
			float temp_output_51_0 = ( Voronoi77 * _Float0 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth27 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth27 = abs( ( screenDepth27 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _IntersectIntensity ) );
			float clampResult28 = clamp( distanceDepth27 , 0.0 , 1.0 );
			float4 lerpResult30 = lerp( _EdgeColour , ( _BaseColour + ( _WaveBrightness * temp_output_51_0 * _Color0 ) ) , clampResult28);
			o.Emission = lerpResult30.rgb;
			o.Alpha = _Opacity;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction tessphong:_TessPhongStrength 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 screenPos : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.screenPos = IN.screenPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2073;116;1390;652;65.38348;-0.0615387;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;82;-1355.139,909.7409;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;80;-1310.203,1164.019;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-1344.547,535.1751;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;54;-1292.156,658.465;Inherit;False;Property;_WaveSpeed;Wave Speed;3;0;Create;True;0;0;False;0;0,0;0.1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;55;-1299.611,789.4537;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;81;-1302.748,1033.031;Inherit;False;Property;_Vector0;Vector 0;4;0;Create;True;0;0;False;0;0,0;0,0.05;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;53;-1025.218,627.5319;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1096.564,810.9299;Inherit;False;Property;_Float1;Float 1;5;0;Create;True;0;0;False;0;0;5;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-1107.156,1185.495;Inherit;False;Property;_Float2;Float 2;6;0;Create;True;0;0;False;0;0;10;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;83;-1035.81,1002.098;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VoronoiNode;85;-803.19,1048.351;Inherit;True;0;0;1;0;1;True;5;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;2;FLOAT;0;FLOAT;1
Node;AmplifyShaderEditor.VoronoiNode;76;-792.5985,673.7859;Inherit;True;0;0;1;0;1;True;5;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;2;FLOAT;0;FLOAT;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-445.0431,900.9788;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-239.2529,685.9923;Inherit;False;Voronoi;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-19.18029,456.3949;Inherit;False;Property;_Float0;Float 0;12;0;Create;True;0;0;False;0;1;4.4;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;80.9071,328.2403;Inherit;False;77;Voronoi;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;514.5854,525.853;Inherit;False;Property;_VertDirection;Vert Direction;2;0;Create;True;0;0;False;0;0;-1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;297.3328,332.1655;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;159.829,243.3731;Inherit;False;Property;_WaveBrightness;Wave Brightness;11;0;Create;True;0;0;False;0;0;1.54;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;260.3101,-50.70773;Float;False;Property;_IntersectIntensity;Intersect Intensity;10;0;Create;True;0;0;False;0;0.2;0.459;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;88;282.6165,472.0615;Inherit;False;Property;_Color0;Color 0;13;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;615.2873,234.3368;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;60;794.3758,719.335;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;27;534.3095,-58.70766;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;829.401,616.8129;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;545.8292,55.76978;Inherit;False;Property;_BaseColour;Base Colour;1;0;Create;True;0;0;False;0;0,0.4037895,1,1;0.03773582,0.03773582,0.03773582,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;56;987.8808,503.6691;Inherit;False;VertexOffset;-1;;3;b9a3cc058467e064aa80449e66217e26;0;2;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;803.1979,62.53529;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;28;782.3096,-57.70764;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;1015.365,606.6017;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;29;707.8464,-229.3701;Inherit;False;Property;_EdgeColour;Edge Colour;9;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;1052.898,235.979;Inherit;False;Property;_Opacity;Opacity;7;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;997.1971,365.0464;Inherit;False;Property;_srgafd;srgafd;8;0;Create;True;0;0;False;0;0;1.9;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;30;1043.829,-39.58575;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;58;1181.068,502.3334;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1394,15;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;WaterShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;True;0.5;True;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;53;0;52;0
WireConnection;53;2;54;0
WireConnection;53;1;55;0
WireConnection;83;0;82;0
WireConnection;83;2;81;0
WireConnection;83;1;80;0
WireConnection;85;0;83;0
WireConnection;85;2;84;0
WireConnection;76;0;53;0
WireConnection;76;2;47;0
WireConnection;86;0;76;0
WireConnection;86;1;85;0
WireConnection;77;0;86;0
WireConnection;51;0;78;0
WireConnection;51;1;87;0
WireConnection;64;0;65;0
WireConnection;64;1;51;0
WireConnection;64;2;88;0
WireConnection;27;0;26;0
WireConnection;63;0;10;0
WireConnection;56;1;51;0
WireConnection;56;2;10;0
WireConnection;23;0;1;0
WireConnection;23;1;64;0
WireConnection;28;0;27;0
WireConnection;61;0;63;0
WireConnection;61;1;60;0
WireConnection;30;0;29;0
WireConnection;30;1;23;0
WireConnection;30;2;28;0
WireConnection;58;0;56;0
WireConnection;58;1;61;0
WireConnection;0;2;30;0
WireConnection;0;9;24;0
WireConnection;0;11;58;0
WireConnection;0;14;79;0
ASEEND*/
//CHKSM=97E5606595EE8E562D2731E912644DAD1D9D5E9B
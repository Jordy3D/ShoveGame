// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BaneArt/FogofWar"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 13.6
		_ColourA("Colour A", Color) = (1,0,0,1)
		_TextureA("Texture A", 2D) = "white" {}
		_ColourB("Colour B", Color) = (1,0,0,1)
		_TextureB("Texture B", 2D) = "white" {}
		[Toggle]_AppearDisappearToggle("Appear/Disappear Toggle", Float) = 1
		[Toggle]_TransparentTextureSwapToggle("Transparent/Texture Swap Toggle", Float) = 1
		[Toggle]_ColourDiffuseToggle("Colour/Diffuse Toggle", Float) = 0
		_CentreStrength("Centre Strength", Range( 0 , 1)) = 1
		_CentreRadius("Centre Radius", Range( 0 , 10)) = 5.588235
		_CentreSpinSpeed("Centre Spin Speed", Range( 0 , 1)) = 0
		_CentreNoise("Centre Noise", 2D) = "white" {}
		_RimStrength("Rim Strength", Range( 0 , 1)) = 1
		_RimRadius("Rim Radius", Range( 0 , 10)) = 5.588235
		_RimSpinSpeed("Rim Spin Speed", Range( 0 , 1)) = 0
		_RimNoise("Rim Noise", 2D) = "white" {}
		_RimColour("Rim Colour", Color) = (1,1,1,1)
		_SettleStrength("Settle Strength", Range( 0 , 1)) = 1
		_SettleRadius("Settle Radius", Range( 0 , 10)) = 5.588235
		_VoronoiScale("Voronoi Scale", Float) = 10
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_VoronoiColour("Voronoi Colour", Color) = (0,0,0,0)
		_VoronoiSpeed("Voronoi Speed", Vector) = (0.1,0,0,0)
		[Toggle]_ToggleSwitch0("Toggle Switch0", Float) = 0
		_VertexDirection("Vertex Direction", Range( -1 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform int ArrayLength;
		uniform float4 positionsArray[42];
		uniform float _SettleRadius;
		uniform float _SettleStrength;
		uniform float _ToggleSwitch0;
		uniform float _VoronoiScale;
		uniform float2 _VoronoiSpeed;
		uniform sampler2D _TextureSample0;
		uniform float _VertexDirection;
		uniform float _ColourDiffuseToggle;
		uniform float4 _ColourA;
		uniform sampler2D _TextureA;
		uniform float4 _TextureA_ST;
		uniform float4 _ColourB;
		uniform sampler2D _TextureB;
		uniform float4 _TextureB_ST;
		uniform float _CentreSpinSpeed;
		uniform sampler2D _CentreNoise;
		uniform float4 _CentreNoise_TexelSize;
		uniform float _CentreRadius;
		uniform float _CentreStrength;
		uniform float4 _VoronoiColour;
		uniform float4 _RimColour;
		uniform float _RimSpinSpeed;
		uniform sampler2D _RimNoise;
		uniform float4 _RimNoise_TexelSize;
		uniform float _RimRadius;
		uniform float _RimStrength;
		uniform float _TransparentTextureSwapToggle;
		uniform float _AppearDisappearToggle;
		uniform float _EdgeLength;


		float DistanceCheck18_g16( float3 WorldPos , int ArrayLength , float3 objectPosition )
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


		float2 voronoihash153( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi153( float2 v, float time, inout float2 id, float smoothness )
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
			 		float2 o = voronoihash153( n + g );
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


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		inline float DitherNoiseTex( float4 screenPos, sampler2D noiseTexture, float4 noiseTexelSize )
		{
			float dither = tex2Dlod( noiseTexture, float4( screenPos.xy * _ScreenParams.xy * noiseTexelSize.xy, 0, 0 ) ).g;
			float ditherRate = noiseTexelSize.x * noiseTexelSize.y;
			dither = ( 1 - ditherRate ) * dither + ditherRate;
			return dither;
		}


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


		float DistanceCheck18_g15( float3 WorldPos , int ArrayLength , float3 objectPosition )
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
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 WorldPos18_g16 = ase_worldPos;
			int ArrayLength18_g16 = ArrayLength;
			float3 objectPosition18_g16 = positionsArray[clamp(0,0,(42 - 1))].xyz;
			float localDistanceCheck18_g16 = DistanceCheck18_g16( WorldPos18_g16 , ArrayLength18_g16 , objectPosition18_g16 );
			float clampResult10_g16 = clamp( pow( ( localDistanceCheck18_g16 / _SettleRadius ) , (0.0 + (_SettleStrength - 0.0) * (100.0 - 0.0) / (1.0 - 0.0)) ) , 0.0 , 1.0 );
			float EffectRadius255 = clampResult10_g16;
			float time153 = 0.0;
			float2 panner159 = ( _Time.y * _VoronoiSpeed + v.texcoord.xy);
			float2 coords153 = panner159 * _VoronoiScale;
			float2 id153 = 0;
			float voroi153 = voronoi153( coords153, time153,id153, 0 );
			float4 temp_cast_1 = (voroi153).xxxx;
			float4 Voronoise230 = (( _ToggleSwitch0 )?( tex2Dlod( _TextureSample0, float4( panner159, 0, 0.0) ) ):( temp_cast_1 ));
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( EffectRadius255 * ( Voronoise230 * float4( ase_vertexNormal , 0.0 ) * _VertexDirection ) ).rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureA = i.uv_texcoord * _TextureA_ST.xy + _TextureA_ST.zw;
			float2 uv_TextureB = i.uv_texcoord * _TextureB_ST.xy + _TextureB_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float2 appendResult189 = (float2(ase_worldPos.x , ase_worldPos.z));
			float mulTime167 = _Time.y * _CentreSpinSpeed;
			float cos190 = cos( mulTime167 );
			float sin190 = sin( mulTime167 );
			float2 rotator190 = mul( appendResult189 - float2( 0.5,0.5 ) , float2x2( cos190 , -sin190 , sin190 , cos190 )) + float2( 0.5,0.5 );
			float simplePerlin2D192 = snoise( i.uv_texcoord*20.0 );
			simplePerlin2D192 = simplePerlin2D192*0.5 + 0.5;
			float4 ditherCustomScreenPos147 = float4( ( rotator190 * simplePerlin2D192 ), 0.0 , 0.0 );
			float dither147 = DitherNoiseTex( ditherCustomScreenPos147, _CentreNoise, _CentreNoise_TexelSize);
			float3 WorldPos18_g14 = ase_worldPos;
			int ArrayLength18_g14 = ArrayLength;
			float3 objectPosition18_g14 = positionsArray[clamp(0,0,(42 - 1))].xyz;
			float localDistanceCheck18_g14 = DistanceCheck18_g14( WorldPos18_g14 , ArrayLength18_g14 , objectPosition18_g14 );
			float clampResult10_g14 = clamp( pow( ( localDistanceCheck18_g14 / _CentreRadius ) , (0.0 + (_CentreStrength - 0.0) * (100.0 - 0.0) / (1.0 - 0.0)) ) , 0.0 , 1.0 );
			dither147 = step( dither147, clampResult10_g14 );
			float TextureBlend136 = dither147;
			float4 lerpResult143 = lerp( (( _ColourDiffuseToggle )?( tex2D( _TextureA, uv_TextureA ) ):( _ColourA )) , (( _ColourDiffuseToggle )?( tex2D( _TextureB, uv_TextureB ) ):( _ColourB )) , TextureBlend136);
			float4 TextureSwapg225 = lerpResult143;
			float time153 = 0.0;
			float2 panner159 = ( _Time.y * _VoronoiSpeed + i.uv_texcoord);
			float2 coords153 = panner159 * _VoronoiScale;
			float2 id153 = 0;
			float voroi153 = voronoi153( coords153, time153,id153, 0 );
			float4 temp_cast_2 = (voroi153).xxxx;
			float4 Voronoise230 = (( _ToggleSwitch0 )?( tex2D( _TextureSample0, panner159 ) ):( temp_cast_2 ));
			float4 temp_output_212_0 = ( Voronoise230 * _VoronoiColour );
			o.Albedo = ( TextureSwapg225 + temp_output_212_0 ).rgb;
			float2 appendResult197 = (float2(ase_worldPos.x , ase_worldPos.z));
			float mulTime198 = _Time.y * _RimSpinSpeed;
			float cos201 = cos( mulTime198 );
			float sin201 = sin( mulTime198 );
			float2 rotator201 = mul( appendResult197 - float2( 0.5,0.5 ) , float2x2( cos201 , -sin201 , sin201 , cos201 )) + float2( 0.5,0.5 );
			float simplePerlin2D202 = snoise( i.uv_texcoord*20.0 );
			simplePerlin2D202 = simplePerlin2D202*0.5 + 0.5;
			float4 ditherCustomScreenPos208 = float4( ( rotator201 * simplePerlin2D202 ), 0.0 , 0.0 );
			float dither208 = DitherNoiseTex( ditherCustomScreenPos208, _RimNoise, _RimNoise_TexelSize);
			float3 WorldPos18_g15 = ase_worldPos;
			int ArrayLength18_g15 = ArrayLength;
			float3 objectPosition18_g15 = positionsArray[clamp(0,0,(42 - 1))].xyz;
			float localDistanceCheck18_g15 = DistanceCheck18_g15( WorldPos18_g15 , ArrayLength18_g15 , objectPosition18_g15 );
			float clampResult10_g15 = clamp( pow( ( localDistanceCheck18_g15 / _RimRadius ) , (0.0 + (_RimStrength - 0.0) * (100.0 - 0.0) / (1.0 - 0.0)) ) , 0.0 , 1.0 );
			dither208 = step( dither208, clampResult10_g15 );
			float TextureBlendRim209 = dither208;
			float4 lerpResult174 = lerp( _RimColour , float4( 0,0,0,1 ) , TextureBlendRim209);
			float4 Emission227 = lerpResult174;
			o.Emission = Emission227.rgb;
			float lerpResult129 = lerp( (( _AppearDisappearToggle )?( 0.0 ):( 1.0 )) , ( 1.0 - (( _AppearDisappearToggle )?( 0.0 ):( 1.0 )) ) , TextureBlend136);
			float Opacity234 = (( _TransparentTextureSwapToggle )?( lerpResult129 ):( 1.0 ));
			o.Alpha = Opacity234;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

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
				surfIN.worldPos = worldPos;
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
2173;204;1390;660;-405.0377;1303.087;1;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;188;-1491.534,248.7511;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;194;-1816.588,399.3737;Inherit;False;Property;_CentreSpinSpeed;Centre Spin Speed;15;0;Create;True;0;0;False;0;0;0.08;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;189;-1302.609,285.4285;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;193;-1524.588,472.3738;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;57;-1792.298,-28.41403;Inherit;False;Property;_CentreStrength;Centre Strength;13;0;Create;True;0;0;False;0;1;0.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;167;-1473.312,397.6465;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;195;-1457.283,1097.404;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;196;-1782.337,1248.027;Inherit;False;Property;_RimSpinSpeed;Rim Spin Speed;19;0;Create;True;0;0;False;0;0;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;65;-1509.454,-21.74534;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;192;-1210.588,460.3738;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;199;-1490.337,1321.027;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;190;-1174.7,289.2582;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1598.185,-114.1752;Inherit;False;Property;_CentreRadius;Centre Radius;14;0;Create;True;0;0;False;0;5.588235;4.7;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;197;-1268.358,1134.082;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;198;-1439.061,1246.3;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;200;-1758.047,820.2389;Inherit;False;Property;_RimStrength;Rim Strength;17;0;Create;True;0;0;False;0;1;0.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;160;540.674,-1082.278;Inherit;False;Property;_VoronoiSpeed;Voronoi Speed;27;0;Create;True;0;0;False;0;0.1,0;0.1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;154;493.3697,-1201.659;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;161;534.8729,-951.1122;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;203;-1475.203,826.9075;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;148;-1219.002,94.44768;Inherit;True;Property;_CentreNoise;Centre Noise;16;0;Create;True;0;0;False;0;16d574e53541bba44a84052fa38778df;bd46706ff72992a4c8a07db09bba3dce;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RotatorNode;201;-1140.449,1137.911;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;124;-1266.046,-6.821754;Inherit;False;DistanceBlendObjectArray;-1;;14;5b9aec6b10979884f8f92cd3b2f819e8;0;2;20;FLOAT;0;False;21;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;191;-989.5881,288.3737;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;202;-1176.337,1309.027;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;204;-1563.934,734.4777;Inherit;False;Property;_RimRadius;Rim Radius;18;0;Create;True;0;0;False;0;5.588235;4.2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DitheringNode;147;-860.1144,119.2043;Inherit;False;2;True;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;132;362.7321,1150.08;Inherit;False;Property;_AppearDisappearToggle;Appear/Disappear Toggle;11;0;Create;True;0;0;False;0;1;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;211;-1238.707,804.9849;Inherit;False;DistanceBlendObjectArray;-1;;15;5b9aec6b10979884f8f92cd3b2f819e8;0;2;20;FLOAT;0;False;21;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;205;-955.3371,1137.027;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;206;-1184.751,943.1006;Inherit;True;Property;_RimNoise;Rim Noise;20;0;Create;True;0;0;False;0;16d574e53541bba44a84052fa38778df;bd46706ff72992a4c8a07db09bba3dce;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.PannerNode;159;764.1757,-1109.81;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;155;772.0082,-991.7929;Inherit;False;Property;_VoronoiScale;Voronoi Scale;24;0;Create;True;0;0;False;0;10;10.66;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;257;980.3389,-967.8184;Inherit;True;Property;_TextureSample0;Texture Sample 0;25;0;Create;True;0;0;False;0;-1;None;bd46706ff72992a4c8a07db09bba3dce;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;153;1041.841,-1106.677;Inherit;False;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;2;FLOAT;0;FLOAT;1
Node;AmplifyShaderEditor.ColorNode;141;-1444.906,-767.9055;Inherit;False;Property;_ColourB;Colour B;9;0;Create;True;0;0;False;0;1,0,0,1;0.367924,0,0.2257431,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;9;-1430.716,-1148.187;Inherit;False;Property;_ColourA;Colour A;7;0;Create;True;0;0;False;0;1,0,0,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;142;-1527.327,-586.4573;Inherit;True;Property;_TextureB;Texture B;10;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;127;-1513.137,-966.7399;Inherit;True;Property;_TextureA;Texture A;8;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;138;648.7852,1151.008;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;136;-582.2338,138.5072;Inherit;False;TextureBlend;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DitheringNode;208;-825.8635,967.8572;Inherit;False;2;True;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;245;-1750.05,1612.378;Inherit;False;Property;_SettleStrength;Settle Strength;22;0;Create;True;0;0;False;0;1;0.14;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;137;614.519,1263.645;Inherit;False;136;TextureBlend;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;125;-1164.59,-991.0748;Inherit;False;Property;_ColourDiffuseToggle;Colour/Diffuse Toggle;12;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;209;-423.0866,992.9581;Inherit;False;TextureBlendRim;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;-1106.432,-644.5207;Inherit;False;136;TextureBlend;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;140;-1167.299,-752.8709;Inherit;False;Property;_ColourDiffuseToggle;Colour/Diffuse Toggle;5;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;249;-1555.937,1526.617;Inherit;False;Property;_SettleRadius;Settle Radius;23;0;Create;True;0;0;False;0;5.588235;3.2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;258;1319.139,-1111.918;Inherit;False;Property;_ToggleSwitch0;Toggle Switch0;28;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;139;805.7852,1154.008;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;134;667.4106,1182.912;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;248;-1467.206,1619.047;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;230;1536.904,-1113.622;Inherit;False;Voronoise;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;143;-835.9949,-769.2081;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;1,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;210;-315.5496,-948.3942;Inherit;False;209;TextureBlendRim;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;129;906.7427,1150.889;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;175;-316.0346,-1121.874;Inherit;False;Property;_RimColour;Rim Colour;21;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;252;-1230.71,1597.124;Inherit;False;DistanceBlendObjectArray;-1;;16;5b9aec6b10979884f8f92cd3b2f819e8;0;2;20;FLOAT;0;False;21;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;217;806.7115,376.0552;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;218;715.5692,527.5193;Inherit;False;Property;_VertexDirection;Vertex Direction;29;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;232;395.3686,-149.0058;Inherit;False;230;Voronoise;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;255;-889.9063,1608.832;Inherit;False;EffectRadius;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;233;813.5897,295.9643;Inherit;False;230;Voronoise;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;225;-645.6,-748.3654;Inherit;False;TextureSwapg;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;174;-76.76279,-1114.971;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,1;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;146;1188.394,1153.834;Inherit;True;Property;_TransparentTextureSwapToggle;Transparent/Texture Swap Toggle;12;0;Create;True;0;0;False;0;1;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;157;380.256,-47.46812;Inherit;False;Property;_VoronoiColour;Voronoi Colour;26;0;Create;True;0;0;False;0;0,0,0,0;0.5660378,0.509968,0.509968,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;228;1029.557,228.9533;Inherit;False;255;EffectRadius;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;213;1077.588,304.3908;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;212;610.7234,-120.6173;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;227;100.7664,-1105.167;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;234;1524.907,1163.477;Inherit;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;226;583.9703,-303.6479;Inherit;False;225;TextureSwapg;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;229;1285.059,-23.42868;Inherit;False;227;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;236;630.2516,114.7328;Inherit;False;234;Opacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;1267.226,249.8299;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;235;1284.341,86.4308;Inherit;False;234;Opacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;156;851.9428,-193.8728;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;231;601.0993,-220.3479;Inherit;False;230;Voronoise;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;256;856.0195,-97.41669;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1547.272,-65.79855;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;BaneArt/FogofWar;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;1;True;True;0;True;Transparent;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;13.6;10;25;False;0.582;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;6;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;189;0;188;1
WireConnection;189;1;188;3
WireConnection;167;0;194;0
WireConnection;65;0;57;0
WireConnection;192;0;193;0
WireConnection;190;0;189;0
WireConnection;190;2;167;0
WireConnection;197;0;195;1
WireConnection;197;1;195;3
WireConnection;198;0;196;0
WireConnection;203;0;200;0
WireConnection;201;0;197;0
WireConnection;201;2;198;0
WireConnection;124;20;58;0
WireConnection;124;21;65;0
WireConnection;191;0;190;0
WireConnection;191;1;192;0
WireConnection;202;0;199;0
WireConnection;147;0;124;0
WireConnection;147;1;148;0
WireConnection;147;2;191;0
WireConnection;211;20;204;0
WireConnection;211;21;203;0
WireConnection;205;0;201;0
WireConnection;205;1;202;0
WireConnection;159;0;154;0
WireConnection;159;2;160;0
WireConnection;159;1;161;0
WireConnection;257;1;159;0
WireConnection;153;0;159;0
WireConnection;153;2;155;0
WireConnection;138;0;132;0
WireConnection;136;0;147;0
WireConnection;208;0;211;0
WireConnection;208;1;206;0
WireConnection;208;2;205;0
WireConnection;125;0;9;0
WireConnection;125;1;127;0
WireConnection;209;0;208;0
WireConnection;140;0;141;0
WireConnection;140;1;142;0
WireConnection;258;0;153;0
WireConnection;258;1;257;0
WireConnection;139;0;138;0
WireConnection;134;0;132;0
WireConnection;248;0;245;0
WireConnection;230;0;258;0
WireConnection;143;0;125;0
WireConnection;143;1;140;0
WireConnection;143;2;144;0
WireConnection;129;0;139;0
WireConnection;129;1;134;0
WireConnection;129;2;137;0
WireConnection;252;20;249;0
WireConnection;252;21;248;0
WireConnection;255;0;252;0
WireConnection;225;0;143;0
WireConnection;174;0;175;0
WireConnection;174;2;210;0
WireConnection;146;1;129;0
WireConnection;213;0;233;0
WireConnection;213;1;217;0
WireConnection;213;2;218;0
WireConnection;212;0;232;0
WireConnection;212;1;157;0
WireConnection;227;0;174;0
WireConnection;234;0;146;0
WireConnection;240;0;228;0
WireConnection;240;1;213;0
WireConnection;156;0;226;0
WireConnection;156;1;212;0
WireConnection;256;0;226;0
WireConnection;256;1;212;0
WireConnection;0;0;156;0
WireConnection;0;2;229;0
WireConnection;0;9;235;0
WireConnection;0;11;240;0
ASEEND*/
//CHKSM=7DD292DCA9D8FAFF24F007F5116FB78B06146CD7
// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Crystal"
{
	Properties
	{
		_TessPhongStrength( "Phong Tess Strength", Range( 0, 1 ) ) = 0
		_DisplacementDirection("Displacement Direction", Range( -1 , 1)) = -1
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		_VoronoiScale("Voronoi Scale", Range( 0 , 100)) = 5.617661
		_Float1("Float 1", Range( 1 , 10)) = 8.920179
		_TilingScale("Tiling Scale", Vector) = (0,0,0,0)
		_TilingOffset("Tiling Offset", Vector) = (0,0,0,0)
		_Transmission("Transmission", Range( 0 , 1)) = 0
		_Opacity("Opacity", Range( 0 , 1)) = 0
		_Roughness("Roughness", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Tessellation.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		struct Input
		{
			float2 uv_texcoord;
		};

		struct SurfaceOutputStandardCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Transmission;
			half3 Translucency;
		};

		uniform float _VoronoiScale;
		uniform float2 _TilingScale;
		uniform float2 _TilingOffset;
		uniform float _DisplacementDirection;
		uniform float _Roughness;
		uniform float _Transmission;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;
		uniform float _Opacity;
		uniform float _Float1;
		uniform float _TessPhongStrength;


		float2 voronoihash1( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi1( float2 v, float time, inout float2 id, float smoothness )
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
			 		float2 o = voronoihash1( n + g );
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
			
F1 = 8.0;
for ( int j = -2; j <= 2; j++ )
{
for ( int i = -2; i <= 2; i++ )
{
float2 g = mg + float2( i, j );
float2 o = voronoihash1( n + g );
		o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = g - f + o;
float d = dot( 0.5 * ( mr + r ), normalize( r - mr ) );
F1 = min( F1, d );
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


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float4 temp_cast_0 = (_Float1).xxxx;
			return temp_cast_0;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float time1 = 0.0;
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 break5_g1 = ase_parentObjectScale;
			float2 appendResult9_g1 = (float2(break5_g1.z , break5_g1.y));
			float2 ZYScale10_g1 = appendResult9_g1;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 normalizeResult8_g1 = normalize( ase_vertexNormal );
			float3 break11_g1 = normalizeResult8_g1;
			float2 appendResult7_g1 = (float2(break5_g1.x , break5_g1.z));
			float2 XZScale13_g1 = appendResult7_g1;
			float2 appendResult6_g1 = (float2(break5_g1.x , break5_g1.y));
			float2 XYScale12_g1 = appendResult6_g1;
			float2 uv_TexCoord25_g1 = v.texcoord.xy * ( ( ( ZYScale10_g1 * break11_g1.x ) + ( break11_g1.y * XZScale13_g1 ) + ( break11_g1.z * XYScale12_g1 ) ) * _TilingScale ) + _TilingOffset;
			float2 coords1 = uv_TexCoord25_g1 * _VoronoiScale;
			float2 id1 = 0;
			float voroi1 = voronoi1( coords1, time1,id1, 0 );
			float3 ase_vertex3Pos = v.vertex.xyz;
			v.vertex.xyz += ( voroi1 * ase_vertex3Pos * _DisplacementDirection );
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			#if !DIRECTIONAL
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + c + d;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			float4 color25 = IsGammaSpace() ? float4(1,0.1084906,0.1084906,0) : float4(1,0.01139139,0.01139139,0);
			float simplePerlin2D17 = snoise( i.uv_texcoord*6.39 );
			simplePerlin2D17 = simplePerlin2D17*0.5 + 0.5;
			o.Albedo = ( color25 * float4( ( i.uv_texcoord + simplePerlin2D17 ), 0.0 , 0.0 ) ).rgb;
			o.Smoothness = _Roughness;
			float3 temp_cast_2 = (_Transmission).xxx;
			o.Transmission = temp_cast_2;
			float3 temp_cast_3 = (1.0).xxx;
			o.Translucency = temp_cast_3;
			o.Alpha = _Opacity;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustom alpha:fade keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc tessellate:tessFunction tessphong:_TessPhongStrength 

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
				SurfaceOutputStandardCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardCustom, o )
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
758;199;832;660;1681.636;307.3289;1.790738;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-1065.252,-557.3672;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;11;-1325.476,74.76062;Inherit;False;Property;_TilingOffset;Tiling Offset;11;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;10;-1336.476,-54.23938;Inherit;False;Property;_TilingScale;Tiling Scale;10;0;Create;True;0;0;False;0;0,0;2,20;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;7;-1107.789,447.9515;Inherit;False;Property;_VoronoiScale;Voronoi Scale;8;0;Create;True;0;0;False;0;5.617661;8;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;9;-1120.476,-2.527041;Inherit;True;IndependantScale;-1;;1;5b6cf2d7ca74860449cd9aecae526348;0;2;27;FLOAT2;1,1;False;28;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;17;-814.4965,-479.9518;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;6.39;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;4;-715.5225,525.7855;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;1;-762.1986,261.5258;Inherit;True;0;0;1;4;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;2;FLOAT;0;FLOAT;1
Node;AmplifyShaderEditor.ColorNode;25;-557.4594,-806.3597;Inherit;False;Constant;_Color1;Color 1;8;0;Create;True;0;0;False;0;1,0.1084906,0.1084906,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-554.3136,-614.4749;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-803.7344,690.4689;Inherit;False;Property;_DisplacementDirection;Displacement Direction;0;0;Create;True;0;0;False;0;-1;-0.06;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;3;-347.11,-205.7279;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-230.3115,-617.6205;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-285.273,340.962;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-319.9186,77.63763;Inherit;False;Property;_Transmission;Transmission;12;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-324.5768,240.08;Inherit;False;Property;_Opacity;Opacity;13;0;Create;True;0;0;False;0;0;0.85;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-290.9887,620.502;Inherit;False;Property;_Float1;Float 1;9;0;Create;True;0;0;False;0;8.920179;2.2;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-744.6259,-661.6609;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-308.9186,-17.36237;Inherit;False;Property;_Roughness;Roughness;14;0;Create;True;0;0;False;0;0;0.45;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-192.5768,156.08;Inherit;False;Constant;_Float0;Float 0;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-1123.258,288.9097;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1657.13,-112.6087;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Crystal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;True;0;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;27;10;0
WireConnection;9;28;11;0
WireConnection;17;0;18;0
WireConnection;1;0;9;0
WireConnection;1;2;7;0
WireConnection;22;0;18;0
WireConnection;22;1;17;0
WireConnection;24;0;25;0
WireConnection;24;1;22;0
WireConnection;6;0;1;0
WireConnection;6;1;4;0
WireConnection;6;2;5;0
WireConnection;23;1;18;0
WireConnection;0;0;24;0
WireConnection;0;4;16;0
WireConnection;0;6;14;0
WireConnection;0;7;26;0
WireConnection;0;9;27;0
WireConnection;0;11;6;0
WireConnection;0;14;8;0
ASEEND*/
//CHKSM=32AE82D09116BE90B5DA3A466D3138156785A62D
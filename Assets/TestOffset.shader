// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TestOffset"
{
	Properties
	{
		_OffsetDirection("Offset Direction", Range( -1 , 1)) = 1
		_VoronoiScale("Voronoi Scale", Float) = 4
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Float0("Float 0", Float) = 2.59
		_Float2("Float 2", Range( 0 , 1)) = 1
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
			float2 uv_texcoord;
		};

		uniform float _VoronoiScale;
		uniform float _OffsetDirection;
		uniform float _Float0;
		uniform float _Float2;
		uniform float _Metallic;
		uniform float _Smoothness;


		float2 voronoihash3( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi3( float2 v, float time, inout float2 id, float smoothness )
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
			 		float2 o = voronoihash3( n + g );
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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float time3 = 0.0;
			float2 coords3 = v.texcoord.xy * _VoronoiScale;
			float2 id3 = 0;
			float voroi3 = voronoi3( coords3, time3,id3, 0 );
			float4 temp_cast_0 = (voroi3).xxxx;
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( temp_cast_0 * _OffsetDirection * float4( ase_vertexNormal , 0.0 ) ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color20 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float4 color21 = IsGammaSpace() ? float4(1,0,0,0) : float4(1,0,0,0);
			float clampResult9_g4 = clamp( ( ( length( (float2( -1,-1 ) + (i.uv_texcoord - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) ) + -_Float0 ) * (0.0 + (_Float2 - 0.0) * (100.0 - 0.0) / (1.0 - 0.0)) ) , 0.0 , 1.0 );
			float4 lerpResult19 = lerp( color20 , color21 , clampResult9_g4);
			o.Albedo = lerpResult19.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2073;116;1390;660;1378.285;-520.8115;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;17;-1111.253,1184.232;Inherit;False;Property;_Float2;Float 2;6;0;Create;True;0;0;False;0;1;5.55;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-833.6035,292.9597;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2;-758.6035,417.9598;Inherit;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;22;-832.2849,1186.812;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-791.6035,490.9596;Inherit;False;Property;_VoronoiScale;Voronoi Scale;1;0;Create;True;0;0;False;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-811.2529,1099.232;Inherit;False;Property;_Float0;Float 0;5;0;Create;True;0;0;False;0;2.59;2.59;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-883.2529,981.2321;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;3;-571.6036,292.9597;Inherit;True;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;2;FLOAT;0;FLOAT;1
Node;AmplifyShaderEditor.ColorNode;20;-552.3534,612.3122;Inherit;False;Constant;_Color0;Color 0;5;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-605.1427,530.7175;Inherit;False;Property;_OffsetDirection;Offset Direction;0;0;Create;True;0;0;False;0;1;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;23;-581.4041,988.4589;Inherit;True;RadialGradient;-1;;4;ec972f7745a8353409da2eb8d000a2e3;0;3;1;FLOAT2;0,0;False;6;FLOAT;0;False;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;-552.353,793.7831;Inherit;False;Constant;_Color1;Color 0;5;0;Create;True;0;0;False;0;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-382.7385,110.8907;Inherit;False;Property;_Smoothness;Smoothness;3;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;4;-278.8441,294.1562;Inherit;False;VertexOffset;-1;;2;b9a3cc058467e064aa80449e66217e26;0;2;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;19;-90.03497,690.0852;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;10;-404.7385,-155.1093;Inherit;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;False;0;-1;84508b93f15f2b64386ec07486afc7a3;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-383.7385,35.89072;Inherit;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;TestOffset;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;0;17;0
WireConnection;3;0;1;0
WireConnection;3;1;2;0
WireConnection;3;2;5;0
WireConnection;23;1;15;0
WireConnection;23;6;16;0
WireConnection;23;7;22;0
WireConnection;4;1;3;0
WireConnection;4;2;6;0
WireConnection;19;0;20;0
WireConnection;19;1;21;0
WireConnection;19;2;23;0
WireConnection;0;0;19;0
WireConnection;0;3;8;0
WireConnection;0;4;9;0
WireConnection;0;11;4;0
ASEEND*/
//CHKSM=D6306DE1F6575096F195F64252931964CC8AA32C
//生物PBR材质
//毛发、选中描边在管线上开启相应的RenderFeature
//by taecg
Shader "ONEMT/Character/CreatureLit"
{
    Properties
    {
        //: { "type": "groupIf","label":"_DebugShowModeEnabled","keyword":"_DebugShowModeEnabled"}
        [Toggle]_DebugShowModeEnabled("",int) = 0
        //: { "type": "enum","prop":"_DebugShowMode", "label":"显示模式","enums":"Albedo|Normal|Metallic|Roughness|Smoothness|Emissive|AO|Curvature"}
        [Enum(Albedo,0,Normal,1,Metallic,2,Roughness,3,Smoothness,4,Emissive,5,AO,6,Curvature,7)]_DebugShowMode("",int) = 0
        
        //: { "type": "group","label":"基础"}
        //: { "type": "default","prop":"_UVType", "label":"类型"}
        //: { "type": "info","label":"类型为Procedual时,请使用Matcap做为主纹理.""}
        [KeywordEnum(NPC,Part,Procedual)]_UVType("类型",int) = 0
        //: { "type": "texture2","prop":"_BaseMap","prop2":"_BaseColor", "label":"基础纹理(RGB)","st":"true"}
        [HDR]_BaseColor("Color", Color) = (1,1,1,1)
        _BaseMap("Albedo", 2D) = "white" {}
        //: { "type": "texture2","prop":"_BumpMap","prop2":"_BumpScale", "label":"法线纹理","st":"true"}
        _BumpScale("Normal Scale", range(0,2)) = 1.0
        [Normal]_BumpMap("Normal Map", 2D) = "bump" {}
        //: { "type": "texture1","prop":"_MetallicGlossMap","label":"金属(R)粗糙(G)自发光(B)AO(A)"}
        _MetallicGlossMap("Metallic(R)Roughness(G)Emission(B)AO(A)", 2D) = "white" {}
        //: { "type": "float","prop":"_MetallicValue", "label":"金属度","vectorComponent1":"x","min":"0","max":"1"}
        //: { "type": "float","prop":"_MetallicValue", "label":"光滑度","vectorComponent1":"y","min":"0","max":"1"}
        //: { "type": "float","prop":"_MetallicValue", "label":"AO强度","vectorComponent1":"w","min":"0","max":"1"}
        //: { "type": "default","prop":"_EmissionColor", "label":"自发光"}
        //: { "type": "toggle","prop":"_MetallicValue", "label":"高光限制?","vectorComponent1":"z"}
        [HDR] _EmissionColor("Emission Color", Color) = (0,0,0)
        _MetallicValue("金属度(X)光滑度(Y)AO(W)",vector) = (1,1,0,1)

        //: { "type": "group","label":"次表面散射(SSS)"}
        //: { "type": "texture1","prop":"_SSSLut", "label":"SSSLut"}
        _SSSLut("SSSLut", 2D) = "white" {}
        //: { "type": "texture1","prop":"_MixMap02","label":"曲率(R)"}
        _MixMap02("", 2D) = "white" {}
        //: { "type": "float","prop":"_SSSValue01", "label":"散射强度","vectorComponent1":"x","min":"0","max":"1"}
        _SSSValue01("",vector) = (1,0,0,0)

        //: { "type": "groupPass","label":"毛发","keyword":"Fur"}
        [Toggle]_FurEnabled("FurEnabled",int) = 0
        //: { "type": "enum","prop":"_FurShowArea", "label":"显示区域","enums":"None|All|Top|Bottom|Chest|Back|ChestAndBack"}
        [Enum(None,0,All,1,Top,2,Bottom,3,Chest,4,Back,5,ChestAndBack,6)]_FurShowArea("显示区域",int) = 1
        //: { "type": "minmax","prop":"_FurArea", "label":"遮罩范围","vectorComponent1":"x","vectorComponent2":"y","min":"-1","max":"1"}
        _FurArea("遮罩范围",vector) = (-1,1,1,0)
        //: { "type": "texture2","prop":"_FurMap","prop2":"_FurColor", "label":"细节纹理(RGB)","st":"true"}
        _FurColor("FurColor",color) = (0.5,0.5,0.5,1)
        _FurMap("FurMap",2D) ="white"{}
        //: { "type": "float","prop":"_FurValue01", "label":"长度","vectorComponent1":"x"}
        //: { "type": "float","prop":"_FurValue01", "label":"曲率","vectorComponent1":"y","min":"0","max":"5"}
        _FurValue01("长度(X) 曲率(Y) 速度(Z) 频率(W)",vector) = (0.035,1,3,20)
        //: { "type": "vector3","prop":"_Gravity", "label":"重力方向"}
        //: { "type": "float","prop":"_FurValue01", "label":"速度","vectorComponent1":"z"}
        //: { "type": "float","prop":"_FurValue01", "label":"频率","vectorComponent1":"w"}
        _Gravity("Direction(XYZ)",vector) = (0,-1,0,0)

        //: { "type": "groupIf","label":"顶点变形","keyword":"_VertexShapeEnabled"}
        [Toggle]_VertexShapeEnabled("顶点变形",int) = 0
        //: { "type": "texture1","prop":"_VertexShapeMap","label":"变形映射纹理"}
        _VertexShapeMap("顶点变形纹理",2D) = "white"{}
        //: { "type": "float","prop":"_VertexShapeValue01", "label":"强度","vectorComponent1":"w","min":"0","max":"5"}
        _VertexShapeValue01("",vector) = (0,0,0,0.05)

        //: { "type": "groupVariant","label":"表面皮肤","keyword":"_SURFACEENABLED_ON"}
        [Toggle]_SurfaceEnabled("SurfaceEnabled",int) = 0
        //: { "type": "enum","prop":"_ShowArea", "label":"显示区域","enums":"None|All|Top|Bottom|Chest|Back|ChestAndBack"}
        [Enum(None,0,All,1,Top,2,Bottom,3,Chest,4,Back,5,ChestAndBack,6,Arm,7)]_ShowArea("显示区域",int) = 0
        _SurfaceMapUV("",vector) = (0,100,1,1)
        //: { "type": "minmax","prop":"_SurfaceArea", "label":"遮罩范围","vectorComponent1":"x","vectorComponent2":"y","min":"-1","max":"1"}
        // { "type": "float","prop":"_SurfaceArea", "label":"过渡","vectorComponent1":"w","min":"0","max":"2"}
        _SurfaceArea("SurfaceArea",vector) = (-1,1,1,1)
        //: { "type": "texture2","prop":"_SurfaceMap","prop2":"_SurfaceColor", "label":"表面纹理(RGB)透明(A)"}
        //: { "type": "enum","prop":"_SurfaceMapUV", "label":"表面纹理映射方式","enums":"全方位映射|前后映射|左右映射|上下映射","vectorComponent1":"x"}
        // { "type": "float","prop":"_SurfaceMapUV", "label":"UV边缘系数","vectorComponent1":"y"}
        //: { "type": "float","prop":"_SurfaceMapUV", "label":"UV重复度","vectorComponent1":"z"}
        //: { "type": "float","prop":"_SurfaceMapUV", "label":"UV重复度系数(仅用于部件)","vectorComponent1":"w"}
        //: { "type": "float","prop":"_SurfaceArea", "label":"底色透明度","vectorComponent1":"z","min":"0","max":"2"}
        [HDR]_SurfaceColor("SurfaceColor", Color) = (1,1,1,1)
        _SurfaceMap("SurfaceMap", 2D) = "white" {}
        //: { "type": "texture2","prop":"_SurfaceBumpMap","prop2":"_SurfaceBumpScale", "label":"法线纹理"}
        _SurfaceBumpScale("Normal Scale", range(0,1)) = 1.0
        [Normal]_SurfaceBumpMap("Surface BumpMap", 2D) = "bump" {}
        //: { "type": "enum","prop":"_SurfaceBumpMapUV", "label":"表面纹理映射方式","enums":"全方位映射|前后映射|左右映射|上下映射","vectorComponent1":"x"}
        //: { "type": "float","prop":"_SurfaceBumpMapUV", "label":"UV边缘系数","vectorComponent1":"y"}
        //: { "type": "float","prop":"_SurfaceBumpMapUV", "label":"UV重复度","vectorComponent1":"z"}
        // { "type": "float","prop":"_SurfaceBumpMapUV", "label":"UV重复度系数(仅用于部件)","vectorComponent1":"w"}
        _SurfaceBumpMapUV("",vector) = (0,100,1,1)

        //: { "type": "groupVariant","label":"衣服","keyword":"_CLOTHENABLED_ON"}
        [Toggle]_ClothEnabled("ClothEnabled",int) = 0
        //: { "type": "float","prop":"_ClothValue01", "label":"上衣范围","vectorComponent1":"x","min":"0.001","max":"1"}
        //: { "type": "float","prop":"_ClothValue01", "label":"下衣范围","vectorComponent1":"y","min":"0.001","max":"1"}
        //: { "type": "float","prop":"_ClothValue01", "label":"手范围","vectorComponent1":"z","min":"0.001","max":"1"}
        //: { "type": "float","prop":"_ClothValue01", "label":"腿范围","vectorComponent1":"w","min":"0.001","max":"1"}
        _ClothValue01("",vector) = (0,0.5,0,0.5)
        //: { "type": "texture1","prop":"_ClothBaseMap","label":"衣服基础纹理","st":"true"}
        _ClothBaseMap("", 2D) = "white" {}
        //: { "type": "texture1","prop":"_ClothNormalMap","label":"衣服法线纹理","st":"true"}
        [Normal]_ClothNormalMap("", 2D) = "bump" {}
        //: { "type": "texture1","prop":"_ClothMixedMap","label":"金属度(R)粗糙度(G)"}
        _ClothMixedMap("", 2D) = "white" {}

        //: { "type": "groupVariant","label":"贴花","keyword":"_DECALENABLED_ON"}
        [Toggle]_DecalEnabled("DecalEnabled",int) = 0
        //: { "type": "texture2","prop":"_DecalMap","prop2":"_DecalColor", "label":"基础纹理(RGB)过渡(A)","st":"true"}
        _DecalColor("DecalColor",color) = (1,1,1,1)
        _DecalMap("DecalMap",2D) = "white"{}

        [Toggle]_RimEnabled("RimEnabled",int) = 0
        _RimColor("RimColor",color) = (1,1,1,1)
        _Rim("Min(X) Max(Y) Intensity(Z) Invert(W)",vector) = (0,1,1,0)

        //: { "type": "groupVariant","label":"半透明Dither","keyword":"_DITHERENABLED_ON"}
        //: { "type": "float","prop":"_DitherValue", "label":"透明度","min":"0","max":"1"}
        _DitherValue("",Range(0,1)) = 1
        
        //: { "type": "groupVariant","label":"镭射层","keyword":"_LASER_ON"}
        //: { "type": "texture1","prop":"_RampTex","label":"镭射渐变图"}
        _RampTex ("Laser RampUV Texture", 2D) = "white" {}
        //: { "type": "float","prop":"_LaserIntensity", "label":"镭射效果强度","min":"0","max":"1"}
        _LaserIntensity("Laser Intensity",Range(0,1)) = 0.5


        //: { "type": "groupVariant","label":"GPUSkinning","keyword":"_SKINNING_ENABLE_ON"}
        [Toggle]_SkinningEnable("_SkinningEnable",int) = 0
        //: { "type": "texture1","prop":"_AnimTex", "label":"GpuSkinning动画缓存纹理"}
        _AnimTex("AnimationTexture", 2D) = "white" {}
        // _AnimationTextureSize("textureSize",vector) = (256, 256, 0, 0)
        //: { "type": "vector3","prop":"_AnimationTexturePointer", "label":"当前动画数据"}
        _AnimationTexturePointer("_AnimationTexturePointer",vector) = (0,0,0,0)

        //: { "type": "group","label":"其它设置"}
        //: { "type": "color","prop":"_AddColor", "label":"叠加颜色(加)"}
        _AddColor("AddColor",color) = (0,0,0,0)

        //: { "type": "group","label":"渲染状态"}
        //: { "type": "queue"}
        //: { "type": "cull","prop":"_Cull"}
        //: { "type": "gpuInstancing"}
        [Enum(UnityEngine.Rendering.CullMode)]_Cull("CullMode",int) = 2

        //外部传值
        [HDR]_BaseColor02("",color)= (1,1,1,1)
        _BaseMap02("", 2D) = "white" {}
        _BaseMap02_Repeat("", float) = 1
        _BumpScale02("", float) = 1
        _MetallicValue02("", vector) = (1,1,1,1)
        _SelectedID("身体选中区域的ID",int) = 0
    }

    HLSLINCLUDE
    #pragma target 3.5
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"

    #ifdef UNITY_INSTANCING_ENABLED
        // GPUInstancing 的支持
        UNITY_INSTANCING_BUFFER_START(Props)
        //支持GPUSkinning
        // UNITY_DEFINE_INSTANCED_PROP(sampler2D, _AnimTex)
        // UNITY_DEFINE_INSTANCED_PROP(float4, _AnimationTextureSize)
        UNITY_DEFINE_INSTANCED_PROP(float4, _AnimationTexturePointer)
        UNITY_DEFINE_INSTANCED_PROP(half4, _AddColor)
        UNITY_INSTANCING_BUFFER_END(Props)
    #endif
    
    CBUFFER_START(UnityPerMaterial)
        uint _DebugShowModeEnabled,_DebugShowMode;//测试显示纹理
        float4 _AnimationTexturePointer;
        half4 _AddColor;
        float4 _BaseMap_ST;
        half4 _BaseColor;
        half4 _SSSValue01;
        half4 _EmissionColor;
        half4 _MetallicValue;
        half _BumpScale;
        half4 _SurfaceMapUV,_SurfaceBumpMapUV;
        int _ShowArea;
        half4 _SurfaceColor;
        half _SurfaceBumpScale;
        half4 _SurfaceArea,_SurfaceMetallicGlossMap,_SurfaceMixValue1;
        half4 _ClothValue01,_ClothBaseMap_ST,_ClothNormalMap_ST;
        half _DitherValue;
        half4 _DecalColor;
        float4 _DecalMap_ST;
        half4 _RimColor,_Rim;
        float4 _FurMap_ST,_FurNoiseMap_ST;
        half _FurShowArea;
        float4 _FurArea,_Fur,_FurColor,_Gravity,_FurValue01;
        half _LaserIntensity;
        uint _VertexShapeEnabled;
        float4 _VertexShapeMap_ST;
        half4 _VertexShapeValue01;
        half _SelectedID;//程序传值
        half _BumpScale02;
        half4 _BaseColor02;
        float _BaseMap02_Repeat;
        half4 _MetallicValue02;
        half _FUR_OFFSET;   //皮毛在每个pass中的偏移值，由RenderFeature中传值过来
        half4 _RemovePartValue; //移除部件时的方向(XYZ) 移除部件的距离(W)
        half4 _SurfaceAreaPosition;//用于标识部件在身体表面皮肤的哪个位置(X:上下,Y:腹部,Z:背部,W:null)
    CBUFFER_END
    TEXTURE2D(_BaseMap);            SAMPLER(sampler_BaseMap);
    TEXTURE2D (_SSSLut);            SAMPLER(sampler_SSSLut);
    TEXTURE2D (_MixMap02);          SAMPLER(sampler_MixMap02);
    TEXTURE2D(_BumpMap);            SAMPLER(sampler_BumpMap);
    TEXTURE2D(_BumpMap02);          SAMPLER(sampler_BumpMap02);//身体皮肤传过来的法线
    TEXTURE2D(_MetallicGlossMap);   SAMPLER(sampler_MetallicGlossMap);
    TEXTURE2D(_MetallicGlossMap02); SAMPLER(sampler_MetallicGlossMap02);//身体皮肤传过来的金属度图
    TEXTURE2D(_SurfaceMap);         SAMPLER(sampler_SurfaceMap);
    TEXTURE2D(_SurfaceBumpMap);     SAMPLER(sampler_SurfaceBumpMap);
    TEXTURE2D(_ClothBaseMap);       SAMPLER(sampler_ClothBaseMap);
    TEXTURE2D(_ClothNormalMap);     SAMPLER(sampler_ClothNormalMap);
    TEXTURE2D(_ClothMixedMap);      SAMPLER(sampler_ClothMixedMap);
    TEXTURE2D(_DecalMap);           SAMPLER(sampler_DecalMap);
    TEXTURE2D(_VertexShapeMap);     SAMPLER(sampler_VertexShapeMap);
    TEXTURE2D(_BaseMap02);          SAMPLER(sampler_BaseMap02);//身体皮肤传过来的纹理
    TEXTURE2D (_FurMap);            SAMPLER(sampler_FurMap);
    TEXTURE2D (_FurNoiseMap);       SAMPLER(sampler_FurNoiseMap);
    TEXTURE2D(_RampTex);            SAMPLER(sampler_RampTex); //镭射渐变图

    #include "../ShaderLibs/COMMON.hlsl"
    #include "../ShaderLibs/Lib-Shadows.hlsl"
    #include "../ShaderLibs/GpuSkinning.hlsl"
    #include "../ShaderLibs/Lib-Lighting.hlsl"

    //程序化计算UV,可选择不同的映射方式
    half4 SampleProcedualUV(TEXTURE2D_PARAM(map,sampler_map),float3 worldUV,half3 normalOS,half4 uvMappingParams)
    {
        half4 c = 1;
        worldUV *= uvMappingParams.z;
        half3 xyz = saturate((abs(normalOS.xyz)+uvMappingParams.y)/(1+uvMappingParams.y));
        half4 map01 = SAMPLE_TEXTURE2D(map, sampler_map, worldUV.zy/xyz.x);
        half4 map02 = SAMPLE_TEXTURE2D(map, sampler_map, worldUV.xy/xyz.z);
        half4 map03 = SAMPLE_TEXTURE2D(map, sampler_map, worldUV.xz/xyz.y);

        switch(uvMappingParams.x)
        {
            case 0:
            half2 faceXY = saturate((abs(normalOS.xy)-0.5)/0.1);//smoothstep(0.5,0.6,abs(normalOS.x));
            c = lerp(map02,map01,faceXY.x);
            c = lerp(c,map03,faceXY.y);
            break;
            case 1:
            c = map02;
            break;
            case 2:
            c = map01;
            break;
            case 3:
            c = map03;
            break;
        }
        return c;
    }

    //程序化计算UV
    half4 SampleProcedualUV(TEXTURE2D_PARAM(map,sampler_map),float3 worldUV,half3 normalOS)
    {
        half4 c = 1;
        half3 xyz = step(0,normalOS.xyz)*2-1;
        half4 map01 = SAMPLE_TEXTURE2D(map, sampler_map, worldUV.zy * half2(xyz.x,1));
        half4 map02 = SAMPLE_TEXTURE2D(map, sampler_map, worldUV.xy * half2(-xyz.z,1));
        half4 map03 = SAMPLE_TEXTURE2D(map, sampler_map, worldUV.xz * half2(1,xyz.y));
        half2 faceXY = saturate((abs(normalOS.xy)-0.5)/0.1);//smoothstep(0.5,0.6,abs(normalOS.x));
        c = lerp(map02,map01,faceXY.x);
        c = lerp(c,map03,faceXY.y);
        return c;
    }

    //程序化计算UV
    half4 SampleProcedualUV(TEXTURE2D_PARAM(map,sampler_map),float3 worldUV,half3 normalOS,half size)
    {
        half4 c = 1;
        half3 xyz = step(0,normalOS.xyz)*2-1;
        half4 map01 = SAMPLE_TEXTURE2D(map, sampler_map, worldUV.zy * size * half2(xyz.x,1));
        half4 map02 = SAMPLE_TEXTURE2D(map, sampler_map, worldUV.xy * size * half2(-xyz.z,1));
        half4 map03 = SAMPLE_TEXTURE2D(map, sampler_map, worldUV.xz * size * half2(1,xyz.y));
        half2 faceXY = saturate((abs(normalOS.xy)-0.5)/0.1);
        c = lerp(map02,map01,faceXY.x);
        c = lerp(c,map03,faceXY.y);
        return c;
    }

    //程序化计算贴花
    half4 SampleProcedualDecal(TEXTURE2D_PARAM(map,sampler_map),float3 worldUV,half3 normalOS)
    {
        half4 c = 1;
        worldUV.xz = saturate(worldUV.xz*_DecalMap_ST.x + _DecalMap_ST.zw);
        c = SAMPLE_TEXTURE2D(map, sampler_map, worldUV.xz);
        c = saturate(c * abs(normalOS.y));
        return c;
    }


    half3 SampleLaserColor(TEXTURE2D_PARAM(rampMap,sampler_rampMap),MyInputData inputData,Light light)
    {
        half3 lightDir = light.direction;
        half3 normalWSTemp = inputData.normalWS;
        half3 viewWS = inputData.viewDirectionWS;
        half NoV = dot(normalWSTemp,viewWS);
        half NoL = dot(normalWSTemp,lightDir);

        float rampU = abs(NoV);
        float halfNoL = NoL * 0.5 + 0.5;
        float2 rampTexUV = float2(rampU, halfNoL);
        half3 laserCol = SAMPLE_TEXTURE2D(rampMap, sampler_rampMap, rampTexUV).rgb;
        return laserCol;
    }
    
    ENDHLSL

    SubShader
    {
        Tags{"RenderPipeline" = "UniversalPipeline"}

        Pass
        {
            Name "ForwardLit"
            Tags{"LightMode" = "UniversalForward"}
            Cull[_Cull]

            HLSLPROGRAM
            #pragma multi_compile_instancing
            #pragma shader_feature_local _ _UVTYPE_NPC _UVTYPE_PART _UVTYPE_PROCEDUAL
            #pragma multi_compile_local _ _SURFACEENABLED_ON
            #pragma shader_feature_local _ _CLOTHENABLED_ON
            #pragma shader_feature_local _ _DECALENABLED_ON
            #pragma multi_compile_local _ _DITHERENABLED_ON
            #pragma multi_compile_local _ _LASER_ON
            #pragma multi_compile _ _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile_local _ _SKINNING_ENABLE_ON
            #pragma vertex vert
            #pragma fragment frag

            struct Attributes
            {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 positionOS   : POSITION;
                float3 normalOS     : NORMAL;
                float4 tangentOS    : TANGENT;
                half4 color         : COLOR;        //Metaball模型: 选中顶点(R)
                float4 texcoord     : TEXCOORD0;    //Metaball模型：模型空间的位置坐标
                half4 texcoord2     : TEXCOORD1;    //Metaball模型：法线
                half4 texcoord3     : TEXCOORD2;    //Metaball模型: 上下渐变(R) 部件选择区域(G) 腹部(B) 背部(A)
                half4 texcoord4     : TEXCOORD3;    //Metaball模型: 衣服 上半身(R) 下半身(G) 手臂(B) 腿(A)
                float4 texcoord7    : TEXCOORD6;    //GPUSKinning boneIndices
                float4 texcoord8    : TEXCOORD7;    //GPUSkinning boneWeights
            };

            struct Varyings
            {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 positionCS               : SV_POSITION;
                #if _UVTYPE_NPC || _UVTYPE_PART || _LASER_ON
                    float4 uv                   : TEXCOORD0;
                #elif  _UVTYPE_PROCEDUAL
                    float4 positionOS           : TEXCOORD0;
                #endif
                float3 normalOS                 : TEXCOORD1;
                float4 normalWS                 : TEXCOORD2;
                float4 tangentWS                : TEXCOORD3;
                float4 bitangentWS              : TEXCOORD4;
                float4 matcapUV                 : TEXCOORD5;
                float4 viewDirWS                : TEXCOORD6; //视向量(XYZ)
                half4 vertexSH_fog              : TEXCOORD7;
                half4 texcoord3                 : TEXCOORD8;   
                half4 texcoord4                 : TEXCOORD9;
                half4 cloth                     : TEXCOORD10;  
                half4 addColor                  : TEXCOORD11;  
            };

            Varyings vert(Attributes v)
            {
                Varyings o = (Varyings)0;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_BRANCH
                if (_VertexShapeEnabled==1)
                {
                    half vertexShapeMap = SAMPLE_TEXTURE2D_LOD(_VertexShapeMap,sampler_VertexShapeMap, v.texcoord.xy*_VertexShapeMap_ST.xy,0).r;
                    v.positionOS.xyz +=(v.normalOS.xyz + _VertexShapeValue01.xyz) * vertexShapeMap * _VertexShapeValue01.w;
                }
                #if _SKINNING_ENABLE_ON
                    float4 pointer = UNITY_ACCESS_INSTANCED_PROP(Props, _AnimationTexturePointer);
                    float4x4 gpuSkinMatrix = TexSkinningMatrix(v.texcoord7, v.texcoord8, pointer);
                    v.positionOS = mul(gpuSkinMatrix, v.positionOS);
                #endif

                float3 positionWS = TransformObjectToWorld(v.positionOS.xyz);

                #if _UVTYPE_NPC
                    o.uv.xy = TRANSFORM_TEX(v.texcoord.xy, _BaseMap);
                    o.normalOS = v.normalOS;
                    o.normalWS.xyz = TransformObjectToWorldNormal(v.normalOS);
                    o.tangentWS.xyz = TransformObjectToWorldDir(v.tangentOS.xyz);
                    real sign = v.tangentOS.w * GetOddNegativeScale();
                    o.bitangentWS.xyz = cross(o.normalWS.xyz, o.tangentWS.xyz) * sign;
                    o.texcoord3 = 1;
                #elif _UVTYPE_PART //美术自己展的UV
                    o.uv.xy = v.texcoord.xy;
                    o.uv.zw = v.texcoord.xy *_BaseMap_ST.x*_BaseMap02_Repeat; 
                    #if _SKINNING_ENABLE_ON
                        gpuSkinMatrix =  transpose(inverseMatrix4x4(gpuSkinMatrix));
                        v.normalOS = mul(gpuSkinMatrix, float4(v.normalOS.xyz, 0)).xyz;
                    #endif
                    o.normalOS = v.normalOS;
                    o.normalWS.xyz = TransformObjectToWorldNormal(v.normalOS);
                    o.tangentWS.xyz = TransformObjectToWorldDir(v.tangentOS.xyz);
                    real sign = v.tangentOS.w * GetOddNegativeScale();
                    o.bitangentWS.xyz = cross(o.normalWS.xyz, o.tangentWS.xyz) * sign;
                    o.texcoord3 = 1;
                #elif  _UVTYPE_PROCEDUAL //程序化UV
                    o.positionOS = v.texcoord;
                    o.normalOS = v.texcoord2.xyz;
                    o.normalWS.xyz = TransformObjectToWorldNormal(v.normalOS.xyz);
                    half3 tangentOS = half3(-v.normalOS.z,v.normalOS.y,v.normalOS.x);
                    o.tangentWS.xyz = TransformObjectToWorldDir(tangentOS);
                    o.bitangentWS.xyz =  cross(o.tangentWS.xyz,o.normalWS.xyz);
                    o.texcoord3 = v.texcoord3;
                    o.texcoord4 = v.texcoord4;
                    #if _CLOTHENABLED_ON
                        half4 clothMask;
                        clothMask = step(_ClothValue01,v.texcoord4);
                        clothMask.zw *= clothMask.xy;
                        clothMask.xy -= step(0.001,v.texcoord4.ba);
                        o.cloth = any(saturate(clothMask));
                        // positionWS += o.cloth*o.normalOS.xyz*0.02;
                    #endif
                #endif
                half2 normalVS = mul(UNITY_MATRIX_V,o.normalWS).xy;
                o.matcapUV.xy = normalVS * 0.5 + 0.5;
                o.tangentWS.w = positionWS.x;
                o.bitangentWS.w = positionWS.y;
                o.normalWS.w = positionWS.z;

                o.viewDirWS.xyz = GetWorldSpaceViewDir(positionWS);
                o.vertexSH_fog.xyz = SampleSHVertex(o.normalWS.xyz);
                
                o.positionCS = TransformWorldToHClip(positionWS);
                o.vertexSH_fog.w = ComputeFogFactor(o.positionCS.z);
                o.addColor = UNITY_ACCESS_INSTANCED_PROP(Props, _AddColor);
                return o;
            }

            half4 frag(Varyings i) : SV_Target
            {
                //表面遮罩
                #if _SURFACEENABLED_ON
                    half mask = 0;
                    half partMask = 0;//部件在身体表面上的遮罩值
                    half topDownMask = 0;
                    half partTopDownMask = 0;
                    half y_x = _SurfaceArea.y-_SurfaceArea.x;

                    topDownMask = saturate((i.texcoord3.x-_SurfaceArea.x)/y_x);//smoothstep(_SurfaceArea.x,_SurfaceArea.y,i.texcoord3.x);
                    partTopDownMask = saturate((_SurfaceAreaPosition.x-_SurfaceArea.x)/y_x);
                    switch(_ShowArea)
                    {
                        case 0: //无
                        mask = 0;
                        partMask = 0;
                        break;
                        case 1: //全身
                        mask = 1;
                        partMask = 1;
                        break;
                        case 2: //顶部
                        mask = topDownMask;
                        partMask = partTopDownMask;
                        break;
                        case 3: //底部
                        mask = 1-topDownMask;
                        partMask = 1-partTopDownMask;
                        break;
                        case 4: //腹部
                        mask = saturate((i.texcoord3.b-_SurfaceArea.x)/y_x);//smoothstep(_SurfaceArea.x,_SurfaceArea.y,i.texcoord3.b);
                        partMask = saturate((_SurfaceAreaPosition.y-_SurfaceArea.x)/y_x);
                        break;
                        case 5: //背部
                        mask = saturate((i.texcoord3.a-_SurfaceArea.x)/y_x);//smoothstep(_SurfaceArea.x,_SurfaceArea.y,i.texcoord3.a);
                        partMask = saturate((_SurfaceAreaPosition.z-_SurfaceArea.x)/y_x);
                        break;
                        case 6: //腹部+背部
                        mask = saturate((i.texcoord3.b+i.texcoord3.a-_SurfaceArea.x)/y_x);//smoothstep(_SurfaceArea.x,_SurfaceArea.y,i.texcoord3.b+i.texcoord3.a);
                        partMask = saturate((_SurfaceAreaPosition.y+_SurfaceAreaPosition.z-_SurfaceArea.x)/y_x);
                        break;
                        case 7: //手臂
                        mask = saturate((i.texcoord4.b-_SurfaceArea.x)/y_x);
                        break;
                        case 8: //腿
                        mask = saturate((i.texcoord4.a-_SurfaceArea.x)/y_x);
                        break;
                        case 9: //手臂+腿
                        mask = saturate((i.texcoord4.b+i.texcoord4.a-_SurfaceArea.x)/y_x);
                        break;
                    }
                    mask = saturate(mask);
                    partMask = saturate(partMask);
                #endif
                
                MySurfaceData surfaceData = (MySurfaceData)0;
                {
                    half4 albedoAlpha = 1;
                    half4 metallicMap = 1;
                    #if _UVTYPE_NPC //美术PNC
                        {
                            half4 baseMap = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv.xy);
                            albedoAlpha = baseMap * _BaseColor;
                            surfaceData.normalTS = UnpackNormalScale(SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, i.uv.xy), _BumpScale);
                            metallicMap = SAMPLE_TEXTURE2D(_MetallicGlossMap, sampler_MetallicGlossMap, i.uv.xy);
                            surfaceData.metallic = metallicMap.r * _MetallicValue.r;
                            surfaceData.roughness = metallicMap.g;
                            surfaceData.smoothness = (1-metallicMap.g)*_MetallicValue.g;
                            // surfaceData.smoothness = pow((1-metallicMap.g)*_MetallicValue.g,0.45);
                            // return pow(surfaceData.smoothness,2.2);
                            surfaceData.occlusion = lerp(1,metallicMap.a,_MetallicValue.a);
                            surfaceData.emission = _EmissionColor.rgb * metallicMap.b;
                            half4 mixedMap02 = SAMPLE_TEXTURE2D(_MixMap02, sampler_MixMap02, i.uv.xy);
                            surfaceData.curvature = saturate(mixedMap02.r * _SSSValue01.x);
                        }
                    #elif _UVTYPE_PART  //主角美术部件
                        half fadeMask=1;
                        {
                            half4 baseMap = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv.xy);
                            fadeMask = baseMap.a;
                            half4 baseMap02 = SAMPLE_TEXTURE2D(_BaseMap02, sampler_BaseMap02, i.matcapUV.xy);
                            albedoAlpha.rgb = baseMap02.rgb * _BaseColor02.rgb;

                            #if _SURFACEENABLED_ON
                                //美术在部件的_SurfaceMapUV.w上微调匹配身体的重复度系数，然后程序将系数乘进重复度中去
                                half4 surfaceMap = SAMPLE_TEXTURE2D(_SurfaceMap,sampler_SurfaceMap,i.uv.xy*_SurfaceMapUV.z);
                                half a = saturate((surfaceMap.a+_SurfaceArea.z)*partMask*_SurfaceColor.a);
                                albedoAlpha.rgb = lerp(albedoAlpha.rgb,surfaceMap.rgb*_SurfaceColor.rgb,a);
                            #endif
                            albedoAlpha.rgb = lerp(albedoAlpha.rgb,baseMap.rgb,fadeMask);

                            // albedoAlpha.rgb = lerp(baseMap02.rgb * _BaseColor02.rgb,baseMap.rgb*lerp(1,_BaseColor02.rgb,0.2),fadeMask);
                            half3 normalMap01 = UnpackNormalScale(SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, i.uv.xy), _BumpScale);
                            half3 normalMap02 = UnpackNormalScale(SAMPLE_TEXTURE2D(_BumpMap02, sampler_BumpMap02, i.uv.zw), _BumpScale02);
                            surfaceData.normalTS = normalize(lerp(normalMap02,normalMap01,fadeMask));
                            // #if _SURFACEENABLED_ON //出于性原因部件身上的皮肤法线就不添加了
                            //     half3 surfaceNormal = UnpackNormal(SAMPLE_TEXTURE2D(_SurfaceBumpMap,sampler_SurfaceBumpMap,i.uv.xy*_SurfaceBumpMapUV.z));
                            //     surfaceData.normalTS = lerp(normalMap02, surfaceNormal,_SurfaceBumpScale*partMask);
                            // #endif

                            half4 metallicMap01 = SAMPLE_TEXTURE2D(_MetallicGlossMap, sampler_MetallicGlossMap, i.uv.xy);
                            half4 metallicMap02 = SAMPLE_TEXTURE2D(_MetallicGlossMap02, sampler_MetallicGlossMap02, i.uv.zw);
                            metallicMap = lerp(metallicMap02,metallicMap01,fadeMask);
                            half4 metallicValue = lerp(_MetallicValue02,_MetallicValue,fadeMask);
                            // metallicMap = PositivePow(metallicMap,metallicValue.z);
                            surfaceData.metallic = metallicMap.r * metallicValue.r;
                            surfaceData.roughness = metallicMap.g;
                            surfaceData.smoothness = (1-metallicMap.g)*metallicValue.g;
                            surfaceData.occlusion = lerp(1,metallicMap.a,metallicValue.a);
                            surfaceData.emission = _EmissionColor.rgb * metallicMap01.b;
                            half4 mixedMap02 = SAMPLE_TEXTURE2D(_MixMap02, sampler_MixMap02, i.uv.xy);
                            surfaceData.curvature = saturate(mixedMap02.r * _SSSValue01.x);
                        }
                    #elif _UVTYPE_PROCEDUAL //程序化UV
                        float3 worldUV = i.positionOS.xyz *_BaseMap_ST.x;
                        albedoAlpha = SAMPLE_TEXTURE2D(_BaseMap,sampler_BaseMap,i.matcapUV.xy);
                        albedoAlpha.rgb *= _BaseColor.rgb;
                        surfaceData.normalTS = UnpackNormalScale(SampleProcedualUV(TEXTURE2D_ARGS(_BumpMap,sampler_BumpMap),worldUV,i.normalOS),_BumpScale);

                        #if _SURFACEENABLED_ON
                            half4 surfaceMap = SampleProcedualUV(TEXTURE2D_ARGS(_SurfaceMap,sampler_SurfaceMap),i.positionOS.xyz,i.normalOS,_SurfaceMapUV);
                            // mask = min(PositivePow(surfaceMap.a,_SurfaceArea.z) * mask,mask);
                            mask = saturate((surfaceMap.a+_SurfaceArea.z)*mask);
                            albedoAlpha.rgb = lerp(albedoAlpha.rgb,surfaceMap.rgb*_SurfaceColor.rgb,mask*_SurfaceColor.a);

                            // half3 surfaceNormal = UnpackNormalScale(SampleProcedualUV(TEXTURE2D_ARGS(_SurfaceBumpMap,sampler_SurfaceBumpMap),surfaceWorldUV,i.normalOS),_SurfaceBumpScale);
                            // surfaceNormal = BlendNormalRNM(surfaceData.normalTS, surfaceNormal);
                            half3 surfaceNormal = UnpackNormal(SampleProcedualUV(TEXTURE2D_ARGS(_SurfaceBumpMap,sampler_SurfaceBumpMap),i.positionOS.xyz,i.normalOS,_SurfaceBumpMapUV));
                            surfaceNormal = lerp(surfaceData.normalTS, surfaceNormal,_SurfaceBumpScale);
                            surfaceData.normalTS = lerp(surfaceData.normalTS,surfaceNormal,mask);
                        #endif

                        #if _CLOTHENABLED_ON
                            // half4 clothMask = step(_ClothValue01,i.cloth*half4(1,1,_ClothValue01.zw));
                            // return i.cloth;

                            // half clothMask = saturate(_clothMask.r+_clothMask.g);
                            // half3 clothWorldUV = i.positionOS.xyz *_ClothBaseMap_ST.x;
                            // half4 clothBaseMap = SampleProcedualUV(TEXTURE2D_ARGS(_ClothBaseMap,sampler_ClothBaseMap),clothWorldUV,i.normalOS);
                            // // return clothBaseMap;
                            // // mask = saturate(surfaceMap.a*mask+mask*_SurfaceArea.z);
                            // albedoAlpha.rgb = lerp(albedoAlpha.rgb,clothBaseMap.rgb,clothMask);
                            // half3 clothNormalWorldUV = i.positionOS.xyz *_ClothNormalMap_ST.x;
                            // half3 clothNormalMap = UnpackNormalScale(SampleProcedualUV(TEXTURE2D_ARGS(_ClothNormalMap,sampler_ClothNormalMap),clothNormalWorldUV,i.normalOS),1);
                            // // return half4(clothNormalMap,1);
                            // // surfaceNormal = BlendNormalRNM(surfaceData.normalTS, surfaceNormal);
                            // surfaceData.normalTS = lerp(surfaceData.normalTS,clothNormalMap,clothMask);
                        #endif

                        metallicMap = SampleProcedualUV(TEXTURE2D_ARGS(_MetallicGlossMap,sampler_MetallicGlossMap),worldUV,i.normalOS);
                        // metallicMap = PositivePow(metallicMap,_MetallicValue.z);
                        surfaceData.metallic = metallicMap.r * _MetallicValue.r;
                        surfaceData.roughness = metallicMap.g;
                        surfaceData.smoothness = (1-metallicMap.g)*_MetallicValue.g;
                        surfaceData.occlusion = lerp(1,metallicMap.a,_MetallicValue.a);
                        surfaceData.emission = _EmissionColor.rgb * metallicMap.b;
                        half4 mixedMap02 = SampleProcedualUV(TEXTURE2D_ARGS(_MixMap02,sampler_MixMap02),worldUV,i.normalOS);
                        surfaceData.curvature = mixedMap02.r * _SSSValue01.x;

                        #if _DECALENABLED_ON
                            half4 decalMap = SampleProcedualDecal(TEXTURE2D_ARGS(_DecalMap,sampler_DecalMap),i.positionOS.xyz,i.normalOS.xyz);
                            albedoAlpha.rgb = lerp(albedoAlpha.rgb,decalMap.rgb*_DecalColor.rgb,decalMap.a*_DecalColor.a);
                        #endif
                    #else
                    #endif
                    surfaceData.albedo = albedoAlpha.rgb;
                    surfaceData.alpha = albedoAlpha.a;
                }

                {//Debug测试显示纹理
                    [branch]if (_DebugShowModeEnabled==1)
                    {
                        half3 col=1;
                        switch(_DebugShowMode)
                        {
                            case 0:
                            col = surfaceData.albedo;
                            break;
                            case 1:
                            col = surfaceData.normalTS;
                            break;
                            case 2:
                            col = surfaceData.metallic;
                            break;
                            case 3:
                            col = surfaceData.roughness;
                            break;
                            case 4:
                            col = surfaceData.smoothness;
                            break;
                            case 5:
                            col = surfaceData.emission;
                            break;
                            case 6:
                            col = surfaceData.occlusion;
                            break;
                            case 7:
                            col = surfaceData.curvature;
                            break;
                        }
                        return half4(col,1);
                    }
                }

                MyInputData inputData = (MyInputData)0;
                {
                    inputData.positionWS = float3(i.tangentWS.w, i.bitangentWS.w, i.normalWS.w);
                    inputData.normalWS = TransformTangentToWorld(surfaceData.normalTS, half3x3(i.tangentWS.xyz, i.bitangentWS.xyz, i.normalWS.xyz));
                    inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
                    inputData.vertexNormalWS = normalize(i.normalWS.xyz);
                    inputData.viewDirectionWS = SafeNormalize(i.viewDirWS.xyz);
                    // return 1-dot(inputData.vertexNormalWS,inputData.viewDirectionWS);
                    inputData.shadowCoord = TransformWorldToShadowCoord(inputData.positionWS);
                    // inputData.vertexLighting = i.fogFactorAndVertexLight.yzw;
                    // inputData.bakedGI = SAMPLE_GI(i.lightmapUV, i.vertexSH_fog.xyz, inputData.normalWS);
                    inputData.bakedGI = SampleSH(inputData.normalWS);
                    // inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(i.positionCS);
                }

                Light mainLight = GetMainLight(inputData.shadowCoord);

                surfaceData.laserColor = SampleLaserColor(TEXTURE2D_ARGS(_RampTex,sampler_RampTex),inputData,mainLight);
                
                // half3 indirectDiffuse = (i.normalWS.y*0.2+0.4)*mainLight.color;
                half4 c = PBRComputer(inputData,surfaceData,mainLight);

                c.rgb += i.addColor.rgb;

                #if _DITHERENABLED_ON
                    uint2 ditherUV = (uint2)i.positionCS.xy;
                    half dither8x8_Array = Dither8x8(ditherUV);
                    clip(dither8x8_Array-(1-_DitherValue));
                #endif


                // #if _UVTYPE_NPC&&_LASER_ON || _UVTYPE_PART&&_LASER_ON
                //     half3 mixTex = SAMPLE_TEXTURE2D(_MixMap, sampler_MixMap, i.uv).rgb;
                //     half lasermask = mixTex.r * _LaserIntensity;
                //     half specularMask = mixTex.b;
                //     half3 lightDir = mainLight.direction;
                //     half3 normalWSTemp = inputData.normalWS;
                //     half3 viewWS = inputData.viewDirectionWS;
                //     half NoV = dot(normalWSTemp,viewWS);
                //     half NoL = dot(normalWSTemp,lightDir);
                //     half fresnelTerm = pow((1 - saturate(NoV)),2);
                //
                //     float rampU = abs(NoV);
                //     float halfNoL = NoL * 0.5 + 0.5;
                //     float2 rampTexUV = float2(rampU, halfNoL);
                //     half3 rampCol = SAMPLE_TEXTURE2D(_RampTex, sampler_RampTex, rampTexUV).rgb;
                //     // lasermask *= halfNoL;
                //     lasermask *= (1- fresnelTerm);
                //     c.rgb = lerp(c.rgb, rampCol, lasermask);
                // #endif


                
                c.rgb = MixFog(c.rgb, i.vertexSH_fog.w);

                c = lerp(c,saturate(c),_MetallicValue.z);

                return c;
            }
            ENDHLSL
        }

        Pass
        {
            Tags{ "LightMode" = "Fur"}
            Blend SrcAlpha OneMinusSrcAlpha,One OneMinusSrcAlpha

            HLSLPROGRAM
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing

            // #pragma shader_feature_local _ _UVTYPE_NPC _UVTYPE_PART _UVTYPE_PROCEDUAL
            #pragma multi_compile_local _ _SURFACEENABLED_ON
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile_local _ _SKINNING_ENABLE_ON
            #pragma multi_compile_local _ _DITHERENABLED_ON
            #pragma multi_compile_fog

            struct Attributes
            {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 positionOS   : POSITION;
                float3 normalOS     : NORMAL;
                float4 tangentOS    : TANGENT;
                float4 texcoord     : TEXCOORD0;    //Metaball模型：模型空间的位置坐标
                float4 texcoord2    : TEXCOORD1;    //Metaball模型：法线
                half4 texcoord3     : TEXCOORD2;    //Metaball模型: 上下渐变(R) 部件选择区域(G) 腹部(B) 背部(A)
                float4 texcoord4     : TEXCOORD3;    //Metaball模型: 衣服 上半身（R）下半身(G)
                float4 texcoord7    : TEXCOORD6;    //GPUSKinning boneIndices
                float4 texcoord8    : TEXCOORD7;    //GPUSkinning boneWeights
            };

            struct Varyings
            {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 positionCS               : SV_POSITION;
                float4 positionOS               : TEXCOORD0;
                float3 normalOS                 : TEXCOORD1;
                float4 normalWS                 : TEXCOORD2;
                float4 matcapUV                 : TEXCOORD3;
                half4 texcoord3                 : TEXCOORD4;
                float4 positionWS               : TEXCOORD5;
                half4 viewDirWS_fog             : TEXCOORD6;
                half4 addColor                  : TEXCOORD7;  

            };

            Varyings vert(Attributes v)
            {
                Varyings o = (Varyings)0;

                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                [branch]if (_VertexShapeEnabled==1)
                {
                    half vertexShapeMap = SAMPLE_TEXTURE2D_LOD(_VertexShapeMap,sampler_VertexShapeMap, v.texcoord.xy*_VertexShapeMap_ST.xy,0).r;
                    v.positionOS.xyz +=(v.normalOS.xyz + _VertexShapeValue01.xyz) * vertexShapeMap * _VertexShapeValue01.w;
                }
                #if _SKINNING_ENABLE_ON
                    float4 pointer = UNITY_ACCESS_INSTANCED_PROP(Props, _AnimationTexturePointer);
                    v.positionOS = TexSkinning(v.positionOS, v.texcoord7, v.texcoord8, pointer);
                #endif

                o.positionWS.xyz = TransformObjectToWorld(v.positionOS.xyz);

                o.positionOS = v.texcoord;
                o.normalOS = v.texcoord2.xyz;
                o.normalWS.xyz = TransformObjectToWorldNormal(v.texcoord2.xyz);
                o.texcoord3 = v.texcoord3;
                half2 normalVS = mul(UNITY_MATRIX_V,o.normalWS).xy;
                o.matcapUV.xy = normalVS * 0.5 + 0.5;
                o.viewDirWS_fog.xyz = GetWorldSpaceViewDir(o.positionWS.xyz);

                //毛发扩展
                half3 direction = (o.normalWS.xyz + _Gravity.xyz) * _FUR_OFFSET;
                direction.xyz += sin(_Time.y*_FurValue01.z+v.positionOS.zxy*_FurValue01.w)*0.1;
                o.positionWS.xyz += normalize(direction) * _FurValue01.x * _FUR_OFFSET;

                o.positionCS = TransformWorldToHClip(o.positionWS.xyz);
                o.viewDirWS_fog.w = ComputeFogFactor(o.positionCS.z);
                o.addColor = UNITY_ACCESS_INSTANCED_PROP(Props, _AddColor);
                return o;
            }

            half4 frag(Varyings i) : SV_Target
            {
                half4 c = 1;

                #if _SURFACEENABLED_ON
                    half mask = 0;
                    half topDownMask = 0;
                    half y_x = _SurfaceArea.y-_SurfaceArea.x;

                    topDownMask = saturate((i.texcoord3.x-_SurfaceArea.x)/y_x);
                    switch(_ShowArea)
                    {
                        case 0: //无
                        mask = 0;
                        break;
                        case 1: //全身
                        mask = 1;
                        break;
                        case 2: //顶部
                        mask = topDownMask;
                        break;
                        case 3: //底部
                        mask = 1-topDownMask;
                        break;
                        case 4: //腹部
                        mask = saturate((i.texcoord3.b-_SurfaceArea.x)/y_x);
                        break;
                        case 5: //背部
                        mask = saturate((i.texcoord3.a-_SurfaceArea.x)/y_x);
                        break;
                        case 6: //腹部+背部
                        mask = saturate((i.texcoord3.b+i.texcoord3.a-_SurfaceArea.x)/y_x);
                        break;
                    }
                    mask = saturate(mask);
                #endif
                
                c = SAMPLE_TEXTURE2D(_BaseMap,sampler_BaseMap,i.matcapUV.xy);
                c.rgb *= _BaseColor.rgb;
                
                #if _SURFACEENABLED_ON
                    half4 surfaceMap = SampleProcedualUV(TEXTURE2D_ARGS(_SurfaceMap,sampler_SurfaceMap),i.positionOS.xyz,i.normalOS,_SurfaceMapUV);
                    mask = saturate((surfaceMap.a+_SurfaceArea.z)*mask);
                    c.rgb = lerp(c.rgb,surfaceMap.rgb*_SurfaceColor.rgb,mask);
                #endif

                c.rgb *= _FurColor.rgb;

                float4 shadowCoord = TransformWorldToShadowCoord(i.positionWS.xyz);
                Light light = GetMainLight(shadowCoord);
                half3 L = light.direction;
                half3 V = i.viewDirWS_fog.xyz;
                half3 N = i.normalWS.xyz;
                half NoL = dot(N,L)*0.5+0.5;
                c.rgb *= NoL * light.shadowAttenuation;

                float3 worldUV = i.positionOS.xyz * _FurMap_ST.x;
                half furLayer = SampleProcedualUV(TEXTURE2D_ARGS(_FurMap,sampler_FurMap),worldUV,i.normalOS).r;
                
                c.rgb = furLayer * c.rgb + c.rgb;
                half furOffset = PositivePow(_FUR_OFFSET,_FurValue01.y);
                half f = furOffset*furOffset;
                c.a = saturate((furLayer-f)/(1-f));// smoothstep(f,1,furLayer);
                c.a *= 1 - _FUR_OFFSET;

                {//毛发遮罩
                    half furMask = 0;
                    half topDownMask = 0;
                    half y_x = _FurArea.y-_FurArea.x;
                    topDownMask = saturate((i.texcoord3.x-_FurArea.x)/y_x);
                    switch(_FurShowArea)
                    {
                        case 0: //无
                        furMask = 0;
                        break;
                        case 1: //全身
                        furMask = 1;
                        break;
                        case 2: //顶部
                        furMask = topDownMask;
                        break;
                        case 3: //底部
                        furMask = 1-topDownMask;
                        break;
                        case 4: //胸部
                        furMask = saturate((i.texcoord3.b-_FurArea.x)/y_x);
                        break;
                        case 5: //背部
                        furMask = saturate((i.texcoord3.a-_FurArea.x)/y_x);
                        break;
                        case 6: //腹部+背部
                        furMask = saturate((i.texcoord3.b+i.texcoord3.a-_FurArea.x)/y_x);
                        break;
                    }
                    c.a *= furMask;
                }
                
                #if _DITHERENABLED_ON
                    uint2 ditherUV = (uint2)i.positionCS.xy;
                    half dither8x8_Array = Dither8x8(ditherUV);
                    clip(dither8x8_Array-(1-_DitherValue));
                #endif

                c.rgb += i.addColor.rgb;
                c.rgb = MixFog(c.rgb, i.viewDirWS_fog.w);

                return c;
            }
            ENDHLSL
        }

        Pass
        {
            Stencil
            {
                Ref 11
                Comp Never
                Fail Replace
            }

            Name "Outline0"
            Tags{"LightMode" = "Outline0"}
            ZWrite Off
            ZTest Always

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature_local _ _UVTYPE_ART _UVTYPE_PROCEDUAL

            struct Attributes
            {
                float4 positionOS   : POSITION;
                #if _UVTYPE_PROCEDUAL
                    half4 texcoord3 : TEXCOORD2;    //Metaball模型: 上下渐变(R) 部件选择区域(G)
                #endif
            };

            struct Varyings
            {
                float4 positionCS               : SV_POSITION;
                half mask                       : TEXCOORD;
            };

            Varyings vert(Attributes v)
            {
                Varyings o = (Varyings)0;
                o.positionCS = TransformObjectToHClip(v.positionOS.xyz);
                #if _UVTYPE_PROCEDUAL
                    o.mask = _SelectedID==v.texcoord3.g;
                #endif
                return o;
            }

            half4 frag(Varyings i) : SV_Target
            {
                #if _UVTYPE_PROCEDUAL
                    clip(i.mask-0.5);
                #endif
                return 0;
            }
            ENDHLSL
        }
        Pass
        {
            Stencil
            {
                Ref 11
                Comp NotEqual
            }
            
            Name "Outline1"
            Tags{"LightMode" = "Outline1"}
            ZWrite Off
            ZTest Always

            HLSLPROGRAM
            #pragma shader_feature_local _ _UVTYPE_ART _UVTYPE_PROCEDUAL
            #pragma vertex vert
            #pragma fragment frag

            struct Attributes
            {
                float4 positionOS   : POSITION;
                float3 normalOS     : NORMAL;
                float4 texcoord     : TEXCOORD0;    //程序化模型：模型空间的位置坐标
                float4 texcoord2    : TEXCOORD1;    //程序化模型：法线
                #if _UVTYPE_PROCEDUAL
                    half4 texcoord3 : TEXCOORD2;    //Metaball模型: 上下渐变(R) 部件选择区域(G)
                #endif
            };

            struct Varyings
            {
                float4 positionCS               : SV_POSITION;
                half mask                       : TEXCOORD;
            };

            Varyings vert(Attributes v)
            {
                Varyings o = (Varyings)0;
                float3 positionOS = v.positionOS.xyz;
                half3 dir = normalize(v.normalOS.xyz);
                #if _UVTYPE_PROCEDUAL
                    dir = normalize(v.texcoord2.xyz);
                    o.mask = _SelectedID==v.texcoord3.g;
                    positionOS += dir * 0.01 * o.mask;
                #else
                    positionOS += dir * 0.01;
                #endif
                o.positionCS = TransformObjectToHClip(positionOS);
                return o;
            }

            half4 frag(Varyings i) : SV_Target
            {
                #if _UVTYPE_PROCEDUAL
                    clip(i.mask-0.5);
                #endif
                return 1;
            }
            ENDHLSL
        }

        UsePass "ONEMT/Pass/MeshShadowPass/MeshShadow"

        Pass
        {
            Name "ShadowCaster"
            Tags{"LightMode" = "ShadowCaster"}

            ZWrite On
            ZTest LEqual
            ColorMask 0

            HLSLPROGRAM
            #pragma target 3.5
            #pragma vertex ShadowPassVertex
            #pragma multi_compile_instancing
            #pragma fragment ShadowPassFragment
            #pragma multi_compile_local _ _SKINNING_ENABLE_ON
            #pragma multi_compile_local _ _DITHERENABLED_ON
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            float3 _LightDirection;

            struct Attributes
            {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 positionOS   : POSITION;
                float3 normalOS     : NORMAL;
                float2 texcoord     : TEXCOORD;
                float4 texcoord7    : TEXCOORD6;    //GPUSKinning boneIndices
                float4 texcoord8    : TEXCOORD7;    //GPUSkinning boneWeights
            };

            struct Varyings
            {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 positionCS   : SV_POSITION;
            };

            float4 GetShadowPositionHClip(Attributes v)
            {
                [branch]if (_VertexShapeEnabled==1)
                {
                    half vertexShapeMap = SAMPLE_TEXTURE2D_LOD(_VertexShapeMap,sampler_VertexShapeMap, v.texcoord.xy*_VertexShapeMap_ST.xy,0).r;
                    v.positionOS.xyz +=(v.normalOS.xyz + _VertexShapeValue01.xyz) * vertexShapeMap * _VertexShapeValue01.w;
                }
                #if _SKINNING_ENABLE_ON
                    float4 pointer = UNITY_ACCESS_INSTANCED_PROP(Props, _AnimationTexturePointer);
                    v.positionOS = TexSkinning(v.positionOS, v.texcoord7, v.texcoord8, pointer);
                #endif
                float3 positionWS = TransformObjectToWorld(v.positionOS.xyz);
                float3 normalWS = TransformObjectToWorldNormal(v.normalOS.xyz);

                float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, _LightDirection));

                #if UNITY_REVERSED_Z
                    positionCS.z = min(positionCS.z, positionCS.w * UNITY_NEAR_CLIP_VALUE);
                #else
                    positionCS.z = max(positionCS.z, positionCS.w * UNITY_NEAR_CLIP_VALUE);
                #endif

                return positionCS;
            }

            Varyings ShadowPassVertex(Attributes v)
            {
                Varyings o = (Varyings)0;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                o.positionCS = GetShadowPositionHClip(v);
                return o;
            }

            half4 ShadowPassFragment(Varyings i) : SV_TARGET
            {
                #if _DITHERENABLED_ON
                    uint2 ditherUV = (uint2)i.positionCS.xy;
                    half dither8x8_Array = Dither8x8(ditherUV);
                    clip(dither8x8_Array-(1-_DitherValue));
                #endif
                return 0;
            }
            ENDHLSL
        }
    }

    CustomEditor "taecg.tools.CustomShaderGUI"
}
precision highp float;
struct MaterialInfo {
  highp vec4 m_DiffuseColor;
  highp vec4 m_SpecularColor;
  highp vec2 m_SpecularPowerBumpiness;
};
uniform MaterialInfo Material;
uniform sampler2D DiffuseTexture;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_COLOR3;
varying highp vec2 xlv_COLOR4;
void main ()
{
  highp vec4 diffuseTextureColor_1;
  highp vec4 baseColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (DiffuseTexture, xlv_TEXCOORD0.xy);
  diffuseTextureColor_1 = tmpvar_3;
  baseColor_2 = (Material.m_DiffuseColor * diffuseTextureColor_1);
  baseColor_2 = (baseColor_2 * xlv_COLOR0);
  bvec4 tmpvar_4;
  tmpvar_4 = lessThan (xlv_COLOR3, vec4(0.0, 0.0, 0.0, 0.0));
  if (any(tmpvar_4)) {
    discard;
  };
  bvec2 tmpvar_5;
  tmpvar_5 = lessThan (xlv_COLOR4, vec2(0.0, 0.0));
  if (any(tmpvar_5)) {
    discard;
  };
  gl_FragData[0] = baseColor_2;
}


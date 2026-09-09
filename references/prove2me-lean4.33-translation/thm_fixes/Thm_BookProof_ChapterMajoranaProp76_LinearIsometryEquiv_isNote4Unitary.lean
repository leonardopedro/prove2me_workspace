-- Generated from ChapterMajoranaProp76.lean — theorem BookProof.ChapterMajoranaProp76.LinearIsometryEquiv.isNote4Unitary
import Mathlib
import Definitions.Def_ChapterMajoranaProp76
open BookProof.ChapterMajoranaProp76










open scoped InnerProductSpace


variable {𝕜 : Type*} [RCLike 𝕜]


variable {H K L : Type*}
  [NormedAddCommGroup H] [InnerProductSpace 𝕜 H]
  [NormedAddCommGroup K] [InnerProductSpace 𝕜 K]
  [NormedAddCommGroup L] [InnerProductSpace 𝕜 L]

theorem BookProof.ChapterMajoranaProp76.LinearIsometryEquiv.isNote4Unitary (e : H ≃ₗᵢ[𝕜] K) :
    IsNote4Unitary 𝕜 (e : H → K) := by sorry

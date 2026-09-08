-- Generated from ChapterMajoranaProp76.lean — solution of BookProof.ChapterMajoranaProp76.LinearIsometryEquiv.isNote4Unitary
import Mathlib
import Definitions.Def_ChapterMajoranaProp76
open BookProof.ChapterMajoranaProp76
open BookProof.ChapterMajoranaProp76.LinearIsometryEquiv











open scoped InnerProductSpace


variable {𝕜 : Type*} [RCLike 𝕜]


variable {H K L : Type*}
  [NormedAddCommGroup H] [InnerProductSpace 𝕜 H]
  [NormedAddCommGroup K] [InnerProductSpace 𝕜 K]
  [NormedAddCommGroup L] [InnerProductSpace 𝕜 L]

set_option maxHeartbeats 1000000 in
theorem solution (e : H ≃ₗᵢ[𝕜] K) :
    IsNote4Unitary 𝕜 (e : H → K) := ⟨e.surjective, fun x => e.inner_map_map x x⟩

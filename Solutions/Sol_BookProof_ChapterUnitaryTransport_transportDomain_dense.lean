-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.transportDomain_dense
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_coe_transportDomain
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H)
    (hD : Dense ((D : Submodule ℂ H) : Set H)) :
    Dense ((transportDomain W D : Submodule ℂ K) : Set K) := by

  rw [coe_transportDomain]
  exact W.toHomeomorph.isDenseEmbedding.dense_image.2 hD

-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.transported_position_domain_dense
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_transportDomain_dense
import Theorems.Thm_BookProof_ChapterUnboundedPosition_mulDomain_dense
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    Dense ((transportDomain W (mulDomain f) : Submodule ℂ K) : Set K) :=
  Set K) :=
    transportDomain_dense W _ (mulDomain_d

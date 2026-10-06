-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.transported_position_domain_dense
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterUnboundedPosition
open BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


open scoped InnerProductSpace



theorem BookProof.ChapterUnitaryTransport.transported_position_domain_dense (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    Dense ((transportDomain W (mulDomain f) : Submodule ℂ K) : Set K) := by sorry

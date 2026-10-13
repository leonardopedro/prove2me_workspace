-- Generated from ChapterDiagonalDGammaEsa.lean — solution of BookProof.DiagonalDGamma.diagVec_coe
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
import Theorems.Thm_BookProof_DiagonalDGamma_diagBasis_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
open BookProof.DiagonalDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore
open BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  {ι : Type*} (e : ι → D₂) (lam : ι → ℝ)
variable {Hs}
variable {E : ι → Hs.carrier} (hE : Orthonormal ℂ E)

set_option maxHeartbeats 1000000 in
theorem solution (i : ι) : ((diagVec hE i : Hs.carrier)) = E i := diagBasis_apply hE i

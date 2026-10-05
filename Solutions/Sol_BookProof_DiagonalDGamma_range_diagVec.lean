-- Generated from ChapterDiagonalDGammaEsa.lean — solution of BookProof.DiagonalDGamma.range_diagVec
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
import Theorems.Thm_BookProof_DiagonalDGamma_diagVec_coe
open BookProof.DiagonalDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  {ι : Type*} (e : ι → D₂) (lam : ι → ℝ)
variable {Hs}
variable {E : ι → Hs.carrier} (hE : Orthonormal ℂ E)

set_option maxHeartbeats 1000000 in
theorem solution :
    (Set.range fun i => ((diagVec hE i : Hs.carrier))) = Set.range E := by

  have hfun : (fun i => ((diagVec hE i : Hs.carrier))) = E := funext fun i => diagVec_coe hE i
  rw [hfun]

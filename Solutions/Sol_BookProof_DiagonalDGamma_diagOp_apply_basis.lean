-- Generated from ChapterDiagonalDGammaEsa.lean — solution of BookProof.DiagonalDGamma.diagOp_apply_basis
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
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
theorem solution (lam : ι → ℝ) (i : ι) :
    diagOp hE lam (diagBasis hE i) = (lam i : ℂ) • E i := by

  rw [diagOp, Module.Basis.constr_basis]

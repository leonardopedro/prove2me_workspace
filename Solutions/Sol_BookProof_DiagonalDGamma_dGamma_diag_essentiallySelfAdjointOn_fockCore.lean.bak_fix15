-- Generated from ChapterDiagonalDGammaEsa.lean — solution of BookProof.DiagonalDGamma.dGamma_diag_essentiallySelfAdjointOn_fockCore
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
import Theorems.Thm_BookProof_DiagonalDGamma_dGamma_diagonal_essentiallySelfAdjointOn_fockCore
import Theorems.Thm_BookProof_DiagonalDGamma_diagOp_eig
import Theorems.Thm_BookProof_DiagonalDGamma_range_diagVec
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
theorem solution (lam : ι → ℝ)
    (hdense : Dense (Submodule.span ℂ (Set.range E) : Set Hs.carrier))
    (D : Submodule ℂ Hs.carrier) (hcore : IsGraphCore D (diagOp hE lam)) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore Hs (diagDomain E) D n))
      (dGammaCoreOp Hs (diagDomain E) (diagOp hE lam) D) :=
  dGamma_diagonal_essentiallySelfAdjointOn_fockCore Hs (diagDomain E) (diagOp hE lam)
      (diagVec hE) lam (diagOp_eig hE lam) (by rw [range_diagVec hE]; exact hdense) D hcore

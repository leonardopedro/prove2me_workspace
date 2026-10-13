-- Generated from ChapterDiagonalDGammaEsa.lean — solution of BookProof.DiagonalDGamma.dGamma_diag_essentiallySelfAdjointOn_fockCore_self
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
import Theorems.Thm_BookProof_DiagonalDGamma_dGamma_diag_essentiallySelfAdjointOn_fockCore
import Theorems.Thm_BookProof_GraphCore_IsGraphCore_refl
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterTensorGraphCore
open BookProof.DiagonalDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.DirectSumEsa
open BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  {ι : Type*} (e : ι → D₂) (lam : ι → ℝ)
variable {Hs}
variable {E : ι → Hs.carrier} (hE : Orthonormal ℂ E)

set_option maxHeartbeats 1000000 in
theorem solution (lam : ι → ℝ)
    (hdense : Dense (Submodule.span ℂ (Set.range E) : Set Hs.carrier)) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore Hs (diagDomain E) (diagDomain E) n))
      (dGammaCoreOp Hs (diagDomain E) (diagOp hE lam) (diagDomain E)) :=
  dGamma_diag_essentiallySelfAdjointOn_fockCore hE lam hdense (diagDomain E)
      (IsGraphCore.refl _)

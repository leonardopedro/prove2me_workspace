-- Generated from ChapterDiagonalDGammaEsa.lean — theorem BookProof.DiagonalDGamma.dGamma_diag_essentiallySelfAdjointOn_fockCore
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.DirectSumEsa
open BookProof.GraphCore
open BookProof.TensorCore
open BookProof.DiagonalDGamma



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  {ι : Type*} (e : ι → D₂) (lam : ι → ℝ)
variable {Hs}
variable {E : ι → Hs.carrier} (hE : Orthonormal ℂ E)

theorem BookProof.DiagonalDGamma.dGamma_diag_essentiallySelfAdjointOn_fockCore (lam : ι → ℝ)
    (hdense : Dense (Submodule.span ℂ (Set.range E) : Set Hs.carrier))
    (D : Submodule ℂ Hs.carrier) (hcore : IsGraphCore D (diagOp hE lam)) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore Hs (diagDomain E) D n))
      (dGammaCoreOp Hs (diagDomain E) (diagOp hE lam) D) := by sorry

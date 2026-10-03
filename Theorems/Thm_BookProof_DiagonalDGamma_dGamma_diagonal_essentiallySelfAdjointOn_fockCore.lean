-- Generated from ChapterDiagonalDGammaEsa.lean — theorem BookProof.DiagonalDGamma.dGamma_diagonal_essentiallySelfAdjointOn_fockCore
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.DirectSumEsa
open BookProof.GraphCore
open BookProof.TensorCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  {ι : Type*} (e : ι → D₂) (lam : ι → ℝ)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.DiagonalDGamma.dGamma_diagonal_essentiallySelfAdjointOn_fockCore
    (heig : ∀ i, A (e i) = (lam i : ℂ) • (e i : Hs.carrier))
    (hdense : Dense (Submodule.span ℂ (Set.range fun i => (e i : Hs.carrier)) :
      Set Hs.carrier))
    (D : Submodule ℂ Hs.carrier) (hcore : IsGraphCore D A) :
    EssentiallySelfAdjointOn (dsCore (fun n : ℕ => fockSectorCore Hs D₂ D n))
      (dGammaCoreOp Hs D₂ A D) := by sorry

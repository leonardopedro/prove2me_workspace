-- Generated from ChapterDiagonalDGammaEsa.lean — solution of BookProof.DiagonalDGamma.dGamma_diagonal_essentiallySelfAdjointOn_fockCore
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
import Theorems.Thm_BookProof_SecondQuantizationCore_dGamma_essentiallySelfAdjointOn_fockCore
open BookProof.DiagonalDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  {ι : Type*} (e : ι → D₂) (lam : ι → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution
    (heig : ∀ i, A (e i) = (lam i : ℂ) • (e i : Hs.carrier))
    (hdense : Dense (Submodule.span ℂ (Set.range fun i => (e i : Hs.carrier)) :
      Set Hs.carrier))
    (D : Submodule ℂ Hs.carrier) (hcore : IsGraphCore D A) :
    EssentiallySelfAdjointOn (dsCore (fun n : ℕ => fockSectorCore Hs D₂ D n))
      (dGammaCoreOp Hs D₂ A D) :=
  dGamma_essentiallySelfAdjointOn_fockCore Hs D₂ A D hcore
      (essentiallySelfAdjointOn_fockSectorDom_diagonal Hs D₂ A e lam heig hdense)

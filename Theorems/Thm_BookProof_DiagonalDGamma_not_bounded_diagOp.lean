-- Generated from ChapterDiagonalDGammaEsa.lean — theorem BookProof.DiagonalDGamma.not_bounded_diagOp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterDiagonalDGammaEsa
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterTensorGraphCore
open BookProof.ChapterAbelianDiagonalCountable
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

theorem BookProof.DiagonalDGamma.not_bounded_diagOp (lam : ι → ℝ) (hlam : ∀ C : ℝ, ∃ i, C < |lam i|) :
    ¬ ∃ C : ℝ, ∀ x : diagDomain E, ‖diagOp hE lam x‖ ≤ C * ‖(x : Hs.carrier)‖ := by sorry

-- Generated from ChapterTensorGraphCore.lean — theorem BookProof.TensorCore.exists_core_approx
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.GraphCore
open BookProof.TensorCore

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

theorem BookProof.TensorCore.exists_core_approx (hcore : IsGraphCore D A) (n : ℕ)
    (x : ((domSpace Hs D₂).pow n)) {ε : ℝ} (hε : 0 < ε) :
    ∃ y ∈ corePow Hs D₂ D n,
      ‖inclPow Hs D₂ n x - inclPow Hs D₂ n y‖ < ε ∧
        ‖derPow Hs D₂ A n x - derPow Hs D₂ A n y‖ < ε := by sorry

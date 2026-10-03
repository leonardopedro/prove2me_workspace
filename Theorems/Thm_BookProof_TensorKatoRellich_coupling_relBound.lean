-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.coupling_relBound
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.TensorCore

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable {ι : Type*} [Fintype ι]



open scoped TensorProduct

noncomputable section

theorem BookProof.TensorKatoRellich.coupling_relBound [FiniteDimensional ℂ DB] (A : DA →ₗ[ℂ] Hs.carrier)
    (B : DB →ₗ[ℂ] Ks.carrier) (V : ι → DA →ₗ[ℂ] Hs.carrier) (Y : ι → DB →ₗ[ℂ] Ks.carrier)
    (hV : ∀ i, ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ u : DA,
      ‖V i u‖ ≤ ε * ‖A u‖ + C * ‖(u : Hs.carrier)‖) :
    ∃ a b : ℝ, 0 ≤ a ∧ a < 1 ∧ 0 ≤ b ∧ ∀ x : cpairDom Hs Ks DA DB,
      ‖pairLiftOp Hs Ks DA DB (couplingPoly Hs Ks DA DB V Y) x‖
        ≤ a * ‖cpairOp Hs Ks DA DB A B x‖ + b * ‖(x : ctensor Hs Ks)‖ := by sorry

-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.essentiallySelfAdjointOn_tensorSum_add_coupling
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.TensorCore
open BookProof.TensorKatoRellich

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable {ι : Type*} [Fintype ι]



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

theorem BookProof.TensorKatoRellich.essentiallySelfAdjointOn_tensorSum_add_coupling [FiniteDimensional ℂ DB]
    (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
    (V : ι → DA →ₗ[ℂ] Hs.carrier) (Y : ι → DB →ₗ[ℂ] Ks.carrier)
    (hA : SymmetricOn DA A) (hB : SymmetricOn DB B)
    (hV : ∀ i, SymmetricOn DA (V i)) (hY : ∀ i, SymmetricOn DB (Y i))
    (hrel : ∀ i, ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ u : DA,
      ‖V i u‖ ≤ ε * ‖A u‖ + C * ‖(u : Hs.carrier)‖)
    (hesa : EssentiallySelfAdjointOn (cpairDom Hs Ks DA DB) (cpairOp Hs Ks DA DB A B)) :
    EssentiallySelfAdjointOn (cpairDom Hs Ks DA DB)
      (cpairOp Hs Ks DA DB A B + pairLiftOp Hs Ks DA DB (couplingPoly Hs Ks DA DB V Y)) := by sorry

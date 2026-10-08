-- Generated from ChapterMackeyConverse.lean — theorem BookProof.ChapterMackeyConverse.mackey_converse_continuous
import Definitions.Def_ChapterPvmMeasure
import Definitions.Def_ChapterPvmCyclicUnitary
import Definitions.Def_ChapterMackeyCocycle
import Mathlib
import Definitions.Def_ChapterMackeyConverse
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterMackeyQuasiInvariant
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterMackeyConverse


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterPvmCyclicUnitary BookProof.ChapterMackeyCocycle

variable {G X H : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


theorem BookProof.ChapterMackeyConverse.mackey_converse_continuous (S : ContinuousImprimitivitySystem G X H) (ψ : H)
    (hcyc : IsCyclic S.P ψ) :
    ∃ (W : Lp ℂ 2 (pvmMeasure S.P ψ) ≃ₗᵢ[ℂ] H) (u : G → X → ℂ),
      QuasiInvariant (pvmMeasure S.P ψ) G ∧
      (∀ g x, ‖u g x‖ = 1) ∧ (∀ g, Measurable (u g)) ∧
      (∀ (E : Set X) (hE : MeasurableSet E) (f : Lp ℂ 2 (pvmMeasure S.P ψ)),
          W (proj (pvmMeasure S.P ψ) hE f) = S.P.p E (W f)) ∧
      (∀ (g : G) (f : Lp ℂ 2 (pvmMeasure S.P ψ)),
          ((W.symm (S.U g (W f))) : X → ℂ) =ᵐ[pvmMeasure S.P ψ]
            fun x => u g x * (sqrtDens (pvmMeasure S.P ψ) g x : ℂ) * (f : X → ℂ) (g⁻¹ • x)) := by sorry

-- Generated from ChapterPvmInducedSystem.lean — theorem BookProof.ChapterPvmInducedSystem.pvm_direct_sum_model
import Definitions.Def_ChapterPvmMeasure
import Definitions.Def_ChapterPvmCyclicUnitary
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterHilbertSumIntertwine
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterPvmInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable [CompleteSpace H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterHilbertSumIntertwine


theorem BookProof.ChapterPvmInducedSystem.pvm_direct_sum_model (P : Pvm X H) :
    ∃ (S : Set H) (V : ∀ ψ : S, Lp ℂ 2 (pvmMeasure P (ψ : H)) →ₗᵢ[ℂ] H),
      (∀ ψ ∈ S, ‖ψ‖ = 1) ∧
      IsHilbertSum ℂ (fun ψ : S => Lp ℂ 2 (pvmMeasure P (ψ : H))) V ∧
      (∀ (ψ : S) (E : Set X) (hE : MeasurableSet E) (f : Lp ℂ 2 (pvmMeasure P (ψ : H))),
        V ψ (proj (pvmMeasure P (ψ : H)) hE f) = P.p E (V ψ f)) := by sorry

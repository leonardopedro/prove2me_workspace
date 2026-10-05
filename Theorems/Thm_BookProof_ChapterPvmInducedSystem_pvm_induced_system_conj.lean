-- Generated from ChapterPvmInducedSystem.lean — theorem BookProof.ChapterPvmInducedSystem.pvm_induced_system_conj
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


theorem BookProof.ChapterPvmInducedSystem.pvm_induced_system_conj (P : Pvm X H) :
    ∃ (S : Set H) (W : H ≃ₗᵢ[ℂ] lp (fun ψ : S => Lp ℂ 2 (pvmMeasure P (ψ : H))) 2),
      (∀ ψ ∈ S, ‖ψ‖ = 1) ∧
      (∀ (E : Set X) (hE : MeasurableSet E)
          (w : lp (fun ψ : S => Lp ℂ 2 (pvmMeasure P (ψ : H))) 2) (ψ : S),
        (conjPvm P W.symm).p E w ψ = proj (pvmMeasure P (ψ : H)) hE (w ψ)) := by sorry

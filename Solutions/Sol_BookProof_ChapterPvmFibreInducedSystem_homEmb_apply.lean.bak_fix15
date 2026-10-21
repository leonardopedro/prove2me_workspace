-- Generated from ChapterPvmFibreInducedSystem.lean — solution of BookProof.ChapterPvmFibreInducedSystem.homEmb_apply
import Mathlib
import Definitions.Def_ChapterPvmFibreInducedSystem
open BookProof.ChapterPvmFibreInducedSystem



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterPvmInducedSystem
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterL2FibreSum
open BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable {P : Pvm X H} {S : Set H} {μ : Measure X}

set_option maxHeartbeats 1000000 in
theorem solution (hmu : ∀ ψ : S, pvmMeasure P (ψ : H) = μ) (ψ : S) (f : Lp ℂ 2 μ) :
    homEmb hmu ψ f = swIsom P (ψ : H) ((lpCongr (hmu ψ)).symm f) := rfl

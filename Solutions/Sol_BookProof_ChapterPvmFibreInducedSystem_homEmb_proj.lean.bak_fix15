-- Generated from ChapterPvmFibreInducedSystem.lean — solution of BookProof.ChapterPvmFibreInducedSystem.homEmb_proj
import Mathlib
import Definitions.Def_ChapterPvmFibreInducedSystem
import Theorems.Thm_BookProof_ChapterPvmFibreInducedSystem_lpCongr_symm_proj
import Theorems.Thm_BookProof_ChapterPvmFibreInducedSystem_homEmb_apply
import Theorems.Thm_BookProof_ChapterPvmCyclicUnitary_swCLM_proj
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
theorem solution (hmu : ∀ ψ : S, pvmMeasure P (ψ : H) = μ) (ψ : S) {E : Set X}
    (hE : MeasurableSet E) (f : Lp ℂ 2 μ) :
    homEmb hmu ψ (proj μ hE f) = P.p E (homEmb hmu ψ f) := by

  rw [homEmb_apply, homEmb_apply, lpCongr_symm_proj (hmu ψ) hE f]
  exact swCLM_proj P (ψ : H) hE _

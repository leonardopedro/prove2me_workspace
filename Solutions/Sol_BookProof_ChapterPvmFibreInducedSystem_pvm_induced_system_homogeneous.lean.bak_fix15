-- Generated from ChapterPvmFibreInducedSystem.lean — solution of BookProof.ChapterPvmFibreInducedSystem.pvm_induced_system_homogeneous
import Mathlib
import Definitions.Def_ChapterPvmFibreInducedSystem
import Theorems.Thm_BookProof_ChapterPvmFibreInducedSystem_induced_system_of_isHilbertSum
import Theorems.Thm_BookProof_ChapterPvmFibreInducedSystem_homEmb_proj
import Theorems.Thm_BookProof_ChapterPvmFibreInducedSystem_isHilbertSum_homEmb
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
theorem solution [Countable S] (hS : OrthCyclicFamily P S)
    (hdense : Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H))
    (hmu : ∀ ψ : S, pvmMeasure P (ψ : H) = μ) :
    ∃ W : H ≃ₗᵢ[ℂ] Lp (Fibre S) 2 μ,
      ∀ (E : Set X) (hE : MeasurableSet E) (v : H), W (P.p E v) = proj μ hE (W v) := by

  classical
  exact induced_system_of_isHilbertSum P μ (homEmb hmu) (isHilbertSum_homEmb hS hdense hmu)
    (fun ψ E hE f => homEmb_proj hmu ψ hE f)

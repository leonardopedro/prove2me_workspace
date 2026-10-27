-- Generated from ChapterPvmInducedSystem.lean — solution of BookProof.ChapterPvmInducedSystem.pvm_direct_sum_model
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
import Theorems.Thm_BookProof_ChapterPvmInducedSystem_isHilbertSum_swIsom
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_exists_orthCyclicFamily
import Theorems.Thm_BookProof_ChapterPvmCyclicUnitary_swCLM_proj
open BookProof.ChapterPvmInducedSystem



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (P : Pvm X H) :
    ∃ (S : Set H) (V : ∀ ψ : S, Lp ℂ 2 (pvmMeasure P (ψ : H)) →ₗᵢ[ℂ] H),
      (∀ ψ ∈ S, ‖ψ‖ = 1) ∧
      IsHilbertSum ℂ (fun ψ : S => Lp ℂ 2 (pvmMeasure P (ψ : H))) V ∧
      (∀ (ψ : S) (E : Set X) (hE : MeasurableSet E) (f : Lp ℂ 2 (pvmMeasure P (ψ : H))),
        V ψ (proj (pvmMeasure P (ψ : H)) hE f) = P.p E (V ψ f)) := by

  obtain ⟨S, hS, hdense⟩ := exists_orthCyclicFamily P
  exact ⟨S, fun ψ => swIsom P (ψ : H), hS.unit, isHilbertSum_swIsom hS hdense,
    fun ψ E hE f => swCLM_proj P (ψ : H) hE f⟩

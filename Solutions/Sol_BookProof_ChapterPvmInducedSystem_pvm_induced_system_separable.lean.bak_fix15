-- Generated from ChapterPvmInducedSystem.lean — solution of BookProof.ChapterPvmInducedSystem.pvm_induced_system_separable
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
import Theorems.Thm_BookProof_ChapterPvmInducedSystem_isHilbertSum_swIsom
import Theorems.Thm_BookProof_ChapterPvmInducedSystem_linearIsometryEquiv_swIsom_pvm
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_countable_of_orthCyclicFamily
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_exists_orthCyclicFamily
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
theorem solution [TopologicalSpace.SeparableSpace H] (P : Pvm X H) :
    ∃ (S : Set H) (W : H ≃ₗᵢ[ℂ] lp (fun ψ : S => Lp ℂ 2 (pvmMeasure P (ψ : H))) 2),
      S.Countable ∧ (∀ ψ ∈ S, ‖ψ‖ = 1) ∧
      (∀ (E : Set X) (hE : MeasurableSet E) (v : H) (ψ : S),
        W (P.p E v) ψ = proj (pvmMeasure P (ψ : H)) hE (W v ψ)) := by

  obtain ⟨S, hS, hdense⟩ := exists_orthCyclicFamily P
  exact ⟨S, (isHilbertSum_swIsom hS hdense).linearIsometryEquiv,
    countable_of_orthCyclicFamily hS, hS.unit,
    fun E hE v ψ => linearIsometryEquiv_swIsom_pvm hS hdense hE v ψ⟩

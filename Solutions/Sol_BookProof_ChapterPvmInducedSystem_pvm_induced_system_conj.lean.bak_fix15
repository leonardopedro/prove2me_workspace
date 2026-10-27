-- Generated from ChapterPvmInducedSystem.lean — solution of BookProof.ChapterPvmInducedSystem.pvm_induced_system_conj
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
import Theorems.Thm_BookProof_ChapterPvmInducedSystem_pvm_induced_system
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
    ∃ (S : Set H) (W : H ≃ₗᵢ[ℂ] lp (fun ψ : S => Lp ℂ 2 (pvmMeasure P (ψ : H))) 2),
      (∀ ψ ∈ S, ‖ψ‖ = 1) ∧
      (∀ (E : Set X) (hE : MeasurableSet E)
          (w : lp (fun ψ : S => Lp ℂ 2 (pvmMeasure P (ψ : H))) 2) (ψ : S),
        (conjPvm P W.symm).p E w ψ = proj (pvmMeasure P (ψ : H)) hE (w ψ)) := by

  obtain ⟨S, W, hunit, hfib⟩ := pvm_induced_system P
  refine ⟨S, W, hunit, ?_⟩
  intro E hE w ψ
  have h : (conjPvm P W.symm).p E w = W (P.p E (W.symm w)) := by
    simp [conjPvm_apply]
  rw [h, hfib E hE (W.symm w) ψ, LinearIsometryEquiv.apply_symm_apply]

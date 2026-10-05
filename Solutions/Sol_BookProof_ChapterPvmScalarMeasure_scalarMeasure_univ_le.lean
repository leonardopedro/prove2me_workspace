-- Generated from ChapterPvmScalarMeasure.lean — solution of BookProof.ChapterPvmScalarMeasure.scalarMeasure_univ_le
import Mathlib
import Definitions.Def_ChapterPvmScalarMeasure
import Theorems.Thm_BookProof_ChapterPvmScalarMeasure_scalarMeasure_apply
open BookProof.ChapterPvmScalarMeasure



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicDecomposition
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterMackeyConverse
open BookProof.ChapterPvmInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution (P : Pvm X H) {S : Set H} {n : S → ℕ}
    (hn : Function.Injective n) (hunit : ∀ ψ ∈ S, ‖ψ‖ = 1) :
    scalarMeasure P S n Set.univ ≤ 2 := by

  rw [scalarMeasure_apply P S n MeasurableSet.univ]
  have hterm : ∀ ψ : S, (2 : ENNReal)⁻¹ ^ n ψ * pvmMeasure P (ψ : H) Set.univ
      = (2 : ENNReal)⁻¹ ^ n ψ := by
    intro ψ
    rw [pvmMeasure_univ, hunit (ψ : H) ψ.2]
    simp
  rw [tsum_congr hterm]
  have hle : ∑' ψ : S, (2 : ENNReal)⁻¹ ^ n ψ ≤ ∑' k : ℕ, (2 : ENNReal)⁻¹ ^ k :=
    ENNReal.tsum_comp_le_tsum_of_injective hn (HPow.hPow (2 : ENNReal)⁻¹)
  refine hle.trans ?_
  rw [ENNReal.tsum_geometric]
  have hhalf : (1 : ENNReal) - (2 : ENNReal)⁻¹ = (2 : ENNReal)⁻¹ := by
    rw [ENNReal.sub_eq_of_eq_add (by simp) ENNReal.inv_two_add_inv_two.symm]
  rw [hhalf]
  simp

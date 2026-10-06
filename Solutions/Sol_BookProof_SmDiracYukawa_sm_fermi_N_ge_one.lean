-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.sm_fermi_N_ge_one
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Theorems.Thm_BookProof_SmDiracYukawa_diagOp_quadForm_eq
import Theorems.Thm_BookProof_SmDiracYukawa_smFermiN_eq_diagOp
import Theorems.Thm_BookProof_SmDiracYukawa_smFermiWeight_ge_one
import Theorems.Thm_BookProof_SmCar_normSq_eq_sum
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {n : ℕ}
variable {hD M : Matrix (Fin n) (Fin n) ℂ} {z : ℂ} {om : Fin n → ℝ} {c0 : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) (x : fullDom n) :
    ‖(x : FermiFock n)‖ ^ 2 ≤ quadForm (onFull (smFermiN om c0)) x := by

  rw [quadForm, onFull_apply, smFermiN_eq_diagOp, diagOp_quadForm_eq, normSq_eq_sum]
  refine Finset.sum_le_sum fun S _ => ?_
  have h1 := smFermiWeight_ge_one hom hc0 (om := om) (c0 := c0) S
  nlinarith [norm_nonneg ((x : FermiFock n) S), sq_nonneg ‖(x : FermiFock n) S‖]

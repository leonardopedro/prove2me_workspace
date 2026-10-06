-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.sm_fermi_N_norm_le
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Theorems.Thm_BookProof_SmDiracYukawa_diagOp_norm_le
import Theorems.Thm_BookProof_SmDiracYukawa_smFermiN_eq_diagOp
import Theorems.Thm_BookProof_SmDiracYukawa_smFermiWeight_le
import Theorems.Thm_BookProof_SmDiracYukawa_smFermiOm_nonneg
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {n : ℕ}
variable {hD M : Matrix (Fin n) (Fin n) ℂ} {z : ℂ} {om : Fin n → ℝ} {c0 : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) (ψ : FermiFock n) :
    ‖smFermiN om c0 ψ‖ ≤ smFermiOm om c0 * ‖ψ‖ := by

  rw [smFermiN_eq_diagOp]
  exact diagOp_norm_le (smFermiOm_nonneg hom hc0) (fun S => smFermiWeight_le hom hc0 S) ψ

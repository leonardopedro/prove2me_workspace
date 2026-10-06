-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.yukawa_entry_bound
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
import Theorems.Thm_BookProof_SmDiracYukawa_isMixing_mul
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {UL V UR D : Matrix (Fin 3) (Fin 3) ℂ}
    (hUL : IsMixing UL) (hV : IsMixing V) (hUR : IsMixing UR)
    (hD : ∀ k l, k ≠ l → D k l = 0) (i j : Fin 3) :
    ‖(UL * V.conjTranspose * D * UR.conjTranspose) i j‖ ≤ ∑ k : Fin 3, ‖D k k‖ := by

  set A : Matrix (Fin 3) (Fin 3) ℂ := UL * V.conjTranspose with hA
  have hAmix : IsMixing A := isMixing_mul hUL hV
  have hentry : (A * D * UR.conjTranspose) i j
      = ∑ k : Fin 3, A i k * D k k * star (UR j k) := by
    rw [Matrix.mul_apply]
    refine Finset.sum_congr rfl fun l _ => ?_
    have hAD : (A * D) i l = A i l * D l l := by
      rw [Matrix.mul_apply]
      exact Finset.sum_eq_single l (fun k _ hk => by rw [hD k l hk, mul_zero])
        (fun hl => absurd (Finset.mem_univ l) hl)
    rw [hAD, Matrix.conjTranspose_apply]
  rw [hentry]
  refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun k _ => ?_)
  rw [norm_mul, norm_mul, norm_star]
  have h1 : ‖A i k‖ ≤ 1 := unitary_entry_norm_le_one hAmix i k
  have h2 : ‖UR j k‖ ≤ 1 := unitary_entry_norm_le_one hUR j k
  calc ‖A i k‖ * ‖D k k‖ * ‖UR j k‖ ≤ 1 * ‖D k k‖ * 1 := by gcongr
    _ = ‖D k k‖ := by ring

-- Generated from ChapterMassGap.lean — solution of BookProof.MassGap.massGap_shifted_gapless
import Mathlib
import Definitions.Def_ChapterMassGap
open BookProof.MassGap




open scoped BigOperators

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]
variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℝ) :
    massGap (shiftedSpectrum (fun _ : Fin (n + 2) => (0 : ℝ)) lam) = lam := by

  refine le_antisymm ?_ ?_;
  · refine Finset.min'_le _ _ ?_;
    simp only [excited, ne_eq, Finset.mem_image, Finset.mem_filter, Finset.mem_univ, true_and,
        shiftedSpectrum, zero_add];
    exact ⟨ 1, by simp, by simp [ numberOp ] ⟩;
  · refine Finset.le_min' _ _ _ ?_ ; simp only [Finset.mem_image, shiftedSpectrum, numberOp,
      mul_ite, mul_zero, mul_one, zero_add, forall_exists_index, and_imp, forall_apply_eq_imp_iff₂];
    exact fun a ha => by rw [ if_neg ( Finset.mem_filter.mp ha |>.2 ) ] ;

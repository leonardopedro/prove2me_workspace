-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.isLorentz_inv
import Mathlib
import Definitions.Def_ChapterLorentzGroup
import Theorems.Thm_BookProof_LorentzGroup_lorentz_det_ne_zero
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    IsLorentz l⁻¹ := by

      unfold IsLorentz at *;
      rw [ Matrix.transpose_nonsing_inv ];
      have h_inv : IsUnit l.det := by
        exact isUnit_iff_ne_zero.mpr ( lorentz_det_ne_zero h );
      replace h := congr_arg ( fun x => x * l⁻¹ ) h
      simp_all [ Matrix.mul_assoc, isUnit_iff_ne_zero ]
      simp [ ← h, h_inv, isUnit_iff_ne_zero ]

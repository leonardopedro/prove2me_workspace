-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.upsilonC_Qc
import Mathlib
import Definitions.Def_ChapterA3h
import Theorems.Thm_BookProof_ChapterA3_det_pauli_comb
import Theorems.Thm_BookProof_ChapterA3_upsilon_apply_comb
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T.det = 1) (x : Fin 4 → ℂ) :
    Qc (fun μ => ∑ ν, UpsilonC T μ ν * x ν) = Qc x := by

  rw [ ← det_pauli_comb, ← det_pauli_comb ];
  rw [ ← upsilon_apply_comb ];
  simp [ hT, Matrix.det_mul ]

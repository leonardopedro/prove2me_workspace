-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.kinSum_conjTranspose
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_Kin_conjTranspose
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (k : Fin 3 → ℝ) :
    (∑ j : Fin 3, (k j : ℂ) • Kin j)ᴴ = ∑ j : Fin 3, (k j : ℂ) • Kin j := by

  rw [Matrix.conjTranspose_sum]
  refine Finset.sum_congr rfl (fun j _ => ?_)
  rw [Matrix.conjTranspose_smul, Kin_conjTranspose, Complex.star_def, Complex.conj_ofReal]

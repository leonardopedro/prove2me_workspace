-- Generated from ChapterAttentionEntropy.lean — solution of BookProof.ChapterAttentionEntropy.shannonEntropy_uniform
import Mathlib
import Definitions.Def_ChapterAttentionEntropy
open BookProof.ChapterAttentionEntropy



open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hm : 0 < m) :
    shannonEntropy (fun _ : Fin m => (1 : ℝ) / m) = Real.log m := by

  have hmR : (0 : ℝ) < m := by exact_mod_cast hm
  rw [shannonEntropy]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul,
    one_div, Real.log_inv]
  field_simp

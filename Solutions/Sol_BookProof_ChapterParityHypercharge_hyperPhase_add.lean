-- Generated from ChapterParityHypercharge.lean — solution of BookProof.ChapterParityHypercharge.hyperPhase_add
import Mathlib
import Definitions.Def_ChapterParityHypercharge
import Theorems.Thm_BookProof_ChapterA3_mgamma5_sq
open BookProof.ChapterParityHypercharge



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (θ φ : ℝ) :
    hyperPhase θ * hyperPhase φ = hyperPhase (θ + φ) := by

  unfold hyperPhase
  simp only [Complex.ofReal_cos, Complex.ofReal_sin, mul_add, Algebra.mul_smul_comm, mul_one,
    smul_add, smul_smul, add_mul, Algebra.smul_mul_assoc, one_mul, Real.cos_add,
    Complex.ofReal_sub, Complex.ofReal_mul, Real.sin_add, Complex.ofReal_add, add_smul]
  rw [BookProof.ChapterA3.mgamma5_sq]
  ext i j; norm_num; ring

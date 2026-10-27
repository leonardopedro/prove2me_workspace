-- Generated from ChapterMajoranaProp74.lean — solution of BookProof.ChapterMajoranaProp74.prop74_Rj_comm
import Mathlib
import Definitions.Def_ChapterMajoranaProp74
open BookProof.ChapterMajoranaProp74



open Matrix


open BookProof.ChapterMajoranaFourier
open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (g ns : Matrix (Fin 4) (Fin 4) ℂ)
    (_hg2 : g * g = 1) (hgns : g * ns = -(ns * g)) (c s pj : ℝ) :
    Dmat g pj * Sinv (ns * g) c s = Sinv (ns * g) c s * Dmat g pj := by

      unfold Dmat Sinv;
      simp only [neg_smul, Complex.coe_smul, fromBlocks_multiply, Algebra.mul_smul_comm, mul_one,
          mul_neg, zero_mul, smul_zero, neg_zero, add_zero, Algebra.smul_mul_assoc, neg_mul,
              smul_neg, neg_neg, zero_add, one_mul, mul_zero, Matrix.mul_assoc, fromBlocks_inj,
                  neg_inj, and_self_left];
      simp only [← smul_assoc, Complex.real_smul, ← mul_assoc, hgns, neg_mul, smul_neg, neg_inj];
      exact ⟨ by ext; simp [ mul_assoc, mul_left_comm ], by ext; simp [ mul_assoc, mul_left_comm ],
                                                            by ext; simp [ mul_assoc, mul_left_comm
                                                                ] ⟩

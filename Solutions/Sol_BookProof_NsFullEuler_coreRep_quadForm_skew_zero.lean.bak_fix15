-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.coreRep_quadForm_skew_zero
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_coreRep_skewOn_op
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (Φ : CoreRep d D) {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)}
    (hT : PolySkew T) (x : D) : quadForm (D.subtype.comp (Φ.op T)) x = 0 := by

  set z : ℂ := inner ℂ ((x : D) : L2d d) ((D.subtype.comp (Φ.op T)) x) with hz
  have h1 : (inner ℂ ((D.subtype.comp (Φ.op T)) x) ((x : D) : L2d d)) = star z :=
    (inner_conj_symm _ _).symm
  have h2 : star z = -z := by
    rw [← h1]
    exact coreRep_skewOn_op Φ hT x x
  have h4 : z.re = 0 := by
    have h := congrArg Complex.re h2
    simp only [Complex.star_def, Complex.conj_re, Complex.neg_re] at h
    linarith
  change (inner ℂ ((x : D) : L2d d) ((D.subtype.comp (Φ.op T)) x)).re = 0
  exact h4

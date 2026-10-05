-- Generated from ChapterNsOuterFockFarisLavine.lean — solution of BookProof.NsOuterFock.linForm_nsConstraint
import Mathlib
import Definitions.Def_ChapterNsOuterFockFarisLavine
import Theorems.Thm_BookProof_NsOuterFock_linForm_nsVec
open BookProof.NsOuterFock




open Finset MvPolynomial
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore BookProof.QgHermiteOscillator
open BookProof.QgOuterFock BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL
open BookProof.SqSumOuterFamily

noncomputable section

variable (bv : Fin 3 → ℝ) (nu lam mu gg : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (p : Fin n) (i : Fin 3) (hne : nextPart p ≠ p) :
    linForm (nsVec bv nu lam mu gg n (p, locU i))
      = (∑ j : Fin 3, ((bv j : ℝ) : ℂ) • X (coordOf p (locD i j)))
        - ((nu : ℝ) : ℂ) • X (coordOf p (locL i)) := by

  rw [linForm_nsVec bv nu lam mu gg p (locU i) hne]
  simp only [Fintype.sum_sum_type, Fintype.sum_prod_type, sameVec, nextVec, locU, locD, locL,
    Fin.sum_univ_three]
  fin_cases i <;> simp <;> module

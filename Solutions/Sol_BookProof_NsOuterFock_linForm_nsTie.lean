-- Generated from ChapterNsOuterFockFarisLavine.lean — solution of BookProof.NsOuterFock.linForm_nsTie
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
theorem solution {n : ℕ} (p : Fin n) (i j : Fin 3) (hne : nextPart p ≠ p) :
    linForm (nsVec bv nu lam mu gg n (p, locD i j))
      = ((lam : ℝ) : ℂ) • (X (coordOf p (locD i j)) + X (coordOf p (locU i))
          - X (coordOf (nextPart p) (locU i))) := by

  rw [linForm_nsVec bv nu lam mu gg p (locD i j) hne]
  simp only [Fintype.sum_sum_type, Fintype.sum_prod_type, sameVec, nextVec, locU, locD,
    Fin.sum_univ_three]
  fin_cases i <;> fin_cases j <;> simp <;> module

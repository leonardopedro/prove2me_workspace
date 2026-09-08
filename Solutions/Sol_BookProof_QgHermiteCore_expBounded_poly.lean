-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.expBounded_poly
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_ExpBounded_add
import Theorems.Thm_BookProof_QgHermiteCore_ExpBounded_const_mul
import Theorems.Thm_BookProof_QgHermiteCore_expBounded_pow
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (p : Polynomial ℝ) : ExpBounded (fun x => p.eval x) := by

  induction p using Polynomial.induction_on' with
  | add p q hp hq => simpa [Polynomial.eval_add] using hp.add hq
  | monomial k a =>
      simpa [Polynomial.eval_monomial] using (expBounded_pow k).const_mul a

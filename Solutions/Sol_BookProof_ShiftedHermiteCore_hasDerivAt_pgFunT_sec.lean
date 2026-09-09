-- Generated from ChapterShiftedHermiteCore.lean — solution of BookProof.ShiftedHermiteCore.hasDerivAt_pgFunT_sec
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
import Theorems.Thm_BookProof_ShiftedHermiteCore_hasDerivAt_phaseFun_sec
open BookProof.ShiftedHermiteCore











open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    HasDerivAt (fun t : ℝ => pgFunT a k p (sec i x t))
      (pgFunT a k (dPoly i p) x + (Complex.I * ((k i : ℝ) : ℂ)) * pgFunT a k p x) (x i) := by

  have hsec : ∀ t : ℝ, sec i x t - a = sec i (x - a) (t - a i) := by
    intro t
    ext j
    by_cases h : j = i <;> simp [sec_apply, h]
  have h1 : HasDerivAt (fun t : ℝ => pgFun p (sec i x t - a))
      (pgFun (dPoly i p) (x - a)) (x i) := by
    have hbase := hasDerivAt_pgFun_sec i p (x - a)
    have hpt : (x - a) i = x i - a i := by simp
    rw [hpt] at hbase
    have hcomp := HasDerivAt.comp_sub_const (x i) (a i) hbase
    have hfun : (fun t : ℝ => pgFun p (sec i (x - a) (t - a i)))
        = fun t : ℝ => pgFun p (sec i x t - a) := by
      funext t
      rw [hsec]
    rw [hfun] at hcomp
    simpa [dPoly_apply] using hcomp
  have h2 := hasDerivAt_phaseFun_sec k x i
  have hprod := h1.mul h2
  simp only [Pi.mul_def, sec_self] at hprod
  have hval : (fun t : ℝ => pgFun p (sec i x t - a) * phaseFun k (sec i x t))
      = fun t : ℝ => pgFunT a k p (sec i x t) := by
    funext t
    rw [pgFunT]
  rw [hval] at hprod
  have hsimp : pgFun (dPoly i p) (x - a) * phaseFun k x
      + pgFun p (x - a) * (phaseFun k x * (Complex.I * ((k i : ℝ) : ℂ)))
      = pgFunT a k (dPoly i p) x + (Complex.I * ((k i : ℝ) : ℂ)) * pgFunT a k p x := by
    rw [pgFunT, pgFunT]
    ring
  rwa [hsimp] at hprod

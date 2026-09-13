-- Generated from ChapterQgHermiteFriedrichs.lean — solution of BookProof.QgHermiteFriedrichs.hasDerivAt_polyEval_coordLine
import Mathlib
import Definitions.Def_ChapterQgHermiteFriedrichs
import Theorems.Thm_BookProof_QgHermiteFriedrichs_coordLine_apply
import Theorems.Thm_BookProof_QgHermiteFriedrichs_coordLine_self
import Definitions.Def_ChapterBandEnclosure
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
open BookProof.QgHermiteFriedrichs








open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.Starobinsky
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension

noncomputable section

variable {d : ℕ}































variable (W : Vd d → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin d) ℂ) (x : Vd d) (j : Fin d)
    (t : ℝ) :
    HasDerivAt (fun s : ℝ => MvPolynomial.eval (fun i => (((coordLine x j s) i : ℝ) : ℂ)) p)
      (MvPolynomial.eval (fun i => (((coordLine x j t) i : ℝ) : ℂ)) (pderiv j p)) t := by

  induction p using MvPolynomial.induction_on with
  | C a => simpa using hasDerivAt_const t (a : ℂ)
  | add p q hp hq => simpa [map_add] using hp.add hq
  | mul_X p i hp =>
      have hcoord : HasDerivAt (fun s : ℝ => (((coordLine x j s) i : ℝ) : ℂ))
          (MvPolynomial.eval (fun k => (((coordLine x j t) k : ℝ) : ℂ))
            (pderiv j (X i : MvPolynomial (Fin d) ℂ))) t := by
        by_cases hij : i = j
        · subst hij
          have h1 : (fun s : ℝ => (((coordLine x i s) i : ℝ) : ℂ)) = fun s : ℝ => (s : ℂ) := by
            funext s
            rw [coordLine_self]
          have h2 : MvPolynomial.eval (fun k => (((coordLine x i t) k : ℝ) : ℂ))
              (pderiv i (X i : MvPolynomial (Fin d) ℂ)) = 1 := by simp
          rw [h1, h2]
          simpa using (hasDerivAt_id t).ofReal_comp
        · have h1 : (fun s : ℝ => (((coordLine x j s) i : ℝ) : ℂ))
              = fun _ : ℝ => ((x i : ℝ) : ℂ) := by
            funext s
            rw [coordLine_apply, Function.update_of_ne hij]
          have h2 : MvPolynomial.eval (fun k => (((coordLine x j t) k : ℝ) : ℂ))
              (pderiv j (X i : MvPolynomial (Fin d) ℂ)) = 0 := by
            simp [pderiv_X, Ne.symm hij]
          rw [h1, h2]
          exact hasDerivAt_const t _
      have hmul := hp.mul hcoord
      have hgoal : (fun s : ℝ =>
            MvPolynomial.eval (fun k => (((coordLine x j s) k : ℝ) : ℂ)) (p * X i))
          = fun s : ℝ => (MvPolynomial.eval (fun k => (((coordLine x j s) k : ℝ) : ℂ)) p)
              * (((coordLine x j s) i : ℝ) : ℂ) := by
        funext s
        simp [map_mul]
      rw [hgoal]
      simp only [Pi.mul_def] at hmul
      refine hmul.congr_deriv ?_
      simp only [pderiv_mul, map_add, map_mul, MvPolynomial.eval_X]

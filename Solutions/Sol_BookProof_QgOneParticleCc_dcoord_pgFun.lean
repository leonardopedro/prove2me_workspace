-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.dcoord_pgFun
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_differentiableAt_of_contDiffTop
import Theorems.Thm_BookProof_QgOneParticleCc_coordLine_add_smul
import Theorems.Thm_BookProof_QgOneParticleCc_coordLine_self_eq
import Theorems.Thm_BookProof_QgHermiteFriedrichs_hasDerivAt_pgFun_coord
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin d) ℂ) (j : Fin d) :
    dcoord j (pgFun p) = pgFun (coreD j p) := by

  funext x
  have h0 := hasDerivAt_pgFun_coord p j x (x j)
  have hshift : HasDerivAt (fun t : ℝ => x j + t) 1 0 := by
    simpa using (hasDerivAt_id (0 : ℝ)).const_add (x j)
  have h0' : HasDerivAt (fun s : ℝ => pgFun p (coordLine x j s)) (pgFun (coreD j p) x)
      (x j + 0) := by
    simpa [coordLine_self_eq] using h0
  have hcomp := HasDerivAt.scomp (0 : ℝ) h0' hshift
  simp only [Function.comp_def, one_smul] at hcomp
  have hfun : (fun t : ℝ => pgFun p (coordLine x j (x j + t)))
      = fun t : ℝ => pgFun p (x + t • kinDir d j) := by
    funext t
    rw [coordLine_add_smul]
  rw [hfun] at hcomp
  have hld : HasLineDerivAt ℝ (pgFun p) (pgFun (coreD j p) x) x (kinDir d j) := by
    simpa [HasLineDerivAt] using hcomp
  have hdiff : DifferentiableAt ℝ (pgFun p) x :=
    differentiableAt_of_contDiffTop (contDiff_pgFun p) x
  have hfd : fderiv ℝ (pgFun p) x (kinDir d j) = pgFun (coreD j p) x := by
    rw [← hdiff.lineDeriv_eq_fderiv]
    exact hld.lineDeriv
  simpa [dcoord] using hfd

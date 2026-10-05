-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.lapCS_pgFun
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_QgOneParticleCc_dcoord_pgFun
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset (Fin d)) (p : MvPolynomial (Fin d) ℂ) :
    lapCS S (pgFun p) = fun x => -pgFun (kinPolyS S p) x := by

  funext x
  simp only [lapCS, dcoord_pgFun]
  simp only [pgFun, kinPolyS, map_neg, map_sum, Finset.sum_mul, neg_mul, neg_neg]

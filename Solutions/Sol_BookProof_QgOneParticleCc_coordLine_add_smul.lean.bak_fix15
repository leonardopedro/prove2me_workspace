-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.coordLine_add_smul
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
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
theorem solution (x : Vd d) (j : Fin d) (t : ℝ) :
    x + t • kinDir d j = coordLine x j (x j + t) := by

  ext i
  by_cases h : i = j
  · subst h
    simp [kinDir, coordLine_apply, EuclideanSpace.single_apply]
  · simp only [PiLp.add_apply, PiLp.smul_apply, coordLine_apply, Function.update_of_ne h,
      kinDir, EuclideanSpace.single_apply, smul_eq_mul]
    simp [h]

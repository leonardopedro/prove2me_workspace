-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.pgFun_mul_polyW
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_DegSchrodinger_polyW_ofReal
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q)
    (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (q * p) x = ((polyW q x : ℝ) : ℂ) * pgFun p x := by

  simp only [pgFun, map_mul, polyW_ofReal hq x]
  ring

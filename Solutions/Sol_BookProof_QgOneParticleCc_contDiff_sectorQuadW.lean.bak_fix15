-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.contDiff_sectorQuadW
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_contDiff_coord
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
theorem solution (M alpha mu : ℝ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (sectorQuadW M alpha mu) := by

  have h : sectorQuadW M alpha mu
      = fun x : Vd 2 => (-(M ^ 2 / 2) * (x 0) + alpha * (x 0) ^ 2) + mu * (x 1) ^ 2 := rfl
  rw [h]
  exact (((contDiff_coord 2 0).const_smul (-(M ^ 2 / 2))).add
    (((contDiff_coord 2 0).pow 2).const_smul alpha)).add
      (((contDiff_coord 2 1).pow 2).const_smul mu)

-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.sectorQuadCc_esa
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_ccHam_essentiallySelfAdjoint_of_core
import Theorems.Thm_BookProof_QgOneParticleCc_contDiff_sectorQuadW
import Theorems.Thm_BookProof_HermiteQuadraticEsa_continuous_sectorQuadW
import Theorems.Thm_BookProof_HermiteQuadraticEsa_expBounded_sectorQuadW
import Theorems.Thm_BookProof_HermiteQuadraticEsa_sectorQuad_essentiallySelfAdjoint
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
theorem solution (M alpha mu : ℝ) (ha0 : 0 < alpha) (ha2 : alpha < 1 / 2)
    (hm0 : 0 < mu) (hm2 : mu < 1 / 2) :
    EssentiallySelfAdjointOn (ccDomain (Vd 2))
      (ccHam (sectorQuadW M alpha mu) (contDiff_sectorQuadW M alpha mu)) :=
  ccHam_essentiallySelfAdjoint_of_core _ _ (continuous_sectorQuadW M alpha mu)
      (expBounded_sectorQuadW M alpha mu)
      (sectorQuad_essentiallySelfAdjoint M alpha mu ha0 ha2 hm0 hm2)

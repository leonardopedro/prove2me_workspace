-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.confVCc_esa
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_ccHam_essentiallySelfAdjoint_of_core
import Theorems.Thm_BookProof_QgOneParticleCc_contDiff_confW
import Theorems.Thm_BookProof_HermiteQuadraticEsa_confV_essentiallySelfAdjoint
import Theorems.Thm_BookProof_HermiteQuadraticEsa_continuous_confW
import Theorems.Thm_BookProof_HermiteQuadraticEsa_expBounded_confW
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.HermiteQuadraticEsa
open BookProof.ScalaronEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (h0 : 0 < alpha) (h2 : alpha < 1 / 2) :
    EssentiallySelfAdjointOn (ccDomain (Vd 1)) (ccHam (confW M alpha) (contDiff_confW M alpha)) :=
  ccHam_essentiallySelfAdjoint_of_core _ _ (continuous_confW M alpha) (expBounded_confW M alpha)
      (confV_essentiallySelfAdjoint M alpha h0 h2)

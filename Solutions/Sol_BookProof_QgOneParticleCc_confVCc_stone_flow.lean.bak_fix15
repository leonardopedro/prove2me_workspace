-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.confVCc_stone_flow
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_ccHam_symmetricOn
import Theorems.Thm_BookProof_QgOneParticleCc_contDiff_confW
import Theorems.Thm_BookProof_QgOneParticleCc_confVCc_esa
import Theorems.Thm_BookProof_ScalaronEsa_ccDomain_dense
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
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
theorem solution (M alpha : ℝ) (h0 : 0 < alpha) (h2 : alpha < 1 / 2) :
    ∃ (T : UnboundedSelfAdjoint (L2d 1)) (U : ℝ → (L2d 1 →L[ℂ] L2d 1)),
      IsSelfAdjointExtension (ccHam (confW M alpha) (contDiff_confW M alpha)) T.op ∧
        IsStoneFlow T U := exists_stone_flow_of_esa _ ccDomain_dense (ccHam_symmetricOn _ _) (confVCc_esa M alpha h0 h2)

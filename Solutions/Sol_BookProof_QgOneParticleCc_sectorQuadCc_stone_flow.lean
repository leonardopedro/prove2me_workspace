-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.sectorQuadCc_stone_flow
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_ccHam_symmetricOn
import Theorems.Thm_BookProof_QgOneParticleCc_contDiff_sectorQuadW
import Theorems.Thm_BookProof_QgOneParticleCc_sectorQuadCc_esa
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
theorem solution (M alpha mu : ℝ) (ha0 : 0 < alpha) (ha2 : alpha < 1 / 2)
    (hm0 : 0 < mu) (hm2 : mu < 1 / 2) :
    ∃ (T : UnboundedSelfAdjoint (L2d 2)) (U : ℝ → (L2d 2 →L[ℂ] L2d 2)),
      IsSelfAdjointExtension (ccHam (sectorQuadW M alpha mu) (contDiff_sectorQuadW M alpha mu))
        T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ ccDomain_dense (ccHam_symmetricOn _ _)
      (sectorQuadCc_esa M alpha mu ha0 ha2 hm0 hm2)

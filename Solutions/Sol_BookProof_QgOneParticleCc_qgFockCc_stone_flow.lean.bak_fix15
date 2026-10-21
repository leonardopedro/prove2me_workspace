-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.qgFockCc_stone_flow
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_qgFockCore_dense
import Theorems.Thm_BookProof_QgOneParticleCc_qgFockHam_symmetricOn
import Theorems.Thm_BookProof_QgOneParticleCc_qgFockCc_esa
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
theorem solution {V : Vd d → ℝ} {a b : ℝ}
    (hVs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hV : ∀ y, |V y| ≤ a * harmW y + b) :
    ∃ (T : UnboundedSelfAdjoint (qgFock d)) (U : ℝ → (qgFock d →L[ℂ] qgFock d)),
      IsSelfAdjointExtension (qgFockHam hVs) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ qgFockCore_dense (qgFockHam_symmetricOn hVs)
      (qgFockCc_esa hVs ha ha1 hb hV)

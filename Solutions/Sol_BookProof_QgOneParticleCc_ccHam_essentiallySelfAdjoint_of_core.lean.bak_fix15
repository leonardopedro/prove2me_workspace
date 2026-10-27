-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.ccHam_essentiallySelfAdjoint_of_core
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_essentiallySelfAdjointOn_of_graphApprox
import Theorems.Thm_BookProof_QgOneParticleCc_exists_cc_graph_approx
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
theorem solution (W : Vd d → ℝ)
    (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) (hWc : Continuous W) (hWb : ExpBounded W)
    (hcore : EssentiallySelfAdjointOn (polyGaussCore (d := d)) (hamCore W hWc hWb)) :
    EssentiallySelfAdjointOn (ccDomain (Vd d)) (ccHam W hWs) :=
  essentiallySelfAdjointOn_of_graphApprox _ _
      (fun x _ hε => exists_cc_graph_approx W hWs hWc hWb x hε) hcore

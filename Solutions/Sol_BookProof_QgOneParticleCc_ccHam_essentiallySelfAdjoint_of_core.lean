-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.ccHam_essentiallySelfAdjoint_of_core
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_essentiallySelfAdjointOn_of_graphApprox
import Theorems.Thm_BookProof_QgOneParticleCc_exists_cc_graph_approx
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.QgHermiteCore
open BookProof.QgHermiteFriedrichs
open BookProof.ScalaronEsa

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

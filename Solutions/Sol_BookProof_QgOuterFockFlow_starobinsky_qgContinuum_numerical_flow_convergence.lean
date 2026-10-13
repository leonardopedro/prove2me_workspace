-- Generated from ChapterQgOuterFockFlow.lean — solution of BookProof.QgOuterFockFlow.starobinsky_qgContinuum_numerical_flow_convergence
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Theorems.Thm_BookProof_QgOuterFockFlow_qgOuterFock_numerical_flow_convergence
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.QgOuterFockFlow




open Filter Topology
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato
open BookProof.EsaClosure
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.ChapterStoneResolvent
open BookProof.StoneBridge

noncomputable section

variable {ι : Type*} (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (halpha : 0 < alpha)
    (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec CMode)) (U : ℝ → (Sec CMode →L[ℂ] Sec CMode)),
      IsSelfAdjointExtension (secData (starobinskyWall M alpha halpha)
          (qgContinuumModes g)).ext T.op ∧ IsStoneFlow T U ∧
        ∀ S : ℕ → UnboundedSelfAdjoint (Sec CMode), StrongResolventConvergence T S →
          ∀ (v : Sec CMode) (T₀ : ℝ), 0 ≤ T₀ →
            (TendstoUniformlyOn (fun n t => (S n).stoneU t v) (fun t => T.stoneU t v) atTop
                (Set.Icc (-T₀) T₀)
              ∧ ∀ t : ℝ, Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v))) := qgOuterFock_numerical_flow_convergence (starobinskyWall M alpha halpha) (qgContinuumModes g)

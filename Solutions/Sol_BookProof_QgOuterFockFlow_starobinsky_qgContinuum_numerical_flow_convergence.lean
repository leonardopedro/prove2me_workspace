-- Generated from ChapterQgOuterFockFlow.lean — solution of BookProof.QgOuterFockFlow.starobinsky_qgContinuum_numerical_flow_convergence
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Theorems.Thm_BookProof_QgOuterFockFlow_qgOuterFock_numerical_flow_convergence
open BookProof.QgOuterFockFlow




open Filter Topology
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

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

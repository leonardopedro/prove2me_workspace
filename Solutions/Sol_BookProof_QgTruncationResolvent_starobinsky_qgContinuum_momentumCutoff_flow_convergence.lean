-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.starobinsky_qgContinuum_momentumCutoff_flow_convergence
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Theorems.Thm_BookProof_QgTruncationResolvent_qgOuterFock_truncation_flow_convergence
import Theorems.Thm_BookProof_QgTruncationResolvent_momWindow_exhausts
open BookProof.QgTruncationResolvent




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ)
    (halpha : 0 < alpha) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec CMode)) (S : ℕ → UnboundedSelfAdjoint (Sec CMode)),
      IsSelfAdjointExtension
          (secHam (starobinskyWall M alpha halpha) (qgContinuumModes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (qgContinuumModes g) (momWindow n))) (S n).op) ∧
        StrongResolventConvergence T S ∧
        ∀ (v : Sec CMode) (T₀ : ℝ), 0 ≤ T₀ →
          TendstoUniformlyOn (fun n t => (S n).stoneU t v) (fun t => T.stoneU t v) atTop
              (Set.Icc (-T₀) T₀) ∧
            ∀ t : ℝ, Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  qgOuterFock_truncation_flow_convergence (starobinskyWall M alpha halpha)
      (qgContinuumModes g) momWindow momWindow_exhausts

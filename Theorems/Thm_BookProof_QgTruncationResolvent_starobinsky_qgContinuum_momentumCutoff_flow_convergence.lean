-- Generated from ChapterQgTruncationResolvent.lean — theorem BookProof.QgTruncationResolvent.starobinsky_qgContinuum_momentumCutoff_flow_convergence
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
open BookProof.QgTruncationResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)



open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.QgTruncationResolvent.starobinsky_qgContinuum_momentumCutoff_flow_convergence (M alpha : ℝ)
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
            ∀ t : ℝ, Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by sorry

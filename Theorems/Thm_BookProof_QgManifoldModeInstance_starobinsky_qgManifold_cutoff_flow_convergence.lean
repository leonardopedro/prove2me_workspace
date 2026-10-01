-- Generated from ChapterQgManifoldModeInstance.lean — theorem BookProof.QgManifoldModeInstance.starobinsky_qgManifold_cutoff_flow_convergence
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
open BookProof.QgManifoldModeInstance

variable {ι : Type*}
variable (S : VielbeinSpectrum ι)



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent
open BookProof.QgTimeStepping

noncomputable section

variable {ι : Type*}

theorem BookProof.QgManifoldModeInstance.starobinsky_qgManifold_cutoff_flow_convergence (M alpha : ℝ) (halpha : 0 < alpha)
    (S : VielbeinSpectrum ι) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (Sn : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha) (S.modes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (S.modes g) (S.energyWindow n))) (Sn n).op) ∧
        StrongResolventConvergence T Sn ∧
        ∀ (v : Sec ι) (T₀ : ℝ), 0 ≤ T₀ →
          TendstoUniformlyOn (fun n t => (Sn n).stoneU t v) (fun t => T.stoneU t v) atTop
              (Set.Icc (-T₀) T₀) ∧
            ∀ t : ℝ, Tendsto (fun n => (Sn n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by sorry

-- Generated from ChapterQgManifoldModeInstance.lean — solution of BookProof.QgManifoldModeInstance.starobinsky_qgManifold_cutoff_flow_convergence
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
import Theorems.Thm_BookProof_QgManifoldModeInstance_VielbeinSpectrum_energyWindow_exhausts
import Theorems.Thm_BookProof_QgTruncationResolvent_qgOuterFock_truncation_flow_convergence




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section

variable {ι : Type*}

variable {ι : Type*}
variable (S : VielbeinSpectrum ι)

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (halpha : 0 < alpha)
    (S : VielbeinSpectrum ι) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (Sn : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha) (S.modes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (S.modes g) (S.energyWindow n))) (Sn n).op) ∧
        StrongResolventConvergence T Sn ∧
        ∀ (v : Sec ι) (T₀ : ℝ), 0 ≤ T₀ →
          TendstoUniformlyOn (fun n t => (Sn n).stoneU t v) (fun t => T.stoneU t v) atTop
              (Set.Icc (-T₀) T₀) ∧
            ∀ t : ℝ, Tendsto (fun n => (Sn n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  qgOuterFock_truncation_flow_convergence (starobinskyWall M alpha halpha) (S.modes g)
      S.energyWindow S.energyWindow_exhausts

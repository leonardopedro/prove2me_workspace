-- Generated from ChapterQgManifoldModeInstance.lean — solution of BookProof.QgManifoldModeInstance.starobinsky_qgManifold_fullyDiscrete_convergence
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
import Theorems.Thm_BookProof_QgManifoldModeInstance_VielbeinSpectrum_energyWindow_exhausts
import Theorems.Thm_BookProof_QgTimeStepping_qgOuterFock_fullyDiscrete_convergence
open BookProof.QgManifoldModeInstance




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent
open BookProof.QgTimeStepping

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
        ∀ (v : Sec ι) (t : ℝ), 0 < t →
          ∃ k : ℕ → ℕ, (∀ n, 0 < k n) ∧
            Tendsto (fun n => (cnStep (Sn n) (t / (k n)))^[k n] v) atTop
              (𝓝 (T.stoneU t v)) :=
  qgOuterFock_fullyDiscrete_convergence (starobinskyWall M alpha halpha) (S.modes g)
      S.energyWindow S.energyWindow_exhausts

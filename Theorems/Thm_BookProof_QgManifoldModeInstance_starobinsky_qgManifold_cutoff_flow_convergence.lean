-- Generated from ChapterQgManifoldModeInstance.lean — theorem BookProof.QgManifoldModeInstance.starobinsky_qgManifold_cutoff_flow_convergence
import Definitions.Def_ChapterStoneTheorem
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterQgTimeStepping
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.EsaClosure
open BookProof.FockSecondQuantization
open BookProof.ChapterSirkTrotterKato
open BookProof.ChapterStoneResolvent
open BookProof.ChapterStoneResolvent
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

-- Generated from ChapterQgManifoldModeInstance.lean — theorem BookProof.QgManifoldModeInstance.starobinsky_qgManifold_fullyDiscrete_convergence
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockCoreFL
import Mathlib
import Definitions.Def_ChapterQgManifoldModeInstance
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterA4
open BookProof.EsaClosure
open BookProof.FockSecondQuantization

variable {ι : Type*}
variable (S : VielbeinSpectrum ι)



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section


theorem BookProof.QgManifoldModeInstance.starobinsky_qgManifold_fullyDiscrete_convergence (M alpha : ℝ) (halpha : 0 < alpha)
    (S : VielbeinSpectrum ι) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (Sn : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha) (S.modes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (S.modes g) (S.energyWindow n))) (Sn n).op) ∧
        ∀ (v : Sec ι) (t : ℝ), 0 < t →
          ∃ k : ℕ → ℕ, (∀ n, 0 < k n) ∧
            Tendsto (fun n => (cnStep (Sn n) (t / (k n)))^[k n] v) atTop
              (𝓝 (T.stoneU t v)) := by sorry

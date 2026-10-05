-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.balancedH_essentiallySelfAdjointOn_core
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFockQuadraticEsa
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.ChapterA3n
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockDifferingBases

variable {ι κ : Type*} {ω : ι → ℝ}



open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section


theorem BookProof.FockDifferingBases.balancedH_essentiallySelfAdjointOn_core (hω : ∀ i, 0 ≤ ω i) (P Q : κ → Idx ι)
    (g : κ → ℂ) (hPQ : ∀ k, deg (P k) + deg (Q k) ≤ 2) (hsum : Summable fun k => ‖g k‖)
    (hbal : ∀ k, Balanced ω (P k) (Q k)) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((balancedH hω P Q g hPQ hsum).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig ω)))) := by sorry

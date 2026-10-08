-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.exchangeH_essentiallySelfAdjointOn_core
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



open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}


theorem BookProof.FockDifferingBases.exchangeH_essentiallySelfAdjointOn_core (hω : ∀ i, 0 ≤ ω i) (p q : κ → ι) (g : κ → ℂ)
    (hsum : Summable fun k => ‖g k‖) (hres : ∀ k, ω (p k) = ω (q k)) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((exchangeH hω p q g hsum).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig ω)))) := by sorry

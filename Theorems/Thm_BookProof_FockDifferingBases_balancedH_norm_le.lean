-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.balancedH_norm_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFockQuadraticEsa
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.ChapterA3n
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockDifferingBases

variable {ι κ : Type*} {ω : ι → ℝ}



open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section


theorem BookProof.FockDifferingBases.balancedH_norm_le (hω : ∀ i, 0 ≤ ω i) (P Q : κ → Idx ι) (g : κ → ℂ)
    (hPQ : ∀ k, deg (P k) + deg (Q k) ≤ 2) (hsum : Summable fun k => ‖g k‖)
    (x : maxDom (sig ω)) :
    ‖(balancedH hω P Q g hPQ hsum x : L2I (Idx ι))‖
      ≤ (1 + ∑' k, 4 * ‖g k‖) * ‖(diagMax (sig ω) x : L2I (Idx ι))‖ := by sorry

-- Generated from ChapterFockQuadraticEsa.lean — theorem BookProof.FockQuadratic.freeOp_norm_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterOperatorSeriesEsa
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.ChapterA3n
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockQuadratic


open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section

variable {ι : Type*}

variable {ω : ι → ℝ}

theorem BookProof.FockQuadratic.freeOp_norm_le (hω : ∀ i, 0 ≤ ω i) (x : maxDom (sig ω)) :
    ‖(freeOp hω x : L2I (Idx ι))‖ ≤ 1 * ‖(diagMax (sig ω) x : L2I (Idx ι))‖ := by sorry

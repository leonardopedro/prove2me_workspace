-- Generated from ChapterFockQuadraticEsa.lean — theorem BookProof.FockQuadratic.wsum_pairIdx
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterOperatorSeriesEsa
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterA3n
open BookProof.ChapterA3n
open BookProof.FockQuadratic

variable {ι : Type*}
variable {ω : ι → ℝ}
variable {κ : Type*}


open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section


theorem BookProof.FockQuadratic.wsum_pairIdx (ω : ι → ℝ) (m n : ι) : wsum ω (pairIdx m n) = ω m + ω n := by sorry

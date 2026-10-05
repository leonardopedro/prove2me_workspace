-- Generated from ChapterFockQuadraticEsa.lean — theorem BookProof.FockQuadratic.amp_le_sig
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterOperatorSeriesEsa
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.ChapterA3n
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.FockQuadratic

variable {ι : Type*}


open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section


theorem BookProof.FockQuadratic.amp_le_sig {ω : ι → ℝ} (hω : ∀ i, 0 ≤ ω i) {P Q a : Idx ι} (hPQ : deg P + deg Q ≤ 2) :
    amp P Q a ≤ 2 * sig ω a := by sorry

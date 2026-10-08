-- Generated from ChapterFockQuadraticEsa.lean — theorem BookProof.FockQuadratic.sig_tgt
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


open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section

variable {ι : Type*}


theorem BookProof.FockQuadratic.sig_tgt {ω : ι → ℝ} {P Q a : Idx ι} (h : P ≤ a) :
    sig ω (tgt P Q a) = sig ω a - wsum ω P - deg P + wsum ω Q + deg Q := by sorry

-- Generated from ChapterFockQuadraticEsa.lean — theorem BookProof.FockQuadratic.wsum_single
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterOperatorSeriesEsa
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
open BookProof.FockQuadratic

variable {ι : Type*}
variable {ω : ι → ℝ}
variable {κ : Type*}


open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section


theorem BookProof.FockQuadratic.wsum_single (ω : ι → ℝ) (i : ι) (k : ℕ) : wsum ω (Finsupp.single i k) = ω i * k := by sorry

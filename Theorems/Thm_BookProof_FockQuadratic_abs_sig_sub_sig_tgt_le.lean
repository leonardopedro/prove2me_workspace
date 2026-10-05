-- Generated from ChapterFockQuadraticEsa.lean — theorem BookProof.FockQuadratic.abs_sig_sub_sig_tgt_le
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


open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section


theorem BookProof.FockQuadratic.abs_sig_sub_sig_tgt_le (hω : ∀ i, 0 ≤ ω i) {P Q b : Idx ι} (hPQ : deg P + deg Q ≤ 2)
    (h : P ≤ b) : |sig ω b - sig ω (tgt P Q b)| ≤ wsum ω P + wsum ω Q + 2 := by sorry

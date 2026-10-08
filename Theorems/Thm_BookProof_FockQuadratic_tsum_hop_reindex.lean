-- Generated from ChapterFockQuadraticEsa.lean — theorem BookProof.FockQuadratic.tsum_hop_reindex
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


theorem BookProof.FockQuadratic.tsum_hop_reindex {P Q : Idx ι} {F G : Idx ι → ℂ}
    (hF : ∀ a, ¬ P ≤ a → F a = 0) (hG : ∀ b, ¬ Q ≤ b → G b = 0)
    (hEq : ∀ a, P ≤ a → F a = G (tgt P Q a)) : ∑' a, F a = ∑' b, G b := by sorry

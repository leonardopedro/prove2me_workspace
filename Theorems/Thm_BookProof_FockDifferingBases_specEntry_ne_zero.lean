-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.specEntry_ne_zero
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFockQuadraticEsa
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
open BookProof.FockDifferingBases



open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}


theorem BookProof.FockDifferingBases.specEntry_ne_zero {lam : ℝ} {v : ι → ℂ} {p q : ι}
    (hlam : lam ≠ 0) (hp : v p ≠ 0) (hq : v q ≠ 0) : specEntry lam v p q ≠ 0 := by sorry

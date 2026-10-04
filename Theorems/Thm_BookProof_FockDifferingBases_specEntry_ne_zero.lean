-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.specEntry_ne_zero
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesDeficiency
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Definitions.Def_ChapterA4
open BookProof.FockDifferingBases

variable {ι κ : Type*} {ω : ι → ℝ}



open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section


theorem BookProof.FockDifferingBases.specEntry_ne_zero {lam : ℝ} {v : ι → ℂ} {p q : ι}
    (hlam : lam ≠ 0) (hp : v p ≠ 0) (hq : v q ≠ 0) : specEntry lam v p q ≠ 0 := by sorry

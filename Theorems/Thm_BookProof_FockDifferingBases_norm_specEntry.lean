-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.norm_specEntry
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


theorem BookProof.FockDifferingBases.norm_specEntry (lam : ℝ) (v : ι → ℂ) (p q : ι) :
    ‖specEntry lam v p q‖ = |lam| * (‖v p‖ * ‖v q‖) := by sorry

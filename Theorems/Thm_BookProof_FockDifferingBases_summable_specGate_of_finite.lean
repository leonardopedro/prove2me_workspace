-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.summable_specGate_of_finite
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


theorem BookProof.FockDifferingBases.summable_specGate_of_finite [Finite κ] (lam : κ → ℝ) (v : κ → ι → ℂ) :
    Summable fun k => |lam k| * (∑' p, ‖v k p‖) ^ 2 := by sorry

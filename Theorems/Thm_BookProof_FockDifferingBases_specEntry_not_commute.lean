-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.specEntry_not_commute
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


theorem BookProof.FockDifferingBases.specEntry_not_commute :
    matMul (specEntry (1 : ℝ) (fun i : Fin 2 => if i = 0 then (1 : ℂ) else 0))
        (specEntry (1 : ℝ) (fun _ : Fin 2 => (1 : ℂ)))
      ≠ matMul (specEntry (1 : ℝ) (fun _ : Fin 2 => (1 : ℂ)))
        (specEntry (1 : ℝ) (fun i : Fin 2 => if i = 0 then (1 : ℂ) else 0)) := by sorry

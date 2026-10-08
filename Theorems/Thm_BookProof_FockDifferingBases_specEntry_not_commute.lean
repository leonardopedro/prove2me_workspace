-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.specEntry_not_commute
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


theorem BookProof.FockDifferingBases.specEntry_not_commute :
    matMul (specEntry (1 : ℝ) (fun i : Fin 2 => if i = 0 then (1 : ℂ) else 0))
        (specEntry (1 : ℝ) (fun _ : Fin 2 => (1 : ℂ)))
      ≠ matMul (specEntry (1 : ℝ) (fun _ : Fin 2 => (1 : ℂ)))
        (specEntry (1 : ℝ) (fun i : Fin 2 => if i = 0 then (1 : ℂ) else 0)) := by sorry

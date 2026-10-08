-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.summable_pairData
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


theorem BookProof.FockDifferingBases.summable_pairData {v₁ v₂ : ι → ℂ} (hv₁ : Summable fun p => ‖v₁ p‖)
    (hv₂ : Summable fun p => ‖v₂ p‖) (k : Fin 2) :
    Summable fun p => ‖(![v₁, v₂] : Fin 2 → ι → ℂ) k p‖ := by sorry

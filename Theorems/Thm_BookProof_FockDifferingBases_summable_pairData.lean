-- Generated from ChapterFockDifferingBasesEsa.lean — theorem BookProof.FockDifferingBases.summable_pairData
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


theorem BookProof.FockDifferingBases.summable_pairData {v₁ v₂ : ι → ℂ} (hv₁ : Summable fun p => ‖v₁ p‖)
    (hv₂ : Summable fun p => ‖v₂ p‖) (k : Fin 2) :
    Summable fun p => ‖(![v₁, v₂] : Fin 2 → ι → ℂ) k p‖ := by sorry

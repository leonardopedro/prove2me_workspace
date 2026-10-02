-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.commTerm_eq_zero
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode

variable {d : ℕ} {κ : Fin d → ℝ}


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian



theorem BookProof.NavierStokesFlow.FockManyMode.commTerm_eq_zero (hκ : ∀ i, 0 ≤ κ i) (i i₀ : Fin d) (β : Occ d)
    (hprod : ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β
      * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) ((modeData hκ i).shift β) = 0) :
    2 * (modeData hκ i).step * ((modeData hκ i).amp β
      * ((starRingEnd ℂ) (((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β)
        * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ)
          ((modeData hκ i).shift β)).re) = 0 := by sorry

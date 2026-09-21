-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.commTerm_eq_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

theorem BookProof.NavierStokesFlow.FockManyMode.commTerm_eq_zero (hκ : ∀ i, 0 ≤ κ i) (i i₀ : Fin d) (β : Occ d)
    (hprod : ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β
      * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) ((modeData hκ i).shift β) = 0) :
    2 * (modeData hκ i).step * ((modeData hκ i).amp β
      * ((starRingEnd ℂ) (((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β)
        * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ)
          ((modeData hκ i).shift β)).re) = 0 := by sorry

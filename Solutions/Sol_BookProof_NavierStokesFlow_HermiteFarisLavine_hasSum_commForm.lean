-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.hasSum_commForm
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_oscSymbol_step
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_hasSum_inner_nsH_left
import Theorems.Thm_BookProof_FarisLavine_commForm_eq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : 0 ≤ κ) (x : maxDom (oscSymbol κ)) :
    HasSum (fun n => 8 * κ * (amp κ n
        * ((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n) * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re))
      (commForm (nsH κ hκ) (diagMax (oscSymbol κ)) x) := by

  have hL := hasSum_inner_nsH_left hκ x (diagMax (oscSymbol κ) x : L2I ℕ)
  have hIm := Complex.hasSum_im hL
  have hpt : ∀ n, (-Complex.I * crossA κ ((x : L2I ℕ) : ℕ → ℂ)
        (((diagMax (oscSymbol κ) x : L2I ℕ) : ℕ → ℂ)) n
      + Complex.I * crossB κ ((x : L2I ℕ) : ℕ → ℂ)
        (((diagMax (oscSymbol κ) x : L2I ℕ) : ℕ → ℂ)) n).im
      = -(4 * κ) * (amp κ n
        * ((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n) * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re) := by
    intro n
    simp only [crossA, crossB, diagMax_coe, oscSymbol_step]
    simp [Complex.add_im, Complex.mul_im, Complex.mul_re]
    ring
  have hIm' : HasSum (fun n => -(4 * κ) * (amp κ n
      * ((starRingEnd ℂ) (((x : L2I ℕ) : ℕ → ℂ) n) * ((x : L2I ℕ) : ℕ → ℂ) (n + 2)).re))
      (inner ℂ (nsH κ hκ x : L2I ℕ) (diagMax (oscSymbol κ) x : L2I ℕ) : ℂ).im := by
    refine hIm.congr_fun ?_
    intro n
    exact (hpt n).symm
  have hres := hIm'.mul_left (-2)
  rw [commForm_eq]
  refine hres.congr_fun ?_
  intro n
  ring
